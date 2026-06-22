-- Name: Faris Beg
-- Group: C

-- 1.  List the last names of actors (alphabetically), as well as how many actors have that last name.

SELECT last_name, COUNT(*) AS count_of_actors
FROM actor
GROUP BY last_name
ORDER BY last_name asc;


-- 2.  List last names of actors and the number of actors who have that last name, but only for names 
-- that are shared by at least three actors, sort so that last name with the highest number of actors appears at the top.

select last_name, COUNT(*) as count_of_actors
from actor 
group by last_name 
having COUNT(*) >= 3
order by count_of_actors desc;


-- 3.  List all comedy films (regardless of other genres) by displaying the title and film year and 
-- sort by revenue_mils so that the highest appears first.


select movies.genre, movies.title, movies.film_year, movies.revenue_mils  
from movies  
where movies.genre like '%Comedy%'
order by movies.revenue_mils desc; 

--NOTE: KEEPING GENRE AND REVENUE COLUMNS FOR VERIFICATION

-- 4.  Display how many films there are in the database for each year. Output should only contain the
-- year and number of films with oldest films appearing first.

select film_year, count(*)
from movies
group by film_year
order by film_year asc;


-- 5.  Show all directors who have directed more than 4 films. The output should contain their names and
-- number of films they have directed. The output should show directors with more films at the top, and if
-- there is a tie, sort alphabetically.


select director as director_name, count(*) as number_of_films_directed
from movies
group by director
having count(*) > 4
order by number_of_films_directed desc, director_name asc;



-- 6.  Display the highest revenue amount for each year – output should show the film_year and revenue_mils
-- and it should show oldest films first.

select film_year, MAX(revenue_mils) as highest_revenue_each_year
from movies
group by film_year
order by film_year asc;


-- 7.  List highest postal codes for all districts starTing with either A, B, C, or D ordered by the starting letter.

select MAX(postal_code) as maximum_code, district
from address
where left (district, 1) in ('A','B','C','D') 
group by district
order by district asc;

-- 8.  Show the ID and average money spent, rounded to 3 decimal points, from 15 top spending customers 
-- (by average spent) that spent below 4.5 so that customers who spent more appear at the top.

select customer_id, ROUND(AVG(amount),3) as avg_spent
from payment
group by customer_id
having ROUND(AVG(amount),3) < 4.5 
order by avg_spent desc
limit 15;


-- 9.  Show the total number of actors who share their last name with 3 or more other actors.

select count(*)
from actor 
where last_name IN
(select last_name
from actor
group by last_name 
having count(*) >= 3
);

--3 OTHERS BESIDES THEMSELVES? then it will be >= 4 OR 3 OTHERS INCLUDING THEMSELVES?

-- 10. Show the total revenue by month. Hint: Research “EXTRACT”.

select SUM(p.amount) as total_revenue, EXTRACT(MONTH from p.payment_date) as month_number
from payment p
group by EXTRACT(MONTH from p.payment_date)
order by month_number asc;



