-- ========================
-- Insert Users
-- ========================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    ('1111-1111-1111', 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', '1234567890', 'host', NOW()),
    ('2222-2222-2222', 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '2345678901', 'guest', NOW()),
    ('3333-3333-3333', 'Charlie', 'Brown', 'charlie@example.com', 'hashed_pw3', '3456789012', 'guest', NOW()),
    ('4444-4444-4444', 'Diana', 'Miller', 'diana@example.com', 'hashed_pw4', '4567890123', 'admin', NOW());

-- ========================
-- Insert Properties
-- ========================
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night, created_at, updated_at)
VALUES
    ('aaaaaaa1', '1111-1111-1111', 'Cozy Apartment', 'A cozy apartment in the city center', 'New York', 120.00, NOW(), NOW()),
    ('aaaaaaa2', '1111-1111-1111', 'Beach House', 'Beautiful house by the beach', 'Miami', 200.00, NOW(), NOW());

-- ========================
-- Insert Bookings
-- ========================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    ('bbbbbbbbbbb1', 'aaaaaaa1', '2222-2222-2222', '2025-09-01', '2025-09-05', 480.00, 'confirmed', NOW()),
    ('bbbbbbbbbbb2', 'aaaaaaa2', '3333-3333-3333', '2025-09-10', '2025-09-12', 400.00, 'pending', NOW());

-- ========================
-- Insert Payments
-- ========================
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
    ('ppppppppppp1', 'bbbbbbbbbbb1', 480.00, NOW(), 'credit_card');

-- ========================
-- Insert Reviews
-- ========================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    ('rrrr1', 'aaaaaaa1', '2222-2222-2222', 5, 'Amazing stay, very clean and comfortable!', NOW()),
    ('rrrr2', 'aaaaaaa2', '3333-3333-3333', 4, 'Great location, but a bit noisy at night.', NOW());

-- ========================
-- Insert Messages
-- ========================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    ('mmmm-mmmm-mmmm1', '2222-2222-2222', '1111-1111-1111', 'Hi Alice, is the apartment available in October?', NOW()),
    ('mmmm-mmmm-mmmm2', '1111-1111-1111', '2222-2222-2222', 'Yes, it’s available. I’ll update the calendar.', NOW());
