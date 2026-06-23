--1) retrieves all books in the fiction genre:
select * from books
where genre = 'Fiction';

--2) find books published after the year 1950:
select * from books
where published_year>1950;

--3) List all the customers from the canada:
select * from customers
where country = 'Canada';

--4) Show orders placed in november 2023:
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

--5) retrieves the total stock of books available;
select count(stock) from books;

--6) Find the details of the most expensive book:
select * from books order by price desc limit 1;

--7) Show all the customers who ordered more than 1 quantity of book:
select * from orders
where quantity >1;

--8) retrieves all orders where the total amount exceeds 20:
select * from orders
where total_amount >20;

--9) List all the genre available in the book market:
select distinct genre from books;

--10) find the book with the lowest stock:
select * from books
where stock<1;

--11) Calculate the total revenue generated from all orders:
select sum(total_amount) as total_revenue
from orders;

--12) Retrives the total number of books sold for each genre;
select b.genre, sum(o.quantity) as total_books_sold
from orders o
join books b
on b.book_id =o.book_id
group by b.genre;

--13) Find the average price of books in the fantasy genre:
select avg(price) from books
where genre = 'Fantasy';

--14) List customers who have placed at least 2 orders:
select customer_id, count(order_id) as order_count
from orders
group by customer_id
having count(order_id)>=2;

--15) Find the most frequently ordered book:
select book_id, count(order_id) as order_count
from orders
group by book_id
order by order_count desc limit 1;

--16) Show the top 3 most expensive books of the fantasy genre:
select * from books where genre ='Fantasy'
order by price desc limit 3;

--17) retrieves the total quantity of books sold by each author:
select b.author, sum(o.quantity) as total_books_sold
from orders o
join books b
on o.book_id =b.book_id
group by b.author;

--18) List the cities where customers who spent over 300 are located;
select distinct c.city, o.total_amount 
from orders o
join customers c
on c.customer_id=o.customer_id
where o.total_amount>30;

--19) Find the customers who spend the most on orders:
select customer_id, sum(total_amount) as total_spent
from orders
group by customer_id
order by total_spent desc;

--20) Calculate the stock remaining after fulfilling all orders:
select b.book_id, b.title, b.stock, coalesce (sum(o.quantity),0) as order_quantity,
b.stock - coalesce (sum(o.quantity),0) as remaining_quantity
from books b
left join orders o on b.book_id =o.book_id
group by b.book_id order by b.book_id
