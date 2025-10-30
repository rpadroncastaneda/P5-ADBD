CREATE VIEW view_ventas_categoria AS
SELECT 
    c.name AS categoria,
    SUM(p.amount) AS total_ventas
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_ventas DESC;


CREATE VIEW view_ventas_tienda AS
SELECT 
    ci.city AS ciudad,
    co.country AS pais,
    st.first_name AS encargado,
    SUM(p.amount) AS total_ventas
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
JOIN staff st ON s.manager_staff_id = st.staff_id
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY ci.city, co.country, st.first_name
ORDER BY total_ventas DESC;


CREATE VIEW view_peliculas_detalle AS
SELECT 
    f.film_id,
    f.title,
    f.description,
    c.name AS categoria,
    f.rental_rate AS precio,
    f.length AS duracion,
    f.rating,
    STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS actores
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id, f.title, f.description, c.name, f.rental_rate, f.length, f.rating
ORDER BY f.title;


CREATE VIEW view_actores_peliculas AS
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS actor,
    STRING_AGG(DISTINCT c.name || ':' || f.title, ', ') AS categorias_y_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY actor
ORDER BY actor;

