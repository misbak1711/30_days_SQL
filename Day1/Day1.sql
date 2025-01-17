---------------------------- FOOD DELIVERY CASE STUDY -------------------------

-- Create Database for CraveCart --
create database cravecart;

-- Select database cravecart to use --
use cravecart;

-- Add Tables to Database --
Create Table Customers (
	customerid int NOT NULL IDENTITY PRIMARY KEY,
	name varchar(50),
	email varchar(50),
	phone varchar(50),
	address varchar(50),
	created_at date);

Create Table Restaurants (
	restaurant_id int NOT NULL IDENTITY PRIMARY KEY,
	name varchar(50),
	cuisine_type varchar(50),
	location varchar(50),
	rating float,
	created_at date);

Create Table Agents(
	agent_id int NOT NULL IDENTITY PRIMARY KEY,
	name varchar(50),
	phone varchar(50),
	rating float,
	vehicle_type varchar(50));

Create Table Orders(
	order_id int NOT NULL IDENTITY PRIMARY KEY,
	customerid int NOT NULL references Customers(customerid),
	restaurant_id int NOT NULL references Restaurants(restaurant_id),
	agent_id int NOT NULL references Agents(agent_id),
	order_date date,
	amount float,
	status varchar(50));

-- Insert Data --
INSERT INTO Customers (name, email, phone, address, created_at)
VALUES
('Alice Johnson', 'alice.johnson@example.com', '555-1234', '123 Maple St, Toronto', '2024-01-05'),
('Bob Smith', 'bob.smith@example.com', '555-5678', '456 Oak Ave, Toronto', '2024-01-10'),
('Charlie Davis', 'charlie.davis@example.com', '555-8765', '789 Pine Rd, Toronto', '2024-01-12');

INSERT INTO Customers (name, email, phone, address, created_at)
VALUES
('David Lee', 'david.lee@example.com', '555-0104','101 Pine Rd, Toronto, ON, M5A 1A4',  '2025-01-03'),
('Eva Davis', 'eva.davis@example.com', '555-0105', '202 Birch Ln, Toronto, ON, M5A 1A5',  '2025-01-02');

INSERT INTO Restaurants (name, cuisine_type, location, rating, created_at)
VALUES
('Pizza Paradise', 'Italian', 'Downtown', 4.5, '2023-12-15'),
('Sushi Delight', 'Japanese', 'Uptown', 4.8, '2023-11-20'),
('Taco Town', 'Mexican', 'West End', 4.2, '2023-10-30'),
('Burger King', 'American', 'Downtown', 3.9, '2023-09-25'),
('Vegan Vibes', 'Vegan', 'East End', 4.6, '2023-10-05'),
('Curry Corner', 'Indian', 'South End', 4.3, '2023-08-15'),
('Pho Fusion', 'Vietnamese', 'Uptown', 4.7, '2023-11-01'),
('The BBQ Shack', 'Barbecue', 'West End', 4.5, '2023-12-10'),
('Dim Sum House', 'Chinese', 'Chinatown', 4.4, '2023-07-20'),
('Pasta Express', 'Italian', 'Downtown', 4.2, '2023-06-15'),
('Fish & Chips Co.', 'British', 'North End', 3.8, '2023-05-22'),
('Tandoor Delight', 'Indian', 'East End', 4.6, '2023-08-01'),
('Sushi Supreme', 'Japanese', 'Bay Area', 4.9, '2023-09-10');

INSERT INTO Orders (customerid, restaurant_id, order_date, amount, status, agent_id)
VALUES
(1, 4, '2024-01-05', 67.00, 'Delivered', 3),
(2, 2, '2024-01-08', 18.75, 'Delivered', 2),
(3, 3, '2024-01-09', 15.00, 'Pending', 3),
(1, 2, '2024-01-10', 30.00, 'Cancelled', 1),
(2, 1, '2024-01-11', 22.30, 'Delivered', 2);

INSERT INTO Agents (name, phone, rating, vehicle_type)
VALUES
('David Lee', '555-1111', 4.6, 'Bike'),
('Emma Wilson', '555-2222', 4.8, 'Car'),
('Frank Moore', '555-3333', 4.3, 'Bike');

-- Use Cases -- 

--1) Retrieve all customer details from the Customers table

SELECT * FROM Customers;


--2) Find all orders with a status of 'Delivered'
Select * from Orders where status = 'Delivered';


--3) List the top 5 restaurants with the highest ratings.
SELECT TOP 5 * 
FROM Restaurants 
ORDER BY rating DESC, restaurant_id ASC;


--4) Display a list of all orders, including the customer name and restaurant name.
select order_id, 
	r.name, 
	c.name 
from orders 
join Restaurants r on Orders.restaurant_id = r.restaurant_id
join Customers c on Orders.customerid = c.customerid;


--5) Calculate the total revenue generated from all orders.
select sum(amount) as total_revenue from Orders;
	

--6) List all the orders delivered by agents with a rating greater than 4.5
select o.order_id, 
	a.name, 
	a.rating 
from orders o
join agents a on o.agent_id = a.agent_id
where a.rating > 4.5
order by rating desc;


--7) Find all customers who signed up in the last 30 days
select * from customers
where created_at >= dateadd(day, -30, GETDATE())


--8) Show the total number of orders and revenue generated by each restaurant
select r.restaurant_id, 
	r.name as Restaurant_name, 
	COUNT(o.order_id)as Total_orders, 
	sum(o.amount) as Revenue 
from Restaurants r 
left join orders o on r.restaurant_id = o.restaurant_id
group by r.restaurant_id, r.name;


--9) Find customers who have spent more than the average order amount
select c.customerid, c.name, sum(o.amount) as amount
from Customers c
join orders o on c.customerid = o.customerid
group by c.customerid, c.name
having sum(o.amount) > (select avg(amount)from Orders);


--10) Identify the most popular cuisine type based on the number of orders
select top 1 r.cuisine_type, count(o.order_id) as total_orders
from orders o
join Restaurants r on o.restaurant_id = r.restaurant_id
group by r.cuisine_type
order by total_orders desc; 








