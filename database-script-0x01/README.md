erDiagram

    USER {
        uuid user_id PK
        varchar first_name
        varchar last_name
        varchar email UNIQUE
        varchar password_hash
        varchar phone_number
        varchar role
        timestamp created_at
    }

    PROPERTY {
        uuid property_id PK
        uuid host_id FK
        varchar name
        text description
        varchar location
        decimal price_per_night
        timestamp created_at
        timestamp updated_at
    }

    BOOKING {
        uuid booking_id PK
        uuid property_id FK
        uuid user_id FK
        date start_date
        date end_date
        varchar status
        timestamp created_at
    }

    PAYMENT {
        uuid payment_id PK
        uuid booking_id FK
        decimal amount
        timestamp payment_date
        varchar payment_method
    }

    REVIEW {
        uuid review_id PK
        uuid property_id FK
        uuid user_id FK
        int rating
        text comment
        timestamp created_at
    }

    MESSAGE {
        uuid message_id PK
        uuid sender_id FK
        uuid recipient_id FK
        text message_body
        timestamp sent_at
    }

    %% Relationships
    USER ||--o{ PROPERTY : "hosts"
    USER ||--o{ BOOKING : "makes"
    USER ||--o{ REVIEW : "writes"
    USER ||--o{ MESSAGE : "sends"
    USER ||--o{ MESSAGE : "receives"

    PROPERTY ||--o{ BOOKING : "is booked in"
    PROPERTY ||--o{ REVIEW : "has"

    BOOKING ||--o{ PAYMENT : "has"
