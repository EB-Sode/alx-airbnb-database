SELECT 
    id AS property_id,
    title
FROM properties
WHERE id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
-- This query retrieves properties that have an average review rating greater than 4.0.


SELECT 
    id AS user_id,
    name
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
) > 3;
-- This query retrieves users who have made more than 3 bookings.