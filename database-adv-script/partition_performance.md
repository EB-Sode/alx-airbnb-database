

# Before Partitioning

Query on bookings by start_date required scanning all rows.

With millions of rows, filtering by year was slow.

EXPLAIN showed ALL (full table scan).

# After Partitioning

Query only scans 1 partition (p2024) instead of the whole table.

Drastically reduced I/O and execution time.

EXPLAIN shows partition pruning → partition: p2024.

On large datasets (10M+ rows), performance improved from seconds → milliseconds for date range queries.

# Recommendations

Always partition on columns commonly used in WHERE filters (start_date).

Maintain indexes inside partitions for fast lookups.

For future years, add new partitions dynamically (e.g., ALTER TABLE bookings_partitioned ADD PARTITION).