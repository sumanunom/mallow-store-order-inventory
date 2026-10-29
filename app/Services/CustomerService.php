<?php

namespace App\Services;
use App\Repositories\Customer\CustomerRepositoryInterface;

class CustomerService
{
    public function __construct(protected CustomerRepositoryInterface $repository)
    {}

    public function getCusOrders($email)
    {
        return $this->repository->getCusOrders($email);
    }
}
