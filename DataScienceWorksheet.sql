-- Active: 1736495830346@@127.0.0.1@3306@pwskills__db
# Question.1 

CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000.00
);


#Question: 2 

-- Purpose of Constraints in a Database:

-- Constraints are rules enforced on data in a database to ensure its accuracy, consistency, and reliability. 
-- They help maintain data integrity by restricting the types of data that can be stored in tables.

--How Constraints Help Maintain Data Integrity

--Data Accuracy: Ensures that the data entered is correct and adheres to specific conditions.
--Example: A CHECK constraint ensures that an age column does not contain values below 18.

--Data Consistency: Ensures that relationships between tables remain valid.
--Example: A FOREIGN KEY constraint ensures that a referenced record exists in the parent table.

--Data Uniqueness: Prevents duplicate values in a column or combination of columns.
--Example: A UNIQUE constraint ensures no two rows have the same email address.

--NOT NULL: Ensures that a column cannot contain NULL values.

-- Example:
-- --CREATE TABLE students (
--     student_id INT NOT NULL,
--     student_name VARCHAR(50) NOT NULL
-- );

--PRIMARY KEY: Combines NOT NULL and UNIQUE to uniquely identify a row in a table.

--Eg;;

-- CREATE TABLE employees (
--     emp_id INT NOT NULL PRIMARY KEY
-- );


--FOREIGN KEY: Ensures that a value in one table corresponds to a value in another table, maintaining referential integrity.
-- Example:

-- CREATE TABLE orders (
--     order_id INT PRIMARY KEY,
--     customer_id INT,
--     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
-- );

-- UNIQUE: Ensures that all values in a column are distinct.
-- Example:

-- CREATE TABLE users (
--     user_id INT PRIMARY KEY,
--     email VARCHAR(255) UNIQUE
-- );


-- CHECK: Ensures that all values in a column satisfy a specific condition.
-- Example:
-- CREATE TABLE products (
--     product_id INT PRIMARY KEY,
--     price DECIMAL(10, 2) CHECK (price > 0)
-- );



--DEFAULT: Provides a default value for a column when no value is specified.
-- Example:
-- CREATE TABLE accounts (
--     account_id INT PRIMARY KEY,
--     balance DECIMAL(10, 2) DEFAULT 0.00
-- );



--Question: 3

-- Why Apply the NOT NULL Constraint?

-- The NOT NULL constraint ensures a column cannot have empty values. It is used when every row must have a value in that column, ensuring the data is complete.

-- Example: In an employees table, the emp_name column should not be empty because every employee must have a name.

-- primary key cannot contain NULL values.

-- A primary key uniquely identifies each row in a table.
-- NULL means "unknown," and we cannot uniquely identify something with unknown values.
-- Example: If a table allows NULL in the primary key, multiple rows could have NULL, breaking uniqueness.


Question: 4

-- Add a Constraint
-- Identify the Table: Decide which table and column need the constraint.
-- Use ALTER TABLE Command:
-- Add the constraint using the ADD keyword.
--Eg...

-- ALTER TABLE employees 
-- ADD CONSTRAINT unique_email UNIQUE (email);


-- Remove a Constraint
-- Find the Constraint Name:
-- Use SHOW CREATE TABLE <table_name>; to identify the constraint name.
-- Use ALTER TABLE Command:
-- Drop the constraint using the DROP keyword.
--eg::
-- ALTER TABLE employees 
-- DROP INDEX unique_email;


-- Question: 5

-- Consequences of Violating Constraints:

-- When ywetry to insert, update, or delete data in a database that violates a constraint,
-- the database will reject the action. 
--This keeps the data consistent and accurate. Common constraints include:

-- Primary Key Constraint: Prevents duplicate or missing key values.
-- Foreign Key Constraint: Ensures relationships between tables are valid.
-- Unique Constraint: Avoids duplicate values in a column.
-- Not Null Constraint: Requires a column to have a value.

-- Example of an Error Message:

-- If ywe try to insert a duplicate value into a column with a primary key, we may see an error like this:

-- ERROR: duplicate key value violates unique constraint "primary_key_name"
-- DETAIL: Key (id)=(101) already exists.


--- Question: 6

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

ALTER TABLE products 
ADD PRIMARY KEY (product_id);

