<?php

namespace App\Repositories\Product;

interface ProductRepositoryInterface
{
    public function getLowStocks(int $threshold);

    public function getProducts($productIds);

}