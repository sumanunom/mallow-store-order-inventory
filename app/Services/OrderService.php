<?php

namespace App\Services;

use App\Models\Order;
use App\Repositories\Order\OrderRepositoryInterface;

class OrderService
{
    public function __construct(protected OrderRepositoryInterface $repository)
    {}

    public function getAll($perPage = 10)
    {
        return $this->repository->all($perPage);
    }

    public function getById($id): ?Order
    {
        return $this->repository->find($id);
    }

    public function create(array $data): Order
    {
        return $this->repository->create($data);
    }

    public function update(Order $order, array $data): bool
    {
        return $this->repository->update($order, $data);
    }

    public function delete(Order $order): bool
    {
        return $this->repository->delete($order);
    }

    public function createOrder(array $order): Order
    {
        return $this->repository->createOrder($order);
    }
}
