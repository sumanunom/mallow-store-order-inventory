<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Services\ProductService;
use App\Http\Requests\ProductThresholdRequest;

class ProductController extends Controller
{
    public function __construct(
        private ProductService $productService
    ) {
    }

    public function lowStock(
        ProductThresholdRequest $request
    ): JsonResponse {
        $threshold = (int) ($validated['threshold'] ?? 5);

        $products = $this->productService->getLowStocks($threshold);

        return response()->json([
            'message' => 'Low-stock products retrieved successfully.',
            'threshold' => $threshold,
            'count' => $products->count(),
            'data' => $products,
        ], 200);
    }
}
