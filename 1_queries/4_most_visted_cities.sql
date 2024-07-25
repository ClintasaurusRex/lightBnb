
SELECT properties.city, COUNT(reservations.*) AS total_reservations
FROM properties
JOIN reservations ON properties.id = reservations.property_id
GROUP BY properties.city
ORDER BY total_reservations DESC;







--1. SELECT properties.city
-- FROM properties;

-- 2. joing the reso table with property table
-- SELECT properties.city
-- FROM properties
-- JOIN reservations ON properties.id = reservations.property_id

-- 3. add up the resverations
-- SELECT properties.city, COUNT(reservations.*) AS total_reservations
-- FROM properties
-- JOIN reservations ON properties.id = reservations.property_id dont forget to group by properties.city for result

-- 4. final seen abopve (order results)




