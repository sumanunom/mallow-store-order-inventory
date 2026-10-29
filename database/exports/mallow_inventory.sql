-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2026 at 06:02 PM
-- Server version: 10.11.16-MariaDB
-- PHP Version: 8.3.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mallow_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `created_at`, `updated_at`) VALUES
(1, 'Ashton Nolan', 'otilia.abshire@example.org', '2026-10-27 11:29:15', '2026-10-27 11:29:15'),
(2, 'Alyson Okuneva', 'fohara@example.org', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(3, 'Dr. Haskell Thiel', 'mann.tara@example.com', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(4, 'Mr. Haleigh Rippin', 'mertz.scotty@example.org', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(5, 'Prof. Kathryne Jenkins', 'larkin.joana@example.net', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(6, 'Brant Hessel', 'quitzon.russel@example.org', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(7, 'German Jerde', 'kris96@example.com', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(8, 'Ellie Krajcik', 'jaunita.bruen@example.com', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(9, 'Peyton Rempel', 'marques.swaniawski@example.com', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(10, 'Brody Cronin', 'arch.kirlin@example.com', '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(11, 'Arun Kumar', 'arun.kumar@example.com', '2026-10-29 06:08:44', '2026-10-29 06:08:44');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_10_27_104230_create_customers_table', 1),
(5, '2026_10_27_104243_create_products_table', 1),
(6, '2026_10_27_104257_create_orders_table', 1),
(7, '2026_10_27_104310_create_order_items_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `tax_total` decimal(12,2) NOT NULL,
  `grand_total` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `subtotal`, `tax_total`, `grand_total`, `created_at`, `updated_at`) VALUES
(1, 11, 23291.56, 2794.99, 26086.55, '2026-10-29 06:08:44', '2026-10-29 06:08:44'),
(2, 11, 7040.32, 589.90, 7630.22, '2026-10-29 06:39:41', '2026-10-29 06:39:41'),
(3, 11, 7040.32, 589.90, 7630.22, '2026-10-29 07:50:08', '2026-10-29 07:50:08'),
(4, 11, 7040.32, 589.90, 7630.22, '2026-10-29 08:55:08', '2026-10-29 08:55:08'),
(5, 11, 7040.32, 589.90, 7630.22, '2026-10-29 09:15:58', '2026-10-29 09:15:58');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `tax_percent` decimal(5,2) NOT NULL,
  `line_subtotal` decimal(12,2) NOT NULL,
  `line_tax` decimal(12,2) NOT NULL,
  `line_total` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `tax_percent`, `line_subtotal`, `line_tax`, `line_total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 9946.61, 12.00, 19893.22, 2387.19, 22280.41, '2026-10-29 06:08:44', '2026-10-29 06:08:44'),
(2, 1, 2, 1, 3398.34, 12.00, 3398.34, 407.80, 3806.14, '2026-10-29 06:08:44', '2026-10-29 06:08:44'),
(3, 2, 3, 1, 3641.98, 5.00, 3641.98, 182.10, 3824.08, '2026-10-29 06:39:41', '2026-10-29 06:39:41'),
(4, 2, 2, 1, 3398.34, 12.00, 3398.34, 407.80, 3806.14, '2026-10-29 06:39:41', '2026-10-29 06:39:41'),
(5, 3, 3, 1, 3641.98, 5.00, 3641.98, 182.10, 3824.08, '2026-10-29 07:50:08', '2026-10-29 07:50:08'),
(6, 3, 2, 1, 3398.34, 12.00, 3398.34, 407.80, 3806.14, '2026-10-29 07:50:08', '2026-10-29 07:50:08'),
(7, 4, 3, 1, 3641.98, 5.00, 3641.98, 182.10, 3824.08, '2026-10-29 08:55:08', '2026-10-29 08:55:08'),
(8, 4, 2, 1, 3398.34, 12.00, 3398.34, 407.80, 3806.14, '2026-10-29 08:55:08', '2026-10-29 08:55:08'),
(9, 5, 3, 1, 3641.98, 5.00, 3641.98, 182.10, 3824.08, '2026-10-29 09:15:58', '2026-10-29 09:15:58'),
(10, 5, 2, 1, 3398.34, 12.00, 3398.34, 407.80, 3806.14, '2026-10-29 09:15:58', '2026-10-29 09:15:58');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `tax_percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `stock_quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `code`, `price`, `tax_percent`, `stock_quantity`, `created_at`, `updated_at`) VALUES
(1, 'maiores officiis officiis', 'PRD-9641', 9946.61, 12.00, 1, '2026-10-27 11:29:16', '2026-10-29 06:08:44'),
(2, 'quia consequatur harum', 'PRD-2750', 3398.34, 12.00, 67, '2026-10-27 11:29:16', '2026-10-29 09:15:58'),
(3, 'quasi aliquid tempore', 'PRD-4878', 3641.98, 5.00, 35, '2026-10-27 11:29:16', '2026-10-29 09:15:58'),
(4, 'ducimus ducimus et', 'PRD-5334', 155.58, 28.00, 53, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(5, 'incidunt cum maxime', 'PRD-2827', 3833.25, 0.00, 51, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(6, 'distinctio quos omnis', 'PRD-9627', 4248.05, 5.00, 14, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(7, 'maxime deserunt non', 'PRD-3796', 830.52, 0.00, 39, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(8, 'consequatur nesciunt pariatur', 'PRD-6951', 8882.86, 18.00, 36, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(9, 'blanditiis vel quibusdam', 'PRD-2939', 8934.92, 5.00, 21, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(10, 'aliquam qui aliquid', 'PRD-2807', 818.68, 12.00, 93, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(11, 'est ut eius', 'PRD-9681', 5692.89, 12.00, 4, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(12, 'sit omnis quis', 'PRD-2526', 6455.03, 28.00, 55, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(13, 'modi natus non', 'PRD-5585', 6047.05, 0.00, 20, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(14, 'et et illum', 'PRD-7008', 3048.58, 28.00, 92, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(15, 'modi voluptatem sit', 'PRD-8000', 9177.27, 28.00, 62, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(16, 'repellat accusantium commodi', 'PRD-1826', 6263.41, 28.00, 74, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(17, 'optio quae quod', 'PRD-5165', 5246.81, 5.00, 48, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(18, 'provident ut pariatur', 'PRD-5729', 4023.59, 5.00, 46, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(19, 'sed numquam est', 'PRD-9861', 3724.62, 18.00, 20, '2026-10-27 11:29:16', '2026-10-27 11:29:16'),
(20, 'perferendis culpa repudiandae', 'PRD-4395', 2068.02, 18.00, 31, '2026-10-27 11:29:16', '2026-10-27 11:29:16');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'test@example.com', '2026-10-27 11:29:16', '$2y$12$Mi75eWyi53.nYrv.sLN4DOu0HyYfNyxmYEziL4x/c1aFWF12UJxHW', 'Rs896JnJ7U', '2026-10-27 11:29:17', '2026-10-27 11:29:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_email_unique` (`email`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_code_unique` (`code`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
