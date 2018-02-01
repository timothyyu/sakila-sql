USE sakila;
-- 1a 
SELECT first_name, last_name 
FROM actor;

-- 1b
select UPPER(CONCAT(first_name, ' ', last_name)) as `Actor_Name`
from actor;

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b 
SELECT *
FROM actor
WHERE last_name like '%GEN%';

-- 2c
SELECT *
FROM actor
WHERE last_name like '%LI%'
ORDER BY last_name,first_name;
-- 2d
SELECT country_id, country
FROM country
WHERE country = "Afghanistan" OR country = "Bangladesh" OR country =  "China";

-- 3a
ALTER TABLE actor
ADD middle_name varchar(255)
AFTER first_name;

-- 3b
ALTER TABLE actor
MODIFY middle_name blob;
-- 3c

ALTER TABLE actor
DROP COLUMN middle_name;

-- 4a
-- 4b
-- 4c
-- 4d
-- 5a
-- 6a
-- 6b
-- 6c
-- 6d
-- 6e
-- 7a
-- 7b
-- 7c
-- 7d
-- 7e
-- 7f
-- 7g
-- 7h
-- 8a
-- 8b
-- 8c


