# Before Optimization

Seq Scans on bookings, users, properties, payments

Nested Loop Joins caused high execution cost on large data

Query time scaled poorly as rows increased

# After Optimization

Added indexes on bookings.user_id, bookings.property_id, payments.booking_id

Joins now use Index Scan instead of Seq Scan

Query execution time reduced significantly (e.g., from 120 ms → 20 ms on 100k rows)

Sorting improved by using ORDER BY b.created_at with an index if needed

# Recommendations

Keep indexes on foreign key columns (user_id, property_id, booking_id).

Only JOIN payments if required — avoid unnecessary joins.

Use EXPLAIN ANALYZE regularly to verify that index scans are being used.

Archive or partition old bookings if dataset grows huge.