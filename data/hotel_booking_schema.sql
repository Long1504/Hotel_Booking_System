CREATE DATABASE hotel_booking_system;

USE hotel_booking_system;

-- 1. Bảng ROLES
CREATE TABLE roles (
    role_id CHAR(36) PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Bảng USERS
CREATE TABLE users (
    user_id CHAR(36) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(20) NOT NULL DEFAULT 'OTHER',
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    user_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Bảng ROLES_USERS (Quan hệ n-n giữa ROLES và USERS)
CREATE TABLE roles_users (
    role_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    PRIMARY KEY (role_id, user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Bảng ROOM_TYPES
CREATE TABLE room_types (
    room_type_id CHAR(36) PRIMARY KEY,
    room_type_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    deleted_at TIMESTAMP DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Bảng VIEWS
CREATE TABLE views (
    view_id CHAR(36) PRIMARY KEY,
    view_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    deleted_at TIMESTAMP DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Bảng ROOMS
CREATE TABLE rooms (
    room_id CHAR(36) PRIMARY KEY,
    room_name VARCHAR(255) NOT NULL,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    floor INTEGER NOT NULL,
    base_price DECIMAL(12, 2) NOT NULL,
    max_adults INTEGER NOT NULL,
    max_children INTEGER NOT NULL,
    area DECIMAL(6, 2) NOT NULL,
    description TEXT,
    room_status VARCHAR(20) NOT NULL DEFAULT 'AVAILABLE',
    deleted_at TIMESTAMP DEFAULT NULL,
    room_type_id CHAR(36) NOT NULL,
    view_id CHAR(36) NOT NULL,
    FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id),
    FOREIGN KEY (view_id) REFERENCES views(view_id),
    CHECK (base_price >= 0),
    CHECK (max_adults >= 1),
    CHECK (max_children >= 0),
    CHECK (area > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Bảng AMENITIES
CREATE TABLE amenities (
    amenity_id CHAR(36) PRIMARY KEY,
    amenity_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    deleted_at TIMESTAMP DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Bảng ROOMS_AMENITIES (Quan hệ n-n giữa ROOMS và AMENITIES)
CREATE TABLE rooms_amenities (
    room_id CHAR(36) NOT NULL,
    amenity_id CHAR(36) NOT NULL,
    PRIMARY KEY (room_id, amenity_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Bảng ROOM_IMAGES
CREATE TABLE room_images (
    room_image_id CHAR(36) PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    public_id VARCHAR(255),
    is_main BOOLEAN NOT NULL DEFAULT FALSE,
    room_id CHAR(36) NOT NULL,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Bảng PRICE_RULES
CREATE TABLE price_rules (
	price_rule_id CHAR(36) PRIMARY KEY,
    price_rule_name VARCHAR(100) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price_multiplier DECIMAL(4, 2) NOT NULL DEFAULT 1.00,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    CHECK (end_date >= start_date),
	CHECK (price_multiplier > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. Bảng BOOKINGS
CREATE TABLE bookings (
    booking_id CHAR(36) PRIMARY KEY,
    booking_code VARCHAR(50) NOT NULL UNIQUE,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    guest_name VARCHAR(200) NOT NULL,
    guest_phone VARCHAR(20) NOT NULL,
    guest_email VARCHAR(100) NOT NULL,
    identity_card VARCHAR(20),
    adults INTEGER NOT NULL,
    children INTEGER NOT NULL,
    note VARCHAR(255),
    room_price DECIMAL(12,2) NOT NULL,
    total_price DECIMAL(12, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    paid_at TIMESTAMP,
    user_id CHAR(36),
    room_id CHAR(36) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    CHECK (check_out_date > check_in_date),
    CHECK (adults >= 1),
	CHECK (children >= 0),
    CHECK (room_price >= 0),
    CHECK (total_price >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. Bảng BOOKING_STATUS_HISTORIES
CREATE TABLE booking_status_histories (
    booking_status_history_id CHAR(36) PRIMARY KEY,
    status VARCHAR(20) NOT NULL,
    changed_by CHAR(36), -- user_id của Lễ tân
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    booking_id CHAR(36) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 13. Bảng SERVICES
CREATE TABLE services (
    service_id CHAR(36) PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    base_price DECIMAL(12, 2) NOT NULL,
    deleted_at TIMESTAMP DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14. Bảng BOOKING_SERVICES
CREATE TABLE booking_services (
    booking_service_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL,
    service_id CHAR(36) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(12,2) NOT NULL,
    total_price DECIMAL(12,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id),
    CHECK (quantity > 0),
    CHECK (unit_price >= 0),
    CHECK (total_price >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 15. Bảng EXTRAS
CREATE TABLE extras (
    extra_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    note VARCHAR(255),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    CHECK (amount >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 16. Bảng CONVERSATIONS
CREATE TABLE conversations (
    conversation_id CHAR(36) PRIMARY KEY,
    customer_username CHAR(36) NOT NULL, -- chat owner
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN', -- OPEN / CLOSED
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 17. Bảng CONVERSATION_MEMBERS
CREATE TABLE conversation_members (
    conversation_id CHAR(36) NOT NULL,
    username CHAR(36) NOT NULL,
    role VARCHAR(20) NOT NULL,
    last_read_at TIMESTAMP NULL,
    PRIMARY KEY (conversation_id, username),
    FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 18. Bảng MESSAGES
CREATE TABLE messages (
    message_id CHAR(36) PRIMARY KEY,
    conversation_id CHAR(36) NOT NULL,
    sender_username CHAR(36) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE invalidated_tokens (
	id VARCHAR(36) PRIMARY KEY,
    expiry_time DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;