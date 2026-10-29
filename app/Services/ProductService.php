<?php

namespace App\Services;
use App\Repositories\Product\ProductRepositoryInterface;

class ProductService
{
    public function __construct(
        protected ProductRepositoryInterface $repository
    ) {
    }

    public function getLowStocks(int $threshold)
    {
        return $this->repository->getLowStocks($threshold);
    }
}