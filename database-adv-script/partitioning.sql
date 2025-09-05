-- partitioning.sql

-- Drop existing table if testing
DROP TABLE IF EXISTS bookings_partitioned;

-- Create partitioned bookings table
CREATE TABLE bookings_partitioned (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    payment_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    start_year INT GENERATED ALWAYS AS (YEAR(start_date)) STORED
)
PARTITION BY RANGE (start_year) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax VALUES LESS THAN (MAXVALUE)
);

-- Example query on partitioned table: fetch bookings by date range
EXPLAIN SELECT * 
FROM bookings_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';


-- Non-partitioned table
EXPLAIN SELECT * FROM bookings WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Partitioned table
EXPLAIN SELECT * FROM bookings_partitioned WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';