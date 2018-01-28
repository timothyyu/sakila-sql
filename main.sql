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

-- alter table actor
-- drop column actor_name;

