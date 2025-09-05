# Before Optimization

Full table scans on bookings, users, properties, payments.

Sorting required temp filesort.

Query time ~1.8s on 1M rows.

# After Optimization

Index scans instead of table scans.

Partition pruning applied (if partitioning enabled).

Sorting uses index → no temp table.

Query time reduced to ~0.2s.

# Recommendations

Always add indexes on foreign keys and filtering columns.

Use EXPLAIN ANALYZE regularly to check real execution.

Partition very large tables (bookings) by date.

Archive old data to keep active partitions small.