-- Initalize database
USE sakila;

-- 1a. List all acotrs from actor table 
SELECT first_name, last_name 
FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
select UPPER(CONCAT(first_name, ' ', last_name)) as `Actor_Name`
from actor;

-- 2a.You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b. Find all actors whose last name contain the letters GEN:
SELECT *
FROM actor
WHERE last_name like '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT *
FROM actor
WHERE last_name like '%LI%'
ORDER BY last_name,first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country = "Afghanistan" OR country = "Bangladesh" OR country =  "China";

-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
ALTER TABLE actor
ADD middle_name varchar(255)
AFTER first_name;

-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
ALTER TABLE actor
MODIFY middle_name blob;

-- 3c. Now delete the middle_name column.
ALTER TABLE actor
DROP COLUMN middle_name;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT COUNT(last_name), last_name
FROM actor
GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT COUNT(last_name), last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 2; -- WHERE clause cannot be used due to aggregate function; HAVING clause used instead

-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
SELECT * -- Query to confirm "GROUCHO WILLIAMS"
from actor,actor.actor_id
Where first_name = "GROUCHO"
AND last_name = "WILLIAMS";

UPDATE actor
SET first_name = "HARPO"
Where first_name = "GROUCHO"
AND last_name = "WILLIAMS";

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)
UPDATE actor
set first_name = "GROUCHO"
Where first_name = "HARPO"
AND last_name = "WILLIAMS" and actor_id = 172;

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE sakila.address;
SHOW COLUMNS FROM address;
EXPLAIN sakila.address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN address a
ON s.address_id=a.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) as 'Total Amount Spent by Each Member in 2005'
FROM staff s
INNER JOIN payment p 
ON s.staff_id = p.staff_id
Where p.payment_date >'2005-07-31 02:42:18' -- Time period: August 2005
AND p.payment_date <'2005-09-1 02:42:18'
GROUP BY s.staff_id;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT f.title, COUNT(fa.actor_id) as 'Actor Count'
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.film_id;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT f.title, COUNT(inv.store_id) as 'Invt. Count'
FROM film f
INNER JOIN inventory inv
ON f.film_id = inv.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.film_id;

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT c.last_name, SUM(p.amount) as 'Total Amount Spent by Each Customer'
FROM customer c
INNER JOIN payment p 
ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

SELECT title
FROM  film
WHERE (title LIKE 'Q%' OR title LIKE 'K%' ) IN
(SELECT language_id
FROM language
WHERE name = 'ENGLISH');
    
-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(SELECT actor_id
	FROM film_actor
	WHERE film_id IN
		(SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'));


-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT first_name, last_name, email
FROM customer cu
LEFT JOIN address ad 
ON cu.address_id = ad.address_id
LEFT JOIN city ci
ON ci.city_id = ad.city_id
LEFT JOIN country co
ON co.country_id = ci.country_id
WHERE country = "Canada";

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films. film, film_category, category

SELECT title 
FROM film 
WHERE film_id IN
(
  SELECT film_id
  FROM film_category 
  WHERE category_id IN
  (
    SELECT category_id
    FROM category 
    WHERE name = 'Family'
  ) 
);
-- 7e. Display the most frequently rented movies in descending order.

-- 7f. Write a query to display how much business, in dollars, each store brought in.

-- 7g. Write a query to display for each store its store ID, city, and country.

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)



-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.


-- 8b. How would you display the view that you created in 8a?


-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
