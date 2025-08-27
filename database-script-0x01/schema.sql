-- Enable UUID extension (PostgreSQL)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ====================================
-- User Table
-- ====================================
CREATE TABLE "user" (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name  VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest','host','admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster lookup by email
CREATE INDEX idx_user_email ON "user"(email);

-- ====================================
-- Property Table
-- ====================================
CREATE TABLE property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(200) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL CHECK (price_per_night >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Foreign key: Property belongs to User(host)
ALTER TABLE property
    ADD CONSTRAINT fk_property_host
    FOREIGN KEY (host_id) REFERENCES "user"(user_id) ON DELETE CASCADE;

-- Index for faster queries by host
CREATE INDEX idx_property_host_id ON property(host_id);

-- ====================================
-- Booking Table
-- ====================================
CREATE TABLE booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    -- total_price excluded for strict 3NF; can compute dynamically
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending','confirmed','canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Foreign keys
ALTER TABLE booking
    ADD CONSTRAINT fk_booking_property
    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE;

ALTER TABLE booking
    ADD CONSTRAINT fk_booking_user
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE;

-- Indexes for frequent queries
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_status ON booking(status);

-- ====================================
-- Payment Table
-- ====================================
CREATE TABLE payment (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card','paypal','stripe'))
);

-- Foreign key
ALTER TABLE payment
    ADD CONSTRAINT fk_payment_booking
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE;

-- Index for fast lookups
CREATE INDEX idx_payment_booking_id ON payment(booking_id);

-- ====================================
-- Review Table
-- ====================================
CREATE TABLE review (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Foreign keys
ALTER TABLE review
    ADD CONSTRAINT fk_review_property
    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE;

ALTER TABLE review
    ADD CONSTRAINT fk_review_user
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE;

-- Indexes for faster queries
CREATE INDEX idx_review_property_id ON review(property_id);
CREATE INDEX idx_review_user_id ON review(user_id);

-- ====================================
-- Message Table
-- ====================================
CREATE TABLE message (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Foreign keys
ALTER TABLE message
    ADD CONSTRAINT fk_message_sender
    FOREIGN KEY (sender_id) REFERENCES "user"(user_id) ON DELETE CASCADE;

ALTER TABLE message
    ADD CONSTRAINT fk_message_recipient
    FOREIGN KEY (recipient_id) REFERENCES "user"(user_id) ON DELETE CASCADE;

-- Indexes
CREATE INDEX idx_message_sender_id ON message(sender_id);
CREATE INDEX idx_message_recipient_id ON message(recipient_id);