ALTER TABLE products 
ALTER COLUMN price SET DEFAULT 50.00;


--Question: 7

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    class_id INT
);

CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50)
);

-- Insert sample data
INSERT INTO students (student_id, student_name, class_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

INSERT INTO classes (class_id, class_name) VALUES
(101, 'Math'),
(102, 'Science');


SELECT students.student_name, classes.class_name
FROM students
INNER JOIN classes
ON students.class_id = classes.class_id;



--Question; 8 

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT
);

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');

INSERT INTO products (product_id, product_name, price) VALUES
(101, 'Laptop', 1000.00),
(102, 'Mouse', 20.00);

INSERT INTO orders (order_id, customer_id, product_id, quantity) VALUES
(1, 1, 101, 2),
(2, 2, 102, 5);

SELECT orders.order_id, customers.customer_name, products.product_name
FROM products
LEFT JOIN orders ON products.product_id = orders.product_id
LEFT JOIN customers ON orders.customer_id = customers.customer_id;


--Question: 9

CREATE TABLE products3 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE orders2 (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT
);

-- Insert sample data
INSERT INTO products3 (product_id, product_name, price) VALUES
(1, 'Laptop', 1000.00),
(2, 'Mouse', 20.00),
(3, 'Keyboard', 50.00);

INSERT INTO orders2 (order_id, product_id, quantity) VALUES
(101, 1, 2),
(102, 2, 5),
(103, 3, 3),
(104, 1, 1);


SELECT products3.product_name, SUM(orders2.quantity * products3.price) AS total_sales
FROM products3
INNER JOIN orders2
ON products3.product_id = orders2.product_id
GROUP BY products3.product_name;


Question: 10

CREATE TABLE customers1 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT
);

