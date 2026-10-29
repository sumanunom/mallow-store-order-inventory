<?php

namespace App\Jobs;

use App\Models\Order;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\Log;

class SendOrderConfirmationJob implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new job instance.
     */
    public function __construct(public int $orderId)
    {}

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        $order = Order::with([
            'customer',
            'items.product',
        ])->find($this->orderId);

        if (!$order) {
            Log::warning(
                "Order {$this->orderId} not found. Confirmation skipped."
            );

            return;
        }

        Log::info('Order confirmation email simulated.', [
            'order_id' => $order->id,
            'customer_name' => $order->customer->name,
            'customer_email' => $order->customer->email,
            'grand_total' => $order->grand_total,
        ]);
    }
}
