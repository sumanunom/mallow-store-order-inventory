<?php

namespace App\Repositories\Product;

use App\Models\Product;

class ProductRepository implements ProductRepositoryInterface
{
    public function getLowStocks(int $threshold)
    {
        return Product::where('stock_quantity', '<=', $threshold)
            ->orderBy('stock_quantity')
            ->get();
    }

    public function getProducts($productIds){
        return Product::whereIn('id', $productIds)
                ->orderBy('id')
                ->lockForUpdate()
                ->get()
                ->keyBy('id');
    }
}