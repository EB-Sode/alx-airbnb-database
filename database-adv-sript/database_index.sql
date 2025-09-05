-- Users table
CREATE INDEX idx_users_name ON users(name);

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- Properties table
CREATE INDEX idx_properties_title ON properties(title);
