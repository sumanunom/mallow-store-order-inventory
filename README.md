# Store Order & Inventory Mini-System

A REST API built with Laravel 12 for managing products, customers, orders, inventory, and simulated order-confirmation notifications.

## Features

- Product and customer management data models.
- Order creation with automatic subtotal, tax, and grand-total calculation.
- Inventory validation and stock deduction within a database transaction.
- Customer order history using email.
- Low-stock product listing with a configurable threshold.
- Queued order-confirmation job using Laravel logging.
- Feature tests for successful orders, insufficient stock, customer order history, low-stock retrieval, and invalid input.

## Tech Stack

- PHP 8.x
- Laravel 12
- MySQL
- Laravel Queues
- PHPUnit / Laravel testing tools

## Requirements

- PHP version compatible with Laravel 12
- Composer
- MySQL
- Required PHP extensions for Laravel

## Installation

1. Clone the repository.
2. Install dependencies:

   ```bash
   composer install
   ```

3. Create the environment file:

   ```bash
   copy .env.example .env
   ```

4. Generate the application key:

   ```bash
   php artisan key:generate
   ```

5. Configure your database credentials in `.env`.
6. Create the database in MySQL.
7. Run migrations and seeders:

   ```bash
   php artisan migrate --seed
   ```

8. Start the development server:

   ```bash
   php artisan serve
   ```

## API Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `/api/orders` | Create an order |
| GET | `/api/customers/{email}/orders` | Retrieve customer order history |
| GET | `/api/products/low-stock?threshold=5` | Retrieve low-stock products |

## Queue Job

Order creation dispatches a confirmation job that logs simulated email details. No real SMTP service is required.

Configure the queue connection according to the environment. For a database queue, run the queue worker:

```bash
php artisan queue:work
```

## Running Tests

```bash
php artisan test
```

The current test suite passes with 5 tests and 20 assertions.

## Assumptions

- Product prices and tax percentages are stored in the database.
- Order totals are calculated by the application.
- Orders with insufficient stock are rejected.
- The confirmation email is simulated through logging.
- API authentication is not included.

## Author

Prepared as a Laravel Store Order & Inventory mini-task.

## AI-Assisted Development — Prompt Log

ChatGPT was used as a supporting tool during development for technical clarification, troubleshooting, and exploring alternative implementation approaches.

The development process was guided by my Laravel experience, with a focus on clean code, maintainable architecture, data consistency, and reliable API behavior.

Selected screenshots of actual prompts used during development are available in the public/prompts/ directory. These cover specific technical discussions related to the implementation, debugging, and testing of the application.
