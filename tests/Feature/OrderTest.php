<?php

namespace Tests\Feature;

use App\Jobs\SendOrderConfirmationJob;
use App\Models\Customer;
use App\Models\Order;
use App\Models\Product;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use Illuminate\Support\Facades\Queue;

class OrderTest extends TestCase
{
    use RefreshDatabase;

    public function test_customer_can_place_an_order_successfully(): void
    {
        Queue::fake();

        $customer = Customer::factory()->create();

        $product = Product::factory()->create([
            'price' => 100,
            'tax_percent' => 18,
            'stock_quantity' => 10,
        ]);

        $response = $this->postJson('/api/orders', [
            'customer' => [
                'name' => $customer->name,
                'email' => $customer->email,
            ],
            'items' => [
                [
                    'product_id' => $product->id,
                    'quantity' => 2,
                ],
            ],
        ]);

        $response->assertCreated()
            ->assertJsonPath('data.subtotal', '200.00')
            ->assertJsonPath('data.tax_total', '36.00')
            ->assertJsonPath('data.grand_total', '236.00');

        $this->assertDatabaseHas('orders', [
            'customer_id' => $customer->id,
            'grand_total' => 236,
        ]);

        $this->assertDatabaseHas('products', [
            'id' => $product->id,
            'stock_quantity' => 8,
        ]);

        Queue::assertPushed(SendOrderConfirmationJob::class);
    }

    public function test_order_fails_when_stock_is_insufficient(): void
    {
        $customer = Customer::factory()->create();

        $product = Product::factory()->create([
            'price' => 100,
            'tax_percent' => 18,
            'stock_quantity' => 1,
        ]);

        $response = $this->postJson('/api/orders', [
            'customer' => [
                'name' => $customer->name,
                'email' => $customer->email,
            ],
            'items' => [
                [
                    'product_id' => $product->id,
                    'quantity' => 2,
                ],
            ],
        ]);

        $response->assertUnprocessable();

        $this->assertDatabaseCount('orders', 0);

        $this->assertDatabaseHas('products', [
            'id' => $product->id,
            'stock_quantity' => 1,
        ]);
    }

    public function test_customer_can_view_order_history(): void
    {
        $customer = Customer::factory()->create();

        $product = Product::factory()->create([
            'price' => 100,
            'tax_percent' => 18,
            'stock_quantity' => 10,
        ]);

        $this->postJson('/api/orders', [
            'customer' => [
                'name' => $customer->name,
                'email' => $customer->email,
            ],
            'items' => [
                [
                    'product_id' => $product->id,
                    'quantity' => 1,
                ],
            ],
        ])->assertCreated();

        $response = $this->getJson(
            '/api/customers/orders?email=' . urlencode($customer->email)
        );

        $response->assertOk();
    }

    public function test_low_stock_endpoint_returns_matching_products(): void
    {
        Product::factory()->create([
            'stock_quantity' => 2,
        ]);

        Product::factory()->create([
            'stock_quantity' => 10,
        ]);

        $response = $this->getJson('/api/products/low-stock');

        $response->assertOk()
            ->assertJsonPath('threshold', 5)
            ->assertJsonPath('count', 1);
    }

    public function test_order_fails_with_invalid_input(): void
    {
        $response = $this->postJson('/api/orders', [
            'customer' => [
                'name' => '',
                'email' => 'invalid-email',
            ],
            'items' => [],
        ]);

        $response->assertUnprocessable()
            ->assertJsonValidationErrors([
                'customer.name',
                'customer.email',
                'items',
            ]);
    }
}
