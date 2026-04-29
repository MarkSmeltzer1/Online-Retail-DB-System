# Online Retail Database System

A MySQL database project that models the core data layer of an online retail platform, including product catalog management, customers, carts, orders, payments, shipments, promotions, reviews, returns, inventory behavior, and operational reporting.

The repository focuses on relational database design and implementation. The PHP frontend is included as a lightweight demonstration layer for running CRUD operations and exercising the database objects.

## Highlights

- Normalized relational schema designed to Third Normal Form (3NF)
- 16 core business tables with primary keys, foreign keys, unique constraints, and indexes
- MySQL views for customer order summaries and product sales reporting
- Stored functions for reusable order total and customer name calculations
- Stored procedures for transactional order placement and customer order history
- Triggers for inventory updates and order audit logging
- Seed data, demo queries, ER diagrams, logical schema diagrams, and screenshots

## Tech Stack

- **Database:** MySQL / InnoDB
- **SQL:** schema design, constraints, views, stored functions, stored procedures, triggers
- **Frontend Demo:** PHP with `mysqli`
- **Modeling Tools:** MySQL Workbench and draw.io

## Repository Structure

```text
online-retail-db-system/
|-- db/
|   |-- schema/
|   |   |-- 01_schema.sql
|   |   `-- 02_alter_schema.sql
|   |-- routines/
|   |   |-- 02_views.sql
|   |   |-- 03_functions.sql
|   |   |-- 04_procedures.sql
|   |   `-- 05_triggers.sql
|   `-- demo/
|       |-- 00_seed_data.sql
|       `-- 99_demo_queries.sql
|-- php/
|   |-- config.example.php
|   `-- index.php
|-- docs/
|   |-- ER_diagram.png
|   `-- logical_schema.png
|-- screenshots/
|-- README.md
`-- .gitignore
```

## Database Objects

| Type | Count | Examples |
| --- | ---: | --- |
| Tables | 16 | `Customer`, `Product`, `Order`, `OrderItem`, `Payment`, `Shipment`, `ReturnRefund` |
| Views | 2 | `CustomerOrderOverviewView`, `ProductSalesView` |
| Functions | 2 | `GetOrderTotal`, `GetCustomerFullName` |
| Procedures | 2 | `PlaceOrder`, `GetCustomerOrderHistory` |
| Triggers | 2 | `trg_UpdateStockOnOrderItemInsert`, `trg_LogOrderCreation` |

## Setup

Run the SQL files in this order from a MySQL client or MySQL Workbench:

```sql
SOURCE db/schema/01_schema.sql;
SOURCE db/schema/02_alter_schema.sql;
SOURCE db/demo/00_seed_data.sql;
SOURCE db/routines/02_views.sql;
SOURCE db/routines/03_functions.sql;
SOURCE db/routines/04_procedures.sql;
SOURCE db/routines/05_triggers.sql;
```

The schema creates and uses the `online_retail` database.

## Demo Queries

After setup, run:

```sql
SOURCE db/demo/99_demo_queries.sql;
```

The demo queries are intended to validate the schema, reporting views, functions, procedures, and trigger-driven behavior.

## PHP Demo

The PHP page demonstrates direct interaction with the database:

- Customer create, read, update, and delete operations
- Reporting view execution
- Stored function execution
- Stored procedure execution
- Trigger behavior through order placement

To configure it:

1. Copy `php/config.example.php` to `php/config.php`.
2. Add your local MySQL credentials.
3. Serve `php/index.php` through a PHP-enabled web server.

`php/config.php` is ignored by Git so credentials are not committed.

## Diagrams and Screenshots

- ER diagram: `docs/ER_diagram.png`
- Logical schema: `docs/logical_schema.png`
- UI and SQL execution screenshots: `screenshots/`

## Future Improvements

- Add prepared statements throughout the PHP demo
- Add authentication, authorization, and password hashing
- Add automated database migration tooling
- Expand reporting and analytics queries

## Notes

This is a portfolio database project. The data model, SQL routines, constraints, and documentation are the primary focus. The PHP interface is intentionally small and exists to demonstrate database integration rather than serve as a production web application.
