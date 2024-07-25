SELECT properties.id, title, cost_per_night, AVG(property_reviews.rating) AS avg_rating
FROM properties
JOIN property_reviews ON properties.id = property_id
WHERE city LIKE '%Vancouver%'
GROUP BY properties.id
HAVING AVG(property_reviews.rating) >= 4
ORDER BY cost_per_night
LIMIT 10;




-- 1. start with basic selection from the properties
-- 2. add and join the property reviews
-- 3. calculate then group by
-- 4. add the condtion for ratings (HAVING)
-- 5. Order by cost per night then limit 10