<?php

namespace App\Repositories\Order;

use App\Models\Order;

interface OrderRepositoryInterface
{
    public function all();
    public function find($id): ?Order;
    public function create(array $data): Order;
    public function update(Order $order, array $data): bool;
    public function delete(Order $order): bool; 
    public function createOrder(array $order): Order;
}

