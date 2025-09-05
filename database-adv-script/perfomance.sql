

-- Retrieve all bookings with user, property, and payment details
SELECT 
    b.id AS booking_id,
    b.created_at,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.title AS property_title,
    p.location AS property_location,
    pay.id AS payment_id,
    pay.amount AS payment_amount,
    pay.status AS payment_status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
WHERE pay.status = 'completed'   -- filter only completed payments
  AND b.created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)  -- only bookings from last 6 months
ORDER BY b.created_at DESC;

-- Indexes for faster joins and filtering
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(status);

EXPLAIN SELECT 
    b.id AS booking_id,
    b.created_at,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.title AS property_title,
    p.location AS property_location,
    pay.id AS payment_id,
     pay.amount AS payment_amount,
    pay.status AS payment_status
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;

SELECT 
    b.id AS booking_id,
    b.created_at,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.title AS property_title,
    p.location AS property_location,
    pay.id AS payment_id,
    pay.amount AS payment_amount,
    pay.status AS payment_status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
ORDER BY b.created_at DESC;  -- ordering improves readability, but requires index
