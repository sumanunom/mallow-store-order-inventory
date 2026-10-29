<?php

namespace App\Repositories\Customer;

use App\Models\Customer;

interface CustomerRepositoryInterface
{
    public function getCusOrders($email): ?Customer;
    public function findCustomer(string $name, string $email): Customer;
}
