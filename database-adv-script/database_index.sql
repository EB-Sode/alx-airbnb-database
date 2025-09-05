-- Users table
CREATE INDEX idx_users_name ON users(name);

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- Properties table
CREATE INDEX idx_properties_title ON properties(title);

EXPLAIN ANALYZE
SELECT u.id, u.name, COUNT(b.id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
GROUP BY u.id, u.name
ORDER BY total_bookings DESC;

EXPLAIN ANALYZE
SELECT p.id, p.title, COUNT(b.id) AS total_bookings
FROM properties p
LEFT JOIN bookings b ON p.id = b.property_id
GROUP BY p.id, p.title
ORDER BY total_bookings DESC;
