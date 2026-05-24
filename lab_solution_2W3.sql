
USE sakila;
-- Challenge 1
-- 1.1 Determine the shortest and longest movie durations and name the values 
-- as max_duration and min_duration.
-- Determining shortest movies durations
SELECT title, length AS min_duration
FROM sakila.film
WHERE length = (SELECT MIN(length) FROM sakila.film);

-- Determining longest movies durations
SELECT title, length AS max_duration
FROM sakila.film
WHERE length = (SELECT MAX(length) FROM sakila.film);

-- 1.2. Express the average movie duration in hours and minutes. 
-- Don't use decimals.
SELECT CONCAT(floor(AVG(length)/60), 'h', MOD(floor(AVG(length)),60), 'min') 
AS average_movie_duration 
FROM sakila.film; 

-- 2.1 Calculate the number of days that the company has been operating
-- first rental date
SELECT DATEDIFF(
	MAX(last_update),
    MIN(rental_date)) AS days_of_operation
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show 
-- the month and weekday of the rental. Return 20 rows of results.
SELECT *,  DATE_FORMAT(rental_date, '%M') AS month_rented,
	DAYNAME(rental_date) AS weekday_rented
FROM sakila.rental LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 
-- 'weekend' or 'workday', depending on the day of the week.

-- 3. retrieve the film titles and their rental duration. If any rental duration value is NULL, 
-- replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film ORDER BY title;
    
-- Challenge 2
-- 1.1 The total number of films that have been released.
SELECT COUNT(release_year) AS total_films_released FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rental_rate, COUNT(film_id) AS number_of_films FROM sakila.film 
GROUP BY rental_rate;

-- 1.3 The number of films for each rating, sorting the results in descending order of the 
-- number of films. This will help you to better understand the popularity of different film 
-- ratings and adjust purchasing decisions accordingly.
SELECT rental_rate, COUNT(film_id) AS number_of_films FROM sakila.film 
GROUP BY rental_rate ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of 
-- the mean duration. Round off the average lengths to two decimal places. This will help identify 
-- popular movie lengths for each category.
SELECT rental_rate, ROUND(AVG(length),2) AS mean_film_duration FROM sakila.film 
GROUP BY rental_rate ORDER BY mean_film_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for 
-- customers who prefer longer movies.
SELECT rental_rate, ROUND(AVG(length),2) AS mean_film_duration FROM sakila.film 
GROUP BY rental_rate
HAVING mean_film_duration>120 ORDER BY mean_film_duration DESC;








    

