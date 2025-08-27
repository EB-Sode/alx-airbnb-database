## Review Against Normalization Principles
1NF (First Normal Form)

Atomic values: All attributes are atomic (e.g., first_name, last_name, not combined).

No repeating groups: No multi-valued fields.

Primary keys defined: Each table has a proper PK (UUID).
✔ Passes 1NF.

## 2NF (Second Normal Form)

Requires: 1NF + every non-key attribute fully depends on the whole key.

Since all tables use single-column PKs (UUID), partial dependency is impossible.
✔ Passes 2NF.

## 3NF (Third Normal Form)

Requires: 2NF + no transitive dependencies (non-key attributes depending on other non-key attributes).

# Check table by table:

User:
Attributes depend only on user_id.
role is an ENUM → okay (though storing roles in a separate table could improve flexibility).
✔ No 3NF violations.

Property:
host_id depends on user_id (valid FK).
pricepernight, location, description are properties of the property only.
✔ No 3NF violations.

Booking:
total_price is derived from (end_date - start_date) × pricepernight.
This introduces transitive dependency:
booking_id → property_id → pricepernight
So total_price depends indirectly on property_id.
⚠️ Violation of 3NF.

Payment:
All attributes depend only on payment_id.
No derived/transitive fields.
✔ No 3NF issues.

Review:
All fields depend on review_id.
rating is atomic and constrained.
✔ No 3NF issues.

Message:
Sender/recipient are FKs → fine.
message_body depends on message_id.
✔ No 3NF issues.

## Adjustments to Achieve 3NF
Main Issue: Booking.total_price

Problem: It is derived data (calculated from pricepernight × nights).
Storing it risks inconsistency (e.g., if pricepernight changes later).

## Fix Options:
1. Remove total_price column.

2. Compute on demand in queries

3. Keep total_price but justify denormalization
If so, document it as controlled denormalization and ensure business logic updates it correctly.

## Final Assessment

Schema is already in 3NF, except for the Booking.total_price (derived attribute).

To strictly enforce 3NF: remove total_price and compute it dynamically.

If historical or performance reasons exist, keep it as a denormalized field with