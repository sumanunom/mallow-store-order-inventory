<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Customer;
use App\Services\OrderService;
use App\Services\CustomerService;
use Illuminate\Http\JsonResponse;
use App\Jobs\SendOrderConfirmationJob;
use App\Http\Requests\StoreOrderRequest;
use App\Http\Requests\CustomerOrderHistoryRequest;

class OrderController extends Controller
{
    public function __construct(
        private OrderService $orderService,
        private CustomerService $customerService
    ) {
    }

    /**
     * Create a new order.
     */
    public function store(StoreOrderRequest $request): JsonResponse
    {
        $order = $this->orderService->createOrder(
            $request->validated()
        );

        // Dispatch the job after the order has been created.
        SendOrderConfirmationJob::dispatch($order->id);

        return response()->json([
            'message' => 'Order created successfully.',
            'data' => $order,
        ], 201);
    }

    /**
     * Get order history for a customer by email.
     */
    public function customerOrders(
        CustomerOrderHistoryRequest $request
    ): JsonResponse {

        $email = $request->validated('email');

        $customer = $this->customerService->getCusOrders($email);

        if (!$customer) {
            return response()->json([
                'message' => 'Customer not found.',
            ], 404);
        }

        return response()->json([
            'message' => 'Customer order history retrieved successfully.',
            'data' => [
                'customer' => [
                    'id' => $customer->id,
                    'name' => $customer->name,
                    'email' => $customer->email,
                ],
                'orders' => $customer->orders,
            ],
        ], 200);
    }
}
