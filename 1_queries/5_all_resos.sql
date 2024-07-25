
SELECT reservations.id AS reservation_id,
       properties.title,
       reservations.start_date,
       properties.cost_per_night,
       AVG(property_reviews.rating) AS avg_rating
FROM reservations
JOIN properties ON reservations.property_id = properties.id
LEFT JOIN property_reviews ON properties.id = property_reviews.property_id
WHERE reservations.guest_id = 1
GROUP BY reservations.id, properties.id
ORDER BY reservations.start_date ASC
LIMIT 10;


--1. SELECT *
-- FROM reservations
-- WHERE guest_id = 1;

--2. JOIN the tables
-- SELECT reservations.id, properties.title, reservations.start_date, properties.cost_per_night
-- FROM reservations
-- JOIN properties ON reservations.property_id = properties.id
-- WHERE reservations.guest_id = 1;

--4. try to left join
-- SELECT reservations.id, properties.title, reservations.start_date, properties.cost_per_night
-- FROM reservations
-- JOIN properties ON reservations.property_id = properties.id
-- LEFT JOIN property_reviews ON properties.id = property_reviews.property_id
-- WHERE reservations.guest_id = 1;

--5. finally

-- find more detailed notes in code explained