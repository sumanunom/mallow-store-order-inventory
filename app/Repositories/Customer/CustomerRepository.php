<?php

namespace App\Repositories\Customer;

use App\Models\Customer;

class CustomerRepository implements CustomerRepositoryInterface
{
    public function getCusOrders($email): ?Customer   
    {
        return Customer::where('email', $email)
            ->with([
                'orders.items.product',
            ])
            ->first();
    }

    public function findCustomer(string $name, string $email): Customer
    {
        return Customer::firstOrCreate(
            ['email' => $email],
            ['name' => $name]
        );

    }
}