CREATE TABLE products1 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO customers1 (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');

INSERT INTO products1 (product_id, product_name, price) VALUES
(1, 'Laptop', 1000.00),
(2, 'Mouse', 20.00);

INSERT INTO orders1 (order_id, customer_id, product_id, quantity) VALUES
(1, 1, 1, 2),
(2, 2, 2, 5),
(3, 1, 2, 3);



SELECT orders1.order_id, customers1.customer_name, orders1.quantity
FROM orders1
INNER JOIN customers1
ON orders1.customer_id = customers1.customer_id
INNER JOIN products1
ON orders1.product_id = products1.product_id;



########################################################################################
##########################################################################################
##########################################################################################


------------------------PART: 2---------------------------------------
------------------------SQL Commands-------------------------------------

-- 1. Identify the primary keys and foreign keys in maven movies DB

-- Primary Keys:
-- Primary keys uniquely identify each record in a table. Examples:

-- actor_id in the actor table
-- film_id in the film table
-- customer_id in the customer table
-- Foreign Keys:
-- Foreign keys enforce relationships between tables. Examples:

-- language_id in the film table referencing language_id in the language table
-- customer_id in the rental table referencing customer_id in the customer table
-- Differences:

-- A primary key ensures uniqueness in one table, while a foreign key links records across two tables.
-- Primary keys cannot have null values; foreign keys can.

-- 2. List all details of actors
SELECT * FROM actors;

-- 3. List all customer information
SELECT * FROM customers;

-- 4. List different countries
SELECT DISTINCT country FROM customers;

-- 5. Display all active customers
SELECT * FROM customers WHERE active = 1;

-- 6. List all rental IDs for customer with ID 1
SELECT rental_id FROM rentals WHERE customer_id = 1;

-- 7. Display all films whose rental duration is greater than 5
SELECT * FROM films WHERE rental_duration > 5;

-- 8. Count films with replacement cost > $15 and < $20
SELECT COUNT(*) AS film_count FROM films WHERE replacement_cost > 15 AND replacement_cost < 20;

-- 9. Count unique first names of actors
SELECT COUNT(DISTINCT first_name) AS unique_names FROM actors;

-- 10. Display first 10 records from customer table
SELECT * FROM customers LIMIT 10;

-- 11. Display first 3 customers with first name starting with 'B'
SELECT * FROM customers WHERE first_name LIKE 'B%' LIMIT 3;

-- 12. Display first 5 movies rated 'G'
SELECT * FROM films WHERE rating = 'G' LIMIT 5;

-- 13. Find customers whose first name starts with 'A'
SELECT * FROM customers WHERE first_name LIKE 'A%';

-- 14. Find customers whose first name ends with 'A'
SELECT * FROM customers WHERE first_name LIKE '%A';

-- 15. List first 4 cities starting and ending with 'A'
SELECT DISTINCT city FROM addresses WHERE city LIKE 'A%' AND city LIKE '%A' LIMIT 4;

-- 16. Find customers whose first name has 'NI'
SELECT * FROM customers WHERE first_name LIKE '%NI%';

-- 17. Find customers whose first name has 'R' as second letter
SELECT * FROM customers WHERE first_name LIKE '_R%';

-- 18. Customers whose first name starts with 'A' and has at least 5 characters
SELECT * FROM customers WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

-- 19. Customers whose first name starts with 'A' and ends with 'O'
SELECT * FROM customers WHERE first_name LIKE 'A%' AND first_name LIKE '%O';

-- 20. Get films with PG and PG-13 ratings
SELECT * FROM films WHERE rating IN ('PG', 'PG-13');

-- 21. Get films with length between 50 and 100
SELECT * FROM films WHERE length BETWEEN 50 AND 100;

-- 22. Get top 50 actors using LIMIT
SELECT * FROM actors LIMIT 50;

-- 23. Get distinct film IDs from inventory table
SELECT DISTINCT film_id FROM inventory;




########################################################################################
########################################################################################
#####################################################################################

----------------------------PART_3-------------------------------------------------

-------------------------------Functions-------------------------------------------


--Question:1
SELECT COUNT(*) AS total_rentals FROM rental;

--Question:2
SELECT AVG(rental_duration) AS avg_rental_duration FROM film;

--Question:3
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper FROM customer;

--Question:4

SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

--Question:5

SELECT customer_id, COUNT(*) AS rental_count 
FROM rental 
GROUP BY customer_id;

--Question:6

SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
INNER JOIN rental r ON p.rental_id = r.rental_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

--Question:7

SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

--Question:8

SELECT l.name AS language_name, AVG(f.rental_rate) AS avg_rental_rate
FROM film f
INNER JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

--Question:9

SELECT 
    film.title AS movie_title,
    customer.first_name AS customer_first_name,
    customer.last_name AS customer_last_name
FROM 
    film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id;


--Question:10

SELECT 
    actor.first_name,
    actor.last_name
FROM 
    film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE 
    film.title = 'Gone with the Wind';


--Question:11

SELECT 
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_spent
FROM 
    customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY 
    customer.customer_id, customer.first_name, customer.last_name;


--Question:12
SELECT 
    customer.first_name,
    customer.last_name,
    film.title AS movie_title
FROM 
    customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE 
    city.city = 'London'
GROUP BY 
    customer.first_name, customer.last_name, film.title;


--Question:13

SELECT 
    film.title AS movie_title,
    COUNT(rental.rental_id) AS rental_count
FROM 
    film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY 
    film.title
ORDER BY 
    rental_count DESC
LIMIT 5;


--Question:14

SELECT 
    customer.first_name,
    customer.last_name
FROM 
    customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
WHERE 
    inventory.store_id = 1
INTERSECT
SELECT 
    customer.first_name,
    customer.last_name
FROM 
    customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
WHERE 
    inventory.store_id = 2;



########################################################################################
#########################################################################################
########################################################################################


--------------------------------------Part-04-------------------------------------
---------------------------------------Windows Functions-------------------------

--Question: 1

SELECT 
    customer_id,
    first_name,
    last_name,
    SUM(payment.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(payment.amount) DESC) AS rank
FROM 
    payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY 
    customer_id, first_name, last_name;


--Question: 2


SELECT 
    film.title,
    rental.rental_date,
    SUM(payment.amount) OVER (PARTITION BY film.film_id ORDER BY rental.rental_date) AS cumulative_revenue
FROM 
    payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id;


--Question: 3

SELECT 
    film.title,
    film.length,
    AVG(DATEDIFF(rental.return_date, rental.rental_date)) OVER (PARTITION BY film.length) AS avg_rental_duration
FROM 
    rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id;


--Question: 4

SELECT 
    category.name AS category,
    film.title,
    COUNT(rental.rental_id) AS rental_count,
    RANK() OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC) AS rank
