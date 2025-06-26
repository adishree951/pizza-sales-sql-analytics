create database dominos;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id)
);

create table orders_details(
order_details_id int not null,
order_id int not null,
pizaa_id text not null,
quantity int not null,
primary key(order_details_id)
);

select * from dominos.orders_details;
select * from dominos.pizzas;
-- BASIC
-- retrieve the total number of order placed.

select * from orders;
select count(order_id) as total_orders from orders ;

-- calculate the total revenue generated from pizza sales

select * from orders_details;

SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizaa_id; 
    
-- idemtify the highest priced pizza

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- identify the most common pizza size ordered

SELECT 
    pizzas.size,
    COUNT(orders_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizaa_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- list the top 5 most ordered pizza types long with their quantities

select pizza_types.name,
sum(orders_details.quantity) as quantity
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizaa_id=pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5 ;

-- INTERMEDIATE
-- JOIN THE NECESSARY TABLES TO FIND THE TOTAL QUANTITY OF PIZZA CATEGORY ORDERED

SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizaa_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- determine the distribution by hour of the day

SELECT 
    HOUR(order_time) as hours, COUNT(order_id) as order_count
FROM
    orders
GROUP BY hours
ORDER BY hours ASC;

-- join relevant tables to find the category wise distribution of pizzas

select category, count(name) from pizza_types
group by category;

-- group the orders by date and calculate the avg number of pizzas ordered per day 

SELECT 
    ROUND(AVG(quantity), 0)
FROM
    (SELECT 
        orders.order_date, SUM(orders_details.quantity) AS quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    
-- determine the top 3 most ordered pizza type based on revenue 

SELECT 
    pizza_types.name,
    sum(orders_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizaa_id = pizzas.pizza_id
    group by pizza_types.name order by revenue desc limit 3;
    
-- ADVANCED
-- calculate the percentage contribution of each pizza type to total revenue 

select pizza_types.category,
sum(orders_details.quantity* pizzas.price) as revenue 
from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id
join orders_details
on orders_details.pizaa_id = pizzas.pizza_id
group by pizza_types.category order by revenue desc;





























