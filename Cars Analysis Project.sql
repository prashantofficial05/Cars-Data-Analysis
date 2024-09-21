-- Cars Table
CREATE TABLE cars (
    car_id INT PRIMARY KEY,
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT,
    price DECIMAL(10, 2),
    horsepower INT,
    fuel_type VARCHAR(20),
    transmission VARCHAR(20),
    seating_capacity INT
);

-- Dealerships Table
CREATE TABLE dealerships (
    dealership_id INT PRIMARY KEY,
    dealership_name VARCHAR(100),
    location VARCHAR(100),
    contact_number VARCHAR(15)
);

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(100)
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    car_id INT,
    customer_id INT,
    dealership_id INT,
    sale_price DECIMAL(10, 2),
    sale_date DATE,
    FOREIGN KEY (car_id) REFERENCES cars(car_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (dealership_id) REFERENCES dealerships(dealership_id)
);

-- Feedback Table
CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    customer_id INT,
    car_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments VARCHAR(255),
    feedback_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (car_id) REFERENCES cars(car_id)
);

-- Insert data into Cars table
INSERT INTO cars VALUES
(1, 'Jaguar', 'F-Type', 2023, 75000.00, 450, 'Gasoline', 'Automatic', 2),
(2, 'Jaguar', 'XE', 2022, 55000.00, 300, 'Gasoline', 'Automatic', 5),
(3, 'Jaguar', 'E-Pace', 2021, 45000.00, 250, 'Diesel', 'Automatic', 5),
(4, 'Range Rover', 'Evoque', 2023, 60000.00, 300, 'Gasoline', 'Automatic', 5),
(5, 'Range Rover', 'Velar', 2022, 80000.00, 400, 'Diesel', 'Automatic', 5),
(6, 'Jaguar', 'I-Pace', 2023, 85000.00, 395, 'Electric', 'Automatic', 5),
(7, 'Range Rover', 'Sport', 2021, 90000.00, 550, 'Gasoline', 'Automatic', 5),
(8, 'Jaguar', 'XF', 2020, 70000.00, 375, 'Gasoline', 'Automatic', 5),
(9, 'Range Rover', 'Defender', 2023, 95000.00, 525, 'Diesel', 'Automatic', 5),
(10, 'Jaguar', 'XJ', 2021, 60000.00, 340, 'Gasoline', 'Automatic', 5);

-- Insert data into Dealerships table
INSERT INTO dealerships VALUES
(1, 'Luxury Motors', 'New York, NY', '123-456-7890'),
(2, 'Elite Cars', 'Los Angeles, CA', '987-654-3210'),
(3, 'Royal Drive', 'Miami, FL', '555-123-4567'),
(4, 'Prestige Auto', 'Houston, TX', '444-987-6543'),
(5, 'Prime Auto', 'Chicago, IL', '222-555-7890');

-- Insert data into Customers table
INSERT INTO customers VALUES
(1, 'John', 'Doe', 'Male', 35, 'New York'),
(2, 'Jane', 'Smith', 'Female', 28, 'Los Angeles'),
(3, 'James', 'Bond', 'Male', 45, 'Miami'),
(4, 'Emily', 'Davis', 'Female', 38, 'Houston'),
(5, 'Michael', 'Johnson', 'Male', 50, 'Chicago'),
(6, 'Sarah', 'Brown', 'Female', 32, 'New York'),
(7, 'Robert', 'Lee', 'Male', 40, 'Los Angeles'),
(8, 'Olivia', 'Garcia', 'Female', 29, 'Miami'),
(9, 'David', 'Martinez', 'Male', 44, 'Houston'),
(10, 'Sophia', 'Wilson', 'Female', 26, 'Chicago');

-- Insert data into Sales table
INSERT INTO sales VALUES
(1, 1, 1, 1, 75000.00, '2023-06-15'),
(2, 2, 2, 2, 54000.00, '2023-05-20'),
(3, 4, 3, 3, 60000.00, '2023-07-10'),
(4, 6, 4, 4, 85000.00, '2023-08-01'),
(5, 8, 5, 5, 70000.00, '2023-09-05'),
(6, 5, 6, 2, 80000.00, '2023-05-25'),
(7, 3, 7, 1, 45000.00, '2023-06-12'),
(8, 9, 8, 3, 95000.00, '2023-07-18'),
(9, 7, 9, 4, 90000.00, '2023-08-23'),
(10, 10, 10, 5, 60000.00, '2023-09-10');

-- Insert data into Feedback table
INSERT INTO feedback VALUES
(1, 1, 1, 5, 'Great car! Love the performance.', '2023-06-20'),
(2, 2, 2, 4, 'Comfortable but a bit pricey.', '2023-05-25'),
(3, 3, 4, 5, 'Smooth drive and great features.', '2023-07-15'),
(4, 4, 6, 5, 'Excellent electric car!', '2023-08-05'),
(5, 5, 8, 4, 'Stylish but fuel efficiency could be better.', '2023-09-08'),
(6, 6, 5, 5, 'Luxurious and powerful.', '2023-06-01'),
(7, 7, 3, 3, 'Good but expected more from the brand.', '2023-06-18'),
(8, 8, 9, 5, 'Love the rugged look and feel.', '2023-07-20'),
(9, 9, 7, 4, 'High performance but expensive.', '2023-08-25'),
(10, 10, 10, 4, 'Good value for money.', '2023-09-12');

-- (EDA):
-- Sales Summary:
-- Find total revenue and number of cars sold by each car brand.
SELECT brand, COUNT(*) AS total_cars_sold, SUM(sale_price) AS total_revenue
FROM cars c
JOIN sales s ON c.car_id = s.car_id
GROUP BY brand;

--Popular Models:
-- Identify which car models are the most popular (sold the most).
select model,count(*) as cars_sold
from cars c
join sales s on c.car_id = s.car_id
group by model
order by cars_sold desc;

--Revenue by Dealership:
-- Find which dealership generates the most revenue.
select d.dealership_name, sum(s.sale_price) as total_revenue, 
                  count(s.sale_id) as total_sales
from sales s
join dealerships d on s.dealership_id = d.dealership_id
group by d.dealership_name
order by total_revenue desc;

-- Customer Feedback and Ratings:
-- Find the average rating for each car model.
select c.model, avg(f.rating) as avg_rating
from feedback f
join cars s on f.car_id = c.car_id
group by c.model
order by avg_rating desc;

 --Data Cleaning:
--Missing Sales Data:
-- Find if there are any records in the sales table that do not have corresponding data in the cars table.
select *
from sales 
where car_id not in (select car_id from cars);

--Duplicate Customer Entries:
-- Check for duplicate customers by name.
select first_name, last_name, count(*)
from customers
group by first_name, last_name
having count(*) > 1;

-- Invalid Feedback Ratings:
-- Find records in the feedback table 
--where ratings are outside the allowed range (1 to 5).
select * 
from feedback
where rating < 1 OR rating > 5;

--Advanced Data Analysis:
--a) Top Performing Car Models Based on Feedback and Sales:
--Combine sales and feedback data to find the most popular and highly-rated models.
select c.model, count(s.sale_id) as cars_sold, avg(f.rating) as avg_rating
from cars c
left join sales s on c.car_id = s.car_id
left join feedback f on c.car_id = f.car_id
group by c.model
order by cars_sold desc, avg_rating desc;

--Customer Demographics Analysis:
--Query: Analyze customer demographics and identify trends in car purchases.
select city, count(*) as total_customers, avg(age) as avg_age
from customers c 
join sales s on c.customer_id = s.customer_id
group by city
order by total_customers desc;




























