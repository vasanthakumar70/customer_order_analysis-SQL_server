---Retrieve all columns from the Customer table.
Select * from customers

---Display the names of all customers.
Select distinct customername from customers 

 ---Show the unique cities in the Customer table.
Select distinct city from customers 

---Count the number of male and female customers.
Select
gender,
count (gender) 
From customers
Group by gender

----List the names and ages of customers in Bangalore.
Select customername, age from customers
Where city='bangalore'

---Calculate the average age of customers.
Select avg(age ) from customers 

---Find the total quantity of products ordered.
Select sum(quantity) as total_quantity_ordered from orders

---Show the customer names and the products they ordered.
Select c.customername ,p.productname
from customers c 
Join orders o on o.customerid=c.customerid
join Products p on o.productid=p.productid

--- Display the product names and their respective categories.
Select productname, catagory from products 
order by 2

---- Find the highest price among all products.
Select productname ,price  from products 
where price = (select max(price) from products)

----List the customers who are older than 30 years.
Select customername,age from customers where age >30

---Calculate the total number of customers in each city.
Select City, count (customerid) from
Customers group by city

---Show the product names and their prices in descending order.
Select productname, price from products
Order by price desc

---Display the names of customers who ordered a laptop.
Select c.customername from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid
Where p.productname='laptop'

---Find the customers who ordered more than 2 products.
Select c.customername ,count(o.orderid) from customers c 
Join orders o on o.customerid=c.customerid 
group by c.customername
Having count(o.orderid)>2

---Calculate the total quantity of each product ordered.
Select p.productname,sum(o.quantity) as total_quantity 
from orders o join
Products p on o.productid=p.productid
group by p.productname
Order by 2 desc

---List the names of customers who ordered a product priced over $100.
Select c.customername from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid
Where p.price>100

--- Show the names and ages of female customers in Pune.
  Select customername,age,city from customers
 Where gender='female' and city='pune'
 
 ---Display the customer names and the date of their orders.
Select c.customername,o.date from customers c 
Join orders o on o.customerid=c.customerid 
order by 2

---Find the average price of products.
Select productname,avg(price) from
Products group by productname

-- List the customers who ordered products in ascending order of age.
Select distinct c.customername,c.age from customers c 
Join orders o on o.customerid=c.customerid 
Order by age 

---Calculate the total price of each order.
Select o.orderid,o.quantity * p.price as total_price  
from orders  o
join
Products p on o.productid=p.productid
order by 2 desc

---Find the product names and categories ordered by the customers.
Select c.customername ,p.productname,p.catagory from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid

---Show the customer names and the total price of their orders.
Select c.customername ,sum(o.quantity * p.price) as total_price from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid
group by c.customername
order by 2 desc

----List the products with prices greater than the average price.
Select productname ,price from products
Where price > (select avg(price) from products)


---Find the product categories and the number of products in each category.
Select catagory,count(productname) from
Products group by catagory

---Show the customers who ordered products on August 5th, 2023.
Select c.customername ,o.date from customers c 
Join orders o on o.customerid=c.customerid where date='2023-08-5'


----Display the customers who ordered products in the 'Electronics' category.
Select c.customername from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid
Where p.catagory='electronics'

---Find the customers who ordered the same product more than once.

 with moreorders as (
Select o.customerid ,count(o.orderid) as totalorders from orders o
Join orders o1 on o.customerid=o1.customerid and o.orderid<>o1.orderid and o.productid=o1.productid
Group by o.customerid
Having count(o.orderid)>1)

select c.customerid,c.customername,m.totalorders from customers c
join moreorders m on c.customerid=m.customerid


---List the products ordered by male customers older than 30.
Select c.customername,c.gender,c.age,p.productname from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid
Where c.gender='male' and c.age>30

----Calculate the total quantity and total price for each order.
Select o.orderid,p.productname,p.price,o.quantity,p.price * o.quantity as total_price from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid
Order by 5 desc


----List the products ordered along with their quantities and total prices.
Select p.productname,p.price,sum(o.quantity),sum( p.price  * o.quantity) as total_price from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid
group by p.productname,p.price
Order by 4 desc

----Calculate the average age of male customers.
Select avg(age) from customers
Where gender='male'

---Display the names of customers who ordered the same product as 'Laptop'.
SELECT DISTINCT c.customername
FROM customers c
JOIN orders o ON c.customerid = o.customerid
JOIN products p ON o.productid = p.productid
WHERE p.productname = 'Laptop';

---List the product names that were not ordered by any customer.
Select productid from products where 
Productid not in (select distinct productid from orders)


----Show the customer names who placed orders on August 1st, 2023, and August 5th, 2023.
Select c.customername ,o.date from customers c 
Join orders o on o.customerid=c.customerid 
Where date='2023-08-1' or date='2023-08-05'

----For each customer, calculate the total number of products they have ordered in each category.
----Display the customer name, category name, and the total number of products ordered in that category. 
---Show only the top category for each customer.

Select top 10 c.customername,p.catagory, count (p.productname) from customers c 
Join orders o on o.customerid=c.customerid join
Products p on o.productid=p.productid
Group by c.customername,p.catagory
Order by 3 desc

---Calculate the Customer Lifetime Value (CLTV) for each customer. 
---CLTV is defined as the total amount a customer has spent on products divided by the number of days between their first and last order. 
---Display the customer name and their CLTV, ordered in descending order of CLTV.
SELECT 
    c.customername,
	sum(o.quantity * p.price)/abs(DATEDIFF(day,MAX(o.date), MIN(o.date)))  as cltv
FROM customers c 
join orders o ON o.customerid = c.customerid
join products p on o.productid=p.productid
group by c.customername
order by 2 desc


/* Find the customers who have placed orders for at least 3 different categories.
Display the customer name and the number of categories they have ordered from. */
SELECT c.customername,count(p.catagory)
FROM customers c
JOIN orders o ON c.customerid = o.customerid
JOIN products p ON o.productid = p.productid
group by c.customername
having count(p.catagory)>3


/*Calculate the month and year when each customer made their first order. 
Display the customer name and the month and year of their first order, ordered chronologically. */
select c.customername,concat(year(min(o.date)),'-',month(min(o.date)))
from orders o 
join customers c on  o.customerid=c.customerid
group by c.customername
order by 2
