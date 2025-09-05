SELECT 
    bookings.id AS booking_id,
    users.id AS user_id,
    users.name AS user_name,
    bookings.property_id,
    bookings.created_at
FROM bookings
INNER JOIN users ON bookings.user_id = users.id;
-- This query retrieves all bookings along with the associated user information.

SELECT 
    properties.id AS property_id,
    properties.title,
    reviews.id AS review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews ON properties.id = reviews.property_id;
-- This query retrieves all properties along with their reviews, if any.

SELECT 
    users.id AS user_id,
    users.name AS user_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.created_at
FROM users
FULL OUTER JOIN bookings ON users.id = bookings.user_id;
-- This query retrieves all users and their bookings, including users without bookings and bookings without users.