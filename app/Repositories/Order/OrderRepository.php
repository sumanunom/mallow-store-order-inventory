<?php

namespace App\Repositories\Order;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use App\Repositories\Customer\CustomerRepositoryInterface;
use App\Repositories\Product\ProductRepositoryInterface;

class OrderRepository implements OrderRepositoryInterface
{
    public function __construct(
        protected CustomerRepositoryInterface $customerRepository, 
        protected ProductRepositoryInterface $productRepository
    ) {
    }

    public function all($perPage = 10)
    {
        return Order::with(['items','customer'])
            ->latest()->paginate($perPage);
    }
    
    public function find($id): ?Order
    {
        return Order::with([
            'customer',
            'items.product',
        ])->find($id);
    }

    public function create(array $data): Order
    {
        return Order::create($data);
    }

    public function update(Order $order, array $data): bool
    {
        return $order->update($data);
    }

    public function delete(Order $order): bool
    {
        return $order->delete();
    }

   public function createOrder(array $data): Order
    {
        return DB::transaction(function () use ($data) {
            $customer = $this->customerRepository->findCustomer(
                $data['customer']['name'],
                $data['customer']['email']
            );

            $items = collect($data['items']);

            // Aggregate quantities if the same product appears more than once.
            $quantities = $items
                ->groupBy(fn ($item) => (int) $item['product_id'])
                ->map(fn ($group) => $group->sum('quantity'));

            $productIds = $quantities->keys()->sort()->values();

            // Lock products in a consistent order to reduce deadlock risk.
            $products = $this->productRepository->getProducts($productIds);

            if ($products->count() !== $productIds->count()) {
                throw ValidationException::withMessages([
                    'items' => ['One or more selected products do not exist.'],
                ]);
            }

            // Check the total requested quantity for each product.
            $this->checkRequestedQtys($quantities, $products);

            // Calculation
            $totals = $this->calculateOrderTotals($quantities, $products);

            $subtotal = $totals['subtotal'];
            $taxTotal = $totals['tax_total'];
            $grandTotal = $totals['grand_total'];
            $orderItems = $totals['items'];

            // $order = Order::create([
            //     'customer_id' => $customer->id,
            //     'subtotal' => $subtotal,
            //     'tax_total' => $taxTotal,
            //     'grand_total' => $grandTotal,
            // ]);

            // Create order
            $orderData = ['customer_id' => $customer->id,
                'subtotal' => $subtotal,
                'tax_total' => $taxTotal,
                'grand_total' => $grandTotal];

            $order = $this->create($orderData);

            // Create Order Items;
            $this->createItems($order, $orderItems, $products);

            return $order->load([
                'customer',
                'items.product',
            ]);
        }, 3);
    }

    private function calculateOrderTotals($quantities, $products): array
    {
        $subtotal = 0;
        $taxTotal = 0;
        $orderItems = [];

        foreach ($quantities as $productId => $quantity) {
            $product = $products->get((int) $productId);

            $unitPrice = (float) $product->price;
            $taxPercent = (float) $product->tax_percent;

            $lineSubtotal = round($unitPrice * $quantity, 2);
            $lineTax = round($lineSubtotal * $taxPercent / 100, 2);
            $lineTotal = round($lineSubtotal + $lineTax, 2);

            $subtotal += $lineSubtotal;
            $taxTotal += $lineTax;

            $orderItems[] = [
                'product_id' => $product->id,
                'quantity' => $quantity,
                'unit_price' => $unitPrice,
                'tax_percent' => $taxPercent,
                'line_subtotal' => $lineSubtotal,
                'line_tax' => $lineTax,
                'line_total' => $lineTotal,
            ];
        }

        $subtotal = round($subtotal, 2);
        $taxTotal = round($taxTotal, 2);
        $grandTotal = round($subtotal + $taxTotal, 2);

        return [
            'subtotal' => $subtotal,
            'tax_total' => $taxTotal,
            'grand_total' => $grandTotal,
            'items' => $orderItems,
        ];
    }

    private function checkRequestedQtys($quantities, $products){
        foreach ($quantities as $productId => $quantity) {
            $product = $products->get((int) $productId);

            if ($product->stock_quantity < $quantity) {
                throw ValidationException::withMessages([
                    'items' => [
                        "Insufficient stock for product: {$product->name}.",
                    ],
                ]);
            }
        }
    }

    private function createItems($order, $orderItems, $products){
        foreach ($orderItems as $item) {
            OrderItem::create([
                'order_id' => $order->id,
                ...$item,
            ]);

            $products->get($item['product_id'])
                ->decrement('stock_quantity', $item['quantity']);
        }
    }
}
