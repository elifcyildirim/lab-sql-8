USE sakila;
-- q1 Write a query to display for each store its store ID, city, and country.
-- SELECT * FROM store;
-- SELECT * FROM address;
-- SELECT * FROM city;
-- SELECT * FROM country;

SELECT s.store_id, c.city, co.country FROM store s
JOIN address a
ON s.address_id= a.address_id
JOIN city c
ON a.city_id= c.city_id
JOIN country co
ON c.country_id=co.country_id;

-- q2 Write a query to display how much business, in dollars, each store brought in.
-- SELECT * FROM payment;
-- SELECT * FROM staff;
-- SELECT * FROM store;

SELECT s.store_id, SUM(p.amount) FROM staff s
JOIN payment p
ON p.staff_id=s.staff_id
JOIN store sto
ON sto.store_id=s.store_id
GROUP BY s.store_id;

-- q3 Which film categories are longest? TOP 3 BASED ON AVG LENGTH PER CATE.: SPORTS, GAMES, FOREIGN

SELECT c.name, AVG(f.length) FROM category c
JOIN film_category fc
ON c.category_id=fc.category_id
JOIN film f
ON fc.film_id=f.film_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC
LIMIT 3;

-- q4 Display the most frequently rented movies in descending order.

-- I NEED TO FIGURE OUT THE WAYS TO WORK WITH DATES IN SQL. 

-- q5 List the top five genres in gross revenue in descending order.

SELECT c.category_id, c.name, SUM(p.amount) FROM payment p
JOIN rental r
ON p.rental_id=r.rental_id
JOIN inventory i
ON i.inventory_id=r.inventory_id
JOIN film_category fc
ON i.film_id=fc.film_id
JOIN category c
ON c.category_id=fc.category_id
GROUP BY c.category_id
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- q6 Is "Academy Dinosaur" available for rent from Store 1?

-- SELECT i.film_id, f.title ,r.return_date, i.store_id FROM inventory i
-- LEFT JOIN rental r
-- ON i.inventory_id = r.inventory_id
-- JOIN film f
-- ON i.film_id=f.film_id
-- WHERE i.film_id=1 AND i.store_id=1;

SELECT COUNT(*) AS "number of available copies of Academy Dinosaur in Store #1" FROM inventory i
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN film f
ON i.film_id=f.film_id
WHERE i.film_id=1 AND i.store_id=1 AND return_date is null ;

-- q7 Get all pairs of actors that worked together. 

SELECT fa1.film_id, fa1.actor_id, fa2.actor_id -- HOW DO I GET RID OF THE DUPLICATE ROWS IN THE RESULT (e.g. Pair A-B and B-A appears in the seach although only A-B would be enough)?
FROM film_actor fa1
JOIN film_actor fa2
ON (fa1.actor_id <> fa2.actor_id) AND (fa1.film_id = fa2.film_id);

-- q8 Get all pairs of customers that have rented the same film more than 3 times.


-- q9 For each film, list actor that has acted in more films.