FROM 
    rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY 
    category.name, film.title
HAVING rank <= 3;


--Question: 5

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_rentals,
    COUNT(rental.rental_id) - AVG(COUNT(rental.rental_id)) OVER () AS rental_diff
FROM 
    rental
JOIN customer ON rental.customer_id = customer.customer_id
GROUP BY 
    customer.customer_id, customer.first_name, customer.last_name;



--Question: 6

SELECT 
    YEAR(rental.rental_date) AS year,
    MONTH(rental.rental_date) AS month,
    SUM(payment.amount) AS monthly_revenue
FROM 
    payment
JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY 
    YEAR(rental.rental_date), MONTH(rental.rental_date)
ORDER BY 
    year, month;


--Question: 7

WITH total_spending AS (
    SELECT 
        customer_id,
        SUM(payment.amount) AS total_spent
    FROM 
        payment
    GROUP BY 
        customer_id
)
SELECT 
    customer_id,
    total_spent
FROM 
    total_spending
WHERE 
    total_spent >= PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_spent) OVER ();


--Question: 8

SELECT 
    category.name AS category,
    COUNT(rental.rental_id) AS rental_count,
    SUM(COUNT(rental.rental_id)) OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC) AS running_total
FROM 
    rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY 
    category.name;


--Question: 9

SELECT 
    film.title,
    category.name AS category,
    COUNT(rental.rental_id) AS rental_count
FROM 
    rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY 
    film.title, category.name
HAVING 
    COUNT(rental.rental_id) < AVG(COUNT(rental.rental_id)) OVER (PARTITION BY category.name);


--Question: 10


SELECT 
    YEAR(rental.rental_date) AS year,
    MONTH(rental.rental_date) AS month,
    SUM(payment.amount) AS monthly_revenue
FROM 
    payment
JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY 
    YEAR(rental.rental_date), MONTH(rental.rental_date)
ORDER BY 
    monthly_revenue DESC
LIMIT 5;






############################################################################################
################################################################################################
################################################################################################

------------------------------------------Part-05-----------------------------------
--------------------------------Normalisation & CTE------------------------------------


---Question-6:

WITH FilmDetails AS (
    SELECT 
        film.title AS film_title,
        language.name AS language_name,
        film.rental_rate
    FROM 
        film
    JOIN language ON film.language_id = language.language_id
)
SELECT * FROM FilmDetails;


---Question-7:

WITH CustomerRevenue AS (
    SELECT 
        customer.customer_id,
        customer.first_name,
        customer.last_name,
        SUM(payment.amount) AS total_revenue
    FROM 
        customer
    JOIN payment ON customer.customer_id = payment.customer_id
    GROUP BY 
        customer.customer_id, customer.first_name, customer.last_name
)
SELECT * FROM CustomerRevenue;

---Question-8:
WITH FilmRankings AS (
    SELECT 
        film.title,
        RANK() OVER (ORDER BY film.rental_duration DESC) AS rank
    FROM 
        film
)
SELECT * FROM FilmRankings;

---Question-9:
WITH FrequentCustomers AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM 
        rental
    GROUP BY 
        customer_id
    HAVING rental_count > 2
)
SELECT 
    customer.first_name,
    customer.last_name
FROM 
    customer
JOIN FrequentCustomers ON customer.customer_id = FrequentCustomers.customer_id;

---Question-10:
WITH MonthlyRentals AS (
    SELECT 
        YEAR(rental_date) AS rental_year,
        MONTH(rental_date) AS rental_month,
        COUNT(*) AS rental_count
    FROM 
        rental
    GROUP BY 
        YEAR(rental_date), MONTH(rental_date)
)
SELECT * FROM MonthlyRentals;

---Question-11:
WITH ActorPairs AS (
    SELECT 
        a1.actor_id AS actor1_id,
        a2.actor_id AS actor2_id,
        fa1.film_id
    FROM 
        film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    JOIN actor a1 ON fa1.actor_id = a1.actor_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id
    WHERE a1.actor_id < a2.actor_id
)
SELECT * FROM ActorPairs;

---Question-12:
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM 
        staff
    WHERE 
        staff_id = <manager_id>
    UNION ALL
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM 
        staff s
    JOIN EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM EmployeeHierarchy;
