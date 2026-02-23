# Online Retail Database System

## Project Overview
This project is a full-stack **online retail database system** designed and implemented as part of an advanced database design course. The system models a realistic e-commerce platform, supporting customers, products, orders, payments, shipping, promotions, and returns.  

The project follows the **entire database lifecycle**, including:
- requirements analysis
- conceptual ER modeling
- normalization to Third Normal Form (3NF)
- relational mapping
- physical implementation in MySQL
- advanced database objects (views, functions, procedures, triggers)
- a PHP frontend demonstrating database interaction

The goal of this project is to demonstrate **strong database design principles**, **advanced SQL usage**, and **integration with a web-based frontend**.

---

## Technology Stack
- **Database:** MySQL (InnoDB)
- **Backend / Frontend:** PHP (mysqli)
- **Design Tools:** draw.io / MySQL Workbench
- **Version Control:** Git & GitHub
- **Hosting (Development):** Rowan University Elvis server

---

## Database Design

### ER / Logical Diagram
The database was designed using ER modeling and normalized to **Third Normal Form (3NF)** to eliminate redundancy and ensure data integrity.

 **Logical / ER Diagram:**  
See the diagram image in the `docs/diagrams` folder.

---

## Database Features

### Schema & Constraints
- Primary and foreign key enforcement
- Unique constraints (e.g., customer email, product SKU)
- Referential integrity across all relationships
- Normalized tables (3NF)

### Views
- **CustomerOrderOverviewView** – Summarizes order totals per customer  
- **ProductSalesView** – Displays product sales quantities and revenue  

### Stored Functions
- **GetOrderTotal(orderID)** – Calculates total order value  
- **GetCustomerFullName(customerID)** – Returns formatted customer name  

### Stored Procedures
- **PlaceOrder** – Transactional order creation  
- **GetCustomerOrderHistory** – Customer order history with totals  

### Triggers
- Automatic inventory updates on order item insert  
- Order creation logging for audit purposes  

---

## Repository Structure

```text
online-retail-db-system/
├── db/
│   ├── schema/
│   │   ├── 01_schema.sql
│   │   └── 02_alter_schema.sql
│   ├── routines/
│   │   ├── 02_views.sql
│   │   ├── 03_functions.sql
│   │   ├── 04_procedures.sql
│   │   └── 05_triggers.sql
│   └── demo/
│       ├── 00_seed_data.sql
│       └── 99_demo_queries.sql
├── php/
│   ├── config.example.php
│   └── finalproject.php
├── docs/
│   └── diagrams/
├── screenshots/
├── README.md
└── .gitignore

---

## How to Run the Database

### 1. Create the schema
Run SQL files in this order:
- `01_schema.sql`
- `02_alter_schema.sql`

### 2. (Optional) Load sample data
- `db/demo/00_seed_data.sql`

### 3. Create views, functions, procedures, and triggers
- `02_views.sql`
- `03_functions.sql`
- `04_procedures.sql`
- `05_triggers.sql`

### 4. (Optional) Demo queries
- `db/demo/99_demo_queries.sql`

---

## PHP Frontend

The PHP frontend demonstrates:
- CRUD operations on customers
- Executing views
- Calling stored functions
- Executing stored procedures
- Trigger-based inventory and logging behavior

### Database Configuration
- Copy `config.example.php` → `config.php`
- Add your database credentials
- `config.php` is ignored by Git to protect credentials

---

## Screenshots
Screenshots demonstrating CRUD operations, views, procedures, and triggers are available in the `screenshots/` folder.

---

## Notes & Limitations
- Intended for educational and portfolio use
- Authentication and security are simplified
- Prepared statements can be added for production use

---

## Author
**Mark Smeltzer**  
Advanced Database Design Project