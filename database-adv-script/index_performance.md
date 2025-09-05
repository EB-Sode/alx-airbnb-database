# Users table

id → primary key (used in joins with bookings.user_id)
name → sometimes searched (WHERE name = '...')

# Bookings table

id → primary key
user_id → join with users
property_id → join with properties
created_at → often used in filtering or ordering (WHERE created_at > ... ORDER BY created_at)

# Properties table

id → primary key
title → sometimes searched
May also be joined via reviews.property_id