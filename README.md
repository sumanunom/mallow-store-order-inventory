# Store Order & Inventory Mini-System

A REST API built with Laravel 12 for managing products, customers, orders, and inventory. The application supports order creation, automatic tax calculation, stock validation, customer order history, low-stock reporting, and simulated order-confirmation notifications.

## Features

- Product and customer data management using Eloquent models.
- Order creation with one or more products.
- Automatic subtotal, tax, and grand-total calculation.
- Product stock validation before order creation.
- Inventory deduction within a database transaction.
- Customer order history retrieved using email.
- Low-stock product listing with a configurable threshold.
- Queued order-confirmation job using Laravel logging.
- Database migrations, factories, and seeders.
- Form Request validation.
- Service and repository-based application structure.
- Feature tests for order creation, insufficient stock, customer order history, low-stock retrieval, and invalid input.

## Tech Stack

- PHP 8.x
- Laravel 12
- MySQL
- Eloquent ORM
- Laravel Queues
- PHPUnit / Laravel testing tools
- Postman for API testing

## Requirements

- PHP version compatible with Laravel 12
- Composer
- MySQL or XAMPP
- Required PHP extensions for Laravel
- Git (optional, for cloning the repository)

## Installation and Setup

### 1. Clone the Repository

```bash
git clone https://github.com/sumanunom/mallow-store-order-inventory.git
cd mallow-store-order-inventory
```

Alternatively, download the project ZIP and extract it.

### 2. Install Dependencies

```bash
composer install
```

### 3. Configure the Environment

Create the local environment file.

**Windows Command Prompt:**

```bat
copy .env.example .env
```

**macOS/Linux:**

```bash
cp .env.example .env
```

Generate the application key:

```bash
php artisan key:generate
```

### 4. Configure the Development Database

Create a MySQL database for the application. The example database name is `mallow_store_inventory`.

Update the database settings in `.env` to match your local MySQL configuration:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=mallow_store_inventory
DB_USERNAME=root
DB_PASSWORD=
```

The username and password above are examples. Update them if your local MySQL configuration is different.

### 5. Run Migrations and Seeders

Create the application tables and populate sample data:

```bash
php artisan migrate --seed
```

This uses the Laravel migrations and seeders included in the project.

### 6. Start the Development Server

```bash
php artisan serve
```

The API will normally be available at:

`http://127.0.0.1:8000`

## Database Export

Laravel migrations and seeders are the recommended way to create the database structure and sample records.

If a MySQL SQL export is included with the project, it can optionally be imported through phpMyAdmin or the MySQL command-line client.

For example, if the export file is located at `database/exports/mallow_store_inventory.sql`, the import command would be:

```bash
mysql -u root -p mallow_store_inventory < database/exports/mallow_store_inventory.sql
```

Replace the example filename and path with the actual export file location.

Before importing, verify the SQL file's database selection statements and confirm that the target database is correct. Use either the SQL export or the migration-and-seeder setup for initial database creation unless the export is specifically intended to be used alongside migrations.

Do not include real credentials or sensitive data in database exports.

## API Endpoints

The following endpoints are available in the application.

| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/orders` | Create an order |
| GET | `/api/customers/orders?email=customer@example.com` | Retrieve a customer's order history |
| GET | `/api/products/low-stock?threshold=5` | Retrieve products at or below the requested stock threshold |

### Create an Order

**Endpoint:** `POST /api/orders`

Example request body:

```json
{
  "customer": {
    "name": "Arun Kumar",
    "email": "arun.kumar@example.com"
  },
  "items": [
    {
      "product_id": 1,
      "quantity": 2
    }
  ]
}
```

The application validates the request, checks product availability, calculates the order totals, creates the order and order items, and deducts the purchased quantities from stock.

The actual product ID must exist in the database.

### Retrieve Customer Order History

**Endpoint:** `GET /api/customers/orders?email=arun.kumar@example.com`

The endpoint retrieves the customer's order history using their email address.

### Retrieve Low-Stock Products

**Endpoint:** `GET /api/products/low-stock?threshold=5`

The threshold is configurable through the query parameter. If no threshold is supplied, the application uses its configured default.

## Queue Job

When an order is successfully created, the application dispatches a queued order-confirmation job.

The job simulates an email notification by writing confirmation details to the Laravel log. No SMTP configuration or actual email delivery is required.

Configure the queue connection in `.env` according to the local environment.

For a database queue, start the worker in a separate terminal:

```bash
php artisan queue:work
```

Keep the worker running while testing order creation so queued jobs can be processed.

The application log is normally available at:

`storage/logs/laravel.log`

## Running Tests

The project uses a separate MySQL database for automated testing to avoid running tests against the development database.

### Configure the Testing Database

Create a separate MySQL database named `mallow_test`.

Configure `.env.testing` with the appropriate testing database credentials:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=mallow_test
DB_USERNAME=root
DB_PASSWORD=
```

Update the credentials according to your local MySQL setup. Keep `.env.testing` out of version control if it contains local credentials.

Ensure the test environment is configured to use the testing database before running the test suite.

### Execute the Tests

Run the automated tests:

```bash
php artisan test
```

The feature tests cover:

- Successful order creation and total calculations.
- Stock deduction after a successful order.
- Rejection of orders with insufficient stock.
- Customer order history retrieval.
- Low-stock product retrieval.
- Invalid order input.

Refer to the actual test suite for the current test count and assertions.

**Important:** Never point the testing environment at a database containing development data. Verify the active test database configuration before running commands that reset or recreate tables.

## Project Structure

The application follows a layered structure to separate request handling and business logic.

```text
app/
├── Http/
│   ├── Controllers/
│   └── Requests/
├── Jobs/
├── Models/
├── Repositories/
└── Services/

database/
├── factories/
├── migrations/
└── seeders/

routes/
tests/
public/
└── prompts/
```

The structure above is illustrative; refer to the actual repository for the complete implementation.

## Assumptions and Design Decisions

- Product prices and tax percentages are stored in the database.
- Order totals are calculated by the application.
- An order must contain at least one product item.
- Orders with insufficient stock are rejected.
- Stock updates and order creation are handled transactionally.
- The order-confirmation notification is simulated through logging.
- MySQL is used for the application and testing databases.
- API authentication is not included in the current scope.
- Sample records can be generated using Laravel seeders and factories.

## AI-Assisted Development — Prompt Log

ChatGPT was used as a supporting tool during development for technical clarification, troubleshooting, and exploring implementation approaches.

The development process was guided by my Laravel experience, with a focus on clean code, maintainable architecture, data consistency, and API behavior.

Selected screenshots of actual prompts used during development are available in the `public/prompts/` directory. These cover technical discussions related to implementation, debugging, and testing.

## Author

Prepared as part of the Mid-Level Laravel Developer mini-task for Mallow Technologies.