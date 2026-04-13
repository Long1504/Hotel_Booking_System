USE hotel_booking_system;

SET FOREIGN_KEY_CHECKS = 0;

-- Tắt foreign key checks để dễ reset bảng nếu cần
TRUNCATE TABLE roles_users;
TRUNCATE TABLE booking_status_histories;
TRUNCATE TABLE booking_services;
TRUNCATE TABLE extras;
TRUNCATE TABLE bookings;
TRUNCATE TABLE room_images;
TRUNCATE TABLE rooms_amenities;
TRUNCATE TABLE rooms;
TRUNCATE TABLE amenities;
TRUNCATE TABLE services;
TRUNCATE TABLE views;
TRUNCATE TABLE room_types;
TRUNCATE TABLE users;
TRUNCATE TABLE roles;

-- ======================
-- ROLES
-- ======================
SET @role_customer = UUID();
SET @role_receptionist = UUID();
SET @role_admin = UUID();
INSERT INTO roles (role_id, role_name) VALUES 
(@role_customer, 'CUSTOMER'),
(@role_receptionist, 'RECEPTIONIST'),
(@role_admin, 'ADMIN');

-- ======================
-- USERS (10 Customers, 10 Receptionists)
-- ======================
SET @cust1 = UUID();
SET @cust2 = UUID();
SET @cust3 = UUID();
SET @cust4 = UUID();
SET @cust5 = UUID();
SET @cust6 = UUID();
SET @cust7 = UUID();
SET @cust8 = UUID();
SET @cust9 = UUID();
SET @cust10 = UUID();
SET @recep1 = UUID();
SET @recep2 = UUID();
SET @recep3 = UUID();
SET @recep4 = UUID();
SET @recep5 = UUID();
SET @recep6 = UUID();
SET @recep7 = UUID();
SET @recep8 = UUID();
SET @recep9 = UUID();
SET @recep10 = UUID();
INSERT INTO users (user_id, username, password, first_name, last_name, gender, email, phone) VALUES
(@cust1, 'customer1', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust1', 'Doe', 'FEMALE', 'customer1@gmail.com', '0900001001'),
(@cust2, 'customer2', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust2', 'Doe', 'FEMALE', 'customer2@gmail.com', '0900001002'),
(@cust3, 'customer3', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust3', 'Doe', 'MALE', 'customer3@gmail.com', '0900001003'),
(@cust4, 'customer4', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust4', 'Doe', 'MALE', 'customer4@gmail.com', '0900001004'),
(@cust5, 'customer5', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust5', 'Doe', 'MALE', 'customer5@gmail.com', '0900001005'),
(@cust6, 'customer6', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust6', 'Doe', 'MALE', 'customer6@gmail.com', '0900001006'),
(@cust7, 'customer7', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust7', 'Doe', 'MALE', 'customer7@gmail.com', '0900001007'),
(@cust8, 'customer8', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust8', 'Doe', 'FEMALE', 'customer8@gmail.com', '0900001008'),
(@cust9, 'customer9', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust9', 'Doe', 'FEMALE', 'customer9@gmail.com', '0900001009'),
(@cust10, 'customer10', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Cust10', 'Doe', 'MALE', 'customer10@gmail.com', '0900001010'),
(@recep1, 'receptionist1', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep1', 'Smith', 'FEMALE', 'receptionist1@gmail.com', '0900002001'),
(@recep2, 'receptionist2', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep2', 'Smith', 'FEMALE', 'receptionist2@gmail.com', '0900002002'),
(@recep3, 'receptionist3', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep3', 'Smith', 'MALE', 'receptionist3@gmail.com', '0900002003'),
(@recep4, 'receptionist4', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep4', 'Smith', 'FEMALE', 'receptionist4@gmail.com', '0900002004'),
(@recep5, 'receptionist5', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep5', 'Smith', 'MALE', 'receptionist5@gmail.com', '0900002005'),
(@recep6, 'receptionist6', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep6', 'Smith', 'MALE', 'receptionist6@gmail.com', '0900002006'),
(@recep7, 'receptionist7', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep7', 'Smith', 'FEMALE', 'receptionist7@gmail.com', '0900002007'),
(@recep8, 'receptionist8', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep8', 'Smith', 'MALE', 'receptionist8@gmail.com', '0900002008'),
(@recep9, 'receptionist9', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep9', 'Smith', 'MALE', 'receptionist9@gmail.com', '0900002009'),
(@recep10, 'receptionist10', '$2a$10$E2k1GVzLCjk2HOxNsb5H3O9dGJjIQkfBg7RU8RLA.ov4Z4Fn.LYiy', 'Recep10', 'Smith', 'MALE', 'receptionist10@gmail.com', '0900002010');

-- ======================
-- ROLES_USERS
-- ======================
INSERT INTO roles_users (role_id, user_id) VALUES
(@role_customer, @cust1),
(@role_customer, @cust2),
(@role_customer, @cust3),
(@role_customer, @cust4),
(@role_customer, @cust5),
(@role_customer, @cust6),
(@role_customer, @cust7),
(@role_customer, @cust8),
(@role_customer, @cust9),
(@role_customer, @cust10),
(@role_receptionist, @recep1),
(@role_receptionist, @recep2),
(@role_receptionist, @recep3),
(@role_receptionist, @recep4),
(@role_receptionist, @recep5),
(@role_receptionist, @recep6),
(@role_receptionist, @recep7),
(@role_receptionist, @recep8),
(@role_receptionist, @recep9),
(@role_receptionist, @recep10);

-- ======================
-- VIEWS (3)
-- ======================
SET @view_sea = UUID();
SET @view_city = UUID();
SET @view_garden = UUID();
INSERT INTO views (view_id, view_name, description) VALUES
(@view_sea, 'Sea View', 'Beautiful ocean view'),
(@view_city, 'City View', 'Dynamic city skyline'),
(@view_garden, 'Garden View', 'Peaceful garden landscape');

-- ======================
-- ROOM TYPES (3)
-- ======================
SET @type_standard = UUID();
SET @type_deluxe = UUID();
SET @type_suite = UUID();
INSERT INTO room_types (room_type_id, room_type_name, description) VALUES
(@type_standard, 'Standard Room', 'Standard room with basic amenities'),
(@type_deluxe, 'Deluxe Room', 'Deluxe room with extra space and features'),
(@type_suite, 'Suite Room', 'Luxury suite with premium experiences');

-- ======================
-- AMENITIES (10)
-- ======================
SET @amenity_0 = UUID();
SET @amenity_1 = UUID();
SET @amenity_2 = UUID();
SET @amenity_3 = UUID();
SET @amenity_4 = UUID();
SET @amenity_5 = UUID();
SET @amenity_6 = UUID();
SET @amenity_7 = UUID();
SET @amenity_8 = UUID();
SET @amenity_9 = UUID();
INSERT INTO amenities (amenity_id, amenity_name, description) VALUES
(@amenity_0, 'Free Wifi', 'Free Wifi desc'),
(@amenity_1, 'Air Conditioner', 'Air Conditioner desc'),
(@amenity_2, 'Smart TV', 'Smart TV desc'),
(@amenity_3, 'Mini Bar', 'Mini Bar desc'),
(@amenity_4, 'Balcony', 'Balcony desc'),
(@amenity_5, 'Bathtub', 'Bathtub desc'),
(@amenity_6, 'Hair Dryer', 'Hair Dryer desc'),
(@amenity_7, 'Safe Box', 'Safe Box desc'),
(@amenity_8, 'Coffee Maker', 'Coffee Maker desc'),
(@amenity_9, 'Work Desk', 'Work Desk desc');

-- ======================
-- SERVICES (3)
-- ======================
SET @ser_airport = UUID();
SET @ser_breakfast = UUID();
SET @ser_spa = UUID();
INSERT INTO services (service_id, service_name, description, base_price) VALUES
(@ser_airport, 'Airport Pickup', 'Car pickup from airport', 200000.00),
(@ser_breakfast, 'Buffet Breakfast', 'Daily buffet breakfast', 150000.00),
(@ser_spa, 'Spa & Massage', '1 hour relaxing spa', 500000.00);

-- ======================
-- ROOMS (10)
-- ======================
SET @room1 = UUID();
SET @room2 = UUID();
SET @room3 = UUID();
SET @room4 = UUID();
SET @room5 = UUID();
SET @room6 = UUID();
SET @room7 = UUID();
SET @room8 = UUID();
SET @room9 = UUID();
SET @room10 = UUID();
INSERT INTO rooms (room_id, room_name, room_number, floor, base_price, max_adults, max_children, area, description, room_type_id, view_id) VALUES
(@room1, 'Standard 101', '101', 1, 500000, 2, 1, 25, 'Description for Standard 101', @type_standard, @view_city),
(@room2, 'Standard 102', '102', 1, 500000, 2, 1, 25, 'Description for Standard 102', @type_standard, @view_garden),
(@room3, 'Standard 103', '103', 1, 500000, 2, 1, 25, 'Description for Standard 103', @type_standard, @view_city),
(@room4, 'Deluxe 201', '201', 2, 800000, 3, 1, 35, 'Description for Deluxe 201', @type_deluxe, @view_sea),
(@room5, 'Deluxe 202', '202', 2, 800000, 3, 1, 35, 'Description for Deluxe 202', @type_deluxe, @view_sea),
(@room6, 'Deluxe 203', '203', 2, 800000, 3, 1, 35, 'Description for Deluxe 203', @type_deluxe, @view_city),
(@room7, 'Suite 301', '301', 3, 1500000, 4, 2, 50, 'Description for Suite 301', @type_suite, @view_sea),
(@room8, 'Suite 302', '302', 3, 1500000, 4, 2, 50, 'Description for Suite 302', @type_suite, @view_sea),
(@room9, 'Suite 303', '303', 3, 1500000, 4, 2, 50, 'Description for Suite 303', @type_suite, @view_garden),
(@room10, 'Suite 304', '304', 3, 1500000, 4, 2, 50, 'Description for Suite 304', @type_suite, @view_city);

-- ======================
-- ROOMS AMENITIES (>6 per room)
-- ======================
INSERT INTO rooms_amenities (room_id, amenity_id) VALUES
(@room1, @amenity_1),
(@room1, @amenity_7),
(@room1, @amenity_5),
(@room1, @amenity_8),
(@room1, @amenity_6),
(@room1, @amenity_4),
(@room1, @amenity_0),
(@room1, @amenity_3),
(@room1, @amenity_9),
(@room2, @amenity_0),
(@room2, @amenity_2),
(@room2, @amenity_5),
(@room2, @amenity_6),
(@room2, @amenity_7),
(@room2, @amenity_8),
(@room2, @amenity_1),
(@room2, @amenity_3),
(@room3, @amenity_6),
(@room3, @amenity_7),
(@room3, @amenity_4),
(@room3, @amenity_5),
(@room3, @amenity_2),
(@room3, @amenity_1),
(@room3, @amenity_0),
(@room3, @amenity_9),
(@room4, @amenity_5),
(@room4, @amenity_4),
(@room4, @amenity_3),
(@room4, @amenity_7),
(@room4, @amenity_9),
(@room4, @amenity_6),
(@room4, @amenity_1),
(@room4, @amenity_2),
(@room5, @amenity_6),
(@room5, @amenity_7),
(@room5, @amenity_9),
(@room5, @amenity_5),
(@room5, @amenity_0),
(@room5, @amenity_3),
(@room5, @amenity_8),
(@room6, @amenity_9),
(@room6, @amenity_4),
(@room6, @amenity_8),
(@room6, @amenity_7),
(@room6, @amenity_0),
(@room6, @amenity_6),
(@room6, @amenity_2),
(@room7, @amenity_8),
(@room7, @amenity_7),
(@room7, @amenity_4),
(@room7, @amenity_0),
(@room7, @amenity_2),
(@room7, @amenity_9),
(@room7, @amenity_1),
(@room7, @amenity_3),
(@room7, @amenity_6),
(@room7, @amenity_5),
(@room8, @amenity_9),
(@room8, @amenity_8),
(@room8, @amenity_7),
(@room8, @amenity_0),
(@room8, @amenity_4),
(@room8, @amenity_1),
(@room8, @amenity_5),
(@room8, @amenity_6),
(@room9, @amenity_5),
(@room9, @amenity_7),
(@room9, @amenity_9),
(@room9, @amenity_4),
(@room9, @amenity_3),
(@room9, @amenity_2),
(@room9, @amenity_1),
(@room9, @amenity_6),
(@room9, @amenity_8),
(@room10, @amenity_3),
(@room10, @amenity_9),
(@room10, @amenity_5),
(@room10, @amenity_2),
(@room10, @amenity_1),
(@room10, @amenity_0),
(@room10, @amenity_6),
(@room10, @amenity_8),
(@room10, @amenity_4),
(@room10, @amenity_7);

-- ======================
-- ROOM IMAGES (1 main + 5 sub)
-- ======================
INSERT INTO room_images (room_image_id, image_url, is_main, room_id) VALUES
(UUID(), 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=800&q=80', TRUE, @room1),
(UUID(), 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80', FALSE, @room1),
(UUID(), 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=800&q=80', FALSE, @room1),
(UUID(), 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', FALSE, @room1),
(UUID(), 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=800&q=80', FALSE, @room1),
(UUID(), 'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=800&q=80', FALSE, @room1),
(UUID(), 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', TRUE, @room2),
(UUID(), 'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=800&q=80', FALSE, @room2),
(UUID(), 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=800&q=80', FALSE, @room2),
(UUID(), 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=800&q=80', FALSE, @room2),
(UUID(), 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80', FALSE, @room2),
(UUID(), 'https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=800&q=80', FALSE, @room2),
(UUID(), 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=80', TRUE, @room3),
(UUID(), 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=800&q=80', FALSE, @room3),
(UUID(), 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=800&q=80', FALSE, @room3),
(UUID(), 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=800&q=80', FALSE, @room3),
(UUID(), 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', FALSE, @room3),
(UUID(), 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=800&q=80', FALSE, @room3),
(UUID(), 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=800&q=80', TRUE, @room4),
(UUID(), 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=800&q=80', FALSE, @room4),
(UUID(), 'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=800&q=80', FALSE, @room4),
(UUID(), 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80', FALSE, @room4),
(UUID(), 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=800&q=80', FALSE, @room4),
(UUID(), 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', FALSE, @room4),
(UUID(), 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=800&q=80', TRUE, @room5),
(UUID(), 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=800&q=80', FALSE, @room5),
(UUID(), 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=800&q=80', FALSE, @room5),
(UUID(), 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', FALSE, @room5),
(UUID(), 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=80', FALSE, @room5),
(UUID(), 'https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=800&q=80', FALSE, @room5),
(UUID(), 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=800&q=80', TRUE, @room6),
(UUID(), 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=800&q=80', FALSE, @room6),
(UUID(), 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=800&q=80', FALSE, @room6),
(UUID(), 'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=800&q=80', FALSE, @room6),
(UUID(), 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=800&q=80', FALSE, @room6),
(UUID(), 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80', FALSE, @room6),
(UUID(), 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=800&q=80', TRUE, @room7),
(UUID(), 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80', FALSE, @room7),
(UUID(), 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=800&q=80', FALSE, @room7),
(UUID(), 'https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=800&q=80', FALSE, @room7),
(UUID(), 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=800&q=80', FALSE, @room7),
(UUID(), 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', FALSE, @room7),
(UUID(), 'https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=800&q=80', TRUE, @room8),
(UUID(), 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=80', FALSE, @room8),
(UUID(), 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=800&q=80', FALSE, @room8),
(UUID(), 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=800&q=80', FALSE, @room8),
(UUID(), 'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=800&q=80', FALSE, @room8),
(UUID(), 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=800&q=80', FALSE, @room8),
(UUID(), 'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=800&q=80', TRUE, @room9),
(UUID(), 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', FALSE, @room9),
(UUID(), 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=800&q=80', FALSE, @room9),
(UUID(), 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=80', FALSE, @room9),
(UUID(), 'https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=800&q=80', FALSE, @room9),
(UUID(), 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=800&q=80', FALSE, @room9),
(UUID(), 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80', TRUE, @room10),
(UUID(), 'https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=800&q=80', FALSE, @room10),
(UUID(), 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=800&q=80', FALSE, @room10),
(UUID(), 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=800&q=80', FALSE, @room10),
(UUID(), 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=80', FALSE, @room10),
(UUID(), 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=800&q=80', FALSE, @room10);

-- ======================
-- BOOKINGS & SERVICES & EXTRAS & HISTORIES
-- ======================
SET @bk_1 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_1, 'BK2501133824', '2025-01-13', '2025-01-18', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID325374', 2, 0, 2500000, 3400000.0, '2025-01-10 03:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-10 04:00:00', @cust5, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_1, @ser_spa, 1, 500000.0, 500000.0, '2025-01-10 03:00:00'),
(UUID(), @bk_1, @ser_airport, 1, 200000.0, 200000.0, '2025-01-10 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_1, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-10 03:00:00', @bk_1),
(UUID(), 'CONFIRMED', NULL, '2025-01-10 18:00:00', @bk_1),
(UUID(), 'CHECKED_IN', @recep2, '2025-01-13 12:00:00', @bk_1),
(UUID(), 'CHECKED_OUT', @recep2, '2025-01-18 08:00:00', @bk_1);

SET @bk_2 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_2, 'BK2502025649', '2025-02-02', '2025-02-06', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID464485', 1, 1, 2000000, 2350000.0, '2025-01-18 09:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-18 10:00:00', @cust1, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_2, @ser_breakfast, 1, 150000.0, 150000.0, '2025-01-18 09:00:00'),
(UUID(), @bk_2, @ser_airport, 1, 200000.0, 200000.0, '2025-01-18 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-18 09:00:00', @bk_2),
(UUID(), 'CONFIRMED', NULL, '2025-01-18 21:00:00', @bk_2),
(UUID(), 'CHECKED_IN', @recep7, '2025-02-02 13:00:00', @bk_2),
(UUID(), 'CHECKED_OUT', @recep7, '2025-02-06 11:00:00', @bk_2);

SET @bk_3 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_3, 'BK2502116157', '2025-02-11', '2025-02-15', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID556907', 1, 1, 2000000, 3100000.0, '2025-01-27 02:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-01-27 03:00:00', @cust10, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_3, @ser_airport, 3, 200000.0, 600000.0, '2025-01-27 02:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_3, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-27 02:00:00', @bk_3),
(UUID(), 'CONFIRMED', NULL, '2025-01-27 05:00:00', @bk_3),
(UUID(), 'CHECKED_IN', @recep9, '2025-02-11 13:00:00', @bk_3),
(UUID(), 'CHECKED_OUT', @recep9, '2025-02-15 10:00:00', @bk_3);

SET @bk_4 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_4, 'BK2503022141', '2025-03-02', '2025-03-07', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID180203', 1, 1, 2500000, 3950000.0, '2025-02-17 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-02-17 23:00:00', @cust9, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_4, @ser_breakfast, 1, 150000.0, 150000.0, '2025-02-17 22:00:00'),
(UUID(), @bk_4, @ser_spa, 2, 500000.0, 1000000.0, '2025-02-17 22:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_4, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-17 22:00:00', @bk_4),
(UUID(), 'CONFIRMED', NULL, '2025-02-17 23:00:00', @bk_4),
(UUID(), 'CHECKED_IN', @recep9, '2025-03-02 16:00:00', @bk_4),
(UUID(), 'CHECKED_OUT', @recep9, '2025-03-07 12:00:00', @bk_4);

SET @bk_5 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_5, 'BK2503183564', '2025-03-18', '2025-03-19', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID570011', 1, 1, 500000, 1200000.0, '2025-03-05 19:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-05 20:00:00', @cust7, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_5, @ser_airport, 1, 200000.0, 200000.0, '2025-03-05 19:00:00'),
(UUID(), @bk_5, @ser_spa, 1, 500000.0, 500000.0, '2025-03-05 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-05 19:00:00', @bk_5),
(UUID(), 'CONFIRMED', NULL, '2025-03-06 04:00:00', @bk_5),
(UUID(), 'CHECKED_IN', @recep4, '2025-03-18 15:00:00', @bk_5),
(UUID(), 'CHECKED_OUT', @recep4, '2025-03-19 11:00:00', @bk_5);

SET @bk_6 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_6, 'BK2503226033', '2025-03-22', '2025-03-28', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID898888', 1, 1, 3000000, 3700000.0, '2025-03-08 05:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-08 06:00:00', @cust1, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_6, @ser_airport, 2, 200000.0, 400000.0, '2025-03-08 05:00:00'),
(UUID(), @bk_6, @ser_breakfast, 2, 150000.0, 300000.0, '2025-03-08 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-08 05:00:00', @bk_6),
(UUID(), 'CONFIRMED', NULL, '2025-03-09 02:00:00', @bk_6),
(UUID(), 'CHECKED_IN', @recep10, '2025-03-22 16:00:00', @bk_6),
(UUID(), 'CHECKED_OUT', @recep10, '2025-03-28 09:00:00', @bk_6);

SET @bk_7 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_7, 'BK2504084873', '2025-04-08', '2025-04-09', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID536054', 2, 0, 500000, 1600000.0, '2025-03-30 14:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-30 15:00:00', @cust8, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_7, @ser_spa, 2, 500000.0, 1000000.0, '2025-03-30 14:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_7, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-30 14:00:00', @bk_7),
(UUID(), 'CONFIRMED', NULL, '2025-03-31 02:00:00', @bk_7),
(UUID(), 'CHECKED_IN', @recep8, '2025-04-08 13:00:00', @bk_7),
(UUID(), 'CHECKED_OUT', @recep8, '2025-04-09 10:00:00', @bk_7);

SET @bk_8 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_8, 'BK2504121496', '2025-04-12', '2025-04-15', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID827109', 1, 0, 1500000, 3000000.0, '2025-04-05 06:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-05 07:00:00', @cust6, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_8, @ser_spa, 3, 500000.0, 1500000.0, '2025-04-05 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-05 06:00:00', @bk_8),
(UUID(), 'CONFIRMED', NULL, '2025-04-05 12:00:00', @bk_8),
(UUID(), 'CHECKED_IN', @recep4, '2025-04-12 12:00:00', @bk_8),
(UUID(), 'CHECKED_OUT', @recep4, '2025-04-15 08:00:00', @bk_8);

SET @bk_9 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_9, 'BK2504291274', '2025-04-29', '2025-04-30', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID504653', 1, 0, 500000, 800000, '2025-04-20 20:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-04-20 21:00:00', @cust6, @room1);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_9, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-20 20:00:00', @bk_9),
(UUID(), 'CONFIRMED', NULL, '2025-04-21 19:00:00', @bk_9),
(UUID(), 'CHECKED_IN', @recep1, '2025-04-29 15:00:00', @bk_9),
(UUID(), 'CHECKED_OUT', @recep1, '2025-04-30 12:00:00', @bk_9);

SET @bk_10 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_10, 'BK2505156338', '2025-05-15', '2025-05-18', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID581218', 2, 0, 1500000, 1700000, '2025-05-05 00:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-05 01:00:00', @cust1, @room1);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_10, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-05 00:00:00', @bk_10),
(UUID(), 'CONFIRMED', NULL, '2025-05-05 20:00:00', @bk_10),
(UUID(), 'CHECKED_IN', @recep9, '2025-05-15 14:00:00', @bk_10),
(UUID(), 'CHECKED_OUT', @recep9, '2025-05-18 09:00:00', @bk_10);

SET @bk_11 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_11, 'BK2506021287', '2025-06-02', '2025-06-07', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID222041', 1, 0, 2500000, 2700000.0, '2025-05-28 04:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-05-28 05:00:00', @cust7, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_11, @ser_airport, 1, 200000.0, 200000.0, '2025-05-28 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-28 04:00:00', @bk_11),
(UUID(), 'CONFIRMED', NULL, '2025-05-28 16:00:00', @bk_11),
(UUID(), 'CHECKED_IN', @recep3, '2025-06-02 14:00:00', @bk_11),
(UUID(), 'CHECKED_OUT', @recep3, '2025-06-07 10:00:00', @bk_11);

SET @bk_12 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_12, 'BK2506088512', '2025-06-08', '2025-06-13', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID498278', 2, 0, 2500000, 2500000, '2025-05-27 13:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-27 14:00:00', @cust1, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-27 13:00:00', @bk_12),
(UUID(), 'CONFIRMED', NULL, '2025-05-28 01:00:00', @bk_12),
(UUID(), 'CHECKED_IN', @recep1, '2025-06-08 12:00:00', @bk_12),
(UUID(), 'CHECKED_OUT', @recep1, '2025-06-13 08:00:00', @bk_12);

SET @bk_13 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_13, 'BK2506204896', '2025-06-20', '2025-06-24', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID879622', 1, 0, 2000000, 3800000.0, '2025-06-14 10:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-14 11:00:00', @cust4, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_13, @ser_spa, 3, 500000.0, 1500000.0, '2025-06-14 10:00:00'),
(UUID(), @bk_13, @ser_breakfast, 2, 150000.0, 300000.0, '2025-06-14 10:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-14 10:00:00', @bk_13),
(UUID(), 'CONFIRMED', NULL, '2025-06-14 17:00:00', @bk_13),
(UUID(), 'CHECKED_IN', @recep3, '2025-06-20 13:00:00', @bk_13),
(UUID(), 'CHECKED_OUT', @recep3, '2025-06-24 11:00:00', @bk_13);

SET @bk_14 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_14, 'BK2506308189', '2025-06-30', '2025-07-05', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID965073', 2, 1, 2500000, 2800000.0, '2025-06-23 06:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-23 07:00:00', @cust4, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_14, @ser_breakfast, 2, 150000.0, 300000.0, '2025-06-23 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-23 06:00:00', @bk_14),
(UUID(), 'CONFIRMED', NULL, '2025-06-23 15:00:00', @bk_14),
(UUID(), 'CHECKED_IN', @recep3, '2025-06-30 13:00:00', @bk_14),
(UUID(), 'CHECKED_OUT', @recep3, '2025-07-05 10:00:00', @bk_14);

SET @bk_15 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_15, 'BK2507073638', '2025-07-07', '2025-07-10', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID819066', 2, 0, 1500000, 2350000.0, '2025-06-24 15:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-06-24 16:00:00', @cust2, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_15, @ser_airport, 2, 200000.0, 400000.0, '2025-06-24 15:00:00'),
(UUID(), @bk_15, @ser_breakfast, 3, 150000.0, 450000.0, '2025-06-24 15:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-24 15:00:00', @bk_15),
(UUID(), 'CONFIRMED', NULL, '2025-06-25 03:00:00', @bk_15),
(UUID(), 'CHECKED_IN', @recep8, '2025-07-07 15:00:00', @bk_15),
(UUID(), 'CHECKED_OUT', @recep8, '2025-07-10 10:00:00', @bk_15);

SET @bk_16 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_16, 'BK2507217878', '2025-07-21', '2025-07-25', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID543107', 1, 0, 2000000, 2000000, '2025-07-10 03:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-07-10 04:00:00', @cust1, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-10 03:00:00', @bk_16),
(UUID(), 'CONFIRMED', NULL, '2025-07-10 18:00:00', @bk_16),
(UUID(), 'CHECKED_IN', @recep4, '2025-07-21 15:00:00', @bk_16),
(UUID(), 'CHECKED_OUT', @recep4, '2025-07-25 08:00:00', @bk_16);

SET @bk_17 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_17, 'BK2508033166', '2025-08-03', '2025-08-06', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID245510', 2, 0, 1500000, 2000000, '2025-08-01 14:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-01 15:00:00', @cust9, @room1);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_17, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-01 14:00:00', @bk_17),
(UUID(), 'CONFIRMED', NULL, '2025-08-02 08:00:00', @bk_17),
(UUID(), 'CHECKED_IN', @recep4, '2025-08-03 15:00:00', @bk_17),
(UUID(), 'CHECKED_OUT', @recep4, '2025-08-06 09:00:00', @bk_17);

SET @bk_18 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_18, 'BK2508099596', '2025-08-09', '2025-08-12', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID509372', 1, 1, 1500000, 2100000.0, '2025-08-01 10:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-01 11:00:00', @cust1, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_18, @ser_airport, 3, 200000.0, 600000.0, '2025-08-01 10:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-01 10:00:00', @bk_18),
(UUID(), 'CONFIRMED', NULL, '2025-08-01 19:00:00', @bk_18),
(UUID(), 'CHECKED_IN', @recep8, '2025-08-09 13:00:00', @bk_18),
(UUID(), 'CHECKED_OUT', @recep8, '2025-08-12 11:00:00', @bk_18);

SET @bk_19 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_19, 'BK2508164096', '2025-08-16', '2025-08-19', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID847232', 2, 1, 1500000, 2900000.0, '2025-08-09 04:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-09 05:00:00', @cust1, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_19, @ser_spa, 2, 500000.0, 1000000.0, '2025-08-09 04:00:00'),
(UUID(), @bk_19, @ser_airport, 1, 200000.0, 200000.0, '2025-08-09 04:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_19, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-09 04:00:00', @bk_19),
(UUID(), 'CONFIRMED', NULL, '2025-08-09 22:00:00', @bk_19),
(UUID(), 'CHECKED_IN', @recep4, '2025-08-16 13:00:00', @bk_19),
(UUID(), 'CHECKED_OUT', @recep4, '2025-08-19 11:00:00', @bk_19);

SET @bk_20 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_20, 'BK2508255809', '2025-08-25', '2025-08-31', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID415019', 1, 1, 3000000, 3000000, '2025-08-16 06:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-16 07:00:00', @cust3, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-16 06:00:00', @bk_20),
(UUID(), 'CONFIRMED', NULL, '2025-08-16 17:00:00', @bk_20),
(UUID(), 'CHECKED_IN', @recep5, '2025-08-25 15:00:00', @bk_20),
(UUID(), 'CHECKED_OUT', @recep5, '2025-08-31 10:00:00', @bk_20);

SET @bk_21 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_21, 'BK2509036654', '2025-09-03', '2025-09-08', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID104508', 2, 0, 2500000, 3000000.0, '2025-08-23 06:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-23 07:00:00', @cust10, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_21, @ser_spa, 1, 500000.0, 500000.0, '2025-08-23 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-23 06:00:00', @bk_21),
(UUID(), 'CONFIRMED', NULL, '2025-08-23 12:00:00', @bk_21),
(UUID(), 'CHECKED_IN', @recep8, '2025-09-03 12:00:00', @bk_21),
(UUID(), 'CHECKED_OUT', @recep8, '2025-09-08 09:00:00', @bk_21);

SET @bk_22 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_22, 'BK2509236736', '2025-09-23', '2025-09-28', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID565804', 1, 0, 2500000, 2950000.0, '2025-09-21 19:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-09-21 20:00:00', @cust7, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_22, @ser_breakfast, 3, 150000.0, 450000.0, '2025-09-21 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-21 19:00:00', @bk_22),
(UUID(), 'CONFIRMED', NULL, '2025-09-22 00:00:00', @bk_22),
(UUID(), 'CHECKED_IN', @recep5, '2025-09-23 12:00:00', @bk_22),
(UUID(), 'CHECKED_OUT', @recep5, '2025-09-28 08:00:00', @bk_22);

SET @bk_23 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_23, 'BK2510127483', '2025-10-12', '2025-10-13', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID251360', 2, 0, 500000, 1350000.0, '2025-09-28 23:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-09-29 00:00:00', @cust6, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_23, @ser_breakfast, 3, 150000.0, 450000.0, '2025-09-28 23:00:00'),
(UUID(), @bk_23, @ser_airport, 2, 200000.0, 400000.0, '2025-09-28 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-28 23:00:00', @bk_23),
(UUID(), 'CONFIRMED', NULL, '2025-09-29 05:00:00', @bk_23),
(UUID(), 'CHECKED_IN', @recep7, '2025-10-12 12:00:00', @bk_23),
(UUID(), 'CHECKED_OUT', @recep7, '2025-10-13 12:00:00', @bk_23);

SET @bk_24 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_24, 'BK2510163038', '2025-10-16', '2025-10-17', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID844671', 1, 0, 500000, 2450000.0, '2025-10-06 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-10-06 23:00:00', @cust6, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_24, @ser_breakfast, 3, 150000.0, 450000.0, '2025-10-06 22:00:00'),
(UUID(), @bk_24, @ser_spa, 3, 500000.0, 1500000.0, '2025-10-06 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-06 22:00:00', @bk_24),
(UUID(), 'CONFIRMED', NULL, '2025-10-07 11:00:00', @bk_24),
(UUID(), 'CHECKED_IN', @recep9, '2025-10-16 15:00:00', @bk_24),
(UUID(), 'CHECKED_OUT', @recep9, '2025-10-17 09:00:00', @bk_24);

SET @bk_25 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_25, 'BK2510311506', '2025-10-31', '2025-11-03', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID615152', 2, 1, 1500000, 3300000.0, '2025-10-17 06:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-10-17 07:00:00', @cust5, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_25, @ser_spa, 2, 500000.0, 1000000.0, '2025-10-17 06:00:00'),
(UUID(), @bk_25, @ser_breakfast, 2, 150000.0, 300000.0, '2025-10-17 06:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_25, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-17 06:00:00', @bk_25),
(UUID(), 'CONFIRMED', NULL, '2025-10-17 11:00:00', @bk_25),
(UUID(), 'CHECKED_IN', @recep8, '2025-10-31 12:00:00', @bk_25),
(UUID(), 'CHECKED_OUT', @recep8, '2025-11-03 09:00:00', @bk_25);

SET @bk_26 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_26, 'BK2511158355', '2025-11-15', '2025-11-17', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID377516', 2, 1, 1000000, 1650000.0, '2025-11-11 09:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-11-11 10:00:00', @cust1, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_26, @ser_breakfast, 3, 150000.0, 450000.0, '2025-11-11 09:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_26, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-11 09:00:00', @bk_26),
(UUID(), 'CONFIRMED', NULL, '2025-11-11 11:00:00', @bk_26),
(UUID(), 'CHECKED_IN', @recep7, '2025-11-15 12:00:00', @bk_26),
(UUID(), 'CHECKED_OUT', @recep7, '2025-11-17 08:00:00', @bk_26);

SET @bk_27 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_27, 'BK2511237968', '2025-11-23', '2025-11-28', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID147735', 1, 0, 2500000, 2950000.0, '2025-11-08 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-08 23:00:00', @cust10, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_27, @ser_breakfast, 3, 150000.0, 450000.0, '2025-11-08 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-08 22:00:00', @bk_27),
(UUID(), 'CONFIRMED', NULL, '2025-11-09 12:00:00', @bk_27),
(UUID(), 'CHECKED_IN', @recep7, '2025-11-23 14:00:00', @bk_27),
(UUID(), 'CHECKED_OUT', @recep7, '2025-11-28 11:00:00', @bk_27);

SET @bk_28 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_28, 'BK2511305068', '2025-11-30', '2025-12-02', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID382414', 1, 0, 1000000, 1500000.0, '2025-11-23 09:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-23 10:00:00', @cust7, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_28, @ser_spa, 1, 500000.0, 500000.0, '2025-11-23 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-23 09:00:00', @bk_28),
(UUID(), 'CONFIRMED', NULL, '2025-11-23 23:00:00', @bk_28),
(UUID(), 'CHECKED_IN', @recep7, '2025-11-30 15:00:00', @bk_28),
(UUID(), 'CHECKED_OUT', @recep7, '2025-12-02 09:00:00', @bk_28);

SET @bk_29 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_29, 'BK2512135531', '2025-12-13', '2025-12-14', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID745680', 1, 0, 500000, 900000.0, '2025-12-09 16:00:00', 'CANCELLED', 'CREDIT_CARD', 'UNPAID', NULL, @cust8, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_29, @ser_airport, 1, 200000.0, 200000.0, '2025-12-09 16:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_29, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-09 16:00:00', @bk_29),
(UUID(), 'CANCELLED', @recep2, '2025-12-10 06:00:00', @bk_29);

SET @bk_30 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_30, 'BK2512178031', '2025-12-17', '2025-12-22', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID529282', 2, 1, 2500000, 3550000.0, '2025-12-02 12:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-02 13:00:00', @cust10, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_30, @ser_breakfast, 3, 150000.0, 450000.0, '2025-12-02 12:00:00'),
(UUID(), @bk_30, @ser_airport, 3, 200000.0, 600000.0, '2025-12-02 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-02 12:00:00', @bk_30),
(UUID(), 'CONFIRMED', NULL, '2025-12-03 07:00:00', @bk_30),
(UUID(), 'CHECKED_IN', @recep3, '2025-12-17 12:00:00', @bk_30),
(UUID(), 'CHECKED_OUT', @recep3, '2025-12-22 09:00:00', @bk_30);

SET @bk_31 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_31, 'BK2512244179', '2025-12-24', '2025-12-26', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID653929', 2, 0, 1000000, 1000000, '2025-12-17 23:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-18 00:00:00', @cust6, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-17 23:00:00', @bk_31),
(UUID(), 'CONFIRMED', NULL, '2025-12-18 22:00:00', @bk_31),
(UUID(), 'CHECKED_IN', @recep3, '2025-12-24 14:00:00', @bk_31),
(UUID(), 'CHECKED_OUT', @recep3, '2025-12-26 11:00:00', @bk_31);

SET @bk_32 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_32, 'BK2512302559', '2025-12-30', '2025-12-31', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID242442', 1, 1, 500000, 500000, '2025-12-24 19:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-24 20:00:00', @cust8, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-24 19:00:00', @bk_32),
(UUID(), 'CONFIRMED', NULL, '2025-12-25 17:00:00', @bk_32),
(UUID(), 'CHECKED_IN', @recep1, '2025-12-30 15:00:00', @bk_32),
(UUID(), 'CHECKED_OUT', @recep1, '2025-12-31 11:00:00', @bk_32);

SET @bk_33 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_33, 'BK2601058662', '2026-01-05', '2026-01-11', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID989099', 1, 0, 3000000, 3000000, '2025-12-26 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-26 02:00:00', @cust7, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-26 01:00:00', @bk_33),
(UUID(), 'CONFIRMED', NULL, '2025-12-26 14:00:00', @bk_33),
(UUID(), 'CHECKED_IN', @recep5, '2026-01-05 12:00:00', @bk_33),
(UUID(), 'CHECKED_OUT', @recep5, '2026-01-11 10:00:00', @bk_33);

SET @bk_34 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_34, 'BK2601124517', '2026-01-12', '2026-01-13', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID473763', 2, 1, 500000, 1150000.0, '2026-01-02 20:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-02 21:00:00', @cust5, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_34, @ser_breakfast, 1, 150000.0, 150000.0, '2026-01-02 20:00:00'),
(UUID(), @bk_34, @ser_spa, 1, 500000.0, 500000.0, '2026-01-02 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-02 20:00:00', @bk_34),
(UUID(), 'CONFIRMED', NULL, '2026-01-02 22:00:00', @bk_34),
(UUID(), 'CHECKED_IN', @recep1, '2026-01-12 13:00:00', @bk_34),
(UUID(), 'CHECKED_OUT', @recep1, '2026-01-13 12:00:00', @bk_34);

SET @bk_35 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_35, 'BK2601272849', '2026-01-27', '2026-02-02', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID246166', 1, 1, 3000000, 3000000, '2026-01-12 13:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-12 14:00:00', @cust6, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-12 13:00:00', @bk_35),
(UUID(), 'CONFIRMED', NULL, '2026-01-13 10:00:00', @bk_35),
(UUID(), 'CHECKED_IN', @recep1, '2026-01-27 16:00:00', @bk_35),
(UUID(), 'CHECKED_OUT', @recep1, '2026-02-02 10:00:00', @bk_35);

SET @bk_36 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_36, 'BK2602129786', '2026-02-12', '2026-02-14', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID410782', 2, 1, 1000000, 1700000.0, '2026-02-09 03:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-02-09 04:00:00', @cust3, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_36, @ser_airport, 1, 200000.0, 200000.0, '2026-02-09 03:00:00'),
(UUID(), @bk_36, @ser_breakfast, 2, 150000.0, 300000.0, '2026-02-09 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_36, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-09 03:00:00', @bk_36),
(UUID(), 'CONFIRMED', NULL, '2026-02-09 19:00:00', @bk_36),
(UUID(), 'CHECKED_IN', @recep8, '2026-02-12 16:00:00', @bk_36),
(UUID(), 'CHECKED_OUT', @recep8, '2026-02-14 12:00:00', @bk_36);

SET @bk_37 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_37, 'BK2602216508', '2026-02-21', '2026-02-23', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID163423', 1, 0, 1000000, 1000000, '2026-02-12 02:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-12 03:00:00', @cust7, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-12 02:00:00', @bk_37),
(UUID(), 'CONFIRMED', NULL, '2026-02-12 18:00:00', @bk_37),
(UUID(), 'CHECKED_IN', @recep3, '2026-02-21 14:00:00', @bk_37),
(UUID(), 'CHECKED_OUT', @recep3, '2026-02-23 11:00:00', @bk_37);

SET @bk_38 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_38, 'BK2603098326', '2026-03-09', '2026-03-11', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID359663', 2, 1, 1000000, 2700000.0, '2026-02-23 14:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-23 15:00:00', @cust2, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_38, @ser_airport, 1, 200000.0, 200000.0, '2026-02-23 14:00:00'),
(UUID(), @bk_38, @ser_spa, 3, 500000.0, 1500000.0, '2026-02-23 14:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-23 14:00:00', @bk_38),
(UUID(), 'CONFIRMED', NULL, '2026-02-24 05:00:00', @bk_38),
(UUID(), 'CHECKED_IN', @recep6, '2026-03-09 15:00:00', @bk_38),
(UUID(), 'CHECKED_OUT', @recep6, '2026-03-11 08:00:00', @bk_38);

SET @bk_39 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_39, 'BK2603266177', '2026-03-26', '2026-04-01', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID222748', 2, 1, 3000000, 3000000, '2026-03-18 10:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-18 11:00:00', @cust5, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-18 10:00:00', @bk_39),
(UUID(), 'CONFIRMED', NULL, '2026-03-19 00:00:00', @bk_39),
(UUID(), 'CHECKED_IN', @recep3, '2026-03-26 14:00:00', @bk_39),
(UUID(), 'CHECKED_OUT', @recep3, '2026-04-01 11:00:00', @bk_39);

SET @bk_40 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_40, 'BK2604164766', '2026-04-16', '2026-04-20', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID498086', 2, 1, 2000000, 2000000, '2026-04-01 13:00:00', 'PENDING', 'CASH', 'UNPAID', NULL, @cust5, @room1);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-01 13:00:00', @bk_40);

SET @bk_41 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_41, 'BK2604286458', '2026-04-28', '2026-05-01', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID984522', 1, 1, 1500000, 2700000.0, '2026-04-21 20:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-04-21 21:00:00', @cust10, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_41, @ser_spa, 2, 500000.0, 1000000.0, '2026-04-21 20:00:00'),
(UUID(), @bk_41, @ser_airport, 1, 200000.0, 200000.0, '2026-04-21 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-21 20:00:00', @bk_41),
(UUID(), 'CONFIRMED', NULL, '2026-04-22 10:00:00', @bk_41);

SET @bk_42 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_42, 'BK2605136111', '2026-05-13', '2026-05-14', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID562514', 2, 1, 500000, 1100000.0, '2026-05-10 12:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-05-10 13:00:00', @cust6, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_42, @ser_airport, 2, 200000.0, 400000.0, '2026-05-10 12:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_42, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-10 12:00:00', @bk_42),
(UUID(), 'CONFIRMED', NULL, '2026-05-11 12:00:00', @bk_42);

SET @bk_43 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_43, 'BK2605293692', '2026-05-29', '2026-05-31', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID380577', 2, 1, 1000000, 2500000.0, '2026-05-26 02:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-05-26 03:00:00', @cust3, @room1);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_43, @ser_spa, 3, 500000.0, 1500000.0, '2026-05-26 02:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-26 02:00:00', @bk_43),
(UUID(), 'CONFIRMED', NULL, '2026-05-26 18:00:00', @bk_43);

SET @bk_44 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_44, 'BK2501106212', '2025-01-10', '2025-01-14', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID327633', 1, 0, 2000000, 2000000, '2024-12-29 01:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2024-12-29 02:00:00', @cust3, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2024-12-29 01:00:00', @bk_44),
(UUID(), 'CONFIRMED', NULL, '2024-12-29 15:00:00', @bk_44),
(UUID(), 'CHECKED_IN', @recep8, '2025-01-10 12:00:00', @bk_44),
(UUID(), 'CHECKED_OUT', @recep8, '2025-01-14 12:00:00', @bk_44);

SET @bk_45 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_45, 'BK2501271608', '2025-01-27', '2025-01-28', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID291529', 2, 1, 500000, 1350000.0, '2025-01-14 12:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-14 13:00:00', @cust4, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_45, @ser_airport, 2, 200000.0, 400000.0, '2025-01-14 12:00:00'),
(UUID(), @bk_45, @ser_breakfast, 3, 150000.0, 450000.0, '2025-01-14 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-14 12:00:00', @bk_45),
(UUID(), 'CONFIRMED', NULL, '2025-01-14 22:00:00', @bk_45),
(UUID(), 'CHECKED_IN', @recep4, '2025-01-27 12:00:00', @bk_45),
(UUID(), 'CHECKED_OUT', @recep4, '2025-01-28 12:00:00', @bk_45);

SET @bk_46 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_46, 'BK2502115314', '2025-02-11', '2025-02-16', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID237769', 2, 1, 2500000, 3500000.0, '2025-01-30 09:00:00', 'CANCELLED', 'BANK_TRANSFER', 'UNPAID', NULL, @cust8, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_46, @ser_spa, 2, 500000.0, 1000000.0, '2025-01-30 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-30 09:00:00', @bk_46),
(UUID(), 'CANCELLED', @recep3, '2025-01-30 22:00:00', @bk_46);

SET @bk_47 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_47, 'BK2502259164', '2025-02-25', '2025-02-26', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID268373', 2, 0, 500000, 1600000.0, '2025-02-23 16:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-23 17:00:00', @cust6, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_47, @ser_spa, 1, 500000.0, 500000.0, '2025-02-23 16:00:00'),
(UUID(), @bk_47, @ser_airport, 3, 200000.0, 600000.0, '2025-02-23 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-23 16:00:00', @bk_47),
(UUID(), 'CONFIRMED', NULL, '2025-02-23 19:00:00', @bk_47),
(UUID(), 'CHECKED_IN', @recep9, '2025-02-25 16:00:00', @bk_47),
(UUID(), 'CHECKED_OUT', @recep9, '2025-02-26 10:00:00', @bk_47);

SET @bk_48 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_48, 'BK2503085291', '2025-03-08', '2025-03-14', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID558294', 1, 0, 3000000, 3100000, '2025-02-26 02:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-02-26 03:00:00', @cust9, @room2);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_48, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-26 02:00:00', @bk_48),
(UUID(), 'CONFIRMED', NULL, '2025-02-26 08:00:00', @bk_48),
(UUID(), 'CHECKED_IN', @recep2, '2025-03-08 15:00:00', @bk_48),
(UUID(), 'CHECKED_OUT', @recep2, '2025-03-14 10:00:00', @bk_48);

SET @bk_49 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_49, 'BK2503298870', '2025-03-29', '2025-04-01', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID973227', 1, 0, 1500000, 1950000.0, '2025-03-25 23:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-26 00:00:00', @cust7, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_49, @ser_breakfast, 3, 150000.0, 450000.0, '2025-03-25 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-25 23:00:00', @bk_49),
(UUID(), 'CONFIRMED', NULL, '2025-03-26 01:00:00', @bk_49),
(UUID(), 'CHECKED_IN', @recep2, '2025-03-29 12:00:00', @bk_49),
(UUID(), 'CHECKED_OUT', @recep2, '2025-04-01 11:00:00', @bk_49);

SET @bk_50 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_50, 'BK2504083091', '2025-04-08', '2025-04-11', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID973782', 2, 0, 1500000, 3150000.0, '2025-04-01 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-01 02:00:00', @cust10, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_50, @ser_spa, 3, 500000.0, 1500000.0, '2025-04-01 01:00:00'),
(UUID(), @bk_50, @ser_breakfast, 1, 150000.0, 150000.0, '2025-04-01 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-01 01:00:00', @bk_50),
(UUID(), 'CONFIRMED', NULL, '2025-04-02 00:00:00', @bk_50),
(UUID(), 'CHECKED_IN', @recep8, '2025-04-08 13:00:00', @bk_50),
(UUID(), 'CHECKED_OUT', @recep8, '2025-04-11 09:00:00', @bk_50);

SET @bk_51 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_51, 'BK2504202793', '2025-04-20', '2025-04-21', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID509896', 1, 1, 500000, 1000000.0, '2025-04-11 19:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-11 20:00:00', @cust6, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_51, @ser_spa, 1, 500000.0, 500000.0, '2025-04-11 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-11 19:00:00', @bk_51),
(UUID(), 'CONFIRMED', NULL, '2025-04-12 14:00:00', @bk_51),
(UUID(), 'CHECKED_IN', @recep6, '2025-04-20 13:00:00', @bk_51),
(UUID(), 'CHECKED_OUT', @recep6, '2025-04-21 10:00:00', @bk_51);

SET @bk_52 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_52, 'BK2504239025', '2025-04-23', '2025-04-28', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID494079', 1, 0, 2500000, 2700000.0, '2025-04-19 04:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-19 05:00:00', @cust10, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_52, @ser_airport, 1, 200000.0, 200000.0, '2025-04-19 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-19 04:00:00', @bk_52),
(UUID(), 'CONFIRMED', NULL, '2025-04-20 02:00:00', @bk_52),
(UUID(), 'CHECKED_IN', @recep5, '2025-04-23 13:00:00', @bk_52),
(UUID(), 'CHECKED_OUT', @recep5, '2025-04-28 08:00:00', @bk_52);

SET @bk_53 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_53, 'BK2505138227', '2025-05-13', '2025-05-16', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID615316', 2, 0, 1500000, 2400000.0, '2025-05-03 03:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-05-03 04:00:00', @cust1, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_53, @ser_airport, 2, 200000.0, 400000.0, '2025-05-03 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_53, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-03 03:00:00', @bk_53),
(UUID(), 'CONFIRMED', NULL, '2025-05-04 02:00:00', @bk_53),
(UUID(), 'CHECKED_IN', @recep7, '2025-05-13 14:00:00', @bk_53),
(UUID(), 'CHECKED_OUT', @recep7, '2025-05-16 09:00:00', @bk_53);

SET @bk_54 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_54, 'BK2505291782', '2025-05-29', '2025-06-02', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID427263', 1, 0, 2000000, 2000000, '2025-05-19 08:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-05-19 09:00:00', @cust7, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-19 08:00:00', @bk_54),
(UUID(), 'CONFIRMED', NULL, '2025-05-20 06:00:00', @bk_54),
(UUID(), 'CHECKED_IN', @recep5, '2025-05-29 12:00:00', @bk_54),
(UUID(), 'CHECKED_OUT', @recep5, '2025-06-02 10:00:00', @bk_54);

SET @bk_55 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_55, 'BK2506071030', '2025-06-07', '2025-06-09', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID687894', 1, 1, 1000000, 1300000.0, '2025-05-30 21:00:00', 'CANCELLED', 'BANK_TRANSFER', 'UNPAID', NULL, @cust3, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_55, @ser_breakfast, 2, 150000.0, 300000.0, '2025-05-30 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-30 21:00:00', @bk_55),
(UUID(), 'CANCELLED', @recep2, '2025-05-31 04:00:00', @bk_55);

SET @bk_56 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_56, 'BK2506182068', '2025-06-18', '2025-06-23', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID419731', 2, 0, 2500000, 3700000.0, '2025-06-08 13:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-08 14:00:00', @cust1, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_56, @ser_airport, 1, 200000.0, 200000.0, '2025-06-08 13:00:00'),
(UUID(), @bk_56, @ser_spa, 2, 500000.0, 1000000.0, '2025-06-08 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-08 13:00:00', @bk_56),
(UUID(), 'CONFIRMED', NULL, '2025-06-08 23:00:00', @bk_56),
(UUID(), 'CHECKED_IN', @recep3, '2025-06-18 12:00:00', @bk_56),
(UUID(), 'CHECKED_OUT', @recep3, '2025-06-23 10:00:00', @bk_56);

SET @bk_57 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_57, 'BK2506279034', '2025-06-27', '2025-07-01', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID175485', 2, 0, 2000000, 2000000, '2025-06-20 18:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-20 19:00:00', @cust9, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-20 18:00:00', @bk_57),
(UUID(), 'CONFIRMED', NULL, '2025-06-20 21:00:00', @bk_57),
(UUID(), 'CHECKED_IN', @recep2, '2025-06-27 15:00:00', @bk_57),
(UUID(), 'CHECKED_OUT', @recep2, '2025-07-01 11:00:00', @bk_57);

SET @bk_58 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_58, 'BK2507161902', '2025-07-16', '2025-07-22', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID178233', 1, 1, 3000000, 3000000, '2025-07-09 11:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-07-09 12:00:00', @cust7, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-09 11:00:00', @bk_58),
(UUID(), 'CONFIRMED', NULL, '2025-07-09 19:00:00', @bk_58),
(UUID(), 'CHECKED_IN', @recep1, '2025-07-16 16:00:00', @bk_58),
(UUID(), 'CHECKED_OUT', @recep1, '2025-07-22 08:00:00', @bk_58);

SET @bk_59 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_59, 'BK2508062787', '2025-08-06', '2025-08-09', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID799395', 2, 1, 1500000, 1500000, '2025-07-31 01:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-07-31 02:00:00', @cust9, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-31 01:00:00', @bk_59),
(UUID(), 'CONFIRMED', NULL, '2025-07-31 20:00:00', @bk_59),
(UUID(), 'CHECKED_IN', @recep9, '2025-08-06 12:00:00', @bk_59),
(UUID(), 'CHECKED_OUT', @recep9, '2025-08-09 09:00:00', @bk_59);

SET @bk_60 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_60, 'BK2508123723', '2025-08-12', '2025-08-14', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID818935', 1, 0, 1000000, 1000000, '2025-08-10 15:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-10 16:00:00', @cust10, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-10 15:00:00', @bk_60),
(UUID(), 'CONFIRMED', NULL, '2025-08-10 16:00:00', @bk_60),
(UUID(), 'CHECKED_IN', @recep1, '2025-08-12 14:00:00', @bk_60),
(UUID(), 'CHECKED_OUT', @recep1, '2025-08-14 10:00:00', @bk_60);

SET @bk_61 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_61, 'BK2508223515', '2025-08-22', '2025-08-24', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID450864', 2, 0, 1000000, 1000000, '2025-08-16 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-08-16 06:00:00', @cust2, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-16 05:00:00', @bk_61),
(UUID(), 'CONFIRMED', NULL, '2025-08-16 19:00:00', @bk_61),
(UUID(), 'CHECKED_IN', @recep8, '2025-08-22 14:00:00', @bk_61),
(UUID(), 'CHECKED_OUT', @recep8, '2025-08-24 10:00:00', @bk_61);

SET @bk_62 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_62, 'BK2508304213', '2025-08-30', '2025-09-01', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID584058', 2, 0, 1000000, 2000000.0, '2025-08-15 11:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-08-15 12:00:00', @cust7, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_62, @ser_airport, 2, 200000.0, 400000.0, '2025-08-15 11:00:00'),
(UUID(), @bk_62, @ser_spa, 1, 500000.0, 500000.0, '2025-08-15 11:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_62, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-15 11:00:00', @bk_62),
(UUID(), 'CONFIRMED', NULL, '2025-08-16 04:00:00', @bk_62),
(UUID(), 'CHECKED_IN', @recep3, '2025-08-30 13:00:00', @bk_62),
(UUID(), 'CHECKED_OUT', @recep3, '2025-09-01 09:00:00', @bk_62);

SET @bk_63 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_63, 'BK2509106372', '2025-09-10', '2025-09-14', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID614908', 1, 0, 2000000, 3950000.0, '2025-08-30 21:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-30 22:00:00', @cust5, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_63, @ser_spa, 3, 500000.0, 1500000.0, '2025-08-30 21:00:00'),
(UUID(), @bk_63, @ser_breakfast, 3, 150000.0, 450000.0, '2025-08-30 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-30 21:00:00', @bk_63),
(UUID(), 'CONFIRMED', NULL, '2025-08-31 17:00:00', @bk_63),
(UUID(), 'CHECKED_IN', @recep1, '2025-09-10 12:00:00', @bk_63),
(UUID(), 'CHECKED_OUT', @recep1, '2025-09-14 08:00:00', @bk_63);

SET @bk_64 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_64, 'BK2509268746', '2025-09-26', '2025-09-29', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID669269', 2, 0, 1500000, 1500000, '2025-09-23 05:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-23 06:00:00', @cust2, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-23 05:00:00', @bk_64),
(UUID(), 'CONFIRMED', NULL, '2025-09-23 11:00:00', @bk_64),
(UUID(), 'CHECKED_IN', @recep10, '2025-09-26 13:00:00', @bk_64),
(UUID(), 'CHECKED_OUT', @recep10, '2025-09-29 09:00:00', @bk_64);

SET @bk_65 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_65, 'BK2510075506', '2025-10-07', '2025-10-13', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID605093', 2, 1, 3000000, 3650000.0, '2025-09-28 18:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-28 19:00:00', @cust3, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_65, @ser_spa, 1, 500000.0, 500000.0, '2025-09-28 18:00:00'),
(UUID(), @bk_65, @ser_breakfast, 1, 150000.0, 150000.0, '2025-09-28 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-28 18:00:00', @bk_65),
(UUID(), 'CONFIRMED', NULL, '2025-09-29 10:00:00', @bk_65),
(UUID(), 'CHECKED_IN', @recep2, '2025-10-07 15:00:00', @bk_65),
(UUID(), 'CHECKED_OUT', @recep2, '2025-10-13 10:00:00', @bk_65);

SET @bk_66 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_66, 'BK2510224280', '2025-10-22', '2025-10-23', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID569874', 1, 1, 500000, 1500000.0, '2025-10-10 03:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-10-10 04:00:00', @cust9, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_66, @ser_spa, 1, 500000.0, 500000.0, '2025-10-10 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_66, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-10 03:00:00', @bk_66),
(UUID(), 'CONFIRMED', NULL, '2025-10-10 13:00:00', @bk_66),
(UUID(), 'CHECKED_IN', @recep6, '2025-10-22 13:00:00', @bk_66),
(UUID(), 'CHECKED_OUT', @recep6, '2025-10-23 09:00:00', @bk_66);

SET @bk_67 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_67, 'BK2511067866', '2025-11-06', '2025-11-08', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID331624', 2, 0, 1000000, 2000000.0, '2025-10-25 20:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-10-25 21:00:00', @cust10, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_67, @ser_spa, 2, 500000.0, 1000000.0, '2025-10-25 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-25 20:00:00', @bk_67),
(UUID(), 'CONFIRMED', NULL, '2025-10-26 18:00:00', @bk_67),
(UUID(), 'CHECKED_IN', @recep8, '2025-11-06 16:00:00', @bk_67),
(UUID(), 'CHECKED_OUT', @recep8, '2025-11-08 11:00:00', @bk_67);

SET @bk_68 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_68, 'BK2511112188', '2025-11-11', '2025-11-14', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID358753', 1, 1, 1500000, 2250000.0, '2025-11-05 01:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-05 02:00:00', @cust2, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_68, @ser_airport, 3, 200000.0, 600000.0, '2025-11-05 01:00:00'),
(UUID(), @bk_68, @ser_breakfast, 1, 150000.0, 150000.0, '2025-11-05 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-05 01:00:00', @bk_68),
(UUID(), 'CONFIRMED', NULL, '2025-11-05 04:00:00', @bk_68),
(UUID(), 'CHECKED_IN', @recep1, '2025-11-11 12:00:00', @bk_68),
(UUID(), 'CHECKED_OUT', @recep1, '2025-11-14 12:00:00', @bk_68);

SET @bk_69 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_69, 'BK2511211186', '2025-11-21', '2025-11-26', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID833440', 2, 1, 2500000, 2700000.0, '2025-11-19 16:00:00', 'CANCELLED', 'CREDIT_CARD', 'UNPAID', NULL, @cust2, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_69, @ser_airport, 1, 200000.0, 200000.0, '2025-11-19 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-19 16:00:00', @bk_69),
(UUID(), 'CANCELLED', @recep3, '2025-11-20 05:00:00', @bk_69);

SET @bk_70 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_70, 'BK2512101893', '2025-12-10', '2025-12-13', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID715650', 1, 1, 1500000, 1500000, '2025-12-07 16:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-12-07 17:00:00', @cust9, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-07 16:00:00', @bk_70),
(UUID(), 'CONFIRMED', NULL, '2025-12-08 02:00:00', @bk_70),
(UUID(), 'CHECKED_IN', @recep10, '2025-12-10 16:00:00', @bk_70),
(UUID(), 'CHECKED_OUT', @recep10, '2025-12-13 08:00:00', @bk_70);

SET @bk_71 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_71, 'BK2512261567', '2025-12-26', '2025-12-29', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID232940', 1, 0, 1500000, 1500000, '2025-12-19 05:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-19 06:00:00', @cust3, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-19 05:00:00', @bk_71),
(UUID(), 'CONFIRMED', NULL, '2025-12-20 05:00:00', @bk_71),
(UUID(), 'CHECKED_IN', @recep9, '2025-12-26 15:00:00', @bk_71),
(UUID(), 'CHECKED_OUT', @recep9, '2025-12-29 08:00:00', @bk_71);

SET @bk_72 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_72, 'BK2601046966', '2026-01-04', '2026-01-10', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID759663', 2, 0, 3000000, 3200000, '2025-12-29 17:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-29 18:00:00', @cust2, @room2);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_72, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-29 17:00:00', @bk_72),
(UUID(), 'CONFIRMED', NULL, '2025-12-30 15:00:00', @bk_72),
(UUID(), 'CHECKED_IN', @recep3, '2026-01-04 15:00:00', @bk_72),
(UUID(), 'CHECKED_OUT', @recep3, '2026-01-10 11:00:00', @bk_72);

SET @bk_73 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_73, 'BK2601203450', '2026-01-20', '2026-01-26', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID193034', 1, 0, 3000000, 4900000.0, '2026-01-06 04:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-06 05:00:00', @cust3, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_73, @ser_airport, 3, 200000.0, 600000.0, '2026-01-06 04:00:00'),
(UUID(), @bk_73, @ser_spa, 2, 500000.0, 1000000.0, '2026-01-06 04:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_73, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-06 04:00:00', @bk_73),
(UUID(), 'CONFIRMED', NULL, '2026-01-06 17:00:00', @bk_73),
(UUID(), 'CHECKED_IN', @recep8, '2026-01-20 16:00:00', @bk_73),
(UUID(), 'CHECKED_OUT', @recep8, '2026-01-26 11:00:00', @bk_73);

SET @bk_74 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_74, 'BK2602079235', '2026-02-07', '2026-02-12', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID637875', 1, 0, 2500000, 2700000.0, '2026-02-04 17:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-04 18:00:00', @cust6, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_74, @ser_airport, 1, 200000.0, 200000.0, '2026-02-04 17:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-04 17:00:00', @bk_74),
(UUID(), 'CONFIRMED', NULL, '2026-02-04 21:00:00', @bk_74),
(UUID(), 'CHECKED_IN', @recep6, '2026-02-07 13:00:00', @bk_74),
(UUID(), 'CHECKED_OUT', @recep6, '2026-02-12 11:00:00', @bk_74);

SET @bk_75 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_75, 'BK2602173150', '2026-02-17', '2026-02-20', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID611778', 2, 1, 1500000, 2300000.0, '2026-02-04 00:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-02-04 01:00:00', @cust8, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_75, @ser_breakfast, 2, 150000.0, 300000.0, '2026-02-04 00:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_75, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-04 00:00:00', @bk_75),
(UUID(), 'CONFIRMED', NULL, '2026-02-04 11:00:00', @bk_75),
(UUID(), 'CHECKED_IN', @recep6, '2026-02-17 14:00:00', @bk_75),
(UUID(), 'CHECKED_OUT', @recep6, '2026-02-20 10:00:00', @bk_75);

SET @bk_76 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_76, 'BK2602214529', '2026-02-21', '2026-02-22', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID897259', 1, 0, 500000, 650000.0, '2026-02-09 16:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-09 17:00:00', @cust2, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_76, @ser_breakfast, 1, 150000.0, 150000.0, '2026-02-09 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-09 16:00:00', @bk_76),
(UUID(), 'CONFIRMED', NULL, '2026-02-10 15:00:00', @bk_76),
(UUID(), 'CHECKED_IN', @recep3, '2026-02-21 16:00:00', @bk_76),
(UUID(), 'CHECKED_OUT', @recep3, '2026-02-22 10:00:00', @bk_76);

SET @bk_77 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_77, 'BK2603091034', '2026-03-09', '2026-03-15', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID991650', 1, 0, 3000000, 3400000.0, '2026-02-22 13:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-02-22 14:00:00', @cust9, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_77, @ser_airport, 2, 200000.0, 400000.0, '2026-02-22 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-22 13:00:00', @bk_77),
(UUID(), 'CONFIRMED', NULL, '2026-02-23 12:00:00', @bk_77),
(UUID(), 'CHECKED_IN', @recep1, '2026-03-09 13:00:00', @bk_77),
(UUID(), 'CHECKED_OUT', @recep1, '2026-03-15 10:00:00', @bk_77);

SET @bk_78 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_78, 'BK2603226407', '2026-03-22', '2026-03-27', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID928892', 2, 1, 2500000, 4000000.0, '2026-03-13 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-13 02:00:00', @cust6, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_78, @ser_spa, 3, 500000.0, 1500000.0, '2026-03-13 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-13 01:00:00', @bk_78),
(UUID(), 'CONFIRMED', NULL, '2026-03-13 07:00:00', @bk_78),
(UUID(), 'CHECKED_IN', @recep8, '2026-03-22 15:00:00', @bk_78),
(UUID(), 'CHECKED_OUT', @recep8, '2026-03-27 08:00:00', @bk_78);

SET @bk_79 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_79, 'BK2604083799', '2026-04-08', '2026-04-10', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID396833', 1, 1, 1000000, 1750000.0, '2026-03-30 13:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-03-30 14:00:00', @cust8, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_79, @ser_breakfast, 1, 150000.0, 150000.0, '2026-03-30 13:00:00'),
(UUID(), @bk_79, @ser_airport, 3, 200000.0, 600000.0, '2026-03-30 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-30 13:00:00', @bk_79),
(UUID(), 'CONFIRMED', NULL, '2026-03-31 10:00:00', @bk_79),
(UUID(), 'CHECKED_IN', @recep6, '2026-04-08 12:00:00', @bk_79),
(UUID(), 'CHECKED_OUT', @recep6, '2026-04-10 12:00:00', @bk_79);

SET @bk_80 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_80, 'BK2604211049', '2026-04-21', '2026-04-26', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID689624', 1, 1, 2500000, 2950000.0, '2026-04-19 23:00:00', 'PENDING', 'CREDIT_CARD', 'UNPAID', NULL, @cust10, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_80, @ser_breakfast, 3, 150000.0, 450000.0, '2026-04-19 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-19 23:00:00', @bk_80);

SET @bk_81 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_81, 'BK2605041099', '2026-05-04', '2026-05-05', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID756201', 1, 0, 500000, 500000, '2026-04-25 03:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-04-25 04:00:00', @cust6, @room2);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-25 03:00:00', @bk_81),
(UUID(), 'CONFIRMED', NULL, '2026-04-25 17:00:00', @bk_81);

SET @bk_82 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_82, 'BK2605135439', '2026-05-13', '2026-05-19', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID992066', 1, 1, 3000000, 4100000.0, '2026-05-10 10:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-05-10 11:00:00', @cust1, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_82, @ser_spa, 1, 500000.0, 500000.0, '2026-05-10 10:00:00'),
(UUID(), @bk_82, @ser_airport, 3, 200000.0, 600000.0, '2026-05-10 10:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-10 10:00:00', @bk_82),
(UUID(), 'CONFIRMED', NULL, '2026-05-10 23:00:00', @bk_82);

SET @bk_83 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_83, 'BK2605241741', '2026-05-24', '2026-05-25', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID828467', 1, 1, 500000, 1200000.0, '2026-05-13 05:00:00', 'PENDING', 'CREDIT_CARD', 'UNPAID', NULL, @cust3, @room2);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_83, @ser_airport, 2, 200000.0, 400000.0, '2026-05-13 05:00:00'),
(UUID(), @bk_83, @ser_breakfast, 2, 150000.0, 300000.0, '2026-05-13 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-13 05:00:00', @bk_83);

SET @bk_84 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_84, 'BK2501053143', '2025-01-05', '2025-01-11', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID309004', 1, 1, 3000000, 4500000.0, '2024-12-22 09:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2024-12-22 10:00:00', @cust4, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_84, @ser_spa, 3, 500000.0, 1500000.0, '2024-12-22 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2024-12-22 09:00:00', @bk_84),
(UUID(), 'CONFIRMED', NULL, '2024-12-22 13:00:00', @bk_84),
(UUID(), 'CHECKED_IN', @recep9, '2025-01-05 16:00:00', @bk_84),
(UUID(), 'CHECKED_OUT', @recep9, '2025-01-11 11:00:00', @bk_84);

SET @bk_85 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_85, 'BK2501187639', '2025-01-18', '2025-01-24', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID636857', 1, 0, 3000000, 4050000.0, '2025-01-04 21:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-01-04 22:00:00', @cust4, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_85, @ser_airport, 3, 200000.0, 600000.0, '2025-01-04 21:00:00'),
(UUID(), @bk_85, @ser_breakfast, 3, 150000.0, 450000.0, '2025-01-04 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-04 21:00:00', @bk_85),
(UUID(), 'CONFIRMED', NULL, '2025-01-05 08:00:00', @bk_85),
(UUID(), 'CHECKED_IN', @recep10, '2025-01-18 13:00:00', @bk_85),
(UUID(), 'CHECKED_OUT', @recep10, '2025-01-24 12:00:00', @bk_85);

SET @bk_86 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_86, 'BK2501301424', '2025-01-30', '2025-02-05', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID897782', 1, 1, 3000000, 3100000, '2025-01-20 04:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-20 05:00:00', @cust8, @room3);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_86, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-20 04:00:00', @bk_86),
(UUID(), 'CONFIRMED', NULL, '2025-01-20 09:00:00', @bk_86),
(UUID(), 'CHECKED_IN', @recep9, '2025-01-30 13:00:00', @bk_86),
(UUID(), 'CHECKED_OUT', @recep9, '2025-02-05 12:00:00', @bk_86);

SET @bk_87 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_87, 'BK2502096541', '2025-02-09', '2025-02-15', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID485233', 1, 1, 3000000, 4450000.0, '2025-02-01 15:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-01 16:00:00', @cust7, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_87, @ser_breakfast, 1, 150000.0, 150000.0, '2025-02-01 15:00:00'),
(UUID(), @bk_87, @ser_spa, 2, 500000.0, 1000000.0, '2025-02-01 15:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_87, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-01 15:00:00', @bk_87),
(UUID(), 'CONFIRMED', NULL, '2025-02-02 07:00:00', @bk_87),
(UUID(), 'CHECKED_IN', @recep10, '2025-02-09 15:00:00', @bk_87),
(UUID(), 'CHECKED_OUT', @recep10, '2025-02-15 10:00:00', @bk_87);

SET @bk_88 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_88, 'BK2502286880', '2025-02-28', '2025-03-06', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID246533', 2, 0, 3000000, 4000000.0, '2025-02-21 03:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-02-21 04:00:00', @cust10, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_88, @ser_spa, 1, 500000.0, 500000.0, '2025-02-21 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_88, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-21 03:00:00', @bk_88),
(UUID(), 'CONFIRMED', NULL, '2025-02-21 16:00:00', @bk_88),
(UUID(), 'CHECKED_IN', @recep1, '2025-02-28 12:00:00', @bk_88),
(UUID(), 'CHECKED_OUT', @recep1, '2025-03-06 09:00:00', @bk_88);

SET @bk_89 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_89, 'BK2503159487', '2025-03-15', '2025-03-17', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID987707', 1, 0, 1000000, 1750000.0, '2025-03-08 03:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-08 04:00:00', @cust2, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_89, @ser_airport, 3, 200000.0, 600000.0, '2025-03-08 03:00:00'),
(UUID(), @bk_89, @ser_breakfast, 1, 150000.0, 150000.0, '2025-03-08 03:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-08 03:00:00', @bk_89),
(UUID(), 'CONFIRMED', NULL, '2025-03-08 10:00:00', @bk_89),
(UUID(), 'CHECKED_IN', @recep5, '2025-03-15 15:00:00', @bk_89),
(UUID(), 'CHECKED_OUT', @recep5, '2025-03-17 09:00:00', @bk_89);

SET @bk_90 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_90, 'BK2503208930', '2025-03-20', '2025-03-24', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID204062', 1, 1, 2000000, 2400000.0, '2025-03-18 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-18 01:00:00', @cust2, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_90, @ser_airport, 2, 200000.0, 400000.0, '2025-03-18 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-18 00:00:00', @bk_90),
(UUID(), 'CONFIRMED', NULL, '2025-03-18 23:00:00', @bk_90),
(UUID(), 'CHECKED_IN', @recep3, '2025-03-20 15:00:00', @bk_90),
(UUID(), 'CHECKED_OUT', @recep3, '2025-03-24 12:00:00', @bk_90);

SET @bk_91 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_91, 'BK2503316574', '2025-03-31', '2025-04-06', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID170875', 1, 0, 3000000, 4750000.0, '2025-03-17 06:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-17 07:00:00', @cust2, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_91, @ser_breakfast, 1, 150000.0, 150000.0, '2025-03-17 06:00:00'),
(UUID(), @bk_91, @ser_spa, 3, 500000.0, 1500000.0, '2025-03-17 06:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_91, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-17 06:00:00', @bk_91),
(UUID(), 'CONFIRMED', NULL, '2025-03-17 09:00:00', @bk_91),
(UUID(), 'CHECKED_IN', @recep3, '2025-03-31 16:00:00', @bk_91),
(UUID(), 'CHECKED_OUT', @recep3, '2025-04-06 09:00:00', @bk_91);

SET @bk_92 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_92, 'BK2504173420', '2025-04-17', '2025-04-20', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID616519', 1, 1, 1500000, 1800000.0, '2025-04-13 16:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-13 17:00:00', @cust7, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_92, @ser_breakfast, 2, 150000.0, 300000.0, '2025-04-13 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-13 16:00:00', @bk_92),
(UUID(), 'CONFIRMED', NULL, '2025-04-13 21:00:00', @bk_92),
(UUID(), 'CHECKED_IN', @recep4, '2025-04-17 16:00:00', @bk_92),
(UUID(), 'CHECKED_OUT', @recep4, '2025-04-20 08:00:00', @bk_92);

SET @bk_93 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_93, 'BK2504214357', '2025-04-21', '2025-04-27', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID383626', 1, 1, 3000000, 3000000, '2025-04-16 16:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-16 17:00:00', @cust10, @room3);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-16 16:00:00', @bk_93),
(UUID(), 'CONFIRMED', NULL, '2025-04-17 06:00:00', @bk_93),
(UUID(), 'CHECKED_IN', @recep3, '2025-04-21 15:00:00', @bk_93),
(UUID(), 'CHECKED_OUT', @recep3, '2025-04-27 08:00:00', @bk_93);

SET @bk_94 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_94, 'BK2505119551', '2025-05-11', '2025-05-14', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID495363', 2, 1, 1500000, 1800000, '2025-04-28 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-28 23:00:00', @cust8, @room3);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_94, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-28 22:00:00', @bk_94),
(UUID(), 'CONFIRMED', NULL, '2025-04-29 21:00:00', @bk_94),
(UUID(), 'CHECKED_IN', @recep1, '2025-05-11 13:00:00', @bk_94),
(UUID(), 'CHECKED_OUT', @recep1, '2025-05-14 08:00:00', @bk_94);

SET @bk_95 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_95, 'BK2505288028', '2025-05-28', '2025-06-03', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID909290', 1, 0, 3000000, 3550000.0, '2025-05-23 16:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-23 17:00:00', @cust2, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_95, @ser_airport, 1, 200000.0, 200000.0, '2025-05-23 16:00:00'),
(UUID(), @bk_95, @ser_breakfast, 1, 150000.0, 150000.0, '2025-05-23 16:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_95, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-23 16:00:00', @bk_95),
(UUID(), 'CONFIRMED', NULL, '2025-05-24 10:00:00', @bk_95),
(UUID(), 'CHECKED_IN', @recep7, '2025-05-28 16:00:00', @bk_95),
(UUID(), 'CHECKED_OUT', @recep7, '2025-06-03 11:00:00', @bk_95);

SET @bk_96 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_96, 'BK2506049428', '2025-06-04', '2025-06-08', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID101087', 1, 0, 2000000, 2150000.0, '2025-05-28 00:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-05-28 01:00:00', @cust7, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_96, @ser_breakfast, 1, 150000.0, 150000.0, '2025-05-28 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-28 00:00:00', @bk_96),
(UUID(), 'CONFIRMED', NULL, '2025-05-28 14:00:00', @bk_96),
(UUID(), 'CHECKED_IN', @recep10, '2025-06-04 13:00:00', @bk_96),
(UUID(), 'CHECKED_OUT', @recep10, '2025-06-08 11:00:00', @bk_96);

SET @bk_97 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_97, 'BK2506165237', '2025-06-16', '2025-06-22', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID547265', 2, 1, 3000000, 3950000.0, '2025-06-13 19:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-06-13 20:00:00', @cust1, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_97, @ser_breakfast, 3, 150000.0, 450000.0, '2025-06-13 19:00:00'),
(UUID(), @bk_97, @ser_spa, 1, 500000.0, 500000.0, '2025-06-13 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-13 19:00:00', @bk_97),
(UUID(), 'CONFIRMED', NULL, '2025-06-14 13:00:00', @bk_97),
(UUID(), 'CHECKED_IN', @recep2, '2025-06-16 15:00:00', @bk_97),
(UUID(), 'CHECKED_OUT', @recep2, '2025-06-22 08:00:00', @bk_97);

SET @bk_98 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_98, 'BK2507044912', '2025-07-04', '2025-07-10', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID910641', 2, 1, 3000000, 3600000.0, '2025-07-01 06:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-07-01 07:00:00', @cust4, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_98, @ser_airport, 3, 200000.0, 600000.0, '2025-07-01 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-01 06:00:00', @bk_98),
(UUID(), 'CONFIRMED', NULL, '2025-07-01 14:00:00', @bk_98),
(UUID(), 'CHECKED_IN', @recep6, '2025-07-04 13:00:00', @bk_98),
(UUID(), 'CHECKED_OUT', @recep6, '2025-07-10 09:00:00', @bk_98);

SET @bk_99 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_99, 'BK2507214510', '2025-07-21', '2025-07-27', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID463333', 1, 0, 3000000, 4350000.0, '2025-07-06 07:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-07-06 08:00:00', @cust8, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_99, @ser_breakfast, 3, 150000.0, 450000.0, '2025-07-06 07:00:00'),
(UUID(), @bk_99, @ser_airport, 2, 200000.0, 400000.0, '2025-07-06 07:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_99, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-06 07:00:00', @bk_99),
(UUID(), 'CONFIRMED', NULL, '2025-07-06 18:00:00', @bk_99),
(UUID(), 'CHECKED_IN', @recep7, '2025-07-21 14:00:00', @bk_99),
(UUID(), 'CHECKED_OUT', @recep7, '2025-07-27 12:00:00', @bk_99);

SET @bk_100 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_100, 'BK2508113482', '2025-08-11', '2025-08-13', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID430660', 1, 1, 1000000, 1800000.0, '2025-08-05 14:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-05 15:00:00', @cust10, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_100, @ser_breakfast, 2, 150000.0, 300000.0, '2025-08-05 14:00:00'),
(UUID(), @bk_100, @ser_spa, 1, 500000.0, 500000.0, '2025-08-05 14:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-05 14:00:00', @bk_100),
(UUID(), 'CONFIRMED', NULL, '2025-08-05 23:00:00', @bk_100),
(UUID(), 'CHECKED_IN', @recep8, '2025-08-11 15:00:00', @bk_100),
(UUID(), 'CHECKED_OUT', @recep8, '2025-08-13 09:00:00', @bk_100);

SET @bk_101 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_101, 'BK2508213459', '2025-08-21', '2025-08-26', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID159118', 2, 0, 2500000, 3850000.0, '2025-08-07 07:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-08-07 08:00:00', @cust9, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_101, @ser_spa, 2, 500000.0, 1000000.0, '2025-08-07 07:00:00'),
(UUID(), @bk_101, @ser_breakfast, 1, 150000.0, 150000.0, '2025-08-07 07:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_101, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-07 07:00:00', @bk_101),
(UUID(), 'CONFIRMED', NULL, '2025-08-08 06:00:00', @bk_101),
(UUID(), 'CHECKED_IN', @recep5, '2025-08-21 16:00:00', @bk_101),
(UUID(), 'CHECKED_OUT', @recep5, '2025-08-26 08:00:00', @bk_101);

SET @bk_102 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_102, 'BK2509105914', '2025-09-10', '2025-09-13', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID608999', 2, 0, 1500000, 1500000, '2025-09-03 15:00:00', 'CANCELLED', 'CASH', 'UNPAID', NULL, @cust2, @room3);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-03 15:00:00', @bk_102),
(UUID(), 'CANCELLED', @recep10, '2025-09-04 08:00:00', @bk_102);

SET @bk_103 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_103, 'BK2509226542', '2025-09-22', '2025-09-23', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID811894', 1, 1, 500000, 800000, '2025-09-19 06:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-09-19 07:00:00', @cust7, @room3);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_103, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-19 06:00:00', @bk_103),
(UUID(), 'CONFIRMED', NULL, '2025-09-19 18:00:00', @bk_103),
(UUID(), 'CHECKED_IN', @recep6, '2025-09-22 16:00:00', @bk_103),
(UUID(), 'CHECKED_OUT', @recep6, '2025-09-23 08:00:00', @bk_103);

SET @bk_104 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_104, 'BK2509263388', '2025-09-26', '2025-10-02', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID120837', 1, 0, 3000000, 3600000.0, '2025-09-17 07:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-17 08:00:00', @cust7, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_104, @ser_airport, 3, 200000.0, 600000.0, '2025-09-17 07:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-17 07:00:00', @bk_104),
(UUID(), 'CONFIRMED', NULL, '2025-09-17 21:00:00', @bk_104),
(UUID(), 'CHECKED_IN', @recep6, '2025-09-26 13:00:00', @bk_104),
(UUID(), 'CHECKED_OUT', @recep6, '2025-10-02 08:00:00', @bk_104);

SET @bk_105 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_105, 'BK2510062308', '2025-10-06', '2025-10-10', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID807912', 2, 1, 2000000, 3950000.0, '2025-09-27 09:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-27 10:00:00', @cust8, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_105, @ser_spa, 2, 500000.0, 1000000.0, '2025-09-27 09:00:00'),
(UUID(), @bk_105, @ser_breakfast, 3, 150000.0, 450000.0, '2025-09-27 09:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_105, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-27 09:00:00', @bk_105),
(UUID(), 'CONFIRMED', NULL, '2025-09-27 12:00:00', @bk_105),
(UUID(), 'CHECKED_IN', @recep8, '2025-10-06 12:00:00', @bk_105),
(UUID(), 'CHECKED_OUT', @recep8, '2025-10-10 10:00:00', @bk_105);

SET @bk_106 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_106, 'BK2510248369', '2025-10-24', '2025-10-27', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID910613', 1, 1, 1500000, 2400000.0, '2025-10-20 14:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-10-20 15:00:00', @cust3, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_106, @ser_spa, 1, 500000.0, 500000.0, '2025-10-20 14:00:00'),
(UUID(), @bk_106, @ser_airport, 2, 200000.0, 400000.0, '2025-10-20 14:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-20 14:00:00', @bk_106),
(UUID(), 'CONFIRMED', NULL, '2025-10-21 14:00:00', @bk_106),
(UUID(), 'CHECKED_IN', @recep2, '2025-10-24 15:00:00', @bk_106),
(UUID(), 'CHECKED_OUT', @recep2, '2025-10-27 10:00:00', @bk_106);

SET @bk_107 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_107, 'BK2511087031', '2025-11-08', '2025-11-12', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID249317', 2, 0, 2000000, 3300000.0, '2025-10-30 23:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-10-31 00:00:00', @cust5, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_107, @ser_spa, 2, 500000.0, 1000000.0, '2025-10-30 23:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_107, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-30 23:00:00', @bk_107),
(UUID(), 'CONFIRMED', NULL, '2025-10-31 13:00:00', @bk_107),
(UUID(), 'CHECKED_IN', @recep8, '2025-11-08 14:00:00', @bk_107),
(UUID(), 'CHECKED_OUT', @recep8, '2025-11-12 09:00:00', @bk_107);

SET @bk_108 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_108, 'BK2511149542', '2025-11-14', '2025-11-19', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID353791', 1, 1, 2500000, 4100000.0, '2025-11-09 23:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-11-10 00:00:00', @cust4, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_108, @ser_spa, 2, 500000.0, 1000000.0, '2025-11-09 23:00:00'),
(UUID(), @bk_108, @ser_airport, 3, 200000.0, 600000.0, '2025-11-09 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-09 23:00:00', @bk_108),
(UUID(), 'CONFIRMED', NULL, '2025-11-10 01:00:00', @bk_108),
(UUID(), 'CHECKED_IN', @recep5, '2025-11-14 15:00:00', @bk_108),
(UUID(), 'CHECKED_OUT', @recep5, '2025-11-19 12:00:00', @bk_108);

SET @bk_109 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_109, 'BK2511285755', '2025-11-28', '2025-12-01', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID316269', 1, 1, 1500000, 2200000.0, '2025-11-18 09:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-11-18 10:00:00', @cust5, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_109, @ser_spa, 1, 500000.0, 500000.0, '2025-11-18 09:00:00'),
(UUID(), @bk_109, @ser_airport, 1, 200000.0, 200000.0, '2025-11-18 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-18 09:00:00', @bk_109),
(UUID(), 'CONFIRMED', NULL, '2025-11-18 23:00:00', @bk_109),
(UUID(), 'CHECKED_IN', @recep4, '2025-11-28 12:00:00', @bk_109),
(UUID(), 'CHECKED_OUT', @recep4, '2025-12-01 12:00:00', @bk_109);

SET @bk_110 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_110, 'BK2512093137', '2025-12-09', '2025-12-14', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID120602', 2, 0, 2500000, 2500000, '2025-12-06 08:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-06 09:00:00', @cust6, @room3);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-06 08:00:00', @bk_110),
(UUID(), 'CONFIRMED', NULL, '2025-12-06 18:00:00', @bk_110),
(UUID(), 'CHECKED_IN', @recep5, '2025-12-09 16:00:00', @bk_110),
(UUID(), 'CHECKED_OUT', @recep5, '2025-12-14 08:00:00', @bk_110);

SET @bk_111 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_111, 'BK2512161804', '2025-12-16', '2025-12-19', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID881074', 1, 1, 1500000, 3450000.0, '2025-12-11 11:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-11 12:00:00', @cust8, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_111, @ser_spa, 3, 500000.0, 1500000.0, '2025-12-11 11:00:00'),
(UUID(), @bk_111, @ser_breakfast, 3, 150000.0, 450000.0, '2025-12-11 11:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-11 11:00:00', @bk_111),
(UUID(), 'CONFIRMED', NULL, '2025-12-12 11:00:00', @bk_111),
(UUID(), 'CHECKED_IN', @recep3, '2025-12-16 16:00:00', @bk_111),
(UUID(), 'CHECKED_OUT', @recep3, '2025-12-19 12:00:00', @bk_111);

SET @bk_112 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_112, 'BK2601013450', '2026-01-01', '2026-01-03', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID761223', 1, 1, 1000000, 1000000, '2025-12-25 22:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-25 23:00:00', @cust6, @room3);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-25 22:00:00', @bk_112),
(UUID(), 'CONFIRMED', NULL, '2025-12-26 10:00:00', @bk_112),
(UUID(), 'CHECKED_IN', @recep9, '2026-01-01 13:00:00', @bk_112),
(UUID(), 'CHECKED_OUT', @recep9, '2026-01-03 09:00:00', @bk_112);

SET @bk_113 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_113, 'BK2601168489', '2026-01-16', '2026-01-20', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID112564', 1, 1, 2000000, 2700000.0, '2026-01-01 10:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-01 11:00:00', @cust8, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_113, @ser_spa, 1, 500000.0, 500000.0, '2026-01-01 10:00:00'),
(UUID(), @bk_113, @ser_airport, 1, 200000.0, 200000.0, '2026-01-01 10:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-01 10:00:00', @bk_113),
(UUID(), 'CONFIRMED', NULL, '2026-01-01 18:00:00', @bk_113),
(UUID(), 'CHECKED_IN', @recep2, '2026-01-16 12:00:00', @bk_113),
(UUID(), 'CHECKED_OUT', @recep2, '2026-01-20 10:00:00', @bk_113);

SET @bk_114 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_114, 'BK2601303274', '2026-01-30', '2026-02-04', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID502912', 2, 0, 2500000, 3300000.0, '2026-01-17 12:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-01-17 13:00:00', @cust2, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_114, @ser_spa, 1, 500000.0, 500000.0, '2026-01-17 12:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_114, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-17 12:00:00', @bk_114),
(UUID(), 'CONFIRMED', NULL, '2026-01-18 01:00:00', @bk_114),
(UUID(), 'CHECKED_IN', @recep6, '2026-01-30 15:00:00', @bk_114),
(UUID(), 'CHECKED_OUT', @recep6, '2026-02-04 10:00:00', @bk_114);

SET @bk_115 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_115, 'BK2602162935', '2026-02-16', '2026-02-19', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID133252', 2, 0, 1500000, 1800000.0, '2026-02-08 14:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-02-08 15:00:00', @cust4, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_115, @ser_breakfast, 2, 150000.0, 300000.0, '2026-02-08 14:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-08 14:00:00', @bk_115),
(UUID(), 'CONFIRMED', NULL, '2026-02-09 09:00:00', @bk_115),
(UUID(), 'CHECKED_IN', @recep3, '2026-02-16 15:00:00', @bk_115),
(UUID(), 'CHECKED_OUT', @recep3, '2026-02-19 10:00:00', @bk_115);

SET @bk_116 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_116, 'BK2603067665', '2026-03-06', '2026-03-11', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID561208', 1, 1, 2500000, 2800000, '2026-03-02 20:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-03-02 21:00:00', @cust7, @room3);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_116, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-02 20:00:00', @bk_116),
(UUID(), 'CONFIRMED', NULL, '2026-03-03 14:00:00', @bk_116),
(UUID(), 'CHECKED_IN', @recep9, '2026-03-06 13:00:00', @bk_116),
(UUID(), 'CHECKED_OUT', @recep9, '2026-03-11 08:00:00', @bk_116);

SET @bk_117 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_117, 'BK2603241275', '2026-03-24', '2026-03-29', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID887998', 1, 0, 2500000, 3900000.0, '2026-03-10 09:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-10 10:00:00', @cust4, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_117, @ser_spa, 2, 500000.0, 1000000.0, '2026-03-10 09:00:00'),
(UUID(), @bk_117, @ser_airport, 2, 200000.0, 400000.0, '2026-03-10 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-10 09:00:00', @bk_117),
(UUID(), 'CONFIRMED', NULL, '2026-03-11 06:00:00', @bk_117),
(UUID(), 'CHECKED_IN', @recep2, '2026-03-24 13:00:00', @bk_117),
(UUID(), 'CHECKED_OUT', @recep2, '2026-03-29 12:00:00', @bk_117);

SET @bk_118 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_118, 'BK2604057480', '2026-04-05', '2026-04-10', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID570172', 2, 1, 2500000, 2700000, '2026-04-01 20:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-04-01 21:00:00', @cust7, @room3);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_118, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-01 20:00:00', @bk_118),
(UUID(), 'CONFIRMED', NULL, '2026-04-02 16:00:00', @bk_118),
(UUID(), 'CHECKED_IN', @recep2, '2026-04-05 16:00:00', @bk_118),
(UUID(), 'CHECKED_OUT', @recep2, '2026-04-10 09:00:00', @bk_118);

SET @bk_119 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_119, 'BK2604208949', '2026-04-20', '2026-04-26', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID623838', 2, 0, 3000000, 3000000, '2026-04-05 18:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-05 19:00:00', @cust3, @room3);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-05 18:00:00', @bk_119),
(UUID(), 'CONFIRMED', NULL, '2026-04-06 08:00:00', @bk_119);

SET @bk_120 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_120, 'BK2605087902', '2026-05-08', '2026-05-12', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID424050', 2, 1, 2000000, 3500000.0, '2026-04-26 03:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-26 04:00:00', @cust5, @room3);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_120, @ser_spa, 3, 500000.0, 1500000.0, '2026-04-26 03:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-26 03:00:00', @bk_120),
(UUID(), 'CONFIRMED', NULL, '2026-04-27 00:00:00', @bk_120);

SET @bk_121 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_121, 'BK2605204790', '2026-05-20', '2026-05-23', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID744999', 1, 0, 1500000, 1500000, '2026-05-12 14:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-05-12 15:00:00', @cust3, @room3);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-12 14:00:00', @bk_121),
(UUID(), 'CONFIRMED', NULL, '2026-05-13 09:00:00', @bk_121);

SET @bk_122 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_122, 'BK2605292838', '2026-05-29', '2026-06-04', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID471033', 1, 0, 3000000, 3200000, '2026-05-26 17:00:00', 'PENDING', 'BANK_TRANSFER', 'UNPAID', NULL, @cust2, @room3);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_122, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-26 17:00:00', @bk_122);

SET @bk_123 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_123, 'BK2501158180', '2025-01-15', '2025-01-18', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID213068', 3, 1, 2400000, 3500000.0, '2025-01-08 16:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-08 17:00:00', @cust3, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_123, @ser_airport, 3, 200000.0, 600000.0, '2025-01-08 16:00:00'),
(UUID(), @bk_123, @ser_spa, 1, 500000.0, 500000.0, '2025-01-08 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-08 16:00:00', @bk_123),
(UUID(), 'CONFIRMED', NULL, '2025-01-09 04:00:00', @bk_123),
(UUID(), 'CHECKED_IN', @recep3, '2025-01-15 15:00:00', @bk_123),
(UUID(), 'CHECKED_OUT', @recep3, '2025-01-18 10:00:00', @bk_123);

SET @bk_124 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_124, 'BK2501228820', '2025-01-22', '2025-01-28', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID607824', 1, 1, 4800000, 4800000, '2025-01-20 10:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-20 11:00:00', @cust9, @room4);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-20 10:00:00', @bk_124),
(UUID(), 'CONFIRMED', NULL, '2025-01-21 10:00:00', @bk_124),
(UUID(), 'CHECKED_IN', @recep8, '2025-01-22 12:00:00', @bk_124),
(UUID(), 'CHECKED_OUT', @recep8, '2025-01-28 08:00:00', @bk_124);

SET @bk_125 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_125, 'BK2502126094', '2025-02-12', '2025-02-17', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID495915', 3, 0, 4000000, 4000000, '2025-01-30 14:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-30 15:00:00', @cust10, @room4);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-30 14:00:00', @bk_125),
(UUID(), 'CONFIRMED', NULL, '2025-01-31 06:00:00', @bk_125),
(UUID(), 'CHECKED_IN', @recep1, '2025-02-12 13:00:00', @bk_125),
(UUID(), 'CHECKED_OUT', @recep1, '2025-02-17 09:00:00', @bk_125);

SET @bk_126 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_126, 'BK2502194639', '2025-02-19', '2025-02-24', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID957908', 1, 0, 4000000, 4350000.0, '2025-02-04 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-04 02:00:00', @cust2, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_126, @ser_breakfast, 1, 150000.0, 150000.0, '2025-02-04 01:00:00'),
(UUID(), @bk_126, @ser_airport, 1, 200000.0, 200000.0, '2025-02-04 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-04 01:00:00', @bk_126),
(UUID(), 'CONFIRMED', NULL, '2025-02-04 21:00:00', @bk_126),
(UUID(), 'CHECKED_IN', @recep6, '2025-02-19 15:00:00', @bk_126),
(UUID(), 'CHECKED_OUT', @recep6, '2025-02-24 11:00:00', @bk_126);

SET @bk_127 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_127, 'BK2502282194', '2025-02-28', '2025-03-06', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID934577', 1, 0, 4800000, 5800000.0, '2025-02-13 20:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-13 21:00:00', @cust6, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_127, @ser_spa, 1, 500000.0, 500000.0, '2025-02-13 20:00:00'),
(UUID(), @bk_127, @ser_breakfast, 2, 150000.0, 300000.0, '2025-02-13 20:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_127, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-13 20:00:00', @bk_127),
(UUID(), 'CONFIRMED', NULL, '2025-02-14 00:00:00', @bk_127),
(UUID(), 'CHECKED_IN', @recep8, '2025-02-28 14:00:00', @bk_127),
(UUID(), 'CHECKED_OUT', @recep8, '2025-03-06 11:00:00', @bk_127);

SET @bk_128 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_128, 'BK2503099730', '2025-03-09', '2025-03-14', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID874137', 1, 1, 4000000, 5300000.0, '2025-03-01 23:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-02 00:00:00', @cust5, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_128, @ser_spa, 2, 500000.0, 1000000.0, '2025-03-01 23:00:00'),
(UUID(), @bk_128, @ser_breakfast, 2, 150000.0, 300000.0, '2025-03-01 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-01 23:00:00', @bk_128),
(UUID(), 'CONFIRMED', NULL, '2025-03-02 00:00:00', @bk_128),
(UUID(), 'CHECKED_IN', @recep3, '2025-03-09 12:00:00', @bk_128),
(UUID(), 'CHECKED_OUT', @recep3, '2025-03-14 12:00:00', @bk_128);

SET @bk_129 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_129, 'BK2503156438', '2025-03-15', '2025-03-20', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID911119', 3, 1, 4000000, 4000000, '2025-03-01 08:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-01 09:00:00', @cust2, @room4);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-01 08:00:00', @bk_129),
(UUID(), 'CONFIRMED', NULL, '2025-03-01 16:00:00', @bk_129),
(UUID(), 'CHECKED_IN', @recep4, '2025-03-15 12:00:00', @bk_129),
(UUID(), 'CHECKED_OUT', @recep4, '2025-03-20 09:00:00', @bk_129);

SET @bk_130 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_130, 'BK2503242991', '2025-03-24', '2025-03-26', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID582084', 1, 0, 1600000, 2000000.0, '2025-03-10 06:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-10 07:00:00', @cust1, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_130, @ser_airport, 2, 200000.0, 400000.0, '2025-03-10 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-10 06:00:00', @bk_130),
(UUID(), 'CONFIRMED', NULL, '2025-03-10 19:00:00', @bk_130),
(UUID(), 'CHECKED_IN', @recep7, '2025-03-24 14:00:00', @bk_130),
(UUID(), 'CHECKED_OUT', @recep7, '2025-03-26 08:00:00', @bk_130);

SET @bk_131 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_131, 'BK2503283306', '2025-03-28', '2025-04-02', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID126518', 2, 1, 4000000, 4600000.0, '2025-03-21 03:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-21 04:00:00', @cust3, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_131, @ser_airport, 3, 200000.0, 600000.0, '2025-03-21 03:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-21 03:00:00', @bk_131),
(UUID(), 'CONFIRMED', NULL, '2025-03-21 13:00:00', @bk_131),
(UUID(), 'CHECKED_IN', @recep8, '2025-03-28 16:00:00', @bk_131),
(UUID(), 'CHECKED_OUT', @recep8, '2025-04-02 11:00:00', @bk_131);

SET @bk_132 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_132, 'BK2504054350', '2025-04-05', '2025-04-06', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID550765', 3, 1, 800000, 2300000.0, '2025-03-23 01:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-23 02:00:00', @cust7, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_132, @ser_spa, 2, 500000.0, 1000000.0, '2025-03-23 01:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_132, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-23 01:00:00', @bk_132),
(UUID(), 'CONFIRMED', NULL, '2025-03-23 04:00:00', @bk_132),
(UUID(), 'CHECKED_IN', @recep3, '2025-04-05 16:00:00', @bk_132),
(UUID(), 'CHECKED_OUT', @recep3, '2025-04-06 12:00:00', @bk_132);

SET @bk_133 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_133, 'BK2504083765', '2025-04-08', '2025-04-14', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID926962', 1, 1, 4800000, 6150000.0, '2025-03-24 12:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-24 13:00:00', @cust8, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_133, @ser_airport, 2, 200000.0, 400000.0, '2025-03-24 12:00:00'),
(UUID(), @bk_133, @ser_breakfast, 3, 150000.0, 450000.0, '2025-03-24 12:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_133, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-24 12:00:00', @bk_133),
(UUID(), 'CONFIRMED', NULL, '2025-03-25 00:00:00', @bk_133),
(UUID(), 'CHECKED_IN', @recep9, '2025-04-08 14:00:00', @bk_133),
(UUID(), 'CHECKED_OUT', @recep9, '2025-04-14 09:00:00', @bk_133);

SET @bk_134 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_134, 'BK2504153391', '2025-04-15', '2025-04-18', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID106573', 1, 0, 2400000, 3100000.0, '2025-04-02 03:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-02 04:00:00', @cust1, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_134, @ser_airport, 1, 200000.0, 200000.0, '2025-04-02 03:00:00'),
(UUID(), @bk_134, @ser_spa, 1, 500000.0, 500000.0, '2025-04-02 03:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-02 03:00:00', @bk_134),
(UUID(), 'CONFIRMED', NULL, '2025-04-02 18:00:00', @bk_134),
(UUID(), 'CHECKED_IN', @recep3, '2025-04-15 12:00:00', @bk_134),
(UUID(), 'CHECKED_OUT', @recep3, '2025-04-18 12:00:00', @bk_134);

SET @bk_135 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_135, 'BK2504284410', '2025-04-28', '2025-04-30', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID762958', 1, 1, 1600000, 3250000.0, '2025-04-22 12:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-04-22 13:00:00', @cust3, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_135, @ser_spa, 3, 500000.0, 1500000.0, '2025-04-22 12:00:00'),
(UUID(), @bk_135, @ser_breakfast, 1, 150000.0, 150000.0, '2025-04-22 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-22 12:00:00', @bk_135),
(UUID(), 'CONFIRMED', NULL, '2025-04-22 16:00:00', @bk_135),
(UUID(), 'CHECKED_IN', @recep4, '2025-04-28 13:00:00', @bk_135),
(UUID(), 'CHECKED_OUT', @recep4, '2025-04-30 12:00:00', @bk_135);

SET @bk_136 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_136, 'BK2505115801', '2025-05-11', '2025-05-15', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID198590', 3, 0, 3200000, 4200000.0, '2025-05-08 03:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-05-08 04:00:00', @cust4, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_136, @ser_airport, 2, 200000.0, 400000.0, '2025-05-08 03:00:00'),
(UUID(), @bk_136, @ser_spa, 1, 500000.0, 500000.0, '2025-05-08 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_136, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-08 03:00:00', @bk_136),
(UUID(), 'CONFIRMED', NULL, '2025-05-08 04:00:00', @bk_136),
(UUID(), 'CHECKED_IN', @recep2, '2025-05-11 13:00:00', @bk_136),
(UUID(), 'CHECKED_OUT', @recep2, '2025-05-15 11:00:00', @bk_136);

SET @bk_137 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_137, 'BK2505287632', '2025-05-28', '2025-05-31', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID840491', 1, 0, 2400000, 2950000.0, '2025-05-19 20:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-19 21:00:00', @cust2, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_137, @ser_airport, 2, 200000.0, 400000.0, '2025-05-19 20:00:00'),
(UUID(), @bk_137, @ser_breakfast, 1, 150000.0, 150000.0, '2025-05-19 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-19 20:00:00', @bk_137),
(UUID(), 'CONFIRMED', NULL, '2025-05-20 10:00:00', @bk_137),
(UUID(), 'CHECKED_IN', @recep2, '2025-05-28 13:00:00', @bk_137),
(UUID(), 'CHECKED_OUT', @recep2, '2025-05-31 11:00:00', @bk_137);

SET @bk_138 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_138, 'BK2506017968', '2025-06-01', '2025-06-06', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID550498', 2, 0, 4000000, 4400000.0, '2025-05-18 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-05-18 01:00:00', @cust7, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_138, @ser_airport, 2, 200000.0, 400000.0, '2025-05-18 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-18 00:00:00', @bk_138),
(UUID(), 'CONFIRMED', NULL, '2025-05-18 23:00:00', @bk_138),
(UUID(), 'CHECKED_IN', @recep4, '2025-06-01 15:00:00', @bk_138),
(UUID(), 'CHECKED_OUT', @recep4, '2025-06-06 11:00:00', @bk_138);

SET @bk_139 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_139, 'BK2506126535', '2025-06-12', '2025-06-14', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID397286', 2, 1, 1600000, 1750000.0, '2025-06-04 11:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-06-04 12:00:00', @cust7, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_139, @ser_breakfast, 1, 150000.0, 150000.0, '2025-06-04 11:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-04 11:00:00', @bk_139),
(UUID(), 'CONFIRMED', NULL, '2025-06-05 08:00:00', @bk_139),
(UUID(), 'CHECKED_IN', @recep6, '2025-06-12 12:00:00', @bk_139),
(UUID(), 'CHECKED_OUT', @recep6, '2025-06-14 08:00:00', @bk_139);

SET @bk_140 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_140, 'BK2506218488', '2025-06-21', '2025-06-25', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID272305', 1, 0, 3200000, 3200000, '2025-06-15 11:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-06-15 12:00:00', @cust1, @room4);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-15 11:00:00', @bk_140),
(UUID(), 'CONFIRMED', NULL, '2025-06-16 11:00:00', @bk_140),
(UUID(), 'CHECKED_IN', @recep6, '2025-06-21 14:00:00', @bk_140),
(UUID(), 'CHECKED_OUT', @recep6, '2025-06-25 12:00:00', @bk_140);

SET @bk_141 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_141, 'BK2506307234', '2025-06-30', '2025-07-03', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID428683', 1, 1, 2400000, 2550000.0, '2025-06-19 10:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-19 11:00:00', @cust10, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_141, @ser_breakfast, 1, 150000.0, 150000.0, '2025-06-19 10:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-19 10:00:00', @bk_141),
(UUID(), 'CONFIRMED', NULL, '2025-06-19 19:00:00', @bk_141),
(UUID(), 'CHECKED_IN', @recep7, '2025-06-30 13:00:00', @bk_141),
(UUID(), 'CHECKED_OUT', @recep7, '2025-07-03 09:00:00', @bk_141);

SET @bk_142 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_142, 'BK2507178358', '2025-07-17', '2025-07-19', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID171584', 2, 0, 1600000, 2100000.0, '2025-07-05 04:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-07-05 05:00:00', @cust10, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_142, @ser_spa, 1, 500000.0, 500000.0, '2025-07-05 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-05 04:00:00', @bk_142),
(UUID(), 'CONFIRMED', NULL, '2025-07-05 09:00:00', @bk_142),
(UUID(), 'CHECKED_IN', @recep1, '2025-07-17 16:00:00', @bk_142),
(UUID(), 'CHECKED_OUT', @recep1, '2025-07-19 08:00:00', @bk_142);

SET @bk_143 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_143, 'BK2507258132', '2025-07-25', '2025-07-29', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID958245', 2, 0, 3200000, 4350000.0, '2025-07-21 07:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-07-21 08:00:00', @cust3, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_143, @ser_breakfast, 3, 150000.0, 450000.0, '2025-07-21 07:00:00'),
(UUID(), @bk_143, @ser_airport, 2, 200000.0, 400000.0, '2025-07-21 07:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_143, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-21 07:00:00', @bk_143),
(UUID(), 'CONFIRMED', NULL, '2025-07-21 12:00:00', @bk_143),
(UUID(), 'CHECKED_IN', @recep9, '2025-07-25 16:00:00', @bk_143),
(UUID(), 'CHECKED_OUT', @recep9, '2025-07-29 09:00:00', @bk_143);

SET @bk_144 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_144, 'BK2508071876', '2025-08-07', '2025-08-11', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID576745', 3, 1, 3200000, 3550000.0, '2025-08-04 00:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-04 01:00:00', @cust4, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_144, @ser_breakfast, 1, 150000.0, 150000.0, '2025-08-04 00:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_144, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-04 00:00:00', @bk_144),
(UUID(), 'CONFIRMED', NULL, '2025-08-04 18:00:00', @bk_144),
(UUID(), 'CHECKED_IN', @recep7, '2025-08-07 12:00:00', @bk_144),
(UUID(), 'CHECKED_OUT', @recep7, '2025-08-11 08:00:00', @bk_144);

SET @bk_145 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_145, 'BK2508152082', '2025-08-15', '2025-08-16', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID425446', 2, 1, 800000, 1600000.0, '2025-08-01 12:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-01 13:00:00', @cust7, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_145, @ser_breakfast, 2, 150000.0, 300000.0, '2025-08-01 12:00:00'),
(UUID(), @bk_145, @ser_spa, 1, 500000.0, 500000.0, '2025-08-01 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-01 12:00:00', @bk_145),
(UUID(), 'CONFIRMED', NULL, '2025-08-02 01:00:00', @bk_145),
(UUID(), 'CHECKED_IN', @recep10, '2025-08-15 12:00:00', @bk_145),
(UUID(), 'CHECKED_OUT', @recep10, '2025-08-16 09:00:00', @bk_145);

SET @bk_146 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_146, 'BK2508268077', '2025-08-26', '2025-08-27', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID362910', 2, 1, 800000, 800000, '2025-08-14 02:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-14 03:00:00', @cust9, @room4);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-14 02:00:00', @bk_146),
(UUID(), 'CONFIRMED', NULL, '2025-08-14 07:00:00', @bk_146),
(UUID(), 'CHECKED_IN', @recep7, '2025-08-26 14:00:00', @bk_146),
(UUID(), 'CHECKED_OUT', @recep7, '2025-08-27 11:00:00', @bk_146);

SET @bk_147 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_147, 'BK2509108081', '2025-09-10', '2025-09-16', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID850384', 3, 0, 4800000, 5200000.0, '2025-09-03 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-03 01:00:00', @cust6, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_147, @ser_airport, 2, 200000.0, 400000.0, '2025-09-03 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-03 00:00:00', @bk_147),
(UUID(), 'CONFIRMED', NULL, '2025-09-03 20:00:00', @bk_147),
(UUID(), 'CHECKED_IN', @recep8, '2025-09-10 14:00:00', @bk_147),
(UUID(), 'CHECKED_OUT', @recep8, '2025-09-16 11:00:00', @bk_147);

SET @bk_148 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_148, 'BK2509287088', '2025-09-28', '2025-10-02', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID230732', 1, 1, 3200000, 3600000.0, '2025-09-19 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-19 02:00:00', @cust5, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_148, @ser_airport, 2, 200000.0, 400000.0, '2025-09-19 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-19 01:00:00', @bk_148),
(UUID(), 'CONFIRMED', NULL, '2025-09-19 04:00:00', @bk_148),
(UUID(), 'CHECKED_IN', @recep3, '2025-09-28 14:00:00', @bk_148),
(UUID(), 'CHECKED_OUT', @recep3, '2025-10-02 09:00:00', @bk_148);

SET @bk_149 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_149, 'BK2510088390', '2025-10-08', '2025-10-11', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID763415', 2, 1, 2400000, 4850000.0, '2025-09-30 14:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-30 15:00:00', @cust5, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_149, @ser_breakfast, 3, 150000.0, 450000.0, '2025-09-30 14:00:00'),
(UUID(), @bk_149, @ser_spa, 3, 500000.0, 1500000.0, '2025-09-30 14:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_149, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-30 14:00:00', @bk_149),
(UUID(), 'CONFIRMED', NULL, '2025-10-01 04:00:00', @bk_149),
(UUID(), 'CHECKED_IN', @recep6, '2025-10-08 12:00:00', @bk_149),
(UUID(), 'CHECKED_OUT', @recep6, '2025-10-11 08:00:00', @bk_149);

SET @bk_150 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_150, 'BK2510183695', '2025-10-18', '2025-10-21', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID779286', 3, 0, 2400000, 3300000.0, '2025-10-16 11:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-10-16 12:00:00', @cust6, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_150, @ser_spa, 1, 500000.0, 500000.0, '2025-10-16 11:00:00'),
(UUID(), @bk_150, @ser_airport, 2, 200000.0, 400000.0, '2025-10-16 11:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-16 11:00:00', @bk_150),
(UUID(), 'CONFIRMED', NULL, '2025-10-17 06:00:00', @bk_150),
(UUID(), 'CHECKED_IN', @recep3, '2025-10-18 14:00:00', @bk_150),
(UUID(), 'CHECKED_OUT', @recep3, '2025-10-21 10:00:00', @bk_150);

SET @bk_151 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_151, 'BK2511059400', '2025-11-05', '2025-11-09', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID911991', 1, 0, 3200000, 3850000.0, '2025-10-26 23:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-10-27 00:00:00', @cust8, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_151, @ser_airport, 1, 200000.0, 200000.0, '2025-10-26 23:00:00'),
(UUID(), @bk_151, @ser_breakfast, 3, 150000.0, 450000.0, '2025-10-26 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-26 23:00:00', @bk_151),
(UUID(), 'CONFIRMED', NULL, '2025-10-27 05:00:00', @bk_151),
(UUID(), 'CHECKED_IN', @recep3, '2025-11-05 15:00:00', @bk_151),
(UUID(), 'CHECKED_OUT', @recep3, '2025-11-09 08:00:00', @bk_151);

SET @bk_152 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_152, 'BK2511136349', '2025-11-13', '2025-11-19', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID568899', 3, 0, 4800000, 5200000.0, '2025-11-02 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-11-02 06:00:00', @cust6, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_152, @ser_breakfast, 2, 150000.0, 300000.0, '2025-11-02 05:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_152, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-02 05:00:00', @bk_152),
(UUID(), 'CONFIRMED', NULL, '2025-11-02 20:00:00', @bk_152),
(UUID(), 'CHECKED_IN', @recep1, '2025-11-13 14:00:00', @bk_152),
(UUID(), 'CHECKED_OUT', @recep1, '2025-11-19 09:00:00', @bk_152);

SET @bk_153 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_153, 'BK2511219954', '2025-11-21', '2025-11-23', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID629347', 3, 1, 1600000, 3300000.0, '2025-11-07 18:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-07 19:00:00', @cust3, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_153, @ser_spa, 3, 500000.0, 1500000.0, '2025-11-07 18:00:00'),
(UUID(), @bk_153, @ser_airport, 1, 200000.0, 200000.0, '2025-11-07 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-07 18:00:00', @bk_153),
(UUID(), 'CONFIRMED', NULL, '2025-11-08 17:00:00', @bk_153),
(UUID(), 'CHECKED_IN', @recep6, '2025-11-21 16:00:00', @bk_153),
(UUID(), 'CHECKED_OUT', @recep6, '2025-11-23 09:00:00', @bk_153);

SET @bk_154 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_154, 'BK2511308215', '2025-11-30', '2025-12-02', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID666476', 1, 0, 1600000, 2250000.0, '2025-11-22 05:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-11-22 06:00:00', @cust8, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_154, @ser_airport, 1, 200000.0, 200000.0, '2025-11-22 05:00:00'),
(UUID(), @bk_154, @ser_breakfast, 3, 150000.0, 450000.0, '2025-11-22 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-22 05:00:00', @bk_154),
(UUID(), 'CONFIRMED', NULL, '2025-11-22 12:00:00', @bk_154),
(UUID(), 'CHECKED_IN', @recep4, '2025-11-30 13:00:00', @bk_154),
(UUID(), 'CHECKED_OUT', @recep4, '2025-12-02 11:00:00', @bk_154);

SET @bk_155 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_155, 'BK2512067864', '2025-12-06', '2025-12-07', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID448513', 3, 0, 800000, 1000000, '2025-12-04 09:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-04 10:00:00', @cust2, @room4);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_155, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-04 09:00:00', @bk_155),
(UUID(), 'CONFIRMED', NULL, '2025-12-04 10:00:00', @bk_155),
(UUID(), 'CHECKED_IN', @recep3, '2025-12-06 16:00:00', @bk_155),
(UUID(), 'CHECKED_OUT', @recep3, '2025-12-07 10:00:00', @bk_155);

SET @bk_156 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_156, 'BK2512189538', '2025-12-18', '2025-12-21', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID332207', 1, 1, 2400000, 3200000.0, '2025-12-10 02:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-10 03:00:00', @cust5, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_156, @ser_airport, 2, 200000.0, 400000.0, '2025-12-10 02:00:00'),
(UUID(), @bk_156, @ser_breakfast, 2, 150000.0, 300000.0, '2025-12-10 02:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_156, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-10 02:00:00', @bk_156),
(UUID(), 'CONFIRMED', NULL, '2025-12-10 21:00:00', @bk_156),
(UUID(), 'CHECKED_IN', @recep2, '2025-12-18 15:00:00', @bk_156),
(UUID(), 'CHECKED_OUT', @recep2, '2025-12-21 09:00:00', @bk_156);

SET @bk_157 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_157, 'BK2512275879', '2025-12-27', '2026-01-01', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID820176', 1, 1, 4000000, 4000000, '2025-12-15 14:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-12-15 15:00:00', @cust3, @room4);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-15 14:00:00', @bk_157),
(UUID(), 'CONFIRMED', NULL, '2025-12-16 05:00:00', @bk_157),
(UUID(), 'CHECKED_IN', @recep7, '2025-12-27 15:00:00', @bk_157),
(UUID(), 'CHECKED_OUT', @recep7, '2026-01-01 09:00:00', @bk_157);

SET @bk_158 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_158, 'BK2601126664', '2026-01-12', '2026-01-13', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID937639', 2, 0, 800000, 2200000.0, '2026-01-10 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-01-10 02:00:00', @cust1, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_158, @ser_airport, 2, 200000.0, 400000.0, '2026-01-10 01:00:00'),
(UUID(), @bk_158, @ser_spa, 2, 500000.0, 1000000.0, '2026-01-10 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-10 01:00:00', @bk_158),
(UUID(), 'CONFIRMED', NULL, '2026-01-10 18:00:00', @bk_158),
(UUID(), 'CHECKED_IN', @recep5, '2026-01-12 16:00:00', @bk_158),
(UUID(), 'CHECKED_OUT', @recep5, '2026-01-13 09:00:00', @bk_158);

SET @bk_159 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_159, 'BK2601221669', '2026-01-22', '2026-01-24', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID351472', 2, 1, 1600000, 3200000.0, '2026-01-20 22:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-01-20 23:00:00', @cust7, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_159, @ser_airport, 3, 200000.0, 600000.0, '2026-01-20 22:00:00'),
(UUID(), @bk_159, @ser_spa, 1, 500000.0, 500000.0, '2026-01-20 22:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_159, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-20 22:00:00', @bk_159),
(UUID(), 'CONFIRMED', NULL, '2026-01-21 07:00:00', @bk_159),
(UUID(), 'CHECKED_IN', @recep7, '2026-01-22 14:00:00', @bk_159),
(UUID(), 'CHECKED_OUT', @recep7, '2026-01-24 09:00:00', @bk_159);

SET @bk_160 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_160, 'BK2601304342', '2026-01-30', '2026-02-01', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID477905', 3, 0, 1600000, 2400000.0, '2026-01-21 22:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-01-21 23:00:00', @cust5, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_160, @ser_breakfast, 2, 150000.0, 300000.0, '2026-01-21 22:00:00'),
(UUID(), @bk_160, @ser_spa, 1, 500000.0, 500000.0, '2026-01-21 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-21 22:00:00', @bk_160),
(UUID(), 'CONFIRMED', NULL, '2026-01-22 03:00:00', @bk_160),
(UUID(), 'CHECKED_IN', @recep7, '2026-01-30 12:00:00', @bk_160),
(UUID(), 'CHECKED_OUT', @recep7, '2026-02-01 10:00:00', @bk_160);

SET @bk_161 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_161, 'BK2602115605', '2026-02-11', '2026-02-17', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID915744', 2, 0, 4800000, 6300000.0, '2026-01-27 12:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-01-27 13:00:00', @cust4, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_161, @ser_spa, 2, 500000.0, 1000000.0, '2026-01-27 12:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_161, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-27 12:00:00', @bk_161),
(UUID(), 'CONFIRMED', NULL, '2026-01-28 01:00:00', @bk_161),
(UUID(), 'CHECKED_IN', @recep10, '2026-02-11 14:00:00', @bk_161),
(UUID(), 'CHECKED_OUT', @recep10, '2026-02-17 10:00:00', @bk_161);

SET @bk_162 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_162, 'BK2603037754', '2026-03-03', '2026-03-05', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID756842', 2, 0, 1600000, 2100000.0, '2026-02-16 12:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-02-16 13:00:00', @cust5, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_162, @ser_spa, 1, 500000.0, 500000.0, '2026-02-16 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-16 12:00:00', @bk_162),
(UUID(), 'CONFIRMED', NULL, '2026-02-17 00:00:00', @bk_162),
(UUID(), 'CHECKED_IN', @recep5, '2026-03-03 16:00:00', @bk_162),
(UUID(), 'CHECKED_OUT', @recep5, '2026-03-05 10:00:00', @bk_162);

SET @bk_163 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_163, 'BK2603115592', '2026-03-11', '2026-03-12', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID264176', 1, 1, 800000, 1000000.0, '2026-03-06 16:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-06 17:00:00', @cust7, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_163, @ser_airport, 1, 200000.0, 200000.0, '2026-03-06 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-06 16:00:00', @bk_163),
(UUID(), 'CONFIRMED', NULL, '2026-03-07 05:00:00', @bk_163),
(UUID(), 'CHECKED_IN', @recep2, '2026-03-11 16:00:00', @bk_163),
(UUID(), 'CHECKED_OUT', @recep2, '2026-03-12 09:00:00', @bk_163);

SET @bk_164 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_164, 'BK2603254936', '2026-03-25', '2026-03-29', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID162408', 1, 1, 3200000, 3650000.0, '2026-03-21 15:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-21 16:00:00', @cust6, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_164, @ser_breakfast, 3, 150000.0, 450000.0, '2026-03-21 15:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-21 15:00:00', @bk_164),
(UUID(), 'CONFIRMED', NULL, '2026-03-22 05:00:00', @bk_164),
(UUID(), 'CHECKED_IN', @recep7, '2026-03-25 13:00:00', @bk_164),
(UUID(), 'CHECKED_OUT', @recep7, '2026-03-29 12:00:00', @bk_164);

SET @bk_165 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_165, 'BK2604095250', '2026-04-09', '2026-04-10', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID283036', 1, 1, 800000, 2300000.0, '2026-03-31 02:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-03-31 03:00:00', @cust3, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_165, @ser_spa, 3, 500000.0, 1500000.0, '2026-03-31 02:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-31 02:00:00', @bk_165),
(UUID(), 'CONFIRMED', NULL, '2026-03-31 21:00:00', @bk_165),
(UUID(), 'CHECKED_IN', @recep8, '2026-04-09 13:00:00', @bk_165),
(UUID(), 'CHECKED_OUT', @recep8, '2026-04-10 11:00:00', @bk_165);

SET @bk_166 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_166, 'BK2604253192', '2026-04-25', '2026-04-26', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID479180', 3, 0, 800000, 1250000.0, '2026-04-10 09:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-10 10:00:00', @cust9, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_166, @ser_breakfast, 3, 150000.0, 450000.0, '2026-04-10 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-10 09:00:00', @bk_166),
(UUID(), 'CONFIRMED', NULL, '2026-04-11 00:00:00', @bk_166);

SET @bk_167 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_167, 'BK2605092787', '2026-05-09', '2026-05-10', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID844616', 3, 1, 800000, 1950000.0, '2026-04-30 19:00:00', 'PENDING', 'CASH', 'UNPAID', NULL, @cust1, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_167, @ser_breakfast, 1, 150000.0, 150000.0, '2026-04-30 19:00:00'),
(UUID(), @bk_167, @ser_spa, 2, 500000.0, 1000000.0, '2026-04-30 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-30 19:00:00', @bk_167);

SET @bk_168 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_168, 'BK2605181295', '2026-05-18', '2026-05-24', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID239435', 2, 1, 4800000, 6400000.0, '2026-05-10 09:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-05-10 10:00:00', @cust1, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_168, @ser_spa, 2, 500000.0, 1000000.0, '2026-05-10 09:00:00'),
(UUID(), @bk_168, @ser_airport, 3, 200000.0, 600000.0, '2026-05-10 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-10 09:00:00', @bk_168),
(UUID(), 'CONFIRMED', NULL, '2026-05-11 09:00:00', @bk_168);

SET @bk_169 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_169, 'BK2605307519', '2026-05-30', '2026-06-01', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID135776', 1, 1, 1600000, 3550000.0, '2026-05-16 01:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-05-16 02:00:00', @cust5, @room4);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_169, @ser_spa, 2, 500000.0, 1000000.0, '2026-05-16 01:00:00'),
(UUID(), @bk_169, @ser_breakfast, 3, 150000.0, 450000.0, '2026-05-16 01:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_169, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-16 01:00:00', @bk_169),
(UUID(), 'CONFIRMED', NULL, '2026-05-16 13:00:00', @bk_169);

SET @bk_170 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_170, 'BK2501135762', '2025-01-13', '2025-01-14', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID977221', 2, 0, 800000, 800000, '2025-01-06 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-06 23:00:00', @cust3, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-06 22:00:00', @bk_170),
(UUID(), 'CONFIRMED', NULL, '2025-01-07 19:00:00', @bk_170),
(UUID(), 'CHECKED_IN', @recep2, '2025-01-13 12:00:00', @bk_170),
(UUID(), 'CHECKED_OUT', @recep2, '2025-01-14 12:00:00', @bk_170);

SET @bk_171 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_171, 'BK2501226140', '2025-01-22', '2025-01-24', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID887880', 2, 0, 1600000, 3000000.0, '2025-01-17 09:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-17 10:00:00', @cust4, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_171, @ser_airport, 2, 200000.0, 400000.0, '2025-01-17 09:00:00'),
(UUID(), @bk_171, @ser_spa, 2, 500000.0, 1000000.0, '2025-01-17 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-17 09:00:00', @bk_171),
(UUID(), 'CONFIRMED', NULL, '2025-01-17 16:00:00', @bk_171),
(UUID(), 'CHECKED_IN', @recep10, '2025-01-22 14:00:00', @bk_171),
(UUID(), 'CHECKED_OUT', @recep10, '2025-01-24 12:00:00', @bk_171);

SET @bk_172 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_172, 'BK2501256560', '2025-01-25', '2025-01-28', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID887465', 2, 1, 2400000, 3100000.0, '2025-01-10 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-10 02:00:00', @cust5, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_172, @ser_spa, 1, 500000.0, 500000.0, '2025-01-10 01:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_172, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-10 01:00:00', @bk_172),
(UUID(), 'CONFIRMED', NULL, '2025-01-10 05:00:00', @bk_172),
(UUID(), 'CHECKED_IN', @recep6, '2025-01-25 13:00:00', @bk_172),
(UUID(), 'CHECKED_OUT', @recep6, '2025-01-28 10:00:00', @bk_172);

SET @bk_173 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_173, 'BK2501306607', '2025-01-30', '2025-01-31', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID510739', 2, 1, 800000, 2550000.0, '2025-01-25 15:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-25 16:00:00', @cust3, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_173, @ser_spa, 3, 500000.0, 1500000.0, '2025-01-25 15:00:00'),
(UUID(), @bk_173, @ser_breakfast, 1, 150000.0, 150000.0, '2025-01-25 15:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_173, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-25 15:00:00', @bk_173),
(UUID(), 'CONFIRMED', NULL, '2025-01-26 06:00:00', @bk_173),
(UUID(), 'CHECKED_IN', @recep9, '2025-01-30 13:00:00', @bk_173),
(UUID(), 'CHECKED_OUT', @recep9, '2025-01-31 10:00:00', @bk_173);

SET @bk_174 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_174, 'BK2502115196', '2025-02-11', '2025-02-12', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID711794', 3, 0, 800000, 950000.0, '2025-01-29 13:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-29 14:00:00', @cust9, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_174, @ser_breakfast, 1, 150000.0, 150000.0, '2025-01-29 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-29 13:00:00', @bk_174),
(UUID(), 'CONFIRMED', NULL, '2025-01-29 22:00:00', @bk_174),
(UUID(), 'CHECKED_IN', @recep1, '2025-02-11 12:00:00', @bk_174),
(UUID(), 'CHECKED_OUT', @recep1, '2025-02-12 08:00:00', @bk_174);

SET @bk_175 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_175, 'BK2502172248', '2025-02-17', '2025-02-18', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID495733', 1, 1, 800000, 1450000.0, '2025-02-03 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-02-03 23:00:00', @cust1, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_175, @ser_breakfast, 1, 150000.0, 150000.0, '2025-02-03 22:00:00'),
(UUID(), @bk_175, @ser_spa, 1, 500000.0, 500000.0, '2025-02-03 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-03 22:00:00', @bk_175),
(UUID(), 'CONFIRMED', NULL, '2025-02-04 12:00:00', @bk_175),
(UUID(), 'CHECKED_IN', @recep10, '2025-02-17 16:00:00', @bk_175),
(UUID(), 'CHECKED_OUT', @recep10, '2025-02-18 09:00:00', @bk_175);

SET @bk_176 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_176, 'BK2502242835', '2025-02-24', '2025-03-02', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID795146', 1, 1, 4800000, 5500000.0, '2025-02-15 14:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-02-15 15:00:00', @cust7, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_176, @ser_spa, 1, 500000.0, 500000.0, '2025-02-15 14:00:00'),
(UUID(), @bk_176, @ser_airport, 1, 200000.0, 200000.0, '2025-02-15 14:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-15 14:00:00', @bk_176),
(UUID(), 'CONFIRMED', NULL, '2025-02-16 12:00:00', @bk_176),
(UUID(), 'CHECKED_IN', @recep9, '2025-02-24 12:00:00', @bk_176),
(UUID(), 'CHECKED_OUT', @recep9, '2025-03-02 10:00:00', @bk_176);

SET @bk_177 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_177, 'BK2503127929', '2025-03-12', '2025-03-18', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID902087', 3, 0, 4800000, 4800000, '2025-03-04 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-04 19:00:00', @cust1, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-04 18:00:00', @bk_177),
(UUID(), 'CONFIRMED', NULL, '2025-03-04 21:00:00', @bk_177),
(UUID(), 'CHECKED_IN', @recep2, '2025-03-12 13:00:00', @bk_177),
(UUID(), 'CHECKED_OUT', @recep2, '2025-03-18 11:00:00', @bk_177);

SET @bk_178 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_178, 'BK2503197790', '2025-03-19', '2025-03-24', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID376805', 3, 0, 4000000, 4000000, '2025-03-10 00:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-10 01:00:00', @cust10, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-10 00:00:00', @bk_178),
(UUID(), 'CONFIRMED', NULL, '2025-03-10 06:00:00', @bk_178),
(UUID(), 'CHECKED_IN', @recep3, '2025-03-19 14:00:00', @bk_178),
(UUID(), 'CHECKED_OUT', @recep3, '2025-03-24 12:00:00', @bk_178);

SET @bk_179 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_179, 'BK2503273247', '2025-03-27', '2025-03-31', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID558847', 3, 1, 3200000, 4600000.0, '2025-03-24 23:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-25 00:00:00', @cust5, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_179, @ser_spa, 1, 500000.0, 500000.0, '2025-03-24 23:00:00'),
(UUID(), @bk_179, @ser_airport, 3, 200000.0, 600000.0, '2025-03-24 23:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_179, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-24 23:00:00', @bk_179),
(UUID(), 'CONFIRMED', NULL, '2025-03-25 13:00:00', @bk_179),
(UUID(), 'CHECKED_IN', @recep1, '2025-03-27 13:00:00', @bk_179),
(UUID(), 'CHECKED_OUT', @recep1, '2025-03-31 10:00:00', @bk_179);

SET @bk_180 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_180, 'BK2504051310', '2025-04-05', '2025-04-10', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID588333', 3, 1, 4000000, 5000000.0, '2025-04-02 18:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-04-02 19:00:00', @cust2, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_180, @ser_spa, 2, 500000.0, 1000000.0, '2025-04-02 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-02 18:00:00', @bk_180),
(UUID(), 'CONFIRMED', NULL, '2025-04-03 00:00:00', @bk_180),
(UUID(), 'CHECKED_IN', @recep5, '2025-04-05 13:00:00', @bk_180),
(UUID(), 'CHECKED_OUT', @recep5, '2025-04-10 12:00:00', @bk_180);

SET @bk_181 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_181, 'BK2504241019', '2025-04-24', '2025-04-27', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID934173', 1, 0, 2400000, 3350000.0, '2025-04-14 20:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-14 21:00:00', @cust4, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_181, @ser_breakfast, 3, 150000.0, 450000.0, '2025-04-14 20:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_181, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-14 20:00:00', @bk_181),
(UUID(), 'CONFIRMED', NULL, '2025-04-15 06:00:00', @bk_181),
(UUID(), 'CHECKED_IN', @recep8, '2025-04-24 13:00:00', @bk_181),
(UUID(), 'CHECKED_OUT', @recep8, '2025-04-27 08:00:00', @bk_181);

SET @bk_182 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_182, 'BK2505047345', '2025-05-04', '2025-05-09', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID769497', 1, 0, 4000000, 4200000.0, '2025-04-27 07:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-27 08:00:00', @cust8, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_182, @ser_airport, 1, 200000.0, 200000.0, '2025-04-27 07:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-27 07:00:00', @bk_182),
(UUID(), 'CONFIRMED', NULL, '2025-04-27 08:00:00', @bk_182),
(UUID(), 'CHECKED_IN', @recep9, '2025-05-04 15:00:00', @bk_182),
(UUID(), 'CHECKED_OUT', @recep9, '2025-05-09 10:00:00', @bk_182);

SET @bk_183 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_183, 'BK2505135269', '2025-05-13', '2025-05-19', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID569212', 3, 1, 4800000, 6500000.0, '2025-05-04 15:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-05-04 16:00:00', @cust2, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_183, @ser_spa, 2, 500000.0, 1000000.0, '2025-05-04 15:00:00'),
(UUID(), @bk_183, @ser_airport, 2, 200000.0, 400000.0, '2025-05-04 15:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_183, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-04 15:00:00', @bk_183),
(UUID(), 'CONFIRMED', NULL, '2025-05-05 01:00:00', @bk_183),
(UUID(), 'CHECKED_IN', @recep9, '2025-05-13 12:00:00', @bk_183),
(UUID(), 'CHECKED_OUT', @recep9, '2025-05-19 12:00:00', @bk_183);

SET @bk_184 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_184, 'BK2505249220', '2025-05-24', '2025-05-29', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID848588', 2, 1, 4000000, 4750000.0, '2025-05-12 17:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-12 18:00:00', @cust2, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_184, @ser_airport, 3, 200000.0, 600000.0, '2025-05-12 17:00:00'),
(UUID(), @bk_184, @ser_breakfast, 1, 150000.0, 150000.0, '2025-05-12 17:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-12 17:00:00', @bk_184),
(UUID(), 'CONFIRMED', NULL, '2025-05-13 03:00:00', @bk_184),
(UUID(), 'CHECKED_IN', @recep7, '2025-05-24 14:00:00', @bk_184),
(UUID(), 'CHECKED_OUT', @recep7, '2025-05-29 08:00:00', @bk_184);

SET @bk_185 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_185, 'BK2506016419', '2025-06-01', '2025-06-07', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID698592', 1, 1, 4800000, 4950000.0, '2025-05-23 10:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-05-23 11:00:00', @cust9, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_185, @ser_breakfast, 1, 150000.0, 150000.0, '2025-05-23 10:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-23 10:00:00', @bk_185),
(UUID(), 'CONFIRMED', NULL, '2025-05-24 06:00:00', @bk_185),
(UUID(), 'CHECKED_IN', @recep1, '2025-06-01 13:00:00', @bk_185),
(UUID(), 'CHECKED_OUT', @recep1, '2025-06-07 11:00:00', @bk_185);

SET @bk_186 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_186, 'BK2506152107', '2025-06-15', '2025-06-16', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID583585', 1, 0, 800000, 2000000.0, '2025-06-05 02:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-05 03:00:00', @cust6, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_186, @ser_breakfast, 2, 150000.0, 300000.0, '2025-06-05 02:00:00'),
(UUID(), @bk_186, @ser_airport, 3, 200000.0, 600000.0, '2025-06-05 02:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_186, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-05 02:00:00', @bk_186),
(UUID(), 'CONFIRMED', NULL, '2025-06-05 15:00:00', @bk_186),
(UUID(), 'CHECKED_IN', @recep4, '2025-06-15 12:00:00', @bk_186),
(UUID(), 'CHECKED_OUT', @recep4, '2025-06-16 12:00:00', @bk_186);

SET @bk_187 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_187, 'BK2506278353', '2025-06-27', '2025-07-02', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID609613', 3, 0, 4000000, 4300000.0, '2025-06-14 03:00:00', 'CANCELLED', 'BANK_TRANSFER', 'UNPAID', NULL, @cust9, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_187, @ser_breakfast, 2, 150000.0, 300000.0, '2025-06-14 03:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-14 03:00:00', @bk_187),
(UUID(), 'CANCELLED', @recep7, '2025-06-14 17:00:00', @bk_187);

SET @bk_188 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_188, 'BK2507166942', '2025-07-16', '2025-07-17', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID636821', 3, 0, 800000, 1400000.0, '2025-07-13 01:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-07-13 02:00:00', @cust7, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_188, @ser_airport, 3, 200000.0, 600000.0, '2025-07-13 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-13 01:00:00', @bk_188),
(UUID(), 'CONFIRMED', NULL, '2025-07-13 07:00:00', @bk_188),
(UUID(), 'CHECKED_IN', @recep7, '2025-07-16 14:00:00', @bk_188),
(UUID(), 'CHECKED_OUT', @recep7, '2025-07-17 08:00:00', @bk_188);

SET @bk_189 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_189, 'BK2507226630', '2025-07-22', '2025-07-26', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID722332', 3, 0, 3200000, 3600000.0, '2025-07-07 16:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-07-07 17:00:00', @cust6, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_189, @ser_airport, 2, 200000.0, 400000.0, '2025-07-07 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-07 16:00:00', @bk_189),
(UUID(), 'CONFIRMED', NULL, '2025-07-08 02:00:00', @bk_189),
(UUID(), 'CHECKED_IN', @recep4, '2025-07-22 15:00:00', @bk_189),
(UUID(), 'CHECKED_OUT', @recep4, '2025-07-26 11:00:00', @bk_189);

SET @bk_190 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_190, 'BK2507309156', '2025-07-30', '2025-08-04', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID918656', 2, 0, 4000000, 4450000.0, '2025-07-27 15:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-07-27 16:00:00', @cust1, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_190, @ser_breakfast, 3, 150000.0, 450000.0, '2025-07-27 15:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-27 15:00:00', @bk_190),
(UUID(), 'CONFIRMED', NULL, '2025-07-27 22:00:00', @bk_190),
(UUID(), 'CHECKED_IN', @recep10, '2025-07-30 13:00:00', @bk_190),
(UUID(), 'CHECKED_OUT', @recep10, '2025-08-04 10:00:00', @bk_190);

SET @bk_191 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_191, 'BK2508168134', '2025-08-16', '2025-08-18', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID452885', 3, 1, 1600000, 3100000.0, '2025-08-05 11:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-05 12:00:00', @cust4, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_191, @ser_spa, 3, 500000.0, 1500000.0, '2025-08-05 11:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-05 11:00:00', @bk_191),
(UUID(), 'CONFIRMED', NULL, '2025-08-06 07:00:00', @bk_191),
(UUID(), 'CHECKED_IN', @recep9, '2025-08-16 15:00:00', @bk_191),
(UUID(), 'CHECKED_OUT', @recep9, '2025-08-18 11:00:00', @bk_191);

SET @bk_192 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_192, 'BK2508316997', '2025-08-31', '2025-09-02', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID419278', 2, 0, 1600000, 2400000.0, '2025-08-17 08:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-17 09:00:00', @cust9, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_192, @ser_airport, 3, 200000.0, 600000.0, '2025-08-17 08:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_192, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-17 08:00:00', @bk_192),
(UUID(), 'CONFIRMED', NULL, '2025-08-18 04:00:00', @bk_192),
(UUID(), 'CHECKED_IN', @recep5, '2025-08-31 13:00:00', @bk_192),
(UUID(), 'CHECKED_OUT', @recep5, '2025-09-02 11:00:00', @bk_192);

SET @bk_193 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_193, 'BK2509129571', '2025-09-12', '2025-09-18', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID452748', 1, 0, 4800000, 5400000.0, '2025-09-03 05:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-09-03 06:00:00', @cust6, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_193, @ser_airport, 3, 200000.0, 600000.0, '2025-09-03 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-03 05:00:00', @bk_193),
(UUID(), 'CONFIRMED', NULL, '2025-09-04 01:00:00', @bk_193),
(UUID(), 'CHECKED_IN', @recep7, '2025-09-12 13:00:00', @bk_193),
(UUID(), 'CHECKED_OUT', @recep7, '2025-09-18 11:00:00', @bk_193);

SET @bk_194 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_194, 'BK2509244597', '2025-09-24', '2025-09-27', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID383793', 1, 1, 2400000, 3100000.0, '2025-09-21 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-21 01:00:00', @cust4, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_194, @ser_airport, 2, 200000.0, 400000.0, '2025-09-21 00:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_194, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-21 00:00:00', @bk_194),
(UUID(), 'CONFIRMED', NULL, '2025-09-21 11:00:00', @bk_194),
(UUID(), 'CHECKED_IN', @recep1, '2025-09-24 13:00:00', @bk_194),
(UUID(), 'CHECKED_OUT', @recep1, '2025-09-27 10:00:00', @bk_194);

SET @bk_195 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_195, 'BK2510058317', '2025-10-05', '2025-10-07', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID938879', 2, 1, 1600000, 2050000.0, '2025-09-26 02:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-09-26 03:00:00', @cust10, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_195, @ser_breakfast, 3, 150000.0, 450000.0, '2025-09-26 02:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-26 02:00:00', @bk_195),
(UUID(), 'CONFIRMED', NULL, '2025-09-26 13:00:00', @bk_195),
(UUID(), 'CHECKED_IN', @recep5, '2025-10-05 13:00:00', @bk_195),
(UUID(), 'CHECKED_OUT', @recep5, '2025-10-07 10:00:00', @bk_195);

SET @bk_196 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_196, 'BK2510187801', '2025-10-18', '2025-10-24', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID432484', 2, 1, 4800000, 5500000.0, '2025-10-12 18:00:00', 'CANCELLED', 'BANK_TRANSFER', 'UNPAID', NULL, @cust4, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_196, @ser_airport, 2, 200000.0, 400000.0, '2025-10-12 18:00:00'),
(UUID(), @bk_196, @ser_breakfast, 2, 150000.0, 300000.0, '2025-10-12 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-12 18:00:00', @bk_196),
(UUID(), 'CANCELLED', @recep8, '2025-10-13 09:00:00', @bk_196);

SET @bk_197 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_197, 'BK2511056516', '2025-11-05', '2025-11-06', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID847588', 1, 0, 800000, 800000, '2025-10-24 13:00:00', 'CANCELLED', 'CREDIT_CARD', 'UNPAID', NULL, @cust5, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-24 13:00:00', @bk_197),
(UUID(), 'CANCELLED', @recep10, '2025-10-25 06:00:00', @bk_197);

SET @bk_198 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_198, 'BK2511124757', '2025-11-12', '2025-11-17', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID808490', 3, 0, 4000000, 4300000, '2025-11-07 20:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-07 21:00:00', @cust3, @room5);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_198, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-07 20:00:00', @bk_198),
(UUID(), 'CONFIRMED', NULL, '2025-11-08 18:00:00', @bk_198),
(UUID(), 'CHECKED_IN', @recep1, '2025-11-12 12:00:00', @bk_198),
(UUID(), 'CHECKED_OUT', @recep1, '2025-11-17 08:00:00', @bk_198);

SET @bk_199 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_199, 'BK2511202362', '2025-11-20', '2025-11-21', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID966113', 2, 1, 800000, 1000000, '2025-11-16 03:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-11-16 04:00:00', @cust6, @room5);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_199, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-16 03:00:00', @bk_199),
(UUID(), 'CONFIRMED', NULL, '2025-11-16 05:00:00', @bk_199),
(UUID(), 'CHECKED_IN', @recep10, '2025-11-20 13:00:00', @bk_199),
(UUID(), 'CHECKED_OUT', @recep10, '2025-11-21 10:00:00', @bk_199);

SET @bk_200 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_200, 'BK2511249620', '2025-11-24', '2025-11-26', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID418351', 3, 0, 1600000, 1750000.0, '2025-11-14 08:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-11-14 09:00:00', @cust7, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_200, @ser_breakfast, 1, 150000.0, 150000.0, '2025-11-14 08:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-14 08:00:00', @bk_200),
(UUID(), 'CONFIRMED', NULL, '2025-11-15 07:00:00', @bk_200),
(UUID(), 'CHECKED_IN', @recep2, '2025-11-24 15:00:00', @bk_200),
(UUID(), 'CHECKED_OUT', @recep2, '2025-11-26 09:00:00', @bk_200);

SET @bk_201 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_201, 'BK2512061780', '2025-12-06', '2025-12-10', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID151098', 1, 0, 3200000, 3400000, '2025-12-02 17:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-12-02 18:00:00', @cust3, @room5);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_201, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-02 17:00:00', @bk_201),
(UUID(), 'CONFIRMED', NULL, '2025-12-03 10:00:00', @bk_201),
(UUID(), 'CHECKED_IN', @recep6, '2025-12-06 15:00:00', @bk_201),
(UUID(), 'CHECKED_OUT', @recep6, '2025-12-10 11:00:00', @bk_201);

SET @bk_202 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_202, 'BK2512194447', '2025-12-19', '2025-12-25', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID796336', 1, 1, 4800000, 5200000.0, '2025-12-17 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-17 19:00:00', @cust1, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_202, @ser_airport, 1, 200000.0, 200000.0, '2025-12-17 18:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_202, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-17 18:00:00', @bk_202),
(UUID(), 'CONFIRMED', NULL, '2025-12-18 10:00:00', @bk_202),
(UUID(), 'CHECKED_IN', @recep4, '2025-12-19 15:00:00', @bk_202),
(UUID(), 'CHECKED_OUT', @recep4, '2025-12-25 08:00:00', @bk_202);

SET @bk_203 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_203, 'BK2601011461', '2026-01-01', '2026-01-07', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID382468', 3, 0, 4800000, 5550000.0, '2025-12-26 03:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-26 04:00:00', @cust8, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_203, @ser_airport, 1, 200000.0, 200000.0, '2025-12-26 03:00:00'),
(UUID(), @bk_203, @ser_breakfast, 3, 150000.0, 450000.0, '2025-12-26 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_203, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-26 03:00:00', @bk_203),
(UUID(), 'CONFIRMED', NULL, '2025-12-26 06:00:00', @bk_203),
(UUID(), 'CHECKED_IN', @recep2, '2026-01-01 16:00:00', @bk_203),
(UUID(), 'CHECKED_OUT', @recep2, '2026-01-07 11:00:00', @bk_203);

SET @bk_204 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_204, 'BK2601114247', '2026-01-11', '2026-01-15', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID545560', 1, 1, 3200000, 3200000, '2025-12-31 07:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-31 08:00:00', @cust9, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-31 07:00:00', @bk_204),
(UUID(), 'CONFIRMED', NULL, '2025-12-31 21:00:00', @bk_204),
(UUID(), 'CHECKED_IN', @recep9, '2026-01-11 15:00:00', @bk_204),
(UUID(), 'CHECKED_OUT', @recep9, '2026-01-15 11:00:00', @bk_204);

SET @bk_205 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_205, 'BK2601277576', '2026-01-27', '2026-02-02', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID730599', 2, 0, 4800000, 6450000.0, '2026-01-18 16:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-18 17:00:00', @cust7, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_205, @ser_breakfast, 3, 150000.0, 450000.0, '2026-01-18 16:00:00'),
(UUID(), @bk_205, @ser_spa, 2, 500000.0, 1000000.0, '2026-01-18 16:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_205, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-18 16:00:00', @bk_205),
(UUID(), 'CONFIRMED', NULL, '2026-01-18 17:00:00', @bk_205),
(UUID(), 'CHECKED_IN', @recep7, '2026-01-27 12:00:00', @bk_205),
(UUID(), 'CHECKED_OUT', @recep7, '2026-02-02 08:00:00', @bk_205);

SET @bk_206 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_206, 'BK2602173756', '2026-02-17', '2026-02-18', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID172981', 1, 1, 800000, 1300000.0, '2026-02-02 06:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-02 07:00:00', @cust1, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_206, @ser_spa, 1, 500000.0, 500000.0, '2026-02-02 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-02 06:00:00', @bk_206),
(UUID(), 'CONFIRMED', NULL, '2026-02-02 18:00:00', @bk_206),
(UUID(), 'CHECKED_IN', @recep10, '2026-02-17 14:00:00', @bk_206),
(UUID(), 'CHECKED_OUT', @recep10, '2026-02-18 10:00:00', @bk_206);

SET @bk_207 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_207, 'BK2603055503', '2026-03-05', '2026-03-09', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID202786', 1, 1, 3200000, 3700000.0, '2026-03-02 09:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-03-02 10:00:00', @cust8, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_207, @ser_spa, 1, 500000.0, 500000.0, '2026-03-02 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-02 09:00:00', @bk_207),
(UUID(), 'CONFIRMED', NULL, '2026-03-02 12:00:00', @bk_207),
(UUID(), 'CHECKED_IN', @recep10, '2026-03-05 16:00:00', @bk_207),
(UUID(), 'CHECKED_OUT', @recep10, '2026-03-09 09:00:00', @bk_207);

SET @bk_208 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_208, 'BK2603121061', '2026-03-12', '2026-03-16', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID616351', 3, 1, 3200000, 3200000, '2026-02-26 22:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-02-26 23:00:00', @cust6, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-26 22:00:00', @bk_208),
(UUID(), 'CONFIRMED', NULL, '2026-02-27 17:00:00', @bk_208),
(UUID(), 'CHECKED_IN', @recep2, '2026-03-12 15:00:00', @bk_208),
(UUID(), 'CHECKED_OUT', @recep2, '2026-03-16 12:00:00', @bk_208);

SET @bk_209 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_209, 'BK2603189510', '2026-03-18', '2026-03-20', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID708456', 2, 1, 1600000, 2100000.0, '2026-03-12 23:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-03-13 00:00:00', @cust8, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_209, @ser_breakfast, 2, 150000.0, 300000.0, '2026-03-12 23:00:00'),
(UUID(), @bk_209, @ser_airport, 1, 200000.0, 200000.0, '2026-03-12 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-12 23:00:00', @bk_209),
(UUID(), 'CONFIRMED', NULL, '2026-03-13 05:00:00', @bk_209),
(UUID(), 'CHECKED_IN', @recep7, '2026-03-18 13:00:00', @bk_209),
(UUID(), 'CHECKED_OUT', @recep7, '2026-03-20 08:00:00', @bk_209);

SET @bk_210 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_210, 'BK2604021755', '2026-04-02', '2026-04-05', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID125622', 3, 1, 2400000, 2400000, '2026-03-27 13:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-03-27 14:00:00', @cust7, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-27 13:00:00', @bk_210),
(UUID(), 'CONFIRMED', NULL, '2026-03-28 11:00:00', @bk_210),
(UUID(), 'CHECKED_IN', @recep5, '2026-04-02 14:00:00', @bk_210),
(UUID(), 'CHECKED_OUT', @recep5, '2026-04-05 12:00:00', @bk_210);

SET @bk_211 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_211, 'BK2604161600', '2026-04-16', '2026-04-21', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID778171', 3, 1, 4000000, 4000000, '2026-04-09 16:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-04-09 17:00:00', @cust5, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-09 16:00:00', @bk_211),
(UUID(), 'CONFIRMED', NULL, '2026-04-10 09:00:00', @bk_211);

SET @bk_212 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_212, 'BK2604252924', '2026-04-25', '2026-04-30', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID676576', 3, 1, 4000000, 5050000.0, '2026-04-12 18:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-12 19:00:00', @cust2, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_212, @ser_breakfast, 3, 150000.0, 450000.0, '2026-04-12 18:00:00'),
(UUID(), @bk_212, @ser_airport, 3, 200000.0, 600000.0, '2026-04-12 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-12 18:00:00', @bk_212),
(UUID(), 'CONFIRMED', NULL, '2026-04-13 06:00:00', @bk_212);

SET @bk_213 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_213, 'BK2605073269', '2026-05-07', '2026-05-09', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID179691', 2, 0, 1600000, 2700000.0, '2026-04-25 01:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-25 02:00:00', @cust8, @room5);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_213, @ser_airport, 2, 200000.0, 400000.0, '2026-04-25 01:00:00'),
(UUID(), @bk_213, @ser_spa, 1, 500000.0, 500000.0, '2026-04-25 01:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_213, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-25 01:00:00', @bk_213),
(UUID(), 'CONFIRMED', NULL, '2026-04-26 00:00:00', @bk_213);

SET @bk_214 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_214, 'BK2605211439', '2026-05-21', '2026-05-25', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID307287', 1, 0, 3200000, 3200000, '2026-05-08 13:00:00', 'PENDING', 'CREDIT_CARD', 'UNPAID', NULL, @cust9, @room5);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-08 13:00:00', @bk_214);

SET @bk_215 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_215, 'BK2501166302', '2025-01-16', '2025-01-20', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID421466', 3, 1, 3200000, 5300000.0, '2025-01-11 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-11 02:00:00', @cust6, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_215, @ser_airport, 3, 200000.0, 600000.0, '2025-01-11 01:00:00'),
(UUID(), @bk_215, @ser_spa, 3, 500000.0, 1500000.0, '2025-01-11 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-11 01:00:00', @bk_215),
(UUID(), 'CONFIRMED', NULL, '2025-01-11 08:00:00', @bk_215),
(UUID(), 'CHECKED_IN', @recep8, '2025-01-16 14:00:00', @bk_215),
(UUID(), 'CHECKED_OUT', @recep8, '2025-01-20 10:00:00', @bk_215);

SET @bk_216 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_216, 'BK2502042895', '2025-02-04', '2025-02-05', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID749075', 2, 0, 800000, 800000, '2025-01-20 17:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-20 18:00:00', @cust6, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-20 17:00:00', @bk_216),
(UUID(), 'CONFIRMED', NULL, '2025-01-21 12:00:00', @bk_216),
(UUID(), 'CHECKED_IN', @recep10, '2025-02-04 12:00:00', @bk_216),
(UUID(), 'CHECKED_OUT', @recep10, '2025-02-05 08:00:00', @bk_216);

SET @bk_217 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_217, 'BK2502079407', '2025-02-07', '2025-02-10', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID526362', 3, 1, 2400000, 3300000.0, '2025-02-04 15:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-02-04 16:00:00', @cust8, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_217, @ser_airport, 2, 200000.0, 400000.0, '2025-02-04 15:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_217, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-04 15:00:00', @bk_217),
(UUID(), 'CONFIRMED', NULL, '2025-02-05 13:00:00', @bk_217),
(UUID(), 'CHECKED_IN', @recep7, '2025-02-07 13:00:00', @bk_217),
(UUID(), 'CHECKED_OUT', @recep7, '2025-02-10 08:00:00', @bk_217);

SET @bk_218 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_218, 'BK2502125095', '2025-02-12', '2025-02-13', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID620879', 2, 0, 800000, 2500000.0, '2025-02-04 19:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-02-04 20:00:00', @cust7, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_218, @ser_spa, 3, 500000.0, 1500000.0, '2025-02-04 19:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_218, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-04 19:00:00', @bk_218),
(UUID(), 'CONFIRMED', NULL, '2025-02-04 20:00:00', @bk_218),
(UUID(), 'CHECKED_IN', @recep3, '2025-02-12 16:00:00', @bk_218),
(UUID(), 'CHECKED_OUT', @recep3, '2025-02-13 09:00:00', @bk_218);

SET @bk_219 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_219, 'BK2502148627', '2025-02-14', '2025-02-17', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID921798', 3, 0, 2400000, 2800000.0, '2025-02-10 01:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-02-10 02:00:00', @cust1, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_219, @ser_airport, 2, 200000.0, 400000.0, '2025-02-10 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-10 01:00:00', @bk_219),
(UUID(), 'CONFIRMED', NULL, '2025-02-10 08:00:00', @bk_219),
(UUID(), 'CHECKED_IN', @recep4, '2025-02-14 15:00:00', @bk_219),
(UUID(), 'CHECKED_OUT', @recep4, '2025-02-17 09:00:00', @bk_219);

SET @bk_220 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_220, 'BK2503031021', '2025-03-03', '2025-03-07', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID833392', 2, 0, 3200000, 3650000.0, '2025-02-20 16:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-20 17:00:00', @cust2, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_220, @ser_breakfast, 3, 150000.0, 450000.0, '2025-02-20 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-20 16:00:00', @bk_220),
(UUID(), 'CONFIRMED', NULL, '2025-02-21 03:00:00', @bk_220),
(UUID(), 'CHECKED_IN', @recep2, '2025-03-03 12:00:00', @bk_220),
(UUID(), 'CHECKED_OUT', @recep2, '2025-03-07 10:00:00', @bk_220);

SET @bk_221 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_221, 'BK2503217361', '2025-03-21', '2025-03-26', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID168418', 1, 1, 4000000, 5800000.0, '2025-03-06 13:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-06 14:00:00', @cust2, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_221, @ser_spa, 3, 500000.0, 1500000.0, '2025-03-06 13:00:00'),
(UUID(), @bk_221, @ser_breakfast, 2, 150000.0, 300000.0, '2025-03-06 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-06 13:00:00', @bk_221),
(UUID(), 'CONFIRMED', NULL, '2025-03-07 05:00:00', @bk_221),
(UUID(), 'CHECKED_IN', @recep7, '2025-03-21 14:00:00', @bk_221),
(UUID(), 'CHECKED_OUT', @recep7, '2025-03-26 08:00:00', @bk_221);

SET @bk_222 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_222, 'BK2504012115', '2025-04-01', '2025-04-03', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID343608', 2, 1, 1600000, 2500000.0, '2025-03-21 04:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-21 05:00:00', @cust3, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_222, @ser_breakfast, 2, 150000.0, 300000.0, '2025-03-21 04:00:00'),
(UUID(), @bk_222, @ser_airport, 3, 200000.0, 600000.0, '2025-03-21 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-21 04:00:00', @bk_222),
(UUID(), 'CONFIRMED', NULL, '2025-03-21 20:00:00', @bk_222),
(UUID(), 'CHECKED_IN', @recep4, '2025-04-01 14:00:00', @bk_222),
(UUID(), 'CHECKED_OUT', @recep4, '2025-04-03 11:00:00', @bk_222);

SET @bk_223 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_223, 'BK2504184394', '2025-04-18', '2025-04-22', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID829624', 3, 0, 3200000, 4100000.0, '2025-04-15 08:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-15 09:00:00', @cust9, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_223, @ser_spa, 1, 500000.0, 500000.0, '2025-04-15 08:00:00'),
(UUID(), @bk_223, @ser_airport, 2, 200000.0, 400000.0, '2025-04-15 08:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-15 08:00:00', @bk_223),
(UUID(), 'CONFIRMED', NULL, '2025-04-15 14:00:00', @bk_223),
(UUID(), 'CHECKED_IN', @recep9, '2025-04-18 16:00:00', @bk_223),
(UUID(), 'CHECKED_OUT', @recep9, '2025-04-22 11:00:00', @bk_223);

SET @bk_224 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_224, 'BK2504282431', '2025-04-28', '2025-05-01', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID155735', 2, 0, 2400000, 3400000.0, '2025-04-22 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-04-22 06:00:00', @cust10, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_224, @ser_spa, 1, 500000.0, 500000.0, '2025-04-22 05:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_224, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-22 05:00:00', @bk_224),
(UUID(), 'CONFIRMED', NULL, '2025-04-22 12:00:00', @bk_224),
(UUID(), 'CHECKED_IN', @recep10, '2025-04-28 13:00:00', @bk_224),
(UUID(), 'CHECKED_OUT', @recep10, '2025-05-01 08:00:00', @bk_224);

SET @bk_225 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_225, 'BK2505049451', '2025-05-04', '2025-05-10', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID476745', 2, 0, 4800000, 4800000, '2025-04-27 03:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-27 04:00:00', @cust4, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-27 03:00:00', @bk_225),
(UUID(), 'CONFIRMED', NULL, '2025-04-27 18:00:00', @bk_225),
(UUID(), 'CHECKED_IN', @recep2, '2025-05-04 12:00:00', @bk_225),
(UUID(), 'CHECKED_OUT', @recep2, '2025-05-10 12:00:00', @bk_225);

SET @bk_226 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_226, 'BK2505157166', '2025-05-15', '2025-05-20', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID377740', 3, 0, 4000000, 4000000, '2025-05-13 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-05-13 01:00:00', @cust7, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-13 00:00:00', @bk_226),
(UUID(), 'CONFIRMED', NULL, '2025-05-13 04:00:00', @bk_226),
(UUID(), 'CHECKED_IN', @recep1, '2025-05-15 15:00:00', @bk_226),
(UUID(), 'CHECKED_OUT', @recep1, '2025-05-20 11:00:00', @bk_226);

SET @bk_227 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_227, 'BK2505226870', '2025-05-22', '2025-05-24', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID408347', 1, 1, 1600000, 1600000, '2025-05-20 09:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-20 10:00:00', @cust1, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-20 09:00:00', @bk_227),
(UUID(), 'CONFIRMED', NULL, '2025-05-21 04:00:00', @bk_227),
(UUID(), 'CHECKED_IN', @recep6, '2025-05-22 15:00:00', @bk_227),
(UUID(), 'CHECKED_OUT', @recep6, '2025-05-24 08:00:00', @bk_227);

SET @bk_228 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_228, 'BK2506058676', '2025-06-05', '2025-06-10', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID313350', 1, 0, 4000000, 4150000.0, '2025-05-30 08:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-30 09:00:00', @cust7, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_228, @ser_breakfast, 1, 150000.0, 150000.0, '2025-05-30 08:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-30 08:00:00', @bk_228),
(UUID(), 'CONFIRMED', NULL, '2025-05-30 19:00:00', @bk_228),
(UUID(), 'CHECKED_IN', @recep5, '2025-06-05 15:00:00', @bk_228),
(UUID(), 'CHECKED_OUT', @recep5, '2025-06-10 10:00:00', @bk_228);

SET @bk_229 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_229, 'BK2506201621', '2025-06-20', '2025-06-23', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID824815', 3, 0, 2400000, 3750000.0, '2025-06-17 03:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-06-17 04:00:00', @cust7, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_229, @ser_airport, 2, 200000.0, 400000.0, '2025-06-17 03:00:00'),
(UUID(), @bk_229, @ser_breakfast, 3, 150000.0, 450000.0, '2025-06-17 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_229, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-17 03:00:00', @bk_229),
(UUID(), 'CONFIRMED', NULL, '2025-06-17 21:00:00', @bk_229),
(UUID(), 'CHECKED_IN', @recep5, '2025-06-20 15:00:00', @bk_229),
(UUID(), 'CHECKED_OUT', @recep5, '2025-06-23 10:00:00', @bk_229);

SET @bk_230 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_230, 'BK2507064841', '2025-07-06', '2025-07-10', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID707354', 1, 1, 3200000, 3650000.0, '2025-06-23 18:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-06-23 19:00:00', @cust6, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_230, @ser_breakfast, 3, 150000.0, 450000.0, '2025-06-23 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-23 18:00:00', @bk_230),
(UUID(), 'CONFIRMED', NULL, '2025-06-23 23:00:00', @bk_230),
(UUID(), 'CHECKED_IN', @recep2, '2025-07-06 13:00:00', @bk_230),
(UUID(), 'CHECKED_OUT', @recep2, '2025-07-10 09:00:00', @bk_230);

SET @bk_231 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_231, 'BK2507231552', '2025-07-23', '2025-07-24', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID277431', 2, 1, 800000, 800000, '2025-07-12 22:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-07-12 23:00:00', @cust1, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-12 22:00:00', @bk_231),
(UUID(), 'CONFIRMED', NULL, '2025-07-13 13:00:00', @bk_231),
(UUID(), 'CHECKED_IN', @recep1, '2025-07-23 12:00:00', @bk_231),
(UUID(), 'CHECKED_OUT', @recep1, '2025-07-24 08:00:00', @bk_231);

SET @bk_232 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_232, 'BK2508066179', '2025-08-06', '2025-08-12', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID821889', 2, 1, 4800000, 5750000.0, '2025-07-26 01:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-07-26 02:00:00', @cust10, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_232, @ser_breakfast, 3, 150000.0, 450000.0, '2025-07-26 01:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_232, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-26 01:00:00', @bk_232),
(UUID(), 'CONFIRMED', NULL, '2025-07-26 23:00:00', @bk_232),
(UUID(), 'CHECKED_IN', @recep6, '2025-08-06 15:00:00', @bk_232),
(UUID(), 'CHECKED_OUT', @recep6, '2025-08-12 10:00:00', @bk_232);

SET @bk_233 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_233, 'BK2508208885', '2025-08-20', '2025-08-25', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID754396', 1, 0, 4000000, 4200000.0, '2025-08-13 06:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-08-13 07:00:00', @cust6, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_233, @ser_airport, 1, 200000.0, 200000.0, '2025-08-13 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-13 06:00:00', @bk_233),
(UUID(), 'CONFIRMED', NULL, '2025-08-13 08:00:00', @bk_233),
(UUID(), 'CHECKED_IN', @recep10, '2025-08-20 16:00:00', @bk_233),
(UUID(), 'CHECKED_OUT', @recep10, '2025-08-25 11:00:00', @bk_233);

SET @bk_234 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_234, 'BK2508281405', '2025-08-28', '2025-09-01', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID894234', 2, 1, 3200000, 3600000.0, '2025-08-18 20:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-18 21:00:00', @cust1, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_234, @ser_airport, 2, 200000.0, 400000.0, '2025-08-18 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-18 20:00:00', @bk_234),
(UUID(), 'CONFIRMED', NULL, '2025-08-19 16:00:00', @bk_234),
(UUID(), 'CHECKED_IN', @recep1, '2025-08-28 14:00:00', @bk_234),
(UUID(), 'CHECKED_OUT', @recep1, '2025-09-01 09:00:00', @bk_234);

SET @bk_235 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_235, 'BK2509057753', '2025-09-05', '2025-09-09', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID599580', 3, 0, 3200000, 4300000.0, '2025-08-28 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-08-28 01:00:00', @cust3, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_235, @ser_airport, 3, 200000.0, 600000.0, '2025-08-28 00:00:00'),
(UUID(), @bk_235, @ser_spa, 1, 500000.0, 500000.0, '2025-08-28 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-28 00:00:00', @bk_235),
(UUID(), 'CONFIRMED', NULL, '2025-08-28 02:00:00', @bk_235),
(UUID(), 'CHECKED_IN', @recep9, '2025-09-05 15:00:00', @bk_235),
(UUID(), 'CHECKED_OUT', @recep9, '2025-09-09 09:00:00', @bk_235);

SET @bk_236 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_236, 'BK2509194612', '2025-09-19', '2025-09-24', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID121997', 1, 0, 4000000, 4150000.0, '2025-09-08 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-08 01:00:00', @cust7, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_236, @ser_breakfast, 1, 150000.0, 150000.0, '2025-09-08 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-08 00:00:00', @bk_236),
(UUID(), 'CONFIRMED', NULL, '2025-09-08 15:00:00', @bk_236),
(UUID(), 'CHECKED_IN', @recep7, '2025-09-19 16:00:00', @bk_236),
(UUID(), 'CHECKED_OUT', @recep7, '2025-09-24 09:00:00', @bk_236);

SET @bk_237 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_237, 'BK2509266391', '2025-09-26', '2025-09-27', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID508385', 3, 1, 800000, 800000, '2025-09-13 10:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-09-13 11:00:00', @cust9, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-13 10:00:00', @bk_237),
(UUID(), 'CONFIRMED', NULL, '2025-09-13 19:00:00', @bk_237),
(UUID(), 'CHECKED_IN', @recep3, '2025-09-26 12:00:00', @bk_237),
(UUID(), 'CHECKED_OUT', @recep3, '2025-09-27 12:00:00', @bk_237);

SET @bk_238 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_238, 'BK2510066149', '2025-10-06', '2025-10-10', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID289759', 1, 0, 3200000, 3900000.0, '2025-09-25 11:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-25 12:00:00', @cust8, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_238, @ser_airport, 1, 200000.0, 200000.0, '2025-09-25 11:00:00'),
(UUID(), @bk_238, @ser_spa, 1, 500000.0, 500000.0, '2025-09-25 11:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-25 11:00:00', @bk_238),
(UUID(), 'CONFIRMED', NULL, '2025-09-26 00:00:00', @bk_238),
(UUID(), 'CHECKED_IN', @recep6, '2025-10-06 13:00:00', @bk_238),
(UUID(), 'CHECKED_OUT', @recep6, '2025-10-10 08:00:00', @bk_238);

SET @bk_239 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_239, 'BK2510137186', '2025-10-13', '2025-10-15', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID334913', 2, 0, 1600000, 1600000, '2025-09-30 03:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-30 04:00:00', @cust3, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-30 03:00:00', @bk_239),
(UUID(), 'CONFIRMED', NULL, '2025-09-30 05:00:00', @bk_239),
(UUID(), 'CHECKED_IN', @recep5, '2025-10-13 12:00:00', @bk_239),
(UUID(), 'CHECKED_OUT', @recep5, '2025-10-15 11:00:00', @bk_239);

SET @bk_240 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_240, 'BK2510289934', '2025-10-28', '2025-11-03', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID956979', 1, 0, 4800000, 4800000, '2025-10-19 10:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-10-19 11:00:00', @cust3, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-19 10:00:00', @bk_240),
(UUID(), 'CONFIRMED', NULL, '2025-10-19 19:00:00', @bk_240),
(UUID(), 'CHECKED_IN', @recep5, '2025-10-28 12:00:00', @bk_240),
(UUID(), 'CHECKED_OUT', @recep5, '2025-11-03 12:00:00', @bk_240);

SET @bk_241 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_241, 'BK2511173101', '2025-11-17', '2025-11-22', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID518003', 3, 0, 4000000, 4300000, '2025-11-12 16:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-11-12 17:00:00', @cust7, @room6);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_241, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-12 16:00:00', @bk_241),
(UUID(), 'CONFIRMED', NULL, '2025-11-12 21:00:00', @bk_241),
(UUID(), 'CHECKED_IN', @recep5, '2025-11-17 12:00:00', @bk_241),
(UUID(), 'CHECKED_OUT', @recep5, '2025-11-22 08:00:00', @bk_241);

SET @bk_242 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_242, 'BK2511262761', '2025-11-26', '2025-11-27', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID315341', 2, 1, 800000, 1500000.0, '2025-11-18 21:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-11-18 22:00:00', @cust10, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_242, @ser_spa, 1, 500000.0, 500000.0, '2025-11-18 21:00:00'),
(UUID(), @bk_242, @ser_airport, 1, 200000.0, 200000.0, '2025-11-18 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-18 21:00:00', @bk_242),
(UUID(), 'CONFIRMED', NULL, '2025-11-19 01:00:00', @bk_242),
(UUID(), 'CHECKED_IN', @recep2, '2025-11-26 16:00:00', @bk_242),
(UUID(), 'CHECKED_OUT', @recep2, '2025-11-27 08:00:00', @bk_242);

SET @bk_243 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_243, 'BK2511284830', '2025-11-28', '2025-12-01', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID857129', 1, 1, 2400000, 2800000.0, '2025-11-24 00:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-24 01:00:00', @cust8, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_243, @ser_airport, 2, 200000.0, 400000.0, '2025-11-24 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-24 00:00:00', @bk_243),
(UUID(), 'CONFIRMED', NULL, '2025-11-24 13:00:00', @bk_243),
(UUID(), 'CHECKED_IN', @recep2, '2025-11-28 15:00:00', @bk_243),
(UUID(), 'CHECKED_OUT', @recep2, '2025-12-01 10:00:00', @bk_243);

SET @bk_244 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_244, 'BK2512041477', '2025-12-04', '2025-12-10', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID578470', 2, 1, 4800000, 5750000.0, '2025-11-21 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-11-21 19:00:00', @cust4, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_244, @ser_breakfast, 3, 150000.0, 450000.0, '2025-11-21 18:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_244, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-21 18:00:00', @bk_244),
(UUID(), 'CONFIRMED', NULL, '2025-11-22 15:00:00', @bk_244),
(UUID(), 'CHECKED_IN', @recep10, '2025-12-04 12:00:00', @bk_244),
(UUID(), 'CHECKED_OUT', @recep10, '2025-12-10 08:00:00', @bk_244);

SET @bk_245 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_245, 'BK2512248429', '2025-12-24', '2025-12-28', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID728006', 1, 1, 3200000, 3500000, '2025-12-11 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-11 02:00:00', @cust5, @room6);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_245, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-11 01:00:00', @bk_245),
(UUID(), 'CONFIRMED', NULL, '2025-12-11 17:00:00', @bk_245),
(UUID(), 'CHECKED_IN', @recep4, '2025-12-24 14:00:00', @bk_245),
(UUID(), 'CHECKED_OUT', @recep4, '2025-12-28 10:00:00', @bk_245);

SET @bk_246 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_246, 'BK2512319838', '2025-12-31', '2026-01-01', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID825727', 3, 0, 800000, 1700000.0, '2025-12-18 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-18 01:00:00', @cust6, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_246, @ser_airport, 2, 200000.0, 400000.0, '2025-12-18 00:00:00'),
(UUID(), @bk_246, @ser_spa, 1, 500000.0, 500000.0, '2025-12-18 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-18 00:00:00', @bk_246),
(UUID(), 'CONFIRMED', NULL, '2025-12-18 02:00:00', @bk_246),
(UUID(), 'CHECKED_IN', @recep9, '2025-12-31 12:00:00', @bk_246),
(UUID(), 'CHECKED_OUT', @recep9, '2026-01-01 10:00:00', @bk_246);

SET @bk_247 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_247, 'BK2601045471', '2026-01-04', '2026-01-10', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID484364', 3, 1, 4800000, 5000000, '2025-12-31 12:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-31 13:00:00', @cust6, @room6);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_247, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-31 12:00:00', @bk_247),
(UUID(), 'CONFIRMED', NULL, '2025-12-31 17:00:00', @bk_247),
(UUID(), 'CHECKED_IN', @recep2, '2026-01-04 12:00:00', @bk_247),
(UUID(), 'CHECKED_OUT', @recep2, '2026-01-10 10:00:00', @bk_247);

SET @bk_248 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_248, 'BK2601121685', '2026-01-12', '2026-01-18', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID743901', 2, 1, 4800000, 4900000, '2026-01-10 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-10 06:00:00', @cust9, @room6);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_248, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-10 05:00:00', @bk_248),
(UUID(), 'CONFIRMED', NULL, '2026-01-10 10:00:00', @bk_248),
(UUID(), 'CHECKED_IN', @recep6, '2026-01-12 15:00:00', @bk_248),
(UUID(), 'CHECKED_OUT', @recep6, '2026-01-18 08:00:00', @bk_248);

SET @bk_249 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_249, 'BK2602026173', '2026-02-02', '2026-02-05', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID935008', 1, 0, 2400000, 2400000, '2026-01-28 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-28 06:00:00', @cust5, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-28 05:00:00', @bk_249),
(UUID(), 'CONFIRMED', NULL, '2026-01-29 04:00:00', @bk_249),
(UUID(), 'CHECKED_IN', @recep10, '2026-02-02 12:00:00', @bk_249),
(UUID(), 'CHECKED_OUT', @recep10, '2026-02-05 08:00:00', @bk_249);

SET @bk_250 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_250, 'BK2602067905', '2026-02-06', '2026-02-07', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID237604', 3, 0, 800000, 1300000.0, '2026-01-29 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-29 06:00:00', @cust8, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_250, @ser_spa, 1, 500000.0, 500000.0, '2026-01-29 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-29 05:00:00', @bk_250),
(UUID(), 'CONFIRMED', NULL, '2026-01-29 21:00:00', @bk_250),
(UUID(), 'CHECKED_IN', @recep7, '2026-02-06 15:00:00', @bk_250),
(UUID(), 'CHECKED_OUT', @recep7, '2026-02-07 11:00:00', @bk_250);

SET @bk_251 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_251, 'BK2602172476', '2026-02-17', '2026-02-22', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID527885', 2, 0, 4000000, 5400000.0, '2026-02-16 00:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-02-16 01:00:00', @cust6, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_251, @ser_airport, 2, 200000.0, 400000.0, '2026-02-16 00:00:00'),
(UUID(), @bk_251, @ser_spa, 2, 500000.0, 1000000.0, '2026-02-16 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-16 00:00:00', @bk_251),
(UUID(), 'CONFIRMED', NULL, '2026-02-16 23:00:00', @bk_251),
(UUID(), 'CHECKED_IN', @recep6, '2026-02-17 14:00:00', @bk_251),
(UUID(), 'CHECKED_OUT', @recep6, '2026-02-22 12:00:00', @bk_251);

SET @bk_252 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_252, 'BK2603095697', '2026-03-09', '2026-03-15', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID581827', 1, 1, 4800000, 4900000, '2026-02-24 06:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-02-24 07:00:00', @cust4, @room6);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_252, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-24 06:00:00', @bk_252),
(UUID(), 'CONFIRMED', NULL, '2026-02-24 08:00:00', @bk_252),
(UUID(), 'CHECKED_IN', @recep1, '2026-03-09 13:00:00', @bk_252),
(UUID(), 'CHECKED_OUT', @recep1, '2026-03-15 10:00:00', @bk_252);

SET @bk_253 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_253, 'BK2603259504', '2026-03-25', '2026-03-30', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID646893', 2, 0, 4000000, 4000000, '2026-03-11 02:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-03-11 03:00:00', @cust5, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-11 02:00:00', @bk_253),
(UUID(), 'CONFIRMED', NULL, '2026-03-11 17:00:00', @bk_253),
(UUID(), 'CHECKED_IN', @recep3, '2026-03-25 16:00:00', @bk_253),
(UUID(), 'CHECKED_OUT', @recep3, '2026-03-30 08:00:00', @bk_253);

SET @bk_254 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_254, 'BK2604022481', '2026-04-02', '2026-04-06', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID351853', 3, 1, 3200000, 3200000, '2026-03-22 17:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-03-22 18:00:00', @cust7, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-22 17:00:00', @bk_254),
(UUID(), 'CONFIRMED', NULL, '2026-03-23 09:00:00', @bk_254),
(UUID(), 'CHECKED_IN', @recep10, '2026-04-02 15:00:00', @bk_254),
(UUID(), 'CHECKED_OUT', @recep10, '2026-04-06 09:00:00', @bk_254);

SET @bk_255 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_255, 'BK2604127192', '2026-04-12', '2026-04-13', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID184308', 2, 1, 800000, 1450000.0, '2026-04-02 22:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-04-02 23:00:00', @cust7, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_255, @ser_breakfast, 1, 150000.0, 150000.0, '2026-04-02 22:00:00'),
(UUID(), @bk_255, @ser_spa, 1, 500000.0, 500000.0, '2026-04-02 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-02 22:00:00', @bk_255),
(UUID(), 'CONFIRMED', NULL, '2026-04-03 18:00:00', @bk_255),
(UUID(), 'CHECKED_IN', @recep9, '2026-04-12 14:00:00', @bk_255),
(UUID(), 'CHECKED_OUT', @recep9, '2026-04-13 08:00:00', @bk_255);

SET @bk_256 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_256, 'BK2604263732', '2026-04-26', '2026-04-30', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID874295', 2, 1, 3200000, 4400000.0, '2026-04-11 19:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-04-11 20:00:00', @cust8, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_256, @ser_airport, 2, 200000.0, 400000.0, '2026-04-11 19:00:00'),
(UUID(), @bk_256, @ser_spa, 1, 500000.0, 500000.0, '2026-04-11 19:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_256, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-11 19:00:00', @bk_256),
(UUID(), 'CONFIRMED', NULL, '2026-04-12 13:00:00', @bk_256);

SET @bk_257 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_257, 'BK2605086248', '2026-05-08', '2026-05-09', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID961716', 1, 0, 800000, 800000, '2026-04-24 22:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-24 23:00:00', @cust6, @room6);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-24 22:00:00', @bk_257),
(UUID(), 'CONFIRMED', NULL, '2026-04-25 13:00:00', @bk_257);

SET @bk_258 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_258, 'BK2605216804', '2026-05-21', '2026-05-23', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID501725', 2, 0, 1600000, 2450000.0, '2026-05-06 11:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-05-06 12:00:00', @cust4, @room6);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_258, @ser_breakfast, 1, 150000.0, 150000.0, '2026-05-06 11:00:00'),
(UUID(), @bk_258, @ser_airport, 1, 200000.0, 200000.0, '2026-05-06 11:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_258, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-06 11:00:00', @bk_258),
(UUID(), 'CONFIRMED', NULL, '2026-05-06 23:00:00', @bk_258);

SET @bk_259 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_259, 'BK2501069485', '2025-01-06', '2025-01-08', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID199817', 1, 2, 3000000, 3300000.0, '2024-12-30 18:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2024-12-30 19:00:00', @cust5, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_259, @ser_breakfast, 2, 150000.0, 300000.0, '2024-12-30 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2024-12-30 18:00:00', @bk_259),
(UUID(), 'CONFIRMED', NULL, '2024-12-31 08:00:00', @bk_259),
(UUID(), 'CHECKED_IN', @recep10, '2025-01-06 12:00:00', @bk_259),
(UUID(), 'CHECKED_OUT', @recep10, '2025-01-08 08:00:00', @bk_259);

SET @bk_260 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_260, 'BK2501137177', '2025-01-13', '2025-01-15', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID322978', 3, 1, 3000000, 4300000.0, '2025-01-07 17:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-01-07 18:00:00', @cust5, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_260, @ser_spa, 2, 500000.0, 1000000.0, '2025-01-07 17:00:00'),
(UUID(), @bk_260, @ser_breakfast, 2, 150000.0, 300000.0, '2025-01-07 17:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-07 17:00:00', @bk_260),
(UUID(), 'CONFIRMED', NULL, '2025-01-08 17:00:00', @bk_260),
(UUID(), 'CHECKED_IN', @recep10, '2025-01-13 13:00:00', @bk_260),
(UUID(), 'CHECKED_OUT', @recep10, '2025-01-15 10:00:00', @bk_260);

SET @bk_261 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_261, 'BK2501216037', '2025-01-21', '2025-01-25', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID912651', 1, 2, 6000000, 6500000, '2025-01-19 14:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-01-19 15:00:00', @cust1, @room7);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_261, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-19 14:00:00', @bk_261),
(UUID(), 'CONFIRMED', NULL, '2025-01-20 11:00:00', @bk_261),
(UUID(), 'CHECKED_IN', @recep3, '2025-01-21 16:00:00', @bk_261),
(UUID(), 'CHECKED_OUT', @recep3, '2025-01-25 12:00:00', @bk_261);

SET @bk_262 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_262, 'BK2502074919', '2025-02-07', '2025-02-10', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID573414', 2, 2, 4500000, 4700000.0, '2025-01-26 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-26 19:00:00', @cust9, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_262, @ser_airport, 1, 200000.0, 200000.0, '2025-01-26 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-26 18:00:00', @bk_262),
(UUID(), 'CONFIRMED', NULL, '2025-01-27 11:00:00', @bk_262),
(UUID(), 'CHECKED_IN', @recep7, '2025-02-07 16:00:00', @bk_262),
(UUID(), 'CHECKED_OUT', @recep7, '2025-02-10 12:00:00', @bk_262);

SET @bk_263 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_263, 'BK2502151442', '2025-02-15', '2025-02-20', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID813862', 2, 1, 7500000, 9000000.0, '2025-02-04 07:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-04 08:00:00', @cust1, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_263, @ser_spa, 3, 500000.0, 1500000.0, '2025-02-04 07:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-04 07:00:00', @bk_263),
(UUID(), 'CONFIRMED', NULL, '2025-02-04 09:00:00', @bk_263),
(UUID(), 'CHECKED_IN', @recep1, '2025-02-15 13:00:00', @bk_263),
(UUID(), 'CHECKED_OUT', @recep1, '2025-02-20 11:00:00', @bk_263);

SET @bk_264 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_264, 'BK2503045073', '2025-03-04', '2025-03-08', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID226759', 3, 2, 6000000, 8400000.0, '2025-03-01 23:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-02 00:00:00', @cust5, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_264, @ser_airport, 2, 200000.0, 400000.0, '2025-03-01 23:00:00'),
(UUID(), @bk_264, @ser_spa, 3, 500000.0, 1500000.0, '2025-03-01 23:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_264, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-01 23:00:00', @bk_264),
(UUID(), 'CONFIRMED', NULL, '2025-03-02 03:00:00', @bk_264),
(UUID(), 'CHECKED_IN', @recep6, '2025-03-04 15:00:00', @bk_264),
(UUID(), 'CHECKED_OUT', @recep6, '2025-03-08 12:00:00', @bk_264);

SET @bk_265 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_265, 'BK2503123852', '2025-03-12', '2025-03-17', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID358125', 1, 1, 7500000, 9500000.0, '2025-03-02 03:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-02 04:00:00', @cust5, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_265, @ser_spa, 3, 500000.0, 1500000.0, '2025-03-02 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_265, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-02 03:00:00', @bk_265),
(UUID(), 'CONFIRMED', NULL, '2025-03-02 21:00:00', @bk_265),
(UUID(), 'CHECKED_IN', @recep2, '2025-03-12 14:00:00', @bk_265),
(UUID(), 'CHECKED_OUT', @recep2, '2025-03-17 12:00:00', @bk_265);

SET @bk_266 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_266, 'BK2503284124', '2025-03-28', '2025-03-31', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID736930', 3, 2, 4500000, 4800000.0, '2025-03-15 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-15 19:00:00', @cust10, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_266, @ser_airport, 1, 200000.0, 200000.0, '2025-03-15 18:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_266, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-15 18:00:00', @bk_266),
(UUID(), 'CONFIRMED', NULL, '2025-03-16 07:00:00', @bk_266),
(UUID(), 'CHECKED_IN', @recep9, '2025-03-28 14:00:00', @bk_266),
(UUID(), 'CHECKED_OUT', @recep9, '2025-03-31 11:00:00', @bk_266);

SET @bk_267 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_267, 'BK2504112378', '2025-04-11', '2025-04-15', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID721677', 2, 0, 6000000, 7500000.0, '2025-04-07 21:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-07 22:00:00', @cust1, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_267, @ser_spa, 3, 500000.0, 1500000.0, '2025-04-07 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-07 21:00:00', @bk_267),
(UUID(), 'CONFIRMED', NULL, '2025-04-08 18:00:00', @bk_267),
(UUID(), 'CHECKED_IN', @recep9, '2025-04-11 16:00:00', @bk_267),
(UUID(), 'CHECKED_OUT', @recep9, '2025-04-15 11:00:00', @bk_267);

SET @bk_268 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_268, 'BK2504251190', '2025-04-25', '2025-04-28', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID761881', 1, 0, 4500000, 4700000.0, '2025-04-22 14:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-22 15:00:00', @cust5, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_268, @ser_airport, 1, 200000.0, 200000.0, '2025-04-22 14:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-22 14:00:00', @bk_268),
(UUID(), 'CONFIRMED', NULL, '2025-04-23 05:00:00', @bk_268),
(UUID(), 'CHECKED_IN', @recep3, '2025-04-25 16:00:00', @bk_268),
(UUID(), 'CHECKED_OUT', @recep3, '2025-04-28 10:00:00', @bk_268);

SET @bk_269 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_269, 'BK2505059187', '2025-05-05', '2025-05-11', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID135406', 1, 2, 9000000, 10000000.0, '2025-04-24 23:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-04-25 00:00:00', @cust1, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_269, @ser_spa, 2, 500000.0, 1000000.0, '2025-04-24 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-24 23:00:00', @bk_269),
(UUID(), 'CONFIRMED', NULL, '2025-04-25 22:00:00', @bk_269),
(UUID(), 'CHECKED_IN', @recep9, '2025-05-05 14:00:00', @bk_269),
(UUID(), 'CHECKED_OUT', @recep9, '2025-05-11 12:00:00', @bk_269);

SET @bk_270 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_270, 'BK2505206148', '2025-05-20', '2025-05-22', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID178137', 4, 0, 3000000, 3600000.0, '2025-05-18 21:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-18 22:00:00', @cust2, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_270, @ser_breakfast, 2, 150000.0, 300000.0, '2025-05-18 21:00:00'),
(UUID(), @bk_270, @ser_airport, 1, 200000.0, 200000.0, '2025-05-18 21:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_270, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-18 21:00:00', @bk_270),
(UUID(), 'CONFIRMED', NULL, '2025-05-19 11:00:00', @bk_270),
(UUID(), 'CHECKED_IN', @recep2, '2025-05-20 16:00:00', @bk_270),
(UUID(), 'CHECKED_OUT', @recep2, '2025-05-22 12:00:00', @bk_270);

SET @bk_271 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_271, 'BK2505304077', '2025-05-30', '2025-06-03', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID841828', 3, 1, 6000000, 6000000, '2025-05-26 19:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-05-26 20:00:00', @cust9, @room7);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-26 19:00:00', @bk_271),
(UUID(), 'CONFIRMED', NULL, '2025-05-27 14:00:00', @bk_271),
(UUID(), 'CHECKED_IN', @recep10, '2025-05-30 14:00:00', @bk_271),
(UUID(), 'CHECKED_OUT', @recep10, '2025-06-03 08:00:00', @bk_271);

SET @bk_272 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_272, 'BK2506155211', '2025-06-15', '2025-06-19', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID915214', 4, 1, 6000000, 6150000.0, '2025-06-06 07:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-06 08:00:00', @cust2, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_272, @ser_breakfast, 1, 150000.0, 150000.0, '2025-06-06 07:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-06 07:00:00', @bk_272),
(UUID(), 'CONFIRMED', NULL, '2025-06-06 13:00:00', @bk_272),
(UUID(), 'CHECKED_IN', @recep1, '2025-06-15 15:00:00', @bk_272),
(UUID(), 'CHECKED_OUT', @recep1, '2025-06-19 11:00:00', @bk_272);

SET @bk_273 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_273, 'BK2506302163', '2025-06-30', '2025-07-02', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID340565', 3, 2, 3000000, 3200000, '2025-06-20 02:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-06-20 03:00:00', @cust3, @room7);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_273, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-20 02:00:00', @bk_273),
(UUID(), 'CONFIRMED', NULL, '2025-06-20 23:00:00', @bk_273),
(UUID(), 'CHECKED_IN', @recep9, '2025-06-30 13:00:00', @bk_273),
(UUID(), 'CHECKED_OUT', @recep9, '2025-07-02 10:00:00', @bk_273);

SET @bk_274 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_274, 'BK2507155251', '2025-07-15', '2025-07-17', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID387093', 1, 1, 3000000, 5200000.0, '2025-07-04 05:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-07-04 06:00:00', @cust1, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_274, @ser_airport, 1, 200000.0, 200000.0, '2025-07-04 05:00:00'),
(UUID(), @bk_274, @ser_spa, 3, 500000.0, 1500000.0, '2025-07-04 05:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_274, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-04 05:00:00', @bk_274),
(UUID(), 'CONFIRMED', NULL, '2025-07-05 03:00:00', @bk_274),
(UUID(), 'CHECKED_IN', @recep1, '2025-07-15 16:00:00', @bk_274),
(UUID(), 'CHECKED_OUT', @recep1, '2025-07-17 09:00:00', @bk_274);

SET @bk_275 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_275, 'BK2507234233', '2025-07-23', '2025-07-24', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID490907', 1, 2, 1500000, 1500000, '2025-07-10 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-07-10 02:00:00', @cust1, @room7);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-10 01:00:00', @bk_275),
(UUID(), 'CONFIRMED', NULL, '2025-07-10 10:00:00', @bk_275),
(UUID(), 'CHECKED_IN', @recep7, '2025-07-23 12:00:00', @bk_275),
(UUID(), 'CHECKED_OUT', @recep7, '2025-07-24 08:00:00', @bk_275);

SET @bk_276 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_276, 'BK2508042273', '2025-08-04', '2025-08-10', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID253438', 2, 1, 9000000, 9200000.0, '2025-08-01 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-01 02:00:00', @cust7, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_276, @ser_airport, 1, 200000.0, 200000.0, '2025-08-01 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-01 01:00:00', @bk_276),
(UUID(), 'CONFIRMED', NULL, '2025-08-01 06:00:00', @bk_276),
(UUID(), 'CHECKED_IN', @recep9, '2025-08-04 12:00:00', @bk_276),
(UUID(), 'CHECKED_OUT', @recep9, '2025-08-10 08:00:00', @bk_276);

SET @bk_277 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_277, 'BK2508177957', '2025-08-17', '2025-08-23', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID352255', 2, 0, 9000000, 9800000.0, '2025-08-12 05:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-12 06:00:00', @cust10, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_277, @ser_breakfast, 2, 150000.0, 300000.0, '2025-08-12 05:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_277, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-12 05:00:00', @bk_277),
(UUID(), 'CONFIRMED', NULL, '2025-08-13 03:00:00', @bk_277),
(UUID(), 'CHECKED_IN', @recep8, '2025-08-17 12:00:00', @bk_277),
(UUID(), 'CHECKED_OUT', @recep8, '2025-08-23 12:00:00', @bk_277);

SET @bk_278 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_278, 'BK2509051882', '2025-09-05', '2025-09-09', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID380065', 3, 0, 6000000, 6000000, '2025-08-28 09:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-28 10:00:00', @cust6, @room7);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-28 09:00:00', @bk_278),
(UUID(), 'CONFIRMED', NULL, '2025-08-28 17:00:00', @bk_278),
(UUID(), 'CHECKED_IN', @recep1, '2025-09-05 12:00:00', @bk_278),
(UUID(), 'CHECKED_OUT', @recep1, '2025-09-09 11:00:00', @bk_278);

SET @bk_279 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_279, 'BK2509193339', '2025-09-19', '2025-09-25', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID773281', 3, 2, 9000000, 9000000, '2025-09-11 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-11 19:00:00', @cust8, @room7);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-11 18:00:00', @bk_279),
(UUID(), 'CONFIRMED', NULL, '2025-09-12 15:00:00', @bk_279),
(UUID(), 'CHECKED_IN', @recep1, '2025-09-19 15:00:00', @bk_279),
(UUID(), 'CHECKED_OUT', @recep1, '2025-09-25 12:00:00', @bk_279);

SET @bk_280 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_280, 'BK2509281897', '2025-09-28', '2025-09-30', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID102495', 1, 1, 3000000, 3500000, '2025-09-25 13:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-25 14:00:00', @cust9, @room7);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_280, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-25 13:00:00', @bk_280),
(UUID(), 'CONFIRMED', NULL, '2025-09-25 22:00:00', @bk_280),
(UUID(), 'CHECKED_IN', @recep5, '2025-09-28 14:00:00', @bk_280),
(UUID(), 'CHECKED_OUT', @recep5, '2025-09-30 09:00:00', @bk_280);

SET @bk_281 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_281, 'BK2510016861', '2025-10-01', '2025-10-02', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID758040', 2, 1, 1500000, 1800000.0, '2025-09-24 22:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-24 23:00:00', @cust7, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_281, @ser_airport, 1, 200000.0, 200000.0, '2025-09-24 22:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_281, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-24 22:00:00', @bk_281),
(UUID(), 'CONFIRMED', NULL, '2025-09-25 20:00:00', @bk_281),
(UUID(), 'CHECKED_IN', @recep9, '2025-10-01 16:00:00', @bk_281),
(UUID(), 'CHECKED_OUT', @recep9, '2025-10-02 10:00:00', @bk_281);

SET @bk_282 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_282, 'BK2510049571', '2025-10-04', '2025-10-09', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID549197', 4, 0, 7500000, 7650000.0, '2025-09-30 12:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-30 13:00:00', @cust7, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_282, @ser_breakfast, 1, 150000.0, 150000.0, '2025-09-30 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-30 12:00:00', @bk_282),
(UUID(), 'CONFIRMED', NULL, '2025-09-30 17:00:00', @bk_282),
(UUID(), 'CHECKED_IN', @recep10, '2025-10-04 16:00:00', @bk_282),
(UUID(), 'CHECKED_OUT', @recep10, '2025-10-09 10:00:00', @bk_282);

SET @bk_283 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_283, 'BK2510116494', '2025-10-11', '2025-10-14', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID413489', 1, 0, 4500000, 5200000.0, '2025-09-27 21:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-27 22:00:00', @cust5, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_283, @ser_breakfast, 2, 150000.0, 300000.0, '2025-09-27 21:00:00'),
(UUID(), @bk_283, @ser_airport, 2, 200000.0, 400000.0, '2025-09-27 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-27 21:00:00', @bk_283),
(UUID(), 'CONFIRMED', NULL, '2025-09-28 02:00:00', @bk_283),
(UUID(), 'CHECKED_IN', @recep6, '2025-10-11 15:00:00', @bk_283),
(UUID(), 'CHECKED_OUT', @recep6, '2025-10-14 11:00:00', @bk_283);

SET @bk_284 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_284, 'BK2510246475', '2025-10-24', '2025-10-27', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID915324', 2, 0, 4500000, 4600000, '2025-10-15 02:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-10-15 03:00:00', @cust6, @room7);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_284, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-15 02:00:00', @bk_284),
(UUID(), 'CONFIRMED', NULL, '2025-10-15 21:00:00', @bk_284),
(UUID(), 'CHECKED_IN', @recep6, '2025-10-24 15:00:00', @bk_284),
(UUID(), 'CHECKED_OUT', @recep6, '2025-10-27 08:00:00', @bk_284);

SET @bk_285 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_285, 'BK2511117047', '2025-11-11', '2025-11-16', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID502409', 2, 2, 7500000, 7600000, '2025-11-07 13:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-07 14:00:00', @cust6, @room7);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_285, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-07 13:00:00', @bk_285),
(UUID(), 'CONFIRMED', NULL, '2025-11-08 07:00:00', @bk_285),
(UUID(), 'CHECKED_IN', @recep10, '2025-11-11 12:00:00', @bk_285),
(UUID(), 'CHECKED_OUT', @recep10, '2025-11-16 11:00:00', @bk_285);

SET @bk_286 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_286, 'BK2512016553', '2025-12-01', '2025-12-04', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID284092', 4, 2, 4500000, 6200000.0, '2025-11-19 12:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-11-19 13:00:00', @cust6, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_286, @ser_airport, 3, 200000.0, 600000.0, '2025-11-19 12:00:00'),
(UUID(), @bk_286, @ser_spa, 2, 500000.0, 1000000.0, '2025-11-19 12:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_286, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-19 12:00:00', @bk_286),
(UUID(), 'CONFIRMED', NULL, '2025-11-20 01:00:00', @bk_286),
(UUID(), 'CHECKED_IN', @recep2, '2025-12-01 16:00:00', @bk_286),
(UUID(), 'CHECKED_OUT', @recep2, '2025-12-04 11:00:00', @bk_286);

SET @bk_287 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_287, 'BK2512142625', '2025-12-14', '2025-12-20', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID408122', 1, 2, 9000000, 9300000, '2025-12-03 05:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-12-03 06:00:00', @cust3, @room7);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_287, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-03 05:00:00', @bk_287),
(UUID(), 'CONFIRMED', NULL, '2025-12-04 03:00:00', @bk_287),
(UUID(), 'CHECKED_IN', @recep8, '2025-12-14 13:00:00', @bk_287),
(UUID(), 'CHECKED_OUT', @recep8, '2025-12-20 10:00:00', @bk_287);

SET @bk_288 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_288, 'BK2512305606', '2025-12-30', '2026-01-01', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID353224', 1, 1, 3000000, 3000000, '2025-12-21 19:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-12-21 20:00:00', @cust3, @room7);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-21 19:00:00', @bk_288),
(UUID(), 'CONFIRMED', NULL, '2025-12-22 15:00:00', @bk_288),
(UUID(), 'CHECKED_IN', @recep3, '2025-12-30 15:00:00', @bk_288),
(UUID(), 'CHECKED_OUT', @recep3, '2026-01-01 11:00:00', @bk_288);

SET @bk_289 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_289, 'BK2601037311', '2026-01-03', '2026-01-06', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID138670', 1, 1, 4500000, 5550000.0, '2025-12-30 15:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-30 16:00:00', @cust8, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_289, @ser_airport, 2, 200000.0, 400000.0, '2025-12-30 15:00:00'),
(UUID(), @bk_289, @ser_breakfast, 1, 150000.0, 150000.0, '2025-12-30 15:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_289, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-30 15:00:00', @bk_289),
(UUID(), 'CONFIRMED', NULL, '2025-12-30 18:00:00', @bk_289),
(UUID(), 'CHECKED_IN', @recep3, '2026-01-03 15:00:00', @bk_289),
(UUID(), 'CHECKED_OUT', @recep3, '2026-01-06 11:00:00', @bk_289);

SET @bk_290 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_290, 'BK2601182535', '2026-01-18', '2026-01-23', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID673186', 4, 2, 7500000, 7900000.0, '2026-01-14 00:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-01-14 01:00:00', @cust5, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_290, @ser_breakfast, 2, 150000.0, 300000.0, '2026-01-14 00:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_290, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-14 00:00:00', @bk_290),
(UUID(), 'CONFIRMED', NULL, '2026-01-14 12:00:00', @bk_290),
(UUID(), 'CHECKED_IN', @recep9, '2026-01-18 14:00:00', @bk_290),
(UUID(), 'CHECKED_OUT', @recep9, '2026-01-23 11:00:00', @bk_290);

SET @bk_291 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_291, 'BK2602059927', '2026-02-05', '2026-02-07', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID165747', 3, 1, 3000000, 3600000.0, '2026-01-24 03:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-24 04:00:00', @cust3, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_291, @ser_airport, 3, 200000.0, 600000.0, '2026-01-24 03:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-24 03:00:00', @bk_291),
(UUID(), 'CONFIRMED', NULL, '2026-01-25 02:00:00', @bk_291),
(UUID(), 'CHECKED_IN', @recep7, '2026-02-05 15:00:00', @bk_291),
(UUID(), 'CHECKED_OUT', @recep7, '2026-02-07 10:00:00', @bk_291);

SET @bk_292 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_292, 'BK2602173567', '2026-02-17', '2026-02-19', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID135665', 2, 1, 3000000, 3000000, '2026-02-04 09:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-04 10:00:00', @cust6, @room7);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-04 09:00:00', @bk_292),
(UUID(), 'CONFIRMED', NULL, '2026-02-05 03:00:00', @bk_292),
(UUID(), 'CHECKED_IN', @recep8, '2026-02-17 13:00:00', @bk_292),
(UUID(), 'CHECKED_OUT', @recep8, '2026-02-19 09:00:00', @bk_292);

SET @bk_293 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_293, 'BK2602251422', '2026-02-25', '2026-03-03', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID362322', 3, 1, 9000000, 9300000, '2026-02-17 13:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-17 14:00:00', @cust9, @room7);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_293, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-17 13:00:00', @bk_293),
(UUID(), 'CONFIRMED', NULL, '2026-02-18 06:00:00', @bk_293),
(UUID(), 'CHECKED_IN', @recep4, '2026-02-25 14:00:00', @bk_293),
(UUID(), 'CHECKED_OUT', @recep4, '2026-03-03 10:00:00', @bk_293);

SET @bk_294 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_294, 'BK2603045365', '2026-03-04', '2026-03-10', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID591562', 4, 0, 9000000, 9500000.0, '2026-02-28 22:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-02-28 23:00:00', @cust3, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_294, @ser_spa, 1, 500000.0, 500000.0, '2026-02-28 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-28 22:00:00', @bk_294),
(UUID(), 'CONFIRMED', NULL, '2026-03-01 17:00:00', @bk_294),
(UUID(), 'CHECKED_IN', @recep5, '2026-03-04 15:00:00', @bk_294),
(UUID(), 'CHECKED_OUT', @recep5, '2026-03-10 09:00:00', @bk_294);

SET @bk_295 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_295, 'BK2603252762', '2026-03-25', '2026-03-29', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID307664', 3, 2, 6000000, 6350000.0, '2026-03-20 20:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-20 21:00:00', @cust8, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_295, @ser_airport, 1, 200000.0, 200000.0, '2026-03-20 20:00:00'),
(UUID(), @bk_295, @ser_breakfast, 1, 150000.0, 150000.0, '2026-03-20 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-20 20:00:00', @bk_295),
(UUID(), 'CONFIRMED', NULL, '2026-03-21 12:00:00', @bk_295),
(UUID(), 'CHECKED_IN', @recep3, '2026-03-25 12:00:00', @bk_295),
(UUID(), 'CHECKED_OUT', @recep3, '2026-03-29 10:00:00', @bk_295);

SET @bk_296 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_296, 'BK2604043328', '2026-04-04', '2026-04-09', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID473720', 1, 0, 7500000, 7600000, '2026-03-21 19:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-21 20:00:00', @cust7, @room7);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_296, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-21 19:00:00', @bk_296),
(UUID(), 'CONFIRMED', NULL, '2026-03-21 23:00:00', @bk_296),
(UUID(), 'CHECKED_IN', @recep6, '2026-04-04 13:00:00', @bk_296),
(UUID(), 'CHECKED_OUT', @recep6, '2026-04-09 10:00:00', @bk_296);

SET @bk_297 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_297, 'BK2604173107', '2026-04-17', '2026-04-19', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID222969', 1, 0, 3000000, 3500000.0, '2026-04-11 12:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-04-11 13:00:00', @cust7, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_297, @ser_airport, 1, 200000.0, 200000.0, '2026-04-11 12:00:00'),
(UUID(), @bk_297, @ser_breakfast, 2, 150000.0, 300000.0, '2026-04-11 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-11 12:00:00', @bk_297),
(UUID(), 'CONFIRMED', NULL, '2026-04-12 07:00:00', @bk_297);

SET @bk_298 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_298, 'BK2604215930', '2026-04-21', '2026-04-22', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID875424', 3, 1, 1500000, 2350000.0, '2026-04-13 18:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-04-13 19:00:00', @cust9, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_298, @ser_breakfast, 3, 150000.0, 450000.0, '2026-04-13 18:00:00'),
(UUID(), @bk_298, @ser_airport, 2, 200000.0, 400000.0, '2026-04-13 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-13 18:00:00', @bk_298),
(UUID(), 'CONFIRMED', NULL, '2026-04-14 07:00:00', @bk_298);

SET @bk_299 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_299, 'BK2605017681', '2026-05-01', '2026-05-03', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID175134', 3, 0, 3000000, 3350000.0, '2026-04-20 19:00:00', 'PENDING', 'CREDIT_CARD', 'UNPAID', NULL, @cust1, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_299, @ser_breakfast, 1, 150000.0, 150000.0, '2026-04-20 19:00:00'),
(UUID(), @bk_299, @ser_airport, 1, 200000.0, 200000.0, '2026-04-20 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-20 19:00:00', @bk_299);

SET @bk_300 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_300, 'BK2605083634', '2026-05-08', '2026-05-10', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID986440', 4, 1, 3000000, 3000000, '2026-04-30 02:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-30 03:00:00', @cust9, @room7);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-30 02:00:00', @bk_300),
(UUID(), 'CONFIRMED', NULL, '2026-04-30 18:00:00', @bk_300);

SET @bk_301 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_301, 'BK2605237526', '2026-05-23', '2026-05-28', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID236423', 1, 0, 7500000, 8100000.0, '2026-05-20 08:00:00', 'PENDING', 'BANK_TRANSFER', 'UNPAID', NULL, @cust4, @room7);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_301, @ser_airport, 3, 200000.0, 600000.0, '2026-05-20 08:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-20 08:00:00', @bk_301);

SET @bk_302 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_302, 'BK2501049195', '2025-01-04', '2025-01-09', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID570838', 1, 2, 7500000, 8450000.0, '2025-01-02 08:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-02 09:00:00', @cust6, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_302, @ser_breakfast, 3, 150000.0, 450000.0, '2025-01-02 08:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_302, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-02 08:00:00', @bk_302),
(UUID(), 'CONFIRMED', NULL, '2025-01-03 02:00:00', @bk_302),
(UUID(), 'CHECKED_IN', @recep3, '2025-01-04 12:00:00', @bk_302),
(UUID(), 'CHECKED_OUT', @recep3, '2025-01-09 09:00:00', @bk_302);

SET @bk_303 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_303, 'BK2501146986', '2025-01-14', '2025-01-20', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID924064', 2, 0, 9000000, 9100000, '2025-01-01 04:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-01 05:00:00', @cust2, @room8);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_303, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-01 04:00:00', @bk_303),
(UUID(), 'CONFIRMED', NULL, '2025-01-01 17:00:00', @bk_303),
(UUID(), 'CHECKED_IN', @recep4, '2025-01-14 12:00:00', @bk_303),
(UUID(), 'CHECKED_OUT', @recep4, '2025-01-20 09:00:00', @bk_303);

SET @bk_304 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_304, 'BK2501213137', '2025-01-21', '2025-01-26', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID394475', 4, 0, 7500000, 8150000.0, '2025-01-16 21:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-01-16 22:00:00', @cust3, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_304, @ser_spa, 1, 500000.0, 500000.0, '2025-01-16 21:00:00'),
(UUID(), @bk_304, @ser_breakfast, 1, 150000.0, 150000.0, '2025-01-16 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-16 21:00:00', @bk_304),
(UUID(), 'CONFIRMED', NULL, '2025-01-17 08:00:00', @bk_304),
(UUID(), 'CHECKED_IN', @recep9, '2025-01-21 16:00:00', @bk_304),
(UUID(), 'CHECKED_OUT', @recep9, '2025-01-26 09:00:00', @bk_304);

SET @bk_305 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_305, 'BK2502048054', '2025-02-04', '2025-02-08', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID432409', 1, 2, 6000000, 6650000.0, '2025-01-29 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-29 23:00:00', @cust5, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_305, @ser_breakfast, 1, 150000.0, 150000.0, '2025-01-29 22:00:00'),
(UUID(), @bk_305, @ser_spa, 1, 500000.0, 500000.0, '2025-01-29 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-29 22:00:00', @bk_305),
(UUID(), 'CONFIRMED', NULL, '2025-01-30 15:00:00', @bk_305),
(UUID(), 'CHECKED_IN', @recep5, '2025-02-04 16:00:00', @bk_305),
(UUID(), 'CHECKED_OUT', @recep5, '2025-02-08 12:00:00', @bk_305);

SET @bk_306 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_306, 'BK2502225102', '2025-02-22', '2025-02-25', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID576590', 2, 0, 4500000, 4500000, '2025-02-12 14:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-02-12 15:00:00', @cust9, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-12 14:00:00', @bk_306),
(UUID(), 'CONFIRMED', NULL, '2025-02-12 15:00:00', @bk_306),
(UUID(), 'CHECKED_IN', @recep6, '2025-02-22 15:00:00', @bk_306),
(UUID(), 'CHECKED_OUT', @recep6, '2025-02-25 10:00:00', @bk_306);

SET @bk_307 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_307, 'BK2503038312', '2025-03-03', '2025-03-06', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID230955', 3, 1, 4500000, 5000000.0, '2025-02-26 04:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-26 05:00:00', @cust1, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_307, @ser_spa, 1, 500000.0, 500000.0, '2025-02-26 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-26 04:00:00', @bk_307),
(UUID(), 'CONFIRMED', NULL, '2025-02-26 05:00:00', @bk_307),
(UUID(), 'CHECKED_IN', @recep3, '2025-03-03 13:00:00', @bk_307),
(UUID(), 'CHECKED_OUT', @recep3, '2025-03-06 12:00:00', @bk_307);

SET @bk_308 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_308, 'BK2503162063', '2025-03-16', '2025-03-18', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID922934', 2, 2, 3000000, 3500000.0, '2025-03-03 16:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-03 17:00:00', @cust10, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_308, @ser_airport, 1, 200000.0, 200000.0, '2025-03-03 16:00:00'),
(UUID(), @bk_308, @ser_breakfast, 2, 150000.0, 300000.0, '2025-03-03 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-03 16:00:00', @bk_308),
(UUID(), 'CONFIRMED', NULL, '2025-03-03 22:00:00', @bk_308),
(UUID(), 'CHECKED_IN', @recep6, '2025-03-16 16:00:00', @bk_308),
(UUID(), 'CHECKED_OUT', @recep6, '2025-03-18 12:00:00', @bk_308);

SET @bk_309 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_309, 'BK2503223320', '2025-03-22', '2025-03-25', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID487003', 2, 2, 4500000, 5100000.0, '2025-03-07 16:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-07 17:00:00', @cust4, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_309, @ser_airport, 3, 200000.0, 600000.0, '2025-03-07 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-07 16:00:00', @bk_309),
(UUID(), 'CONFIRMED', NULL, '2025-03-07 18:00:00', @bk_309),
(UUID(), 'CHECKED_IN', @recep8, '2025-03-22 14:00:00', @bk_309),
(UUID(), 'CHECKED_OUT', @recep8, '2025-03-25 09:00:00', @bk_309);

SET @bk_310 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_310, 'BK2503268812', '2025-03-26', '2025-03-31', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID965354', 2, 1, 7500000, 7500000, '2025-03-19 23:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-20 00:00:00', @cust8, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-19 23:00:00', @bk_310),
(UUID(), 'CONFIRMED', NULL, '2025-03-20 01:00:00', @bk_310),
(UUID(), 'CHECKED_IN', @recep2, '2025-03-26 15:00:00', @bk_310),
(UUID(), 'CHECKED_OUT', @recep2, '2025-03-31 08:00:00', @bk_310);

SET @bk_311 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_311, 'BK2504024924', '2025-04-02', '2025-04-08', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID459015', 1, 1, 9000000, 9700000.0, '2025-03-25 13:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-25 14:00:00', @cust7, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_311, @ser_airport, 2, 200000.0, 400000.0, '2025-03-25 13:00:00'),
(UUID(), @bk_311, @ser_breakfast, 2, 150000.0, 300000.0, '2025-03-25 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-25 13:00:00', @bk_311),
(UUID(), 'CONFIRMED', NULL, '2025-03-26 03:00:00', @bk_311),
(UUID(), 'CHECKED_IN', @recep6, '2025-04-02 13:00:00', @bk_311),
(UUID(), 'CHECKED_OUT', @recep6, '2025-04-08 11:00:00', @bk_311);

SET @bk_312 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_312, 'BK2504157448', '2025-04-15', '2025-04-16', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID980507', 2, 0, 1500000, 1700000, '2025-04-11 13:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-11 14:00:00', @cust7, @room8);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_312, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-11 13:00:00', @bk_312),
(UUID(), 'CONFIRMED', NULL, '2025-04-11 16:00:00', @bk_312),
(UUID(), 'CHECKED_IN', @recep3, '2025-04-15 15:00:00', @bk_312),
(UUID(), 'CHECKED_OUT', @recep3, '2025-04-16 10:00:00', @bk_312);

SET @bk_313 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_313, 'BK2504253203', '2025-04-25', '2025-04-27', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID640086', 4, 1, 3000000, 3000000, '2025-04-15 16:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-15 17:00:00', @cust2, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-15 16:00:00', @bk_313),
(UUID(), 'CONFIRMED', NULL, '2025-04-16 11:00:00', @bk_313),
(UUID(), 'CHECKED_IN', @recep5, '2025-04-25 16:00:00', @bk_313),
(UUID(), 'CHECKED_OUT', @recep5, '2025-04-27 11:00:00', @bk_313);

SET @bk_314 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_314, 'BK2505053773', '2025-05-05', '2025-05-06', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID102200', 1, 1, 1500000, 2950000.0, '2025-04-23 02:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-23 03:00:00', @cust10, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_314, @ser_breakfast, 3, 150000.0, 450000.0, '2025-04-23 02:00:00'),
(UUID(), @bk_314, @ser_spa, 2, 500000.0, 1000000.0, '2025-04-23 02:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-23 02:00:00', @bk_314),
(UUID(), 'CONFIRMED', NULL, '2025-04-23 15:00:00', @bk_314),
(UUID(), 'CHECKED_IN', @recep8, '2025-05-05 16:00:00', @bk_314),
(UUID(), 'CHECKED_OUT', @recep8, '2025-05-06 09:00:00', @bk_314);

SET @bk_315 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_315, 'BK2505196905', '2025-05-19', '2025-05-23', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID780177', 1, 2, 6000000, 7950000.0, '2025-05-13 01:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-05-13 02:00:00', @cust10, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_315, @ser_breakfast, 3, 150000.0, 450000.0, '2025-05-13 01:00:00'),
(UUID(), @bk_315, @ser_spa, 3, 500000.0, 1500000.0, '2025-05-13 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-13 01:00:00', @bk_315),
(UUID(), 'CONFIRMED', NULL, '2025-05-13 16:00:00', @bk_315),
(UUID(), 'CHECKED_IN', @recep8, '2025-05-19 15:00:00', @bk_315),
(UUID(), 'CHECKED_OUT', @recep8, '2025-05-23 09:00:00', @bk_315);

SET @bk_316 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_316, 'BK2505296022', '2025-05-29', '2025-06-02', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID317750', 3, 0, 6000000, 6500000, '2025-05-19 08:00:00', 'CANCELLED', 'BANK_TRANSFER', 'UNPAID', NULL, @cust5, @room8);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_316, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-19 08:00:00', @bk_316),
(UUID(), 'CANCELLED', @recep2, '2025-05-19 22:00:00', @bk_316);

SET @bk_317 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_317, 'BK2506041847', '2025-06-04', '2025-06-08', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID886682', 1, 2, 6000000, 7900000.0, '2025-06-02 17:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-02 18:00:00', @cust5, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_317, @ser_airport, 2, 200000.0, 400000.0, '2025-06-02 17:00:00'),
(UUID(), @bk_317, @ser_spa, 3, 500000.0, 1500000.0, '2025-06-02 17:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-02 17:00:00', @bk_317),
(UUID(), 'CONFIRMED', NULL, '2025-06-03 07:00:00', @bk_317),
(UUID(), 'CHECKED_IN', @recep4, '2025-06-04 13:00:00', @bk_317),
(UUID(), 'CHECKED_OUT', @recep4, '2025-06-08 11:00:00', @bk_317);

SET @bk_318 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_318, 'BK2506229602', '2025-06-22', '2025-06-26', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID677368', 4, 0, 6000000, 6650000.0, '2025-06-16 15:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-16 16:00:00', @cust1, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_318, @ser_breakfast, 1, 150000.0, 150000.0, '2025-06-16 15:00:00'),
(UUID(), @bk_318, @ser_spa, 1, 500000.0, 500000.0, '2025-06-16 15:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-16 15:00:00', @bk_318),
(UUID(), 'CONFIRMED', NULL, '2025-06-17 10:00:00', @bk_318),
(UUID(), 'CHECKED_IN', @recep5, '2025-06-22 16:00:00', @bk_318),
(UUID(), 'CHECKED_OUT', @recep5, '2025-06-26 12:00:00', @bk_318);

SET @bk_319 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_319, 'BK2506285445', '2025-06-28', '2025-07-03', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID261893', 2, 2, 7500000, 7650000.0, '2025-06-23 20:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-06-23 21:00:00', @cust2, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_319, @ser_breakfast, 1, 150000.0, 150000.0, '2025-06-23 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-23 20:00:00', @bk_319),
(UUID(), 'CONFIRMED', NULL, '2025-06-24 07:00:00', @bk_319),
(UUID(), 'CHECKED_IN', @recep5, '2025-06-28 16:00:00', @bk_319),
(UUID(), 'CHECKED_OUT', @recep5, '2025-07-03 12:00:00', @bk_319);

SET @bk_320 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_320, 'BK2507078397', '2025-07-07', '2025-07-09', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID711138', 3, 0, 3000000, 4050000.0, '2025-06-28 14:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-28 15:00:00', @cust1, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_320, @ser_airport, 3, 200000.0, 600000.0, '2025-06-28 14:00:00'),
(UUID(), @bk_320, @ser_breakfast, 3, 150000.0, 450000.0, '2025-06-28 14:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-28 14:00:00', @bk_320),
(UUID(), 'CONFIRMED', NULL, '2025-06-29 00:00:00', @bk_320),
(UUID(), 'CHECKED_IN', @recep4, '2025-07-07 12:00:00', @bk_320),
(UUID(), 'CHECKED_OUT', @recep4, '2025-07-09 09:00:00', @bk_320);

SET @bk_321 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_321, 'BK2507206060', '2025-07-20', '2025-07-26', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID962700', 4, 0, 9000000, 9000000, '2025-07-12 01:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-07-12 02:00:00', @cust9, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-12 01:00:00', @bk_321),
(UUID(), 'CONFIRMED', NULL, '2025-07-12 17:00:00', @bk_321),
(UUID(), 'CHECKED_IN', @recep8, '2025-07-20 16:00:00', @bk_321),
(UUID(), 'CHECKED_OUT', @recep8, '2025-07-26 09:00:00', @bk_321);

SET @bk_322 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_322, 'BK2507308484', '2025-07-30', '2025-08-02', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID514945', 4, 1, 4500000, 4500000, '2025-07-28 14:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-07-28 15:00:00', @cust10, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-28 14:00:00', @bk_322),
(UUID(), 'CONFIRMED', NULL, '2025-07-29 13:00:00', @bk_322),
(UUID(), 'CHECKED_IN', @recep8, '2025-07-30 15:00:00', @bk_322),
(UUID(), 'CHECKED_OUT', @recep8, '2025-08-02 12:00:00', @bk_322);

SET @bk_323 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_323, 'BK2508099671', '2025-08-09', '2025-08-10', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID361840', 3, 2, 1500000, 2100000.0, '2025-08-04 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-08-04 06:00:00', @cust2, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_323, @ser_airport, 3, 200000.0, 600000.0, '2025-08-04 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-04 05:00:00', @bk_323),
(UUID(), 'CONFIRMED', NULL, '2025-08-04 15:00:00', @bk_323),
(UUID(), 'CHECKED_IN', @recep1, '2025-08-09 13:00:00', @bk_323),
(UUID(), 'CHECKED_OUT', @recep1, '2025-08-10 12:00:00', @bk_323);

SET @bk_324 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_324, 'BK2508156003', '2025-08-15', '2025-08-17', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID542802', 3, 2, 3000000, 3700000.0, '2025-08-07 13:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-07 14:00:00', @cust1, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_324, @ser_airport, 2, 200000.0, 400000.0, '2025-08-07 13:00:00'),
(UUID(), @bk_324, @ser_breakfast, 2, 150000.0, 300000.0, '2025-08-07 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-07 13:00:00', @bk_324),
(UUID(), 'CONFIRMED', NULL, '2025-08-08 04:00:00', @bk_324),
(UUID(), 'CHECKED_IN', @recep4, '2025-08-15 16:00:00', @bk_324),
(UUID(), 'CHECKED_OUT', @recep4, '2025-08-17 09:00:00', @bk_324);

SET @bk_325 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_325, 'BK2508182645', '2025-08-18', '2025-08-23', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID776757', 1, 1, 7500000, 8700000.0, '2025-08-11 04:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-11 05:00:00', @cust4, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_325, @ser_airport, 1, 200000.0, 200000.0, '2025-08-11 04:00:00'),
(UUID(), @bk_325, @ser_spa, 2, 500000.0, 1000000.0, '2025-08-11 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-11 04:00:00', @bk_325),
(UUID(), 'CONFIRMED', NULL, '2025-08-12 03:00:00', @bk_325),
(UUID(), 'CHECKED_IN', @recep10, '2025-08-18 13:00:00', @bk_325),
(UUID(), 'CHECKED_OUT', @recep10, '2025-08-23 10:00:00', @bk_325);

SET @bk_326 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_326, 'BK2509054788', '2025-09-05', '2025-09-11', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID354683', 1, 0, 9000000, 9600000.0, '2025-08-29 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-08-29 06:00:00', @cust4, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_326, @ser_airport, 3, 200000.0, 600000.0, '2025-08-29 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-29 05:00:00', @bk_326),
(UUID(), 'CONFIRMED', NULL, '2025-08-29 07:00:00', @bk_326),
(UUID(), 'CHECKED_IN', @recep5, '2025-09-05 13:00:00', @bk_326),
(UUID(), 'CHECKED_OUT', @recep5, '2025-09-11 12:00:00', @bk_326);

SET @bk_327 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_327, 'BK2509217059', '2025-09-21', '2025-09-27', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID262486', 1, 2, 9000000, 9000000, '2025-09-14 14:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-09-14 15:00:00', @cust10, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-14 14:00:00', @bk_327),
(UUID(), 'CONFIRMED', NULL, '2025-09-14 21:00:00', @bk_327),
(UUID(), 'CHECKED_IN', @recep7, '2025-09-21 13:00:00', @bk_327),
(UUID(), 'CHECKED_OUT', @recep7, '2025-09-27 12:00:00', @bk_327);

SET @bk_328 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_328, 'BK2510082212', '2025-10-08', '2025-10-14', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID261998', 3, 2, 9000000, 9300000, '2025-10-01 16:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-10-01 17:00:00', @cust7, @room8);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_328, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-01 16:00:00', @bk_328),
(UUID(), 'CONFIRMED', NULL, '2025-10-02 03:00:00', @bk_328),
(UUID(), 'CHECKED_IN', @recep8, '2025-10-08 12:00:00', @bk_328),
(UUID(), 'CHECKED_OUT', @recep8, '2025-10-14 12:00:00', @bk_328);

SET @bk_329 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_329, 'BK2510249300', '2025-10-24', '2025-10-30', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID833356', 1, 0, 9000000, 9300000, '2025-10-16 14:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-10-16 15:00:00', @cust9, @room8);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_329, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-16 14:00:00', @bk_329),
(UUID(), 'CONFIRMED', NULL, '2025-10-17 08:00:00', @bk_329),
(UUID(), 'CHECKED_IN', @recep4, '2025-10-24 14:00:00', @bk_329),
(UUID(), 'CHECKED_OUT', @recep4, '2025-10-30 10:00:00', @bk_329);

SET @bk_330 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_330, 'BK2511053762', '2025-11-05', '2025-11-11', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID674205', 4, 1, 9000000, 10500000.0, '2025-10-22 20:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-10-22 21:00:00', @cust7, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_330, @ser_spa, 3, 500000.0, 1500000.0, '2025-10-22 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-22 20:00:00', @bk_330),
(UUID(), 'CONFIRMED', NULL, '2025-10-23 14:00:00', @bk_330),
(UUID(), 'CHECKED_IN', @recep5, '2025-11-05 12:00:00', @bk_330),
(UUID(), 'CHECKED_OUT', @recep5, '2025-11-11 12:00:00', @bk_330);

SET @bk_331 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_331, 'BK2511251896', '2025-11-25', '2025-11-28', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID913379', 3, 2, 4500000, 6000000.0, '2025-11-17 07:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-17 08:00:00', @cust5, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_331, @ser_spa, 3, 500000.0, 1500000.0, '2025-11-17 07:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-17 07:00:00', @bk_331),
(UUID(), 'CONFIRMED', NULL, '2025-11-17 22:00:00', @bk_331),
(UUID(), 'CHECKED_IN', @recep3, '2025-11-25 13:00:00', @bk_331),
(UUID(), 'CHECKED_OUT', @recep3, '2025-11-28 10:00:00', @bk_331);

SET @bk_332 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_332, 'BK2512084030', '2025-12-08', '2025-12-09', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID293543', 3, 1, 1500000, 1500000, '2025-11-27 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-11-27 01:00:00', @cust6, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-27 00:00:00', @bk_332),
(UUID(), 'CONFIRMED', NULL, '2025-11-27 03:00:00', @bk_332),
(UUID(), 'CHECKED_IN', @recep5, '2025-12-08 13:00:00', @bk_332),
(UUID(), 'CHECKED_OUT', @recep5, '2025-12-09 09:00:00', @bk_332);

SET @bk_333 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_333, 'BK2512113613', '2025-12-11', '2025-12-12', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID955429', 2, 2, 1500000, 2250000.0, '2025-12-05 12:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-12-05 13:00:00', @cust8, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_333, @ser_breakfast, 1, 150000.0, 150000.0, '2025-12-05 12:00:00'),
(UUID(), @bk_333, @ser_airport, 3, 200000.0, 600000.0, '2025-12-05 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-05 12:00:00', @bk_333),
(UUID(), 'CONFIRMED', NULL, '2025-12-06 00:00:00', @bk_333),
(UUID(), 'CHECKED_IN', @recep6, '2025-12-11 13:00:00', @bk_333),
(UUID(), 'CHECKED_OUT', @recep6, '2025-12-12 10:00:00', @bk_333);

SET @bk_334 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_334, 'BK2512268028', '2025-12-26', '2026-01-01', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID986849', 3, 0, 9000000, 10400000.0, '2025-12-24 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-24 06:00:00', @cust9, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_334, @ser_spa, 2, 500000.0, 1000000.0, '2025-12-24 05:00:00'),
(UUID(), @bk_334, @ser_breakfast, 2, 150000.0, 300000.0, '2025-12-24 05:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_334, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-24 05:00:00', @bk_334),
(UUID(), 'CONFIRMED', NULL, '2025-12-24 08:00:00', @bk_334),
(UUID(), 'CHECKED_IN', @recep6, '2025-12-26 14:00:00', @bk_334),
(UUID(), 'CHECKED_OUT', @recep6, '2026-01-01 09:00:00', @bk_334);

SET @bk_335 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_335, 'BK2601105942', '2026-01-10', '2026-01-15', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID579463', 3, 1, 7500000, 7900000.0, '2025-12-29 04:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-29 05:00:00', @cust1, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_335, @ser_airport, 2, 200000.0, 400000.0, '2025-12-29 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-29 04:00:00', @bk_335),
(UUID(), 'CONFIRMED', NULL, '2025-12-29 22:00:00', @bk_335),
(UUID(), 'CHECKED_IN', @recep5, '2026-01-10 13:00:00', @bk_335),
(UUID(), 'CHECKED_OUT', @recep5, '2026-01-15 12:00:00', @bk_335);

SET @bk_336 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_336, 'BK2601217991', '2026-01-21', '2026-01-23', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID305829', 4, 1, 3000000, 4450000.0, '2026-01-18 21:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-18 22:00:00', @cust4, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_336, @ser_spa, 2, 500000.0, 1000000.0, '2026-01-18 21:00:00'),
(UUID(), @bk_336, @ser_breakfast, 3, 150000.0, 450000.0, '2026-01-18 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-18 21:00:00', @bk_336),
(UUID(), 'CONFIRMED', NULL, '2026-01-19 02:00:00', @bk_336),
(UUID(), 'CHECKED_IN', @recep6, '2026-01-21 15:00:00', @bk_336),
(UUID(), 'CHECKED_OUT', @recep6, '2026-01-23 11:00:00', @bk_336);

SET @bk_337 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_337, 'BK2601303094', '2026-01-30', '2026-02-05', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID199570', 4, 2, 9000000, 10900000.0, '2026-01-26 09:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-01-26 10:00:00', @cust1, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_337, @ser_spa, 3, 500000.0, 1500000.0, '2026-01-26 09:00:00'),
(UUID(), @bk_337, @ser_airport, 2, 200000.0, 400000.0, '2026-01-26 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-26 09:00:00', @bk_337),
(UUID(), 'CONFIRMED', NULL, '2026-01-26 18:00:00', @bk_337),
(UUID(), 'CHECKED_IN', @recep5, '2026-01-30 16:00:00', @bk_337),
(UUID(), 'CHECKED_OUT', @recep5, '2026-02-05 12:00:00', @bk_337);

SET @bk_338 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_338, 'BK2602137764', '2026-02-13', '2026-02-18', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID742950', 1, 1, 7500000, 8800000.0, '2026-01-31 11:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-01-31 12:00:00', @cust4, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_338, @ser_spa, 2, 500000.0, 1000000.0, '2026-01-31 11:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_338, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-31 11:00:00', @bk_338),
(UUID(), 'CONFIRMED', NULL, '2026-02-01 11:00:00', @bk_338),
(UUID(), 'CHECKED_IN', @recep1, '2026-02-13 13:00:00', @bk_338),
(UUID(), 'CHECKED_OUT', @recep1, '2026-02-18 12:00:00', @bk_338);

SET @bk_339 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_339, 'BK2602256172', '2026-02-25', '2026-02-28', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID180757', 3, 1, 4500000, 4500000, '2026-02-13 08:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-02-13 09:00:00', @cust3, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-13 08:00:00', @bk_339),
(UUID(), 'CONFIRMED', NULL, '2026-02-13 12:00:00', @bk_339),
(UUID(), 'CHECKED_IN', @recep9, '2026-02-25 12:00:00', @bk_339),
(UUID(), 'CHECKED_OUT', @recep9, '2026-02-28 10:00:00', @bk_339);

SET @bk_340 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_340, 'BK2603146540', '2026-03-14', '2026-03-19', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID831389', 1, 0, 7500000, 8500000.0, '2026-03-02 05:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-02 06:00:00', @cust1, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_340, @ser_spa, 2, 500000.0, 1000000.0, '2026-03-02 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-02 05:00:00', @bk_340),
(UUID(), 'CONFIRMED', NULL, '2026-03-02 17:00:00', @bk_340),
(UUID(), 'CHECKED_IN', @recep1, '2026-03-14 15:00:00', @bk_340),
(UUID(), 'CHECKED_OUT', @recep1, '2026-03-19 12:00:00', @bk_340);

SET @bk_341 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_341, 'BK2603218292', '2026-03-21', '2026-03-27', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID777486', 2, 1, 9000000, 9600000.0, '2026-03-12 06:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-03-12 07:00:00', @cust2, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_341, @ser_airport, 3, 200000.0, 600000.0, '2026-03-12 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-12 06:00:00', @bk_341),
(UUID(), 'CONFIRMED', NULL, '2026-03-12 18:00:00', @bk_341),
(UUID(), 'CHECKED_IN', @recep1, '2026-03-21 15:00:00', @bk_341),
(UUID(), 'CHECKED_OUT', @recep1, '2026-03-27 10:00:00', @bk_341);

SET @bk_342 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_342, 'BK2604111883', '2026-04-11', '2026-04-13', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID810389', 2, 0, 3000000, 3000000, '2026-04-07 21:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-04-07 22:00:00', @cust8, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-07 21:00:00', @bk_342),
(UUID(), 'CONFIRMED', NULL, '2026-04-07 23:00:00', @bk_342),
(UUID(), 'CHECKED_IN', @recep5, '2026-04-11 16:00:00', @bk_342),
(UUID(), 'CHECKED_OUT', @recep5, '2026-04-13 08:00:00', @bk_342);

SET @bk_343 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_343, 'BK2604205956', '2026-04-20', '2026-04-25', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID849638', 1, 2, 7500000, 7650000.0, '2026-04-14 06:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-04-14 07:00:00', @cust9, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_343, @ser_breakfast, 1, 150000.0, 150000.0, '2026-04-14 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-14 06:00:00', @bk_343),
(UUID(), 'CONFIRMED', NULL, '2026-04-14 12:00:00', @bk_343);

SET @bk_344 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_344, 'BK2604274587', '2026-04-27', '2026-04-30', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID250869', 4, 2, 4500000, 4500000, '2026-04-17 17:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-04-17 18:00:00', @cust9, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-17 17:00:00', @bk_344),
(UUID(), 'CONFIRMED', NULL, '2026-04-18 04:00:00', @bk_344);

SET @bk_345 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_345, 'BK2605021109', '2026-05-02', '2026-05-06', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID990192', 1, 0, 6000000, 7400000.0, '2026-04-22 06:00:00', 'PENDING', 'BANK_TRANSFER', 'UNPAID', NULL, @cust8, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_345, @ser_spa, 2, 500000.0, 1000000.0, '2026-04-22 06:00:00'),
(UUID(), @bk_345, @ser_airport, 2, 200000.0, 400000.0, '2026-04-22 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-22 06:00:00', @bk_345);

SET @bk_346 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_346, 'BK2605149022', '2026-05-14', '2026-05-18', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID817135', 4, 0, 6000000, 6000000, '2026-05-08 05:00:00', 'PENDING', 'CASH', 'UNPAID', NULL, @cust9, @room8);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-08 05:00:00', @bk_346);

SET @bk_347 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_347, 'BK2605269022', '2026-05-26', '2026-05-28', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID453543', 1, 1, 3000000, 3800000.0, '2026-05-19 18:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-05-19 19:00:00', @cust9, @room8);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_347, @ser_spa, 1, 500000.0, 500000.0, '2026-05-19 18:00:00'),
(UUID(), @bk_347, @ser_breakfast, 2, 150000.0, 300000.0, '2026-05-19 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-19 18:00:00', @bk_347),
(UUID(), 'CONFIRMED', NULL, '2026-05-20 03:00:00', @bk_347);

SET @bk_348 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_348, 'BK2501168744', '2025-01-16', '2025-01-19', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID278521', 3, 2, 4500000, 4950000.0, '2025-01-09 22:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-09 23:00:00', @cust6, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_348, @ser_breakfast, 3, 150000.0, 450000.0, '2025-01-09 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-09 22:00:00', @bk_348),
(UUID(), 'CONFIRMED', NULL, '2025-01-10 12:00:00', @bk_348),
(UUID(), 'CHECKED_IN', @recep2, '2025-01-16 14:00:00', @bk_348),
(UUID(), 'CHECKED_OUT', @recep2, '2025-01-19 09:00:00', @bk_348);

SET @bk_349 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_349, 'BK2501216053', '2025-01-21', '2025-01-25', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID403133', 3, 0, 6000000, 6300000, '2025-01-12 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-01-12 19:00:00', @cust2, @room9);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_349, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-12 18:00:00', @bk_349),
(UUID(), 'CONFIRMED', NULL, '2025-01-13 12:00:00', @bk_349),
(UUID(), 'CHECKED_IN', @recep1, '2025-01-21 16:00:00', @bk_349),
(UUID(), 'CHECKED_OUT', @recep1, '2025-01-25 11:00:00', @bk_349);

SET @bk_350 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_350, 'BK2501267424', '2025-01-26', '2025-01-28', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID151062', 2, 0, 3000000, 3000000, '2025-01-21 19:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-21 20:00:00', @cust3, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-21 19:00:00', @bk_350),
(UUID(), 'CONFIRMED', NULL, '2025-01-22 09:00:00', @bk_350),
(UUID(), 'CHECKED_IN', @recep10, '2025-01-26 16:00:00', @bk_350),
(UUID(), 'CHECKED_OUT', @recep10, '2025-01-28 08:00:00', @bk_350);

SET @bk_351 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_351, 'BK2502116281', '2025-02-11', '2025-02-12', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID198050', 3, 1, 1500000, 1500000, '2025-02-05 04:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-05 05:00:00', @cust4, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-05 04:00:00', @bk_351),
(UUID(), 'CONFIRMED', NULL, '2025-02-05 15:00:00', @bk_351),
(UUID(), 'CHECKED_IN', @recep3, '2025-02-11 13:00:00', @bk_351),
(UUID(), 'CHECKED_OUT', @recep3, '2025-02-12 11:00:00', @bk_351);

SET @bk_352 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_352, 'BK2502184122', '2025-02-18', '2025-02-24', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID198363', 4, 0, 9000000, 9300000.0, '2025-02-06 19:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-02-06 20:00:00', @cust4, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_352, @ser_breakfast, 2, 150000.0, 300000.0, '2025-02-06 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-06 19:00:00', @bk_352),
(UUID(), 'CONFIRMED', NULL, '2025-02-07 17:00:00', @bk_352),
(UUID(), 'CHECKED_IN', @recep7, '2025-02-18 12:00:00', @bk_352),
(UUID(), 'CHECKED_OUT', @recep7, '2025-02-24 12:00:00', @bk_352);

SET @bk_353 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_353, 'BK2502289349', '2025-02-28', '2025-03-01', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID765478', 2, 0, 1500000, 1500000, '2025-02-25 01:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-25 02:00:00', @cust8, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-25 01:00:00', @bk_353),
(UUID(), 'CONFIRMED', NULL, '2025-02-25 09:00:00', @bk_353),
(UUID(), 'CHECKED_IN', @recep1, '2025-02-28 13:00:00', @bk_353),
(UUID(), 'CHECKED_OUT', @recep1, '2025-03-01 11:00:00', @bk_353);

SET @bk_354 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_354, 'BK2503081061', '2025-03-08', '2025-03-09', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID824463', 1, 2, 1500000, 1500000, '2025-03-06 19:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-06 20:00:00', @cust6, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-06 19:00:00', @bk_354),
(UUID(), 'CONFIRMED', NULL, '2025-03-07 06:00:00', @bk_354),
(UUID(), 'CHECKED_IN', @recep9, '2025-03-08 14:00:00', @bk_354),
(UUID(), 'CHECKED_OUT', @recep9, '2025-03-09 10:00:00', @bk_354);

SET @bk_355 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_355, 'BK2503224586', '2025-03-22', '2025-03-26', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID426839', 1, 2, 6000000, 6000000, '2025-03-17 23:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-03-18 00:00:00', @cust1, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-17 23:00:00', @bk_355),
(UUID(), 'CONFIRMED', NULL, '2025-03-18 00:00:00', @bk_355),
(UUID(), 'CHECKED_IN', @recep1, '2025-03-22 13:00:00', @bk_355),
(UUID(), 'CHECKED_OUT', @recep1, '2025-03-26 09:00:00', @bk_355);

SET @bk_356 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_356, 'BK2503294330', '2025-03-29', '2025-03-30', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID481749', 4, 1, 1500000, 1500000, '2025-03-16 03:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-16 04:00:00', @cust9, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-16 03:00:00', @bk_356),
(UUID(), 'CONFIRMED', NULL, '2025-03-16 12:00:00', @bk_356),
(UUID(), 'CHECKED_IN', @recep9, '2025-03-29 13:00:00', @bk_356),
(UUID(), 'CHECKED_OUT', @recep9, '2025-03-30 11:00:00', @bk_356);

SET @bk_357 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_357, 'BK2504071384', '2025-04-07', '2025-04-12', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID323755', 4, 1, 7500000, 8500000.0, '2025-04-02 17:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-04-02 18:00:00', @cust2, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_357, @ser_spa, 2, 500000.0, 1000000.0, '2025-04-02 17:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-02 17:00:00', @bk_357),
(UUID(), 'CONFIRMED', NULL, '2025-04-03 14:00:00', @bk_357),
(UUID(), 'CHECKED_IN', @recep8, '2025-04-07 12:00:00', @bk_357),
(UUID(), 'CHECKED_OUT', @recep8, '2025-04-12 08:00:00', @bk_357);

SET @bk_358 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_358, 'BK2504245463', '2025-04-24', '2025-04-28', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID700447', 4, 0, 6000000, 7000000.0, '2025-04-09 21:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-04-09 22:00:00', @cust6, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_358, @ser_spa, 2, 500000.0, 1000000.0, '2025-04-09 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-09 21:00:00', @bk_358),
(UUID(), 'CONFIRMED', NULL, '2025-04-10 09:00:00', @bk_358),
(UUID(), 'CHECKED_IN', @recep6, '2025-04-24 14:00:00', @bk_358),
(UUID(), 'CHECKED_OUT', @recep6, '2025-04-28 10:00:00', @bk_358);

SET @bk_359 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_359, 'BK2505042829', '2025-05-04', '2025-05-05', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID981781', 2, 0, 1500000, 2950000.0, '2025-04-21 09:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-21 10:00:00', @cust7, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_359, @ser_spa, 2, 500000.0, 1000000.0, '2025-04-21 09:00:00'),
(UUID(), @bk_359, @ser_breakfast, 3, 150000.0, 450000.0, '2025-04-21 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-21 09:00:00', @bk_359),
(UUID(), 'CONFIRMED', NULL, '2025-04-22 02:00:00', @bk_359),
(UUID(), 'CHECKED_IN', @recep6, '2025-05-04 12:00:00', @bk_359),
(UUID(), 'CHECKED_OUT', @recep6, '2025-05-05 09:00:00', @bk_359);

SET @bk_360 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_360, 'BK2505094094', '2025-05-09', '2025-05-15', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID402753', 1, 2, 9000000, 10450000.0, '2025-05-04 15:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-05-04 16:00:00', @cust10, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_360, @ser_spa, 2, 500000.0, 1000000.0, '2025-05-04 15:00:00'),
(UUID(), @bk_360, @ser_breakfast, 3, 150000.0, 450000.0, '2025-05-04 15:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-04 15:00:00', @bk_360),
(UUID(), 'CONFIRMED', NULL, '2025-05-05 03:00:00', @bk_360),
(UUID(), 'CHECKED_IN', @recep10, '2025-05-09 14:00:00', @bk_360),
(UUID(), 'CHECKED_OUT', @recep10, '2025-05-15 09:00:00', @bk_360);

SET @bk_361 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_361, 'BK2505261629', '2025-05-26', '2025-05-27', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID254905', 1, 1, 1500000, 2500000.0, '2025-05-20 06:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-05-20 07:00:00', @cust7, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_361, @ser_spa, 2, 500000.0, 1000000.0, '2025-05-20 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-20 06:00:00', @bk_361),
(UUID(), 'CONFIRMED', NULL, '2025-05-20 08:00:00', @bk_361),
(UUID(), 'CHECKED_IN', @recep8, '2025-05-26 16:00:00', @bk_361),
(UUID(), 'CHECKED_OUT', @recep8, '2025-05-27 12:00:00', @bk_361);

SET @bk_362 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_362, 'BK2506086710', '2025-06-08', '2025-06-12', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID572125', 4, 1, 6000000, 7900000.0, '2025-05-28 09:00:00', 'CANCELLED', 'CASH', 'UNPAID', NULL, @cust9, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_362, @ser_spa, 3, 500000.0, 1500000.0, '2025-05-28 09:00:00'),
(UUID(), @bk_362, @ser_airport, 2, 200000.0, 400000.0, '2025-05-28 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-28 09:00:00', @bk_362),
(UUID(), 'CANCELLED', @recep10, '2025-05-29 02:00:00', @bk_362);

SET @bk_363 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_363, 'BK2506132956', '2025-06-13', '2025-06-17', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID333549', 1, 0, 6000000, 7900000.0, '2025-06-04 13:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-06-04 14:00:00', @cust5, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_363, @ser_airport, 2, 200000.0, 400000.0, '2025-06-04 13:00:00'),
(UUID(), @bk_363, @ser_spa, 3, 500000.0, 1500000.0, '2025-06-04 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-04 13:00:00', @bk_363),
(UUID(), 'CONFIRMED', NULL, '2025-06-05 10:00:00', @bk_363),
(UUID(), 'CHECKED_IN', @recep1, '2025-06-13 12:00:00', @bk_363),
(UUID(), 'CHECKED_OUT', @recep1, '2025-06-17 10:00:00', @bk_363);

SET @bk_364 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_364, 'BK2506189072', '2025-06-18', '2025-06-20', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID102805', 1, 1, 3000000, 4600000.0, '2025-06-10 04:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-06-10 05:00:00', @cust10, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_364, @ser_spa, 2, 500000.0, 1000000.0, '2025-06-10 04:00:00'),
(UUID(), @bk_364, @ser_airport, 3, 200000.0, 600000.0, '2025-06-10 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-10 04:00:00', @bk_364),
(UUID(), 'CONFIRMED', NULL, '2025-06-10 05:00:00', @bk_364),
(UUID(), 'CHECKED_IN', @recep9, '2025-06-18 16:00:00', @bk_364),
(UUID(), 'CHECKED_OUT', @recep9, '2025-06-20 10:00:00', @bk_364);

SET @bk_365 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_365, 'BK2506266194', '2025-06-26', '2025-07-01', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID853061', 1, 1, 7500000, 7500000, '2025-06-15 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-06-15 19:00:00', @cust1, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-15 18:00:00', @bk_365),
(UUID(), 'CONFIRMED', NULL, '2025-06-15 23:00:00', @bk_365),
(UUID(), 'CHECKED_IN', @recep1, '2025-06-26 12:00:00', @bk_365),
(UUID(), 'CHECKED_OUT', @recep1, '2025-07-01 09:00:00', @bk_365);

SET @bk_366 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_366, 'BK2507082515', '2025-07-08', '2025-07-10', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID889585', 4, 0, 3000000, 3000000, '2025-06-27 20:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-06-27 21:00:00', @cust6, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-27 20:00:00', @bk_366),
(UUID(), 'CONFIRMED', NULL, '2025-06-28 08:00:00', @bk_366),
(UUID(), 'CHECKED_IN', @recep2, '2025-07-08 16:00:00', @bk_366),
(UUID(), 'CHECKED_OUT', @recep2, '2025-07-10 08:00:00', @bk_366);

SET @bk_367 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_367, 'BK2507136489', '2025-07-13', '2025-07-15', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID216011', 2, 1, 3000000, 4800000.0, '2025-07-03 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-07-03 23:00:00', @cust8, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_367, @ser_spa, 3, 500000.0, 1500000.0, '2025-07-03 22:00:00'),
(UUID(), @bk_367, @ser_breakfast, 2, 150000.0, 300000.0, '2025-07-03 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-03 22:00:00', @bk_367),
(UUID(), 'CONFIRMED', NULL, '2025-07-04 13:00:00', @bk_367),
(UUID(), 'CHECKED_IN', @recep4, '2025-07-13 14:00:00', @bk_367),
(UUID(), 'CHECKED_OUT', @recep4, '2025-07-15 08:00:00', @bk_367);

SET @bk_368 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_368, 'BK2507279322', '2025-07-27', '2025-08-02', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID468717', 3, 0, 9000000, 11100000.0, '2025-07-16 19:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-07-16 20:00:00', @cust4, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_368, @ser_airport, 3, 200000.0, 600000.0, '2025-07-16 19:00:00'),
(UUID(), @bk_368, @ser_spa, 3, 500000.0, 1500000.0, '2025-07-16 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-16 19:00:00', @bk_368),
(UUID(), 'CONFIRMED', NULL, '2025-07-17 02:00:00', @bk_368),
(UUID(), 'CHECKED_IN', @recep3, '2025-07-27 14:00:00', @bk_368),
(UUID(), 'CHECKED_OUT', @recep3, '2025-08-02 09:00:00', @bk_368);

SET @bk_369 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_369, 'BK2508124764', '2025-08-12', '2025-08-15', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID683653', 2, 2, 4500000, 5150000.0, '2025-08-08 09:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-08-08 10:00:00', @cust9, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_369, @ser_breakfast, 1, 150000.0, 150000.0, '2025-08-08 09:00:00'),
(UUID(), @bk_369, @ser_spa, 1, 500000.0, 500000.0, '2025-08-08 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-08 09:00:00', @bk_369),
(UUID(), 'CONFIRMED', NULL, '2025-08-08 13:00:00', @bk_369),
(UUID(), 'CHECKED_IN', @recep4, '2025-08-12 12:00:00', @bk_369),
(UUID(), 'CHECKED_OUT', @recep4, '2025-08-15 11:00:00', @bk_369);

SET @bk_370 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_370, 'BK2508218860', '2025-08-21', '2025-08-22', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID781740', 1, 2, 1500000, 2400000.0, '2025-08-09 18:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-09 19:00:00', @cust4, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_370, @ser_breakfast, 2, 150000.0, 300000.0, '2025-08-09 18:00:00'),
(UUID(), @bk_370, @ser_airport, 3, 200000.0, 600000.0, '2025-08-09 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-09 18:00:00', @bk_370),
(UUID(), 'CONFIRMED', NULL, '2025-08-10 10:00:00', @bk_370),
(UUID(), 'CHECKED_IN', @recep8, '2025-08-21 14:00:00', @bk_370),
(UUID(), 'CHECKED_OUT', @recep8, '2025-08-22 11:00:00', @bk_370);

SET @bk_371 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_371, 'BK2509051817', '2025-09-05', '2025-09-08', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID504050', 1, 1, 4500000, 5000000.0, '2025-08-26 00:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-26 01:00:00', @cust8, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_371, @ser_airport, 1, 200000.0, 200000.0, '2025-08-26 00:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_371, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-26 00:00:00', @bk_371),
(UUID(), 'CONFIRMED', NULL, '2025-08-26 11:00:00', @bk_371),
(UUID(), 'CHECKED_IN', @recep7, '2025-09-05 12:00:00', @bk_371),
(UUID(), 'CHECKED_OUT', @recep7, '2025-09-08 08:00:00', @bk_371);

SET @bk_372 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_372, 'BK2509188442', '2025-09-18', '2025-09-20', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID737636', 1, 1, 3000000, 3200000, '2025-09-08 16:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-08 17:00:00', @cust5, @room9);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_372, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-08 16:00:00', @bk_372),
(UUID(), 'CONFIRMED', NULL, '2025-09-08 23:00:00', @bk_372),
(UUID(), 'CHECKED_IN', @recep6, '2025-09-18 12:00:00', @bk_372),
(UUID(), 'CHECKED_OUT', @recep6, '2025-09-20 10:00:00', @bk_372);

SET @bk_373 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_373, 'BK2510035527', '2025-10-03', '2025-10-09', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID980917', 4, 1, 9000000, 10800000.0, '2025-09-19 04:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-09-19 05:00:00', @cust7, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_373, @ser_spa, 3, 500000.0, 1500000.0, '2025-09-19 04:00:00'),
(UUID(), @bk_373, @ser_breakfast, 2, 150000.0, 300000.0, '2025-09-19 04:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-19 04:00:00', @bk_373),
(UUID(), 'CONFIRMED', NULL, '2025-09-20 03:00:00', @bk_373),
(UUID(), 'CHECKED_IN', @recep10, '2025-10-03 14:00:00', @bk_373),
(UUID(), 'CHECKED_OUT', @recep10, '2025-10-09 11:00:00', @bk_373);

SET @bk_374 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_374, 'BK2510137859', '2025-10-13', '2025-10-19', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID774167', 3, 0, 9000000, 9400000.0, '2025-09-30 07:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-30 08:00:00', @cust4, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_374, @ser_airport, 2, 200000.0, 400000.0, '2025-09-30 07:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-30 07:00:00', @bk_374),
(UUID(), 'CONFIRMED', NULL, '2025-09-30 22:00:00', @bk_374),
(UUID(), 'CHECKED_IN', @recep4, '2025-10-13 12:00:00', @bk_374),
(UUID(), 'CHECKED_OUT', @recep4, '2025-10-19 11:00:00', @bk_374);

SET @bk_375 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_375, 'BK2510236754', '2025-10-23', '2025-10-27', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID123411', 2, 2, 6000000, 6000000, '2025-10-20 18:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-10-20 19:00:00', @cust7, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-20 18:00:00', @bk_375),
(UUID(), 'CONFIRMED', NULL, '2025-10-20 23:00:00', @bk_375),
(UUID(), 'CHECKED_IN', @recep3, '2025-10-23 14:00:00', @bk_375),
(UUID(), 'CHECKED_OUT', @recep3, '2025-10-27 12:00:00', @bk_375);

SET @bk_376 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_376, 'BK2511019317', '2025-11-01', '2025-11-02', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID389842', 1, 2, 1500000, 1500000, '2025-10-22 21:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-10-22 22:00:00', @cust1, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-22 21:00:00', @bk_376),
(UUID(), 'CONFIRMED', NULL, '2025-10-23 17:00:00', @bk_376),
(UUID(), 'CHECKED_IN', @recep7, '2025-11-01 12:00:00', @bk_376),
(UUID(), 'CHECKED_OUT', @recep7, '2025-11-02 11:00:00', @bk_376);

SET @bk_377 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_377, 'BK2511093047', '2025-11-09', '2025-11-11', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID884554', 3, 1, 3000000, 3400000.0, '2025-11-05 00:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-05 01:00:00', @cust1, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_377, @ser_airport, 2, 200000.0, 400000.0, '2025-11-05 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-05 00:00:00', @bk_377),
(UUID(), 'CONFIRMED', NULL, '2025-11-05 13:00:00', @bk_377),
(UUID(), 'CHECKED_IN', @recep8, '2025-11-09 13:00:00', @bk_377),
(UUID(), 'CHECKED_OUT', @recep8, '2025-11-11 10:00:00', @bk_377);

SET @bk_378 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_378, 'BK2511145680', '2025-11-14', '2025-11-19', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID384443', 1, 1, 7500000, 8350000.0, '2025-11-06 11:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-11-06 12:00:00', @cust6, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_378, @ser_breakfast, 3, 150000.0, 450000.0, '2025-11-06 11:00:00'),
(UUID(), @bk_378, @ser_airport, 2, 200000.0, 400000.0, '2025-11-06 11:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-06 11:00:00', @bk_378),
(UUID(), 'CONFIRMED', NULL, '2025-11-06 12:00:00', @bk_378),
(UUID(), 'CHECKED_IN', @recep6, '2025-11-14 15:00:00', @bk_378),
(UUID(), 'CHECKED_OUT', @recep6, '2025-11-19 11:00:00', @bk_378);

SET @bk_379 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_379, 'BK2511257537', '2025-11-25', '2025-11-27', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID976796', 3, 2, 3000000, 3650000.0, '2025-11-22 10:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-22 11:00:00', @cust10, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_379, @ser_breakfast, 3, 150000.0, 450000.0, '2025-11-22 10:00:00'),
(UUID(), @bk_379, @ser_airport, 1, 200000.0, 200000.0, '2025-11-22 10:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-22 10:00:00', @bk_379),
(UUID(), 'CONFIRMED', NULL, '2025-11-23 05:00:00', @bk_379),
(UUID(), 'CHECKED_IN', @recep1, '2025-11-25 14:00:00', @bk_379),
(UUID(), 'CHECKED_OUT', @recep1, '2025-11-27 11:00:00', @bk_379);

SET @bk_380 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_380, 'BK2512077264', '2025-12-07', '2025-12-08', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID697799', 1, 2, 1500000, 3300000.0, '2025-11-23 15:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-11-23 16:00:00', @cust1, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_380, @ser_spa, 3, 500000.0, 1500000.0, '2025-11-23 15:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_380, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-23 15:00:00', @bk_380),
(UUID(), 'CONFIRMED', NULL, '2025-11-24 07:00:00', @bk_380),
(UUID(), 'CHECKED_IN', @recep1, '2025-12-07 12:00:00', @bk_380),
(UUID(), 'CHECKED_OUT', @recep1, '2025-12-08 10:00:00', @bk_380);

SET @bk_381 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_381, 'BK2512144183', '2025-12-14', '2025-12-16', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID296316', 1, 0, 3000000, 4400000.0, '2025-12-09 08:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-09 09:00:00', @cust8, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_381, @ser_airport, 2, 200000.0, 400000.0, '2025-12-09 08:00:00'),
(UUID(), @bk_381, @ser_spa, 2, 500000.0, 1000000.0, '2025-12-09 08:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-09 08:00:00', @bk_381),
(UUID(), 'CONFIRMED', NULL, '2025-12-09 18:00:00', @bk_381),
(UUID(), 'CHECKED_IN', @recep10, '2025-12-14 15:00:00', @bk_381),
(UUID(), 'CHECKED_OUT', @recep10, '2025-12-16 09:00:00', @bk_381);

SET @bk_382 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_382, 'BK2512197129', '2025-12-19', '2025-12-21', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID265302', 4, 1, 3000000, 3000000, '2025-12-13 00:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-13 01:00:00', @cust4, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-13 00:00:00', @bk_382),
(UUID(), 'CONFIRMED', NULL, '2025-12-13 06:00:00', @bk_382),
(UUID(), 'CHECKED_IN', @recep1, '2025-12-19 12:00:00', @bk_382),
(UUID(), 'CHECKED_OUT', @recep1, '2025-12-21 11:00:00', @bk_382);

SET @bk_383 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_383, 'BK2601047238', '2026-01-04', '2026-01-09', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID684258', 3, 1, 7500000, 8350000.0, '2025-12-31 04:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-31 05:00:00', @cust8, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_383, @ser_airport, 1, 200000.0, 200000.0, '2025-12-31 04:00:00'),
(UUID(), @bk_383, @ser_breakfast, 3, 150000.0, 450000.0, '2025-12-31 04:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_383, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-31 04:00:00', @bk_383),
(UUID(), 'CONFIRMED', NULL, '2025-12-31 06:00:00', @bk_383),
(UUID(), 'CHECKED_IN', @recep5, '2026-01-04 15:00:00', @bk_383),
(UUID(), 'CHECKED_OUT', @recep5, '2026-01-09 10:00:00', @bk_383);

SET @bk_384 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_384, 'BK2601105575', '2026-01-10', '2026-01-12', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID453566', 2, 1, 3000000, 3000000, '2025-12-27 10:00:00', 'CANCELLED', 'CREDIT_CARD', 'UNPAID', NULL, @cust6, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-27 10:00:00', @bk_384),
(UUID(), 'CANCELLED', @recep3, '2025-12-27 17:00:00', @bk_384);

SET @bk_385 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_385, 'BK2601199800', '2026-01-19', '2026-01-21', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID181011', 1, 2, 3000000, 3900000.0, '2026-01-08 06:00:00', 'CANCELLED', 'CASH', 'UNPAID', NULL, @cust5, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_385, @ser_airport, 3, 200000.0, 600000.0, '2026-01-08 06:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_385, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-08 06:00:00', @bk_385),
(UUID(), 'CANCELLED', @recep7, '2026-01-08 15:00:00', @bk_385);

SET @bk_386 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_386, 'BK2601283474', '2026-01-28', '2026-02-02', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID288096', 4, 1, 7500000, 8650000.0, '2026-01-19 13:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-01-19 14:00:00', @cust9, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_386, @ser_breakfast, 1, 150000.0, 150000.0, '2026-01-19 13:00:00'),
(UUID(), @bk_386, @ser_spa, 2, 500000.0, 1000000.0, '2026-01-19 13:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-19 13:00:00', @bk_386),
(UUID(), 'CONFIRMED', NULL, '2026-01-20 12:00:00', @bk_386),
(UUID(), 'CHECKED_IN', @recep3, '2026-01-28 16:00:00', @bk_386),
(UUID(), 'CHECKED_OUT', @recep3, '2026-02-02 09:00:00', @bk_386);

SET @bk_387 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_387, 'BK2602101492', '2026-02-10', '2026-02-13', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID264644', 3, 2, 4500000, 6000000.0, '2026-02-01 08:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-01 09:00:00', @cust3, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_387, @ser_spa, 3, 500000.0, 1500000.0, '2026-02-01 08:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-01 08:00:00', @bk_387),
(UUID(), 'CONFIRMED', NULL, '2026-02-01 17:00:00', @bk_387),
(UUID(), 'CHECKED_IN', @recep10, '2026-02-10 16:00:00', @bk_387),
(UUID(), 'CHECKED_OUT', @recep10, '2026-02-13 12:00:00', @bk_387);

SET @bk_388 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_388, 'BK2602212958', '2026-02-21', '2026-02-24', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID759950', 4, 2, 4500000, 6000000.0, '2026-02-18 22:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-02-18 23:00:00', @cust9, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_388, @ser_spa, 3, 500000.0, 1500000.0, '2026-02-18 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-18 22:00:00', @bk_388),
(UUID(), 'CONFIRMED', NULL, '2026-02-19 04:00:00', @bk_388),
(UUID(), 'CHECKED_IN', @recep8, '2026-02-21 16:00:00', @bk_388),
(UUID(), 'CHECKED_OUT', @recep8, '2026-02-24 11:00:00', @bk_388);

SET @bk_389 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_389, 'BK2603098036', '2026-03-09', '2026-03-14', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID707076', 1, 0, 7500000, 8050000.0, '2026-02-28 18:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-02-28 19:00:00', @cust6, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_389, @ser_airport, 1, 200000.0, 200000.0, '2026-02-28 18:00:00'),
(UUID(), @bk_389, @ser_breakfast, 1, 150000.0, 150000.0, '2026-02-28 18:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_389, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-28 18:00:00', @bk_389),
(UUID(), 'CONFIRMED', NULL, '2026-03-01 16:00:00', @bk_389),
(UUID(), 'CHECKED_IN', @recep10, '2026-03-09 13:00:00', @bk_389),
(UUID(), 'CHECKED_OUT', @recep10, '2026-03-14 09:00:00', @bk_389);

SET @bk_390 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_390, 'BK2603267338', '2026-03-26', '2026-03-29', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID918634', 4, 2, 4500000, 4700000.0, '2026-03-21 12:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-21 13:00:00', @cust3, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_390, @ser_airport, 1, 200000.0, 200000.0, '2026-03-21 12:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-21 12:00:00', @bk_390),
(UUID(), 'CONFIRMED', NULL, '2026-03-22 12:00:00', @bk_390),
(UUID(), 'CHECKED_IN', @recep6, '2026-03-26 15:00:00', @bk_390),
(UUID(), 'CHECKED_OUT', @recep6, '2026-03-29 12:00:00', @bk_390);

SET @bk_391 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_391, 'BK2604064945', '2026-04-06', '2026-04-10', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID145078', 1, 0, 6000000, 7350000.0, '2026-04-04 13:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-04-04 14:00:00', @cust3, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_391, @ser_breakfast, 3, 150000.0, 450000.0, '2026-04-04 13:00:00'),
(UUID(), @bk_391, @ser_airport, 2, 200000.0, 400000.0, '2026-04-04 13:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_391, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-04 13:00:00', @bk_391),
(UUID(), 'CONFIRMED', NULL, '2026-04-05 03:00:00', @bk_391),
(UUID(), 'CHECKED_IN', @recep8, '2026-04-06 14:00:00', @bk_391),
(UUID(), 'CHECKED_OUT', @recep8, '2026-04-10 11:00:00', @bk_391);

SET @bk_392 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_392, 'BK2604144875', '2026-04-14', '2026-04-18', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID302660', 1, 1, 6000000, 6450000.0, '2026-03-31 19:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-03-31 20:00:00', @cust2, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_392, @ser_breakfast, 3, 150000.0, 450000.0, '2026-03-31 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-31 19:00:00', @bk_392),
(UUID(), 'CONFIRMED', NULL, '2026-04-01 04:00:00', @bk_392);

SET @bk_393 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_393, 'BK2604242372', '2026-04-24', '2026-04-27', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID243277', 3, 2, 4500000, 6100000.0, '2026-04-20 06:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-04-20 07:00:00', @cust2, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_393, @ser_spa, 2, 500000.0, 1000000.0, '2026-04-20 06:00:00'),
(UUID(), @bk_393, @ser_airport, 3, 200000.0, 600000.0, '2026-04-20 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-20 06:00:00', @bk_393),
(UUID(), 'CONFIRMED', NULL, '2026-04-20 15:00:00', @bk_393);

SET @bk_394 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_394, 'BK2605034300', '2026-05-03', '2026-05-04', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID975989', 2, 2, 1500000, 3450000.0, '2026-04-24 17:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-24 18:00:00', @cust9, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_394, @ser_spa, 2, 500000.0, 1000000.0, '2026-04-24 17:00:00'),
(UUID(), @bk_394, @ser_breakfast, 3, 150000.0, 450000.0, '2026-04-24 17:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_394, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-24 17:00:00', @bk_394),
(UUID(), 'CONFIRMED', NULL, '2026-04-24 23:00:00', @bk_394);

SET @bk_395 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_395, 'BK2605112953', '2026-05-11', '2026-05-12', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID505573', 4, 1, 1500000, 2000000.0, '2026-04-27 03:00:00', 'PENDING', 'CREDIT_CARD', 'UNPAID', NULL, @cust9, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_395, @ser_spa, 1, 500000.0, 500000.0, '2026-04-27 03:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-27 03:00:00', @bk_395);

SET @bk_396 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_396, 'BK2605163312', '2026-05-16', '2026-05-17', 'Cust7 Doe', '0900001007', 'customer7@gmail.com', 'ID663232', 2, 0, 1500000, 2000000.0, '2026-05-09 01:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-05-09 02:00:00', @cust7, @room9);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_396, @ser_spa, 1, 500000.0, 500000.0, '2026-05-09 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-09 01:00:00', @bk_396),
(UUID(), 'CONFIRMED', NULL, '2026-05-09 17:00:00', @bk_396);

SET @bk_397 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_397, 'BK2605258774', '2026-05-25', '2026-05-29', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID886039', 2, 1, 6000000, 6000000, '2026-05-21 10:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-05-21 11:00:00', @cust6, @room9);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-21 10:00:00', @bk_397),
(UUID(), 'CONFIRMED', NULL, '2026-05-21 11:00:00', @bk_397);

SET @bk_398 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_398, 'BK2501039432', '2025-01-03', '2025-01-06', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID961148', 3, 1, 4500000, 4850000.0, '2024-12-23 21:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2024-12-23 22:00:00', @cust1, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_398, @ser_breakfast, 1, 150000.0, 150000.0, '2024-12-23 21:00:00'),
(UUID(), @bk_398, @ser_airport, 1, 200000.0, 200000.0, '2024-12-23 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2024-12-23 21:00:00', @bk_398),
(UUID(), 'CONFIRMED', NULL, '2024-12-24 04:00:00', @bk_398),
(UUID(), 'CHECKED_IN', @recep7, '2025-01-03 15:00:00', @bk_398),
(UUID(), 'CHECKED_OUT', @recep7, '2025-01-06 08:00:00', @bk_398);

SET @bk_399 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_399, 'BK2501091867', '2025-01-09', '2025-01-14', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID978669', 2, 1, 7500000, 7700000, '2025-01-04 01:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-01-04 02:00:00', @cust1, @room10);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_399, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-04 01:00:00', @bk_399),
(UUID(), 'CONFIRMED', NULL, '2025-01-04 02:00:00', @bk_399),
(UUID(), 'CHECKED_IN', @recep9, '2025-01-09 12:00:00', @bk_399),
(UUID(), 'CHECKED_OUT', @recep9, '2025-01-14 10:00:00', @bk_399);

SET @bk_400 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_400, 'BK2501206364', '2025-01-20', '2025-01-21', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID361640', 3, 1, 1500000, 3100000.0, '2025-01-11 22:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-01-11 23:00:00', @cust8, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_400, @ser_airport, 3, 200000.0, 600000.0, '2025-01-11 22:00:00'),
(UUID(), @bk_400, @ser_spa, 2, 500000.0, 1000000.0, '2025-01-11 22:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-11 22:00:00', @bk_400),
(UUID(), 'CONFIRMED', NULL, '2025-01-11 23:00:00', @bk_400),
(UUID(), 'CHECKED_IN', @recep2, '2025-01-20 16:00:00', @bk_400),
(UUID(), 'CHECKED_OUT', @recep2, '2025-01-21 11:00:00', @bk_400);

SET @bk_401 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_401, 'BK2501304558', '2025-01-30', '2025-02-01', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID530345', 3, 1, 3000000, 3450000.0, '2025-01-21 16:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-01-21 17:00:00', @cust9, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_401, @ser_breakfast, 3, 150000.0, 450000.0, '2025-01-21 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-21 16:00:00', @bk_401),
(UUID(), 'CONFIRMED', NULL, '2025-01-22 12:00:00', @bk_401),
(UUID(), 'CHECKED_IN', @recep3, '2025-01-30 14:00:00', @bk_401),
(UUID(), 'CHECKED_OUT', @recep3, '2025-02-01 09:00:00', @bk_401);

SET @bk_402 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_402, 'BK2502035318', '2025-02-03', '2025-02-06', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID849470', 3, 1, 4500000, 4500000, '2025-01-27 01:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-01-27 02:00:00', @cust8, @room10);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-01-27 01:00:00', @bk_402),
(UUID(), 'CONFIRMED', NULL, '2025-01-27 08:00:00', @bk_402),
(UUID(), 'CHECKED_IN', @recep10, '2025-02-03 15:00:00', @bk_402),
(UUID(), 'CHECKED_OUT', @recep10, '2025-02-06 12:00:00', @bk_402);

SET @bk_403 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_403, 'BK2502109779', '2025-02-10', '2025-02-16', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID790393', 1, 1, 9000000, 9150000.0, '2025-02-07 06:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-02-07 07:00:00', @cust5, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_403, @ser_breakfast, 1, 150000.0, 150000.0, '2025-02-07 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-07 06:00:00', @bk_403),
(UUID(), 'CONFIRMED', NULL, '2025-02-08 05:00:00', @bk_403),
(UUID(), 'CHECKED_IN', @recep10, '2025-02-10 12:00:00', @bk_403),
(UUID(), 'CHECKED_OUT', @recep10, '2025-02-16 10:00:00', @bk_403);

SET @bk_404 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_404, 'BK2502281417', '2025-02-28', '2025-03-06', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID228627', 4, 1, 9000000, 9200000, '2025-02-14 12:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-02-14 13:00:00', @cust5, @room10);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_404, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-02-14 12:00:00', @bk_404),
(UUID(), 'CONFIRMED', NULL, '2025-02-14 22:00:00', @bk_404),
(UUID(), 'CHECKED_IN', @recep3, '2025-02-28 13:00:00', @bk_404),
(UUID(), 'CHECKED_OUT', @recep3, '2025-03-06 09:00:00', @bk_404);

SET @bk_405 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_405, 'BK2503177753', '2025-03-17', '2025-03-23', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID273826', 1, 0, 9000000, 9000000, '2025-03-02 16:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-03-02 17:00:00', @cust2, @room10);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-02 16:00:00', @bk_405),
(UUID(), 'CONFIRMED', NULL, '2025-03-03 06:00:00', @bk_405),
(UUID(), 'CHECKED_IN', @recep10, '2025-03-17 15:00:00', @bk_405),
(UUID(), 'CHECKED_OUT', @recep10, '2025-03-23 11:00:00', @bk_405);

SET @bk_406 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_406, 'BK2504053729', '2025-04-05', '2025-04-10', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID711856', 1, 0, 7500000, 7950000.0, '2025-03-30 06:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-03-30 07:00:00', @cust10, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_406, @ser_breakfast, 3, 150000.0, 450000.0, '2025-03-30 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-03-30 06:00:00', @bk_406),
(UUID(), 'CONFIRMED', NULL, '2025-03-31 00:00:00', @bk_406),
(UUID(), 'CHECKED_IN', @recep9, '2025-04-05 12:00:00', @bk_406),
(UUID(), 'CHECKED_OUT', @recep9, '2025-04-10 09:00:00', @bk_406);

SET @bk_407 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_407, 'BK2504152881', '2025-04-15', '2025-04-21', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID906749', 3, 2, 9000000, 11400000.0, '2025-04-06 19:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-04-06 20:00:00', @cust9, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_407, @ser_spa, 3, 500000.0, 1500000.0, '2025-04-06 19:00:00'),
(UUID(), @bk_407, @ser_airport, 3, 200000.0, 600000.0, '2025-04-06 19:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_407, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-06 19:00:00', @bk_407),
(UUID(), 'CONFIRMED', NULL, '2025-04-07 15:00:00', @bk_407),
(UUID(), 'CHECKED_IN', @recep3, '2025-04-15 13:00:00', @bk_407),
(UUID(), 'CHECKED_OUT', @recep3, '2025-04-21 10:00:00', @bk_407);

SET @bk_408 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_408, 'BK2505049851', '2025-05-04', '2025-05-09', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID705518', 2, 0, 7500000, 8000000, '2025-04-25 08:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-04-25 09:00:00', @cust4, @room10);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_408, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-04-25 08:00:00', @bk_408),
(UUID(), 'CONFIRMED', NULL, '2025-04-25 20:00:00', @bk_408),
(UUID(), 'CHECKED_IN', @recep5, '2025-05-04 13:00:00', @bk_408),
(UUID(), 'CHECKED_OUT', @recep5, '2025-05-09 09:00:00', @bk_408);

SET @bk_409 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_409, 'BK2505143239', '2025-05-14', '2025-05-17', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID874244', 2, 0, 4500000, 4950000.0, '2025-05-01 19:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-05-01 20:00:00', @cust8, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_409, @ser_breakfast, 3, 150000.0, 450000.0, '2025-05-01 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-01 19:00:00', @bk_409),
(UUID(), 'CONFIRMED', NULL, '2025-05-02 06:00:00', @bk_409),
(UUID(), 'CHECKED_IN', @recep8, '2025-05-14 16:00:00', @bk_409),
(UUID(), 'CHECKED_OUT', @recep8, '2025-05-17 10:00:00', @bk_409);

SET @bk_410 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_410, 'BK2505317329', '2025-05-31', '2025-06-06', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID158487', 4, 2, 9000000, 9000000, '2025-05-16 04:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-05-16 05:00:00', @cust1, @room10);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-05-16 04:00:00', @bk_410),
(UUID(), 'CONFIRMED', NULL, '2025-05-17 03:00:00', @bk_410),
(UUID(), 'CHECKED_IN', @recep2, '2025-05-31 12:00:00', @bk_410),
(UUID(), 'CHECKED_OUT', @recep2, '2025-06-06 12:00:00', @bk_410);

SET @bk_411 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_411, 'BK2506195257', '2025-06-19', '2025-06-23', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID575308', 2, 0, 6000000, 7000000.0, '2025-06-11 03:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-06-11 04:00:00', @cust9, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_411, @ser_breakfast, 2, 150000.0, 300000.0, '2025-06-11 03:00:00'),
(UUID(), @bk_411, @ser_spa, 1, 500000.0, 500000.0, '2025-06-11 03:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_411, 200000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-11 03:00:00', @bk_411),
(UUID(), 'CONFIRMED', NULL, '2025-06-11 17:00:00', @bk_411),
(UUID(), 'CHECKED_IN', @recep8, '2025-06-19 13:00:00', @bk_411),
(UUID(), 'CHECKED_OUT', @recep8, '2025-06-23 11:00:00', @bk_411);

SET @bk_412 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_412, 'BK2507032898', '2025-07-03', '2025-07-04', 'Cust9 Doe', '0900001009', 'customer9@gmail.com', 'ID452534', 3, 0, 1500000, 2650000.0, '2025-06-25 09:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-06-25 10:00:00', @cust9, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_412, @ser_breakfast, 1, 150000.0, 150000.0, '2025-06-25 09:00:00'),
(UUID(), @bk_412, @ser_spa, 2, 500000.0, 1000000.0, '2025-06-25 09:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-25 09:00:00', @bk_412),
(UUID(), 'CONFIRMED', NULL, '2025-06-26 08:00:00', @bk_412),
(UUID(), 'CHECKED_IN', @recep8, '2025-07-03 14:00:00', @bk_412),
(UUID(), 'CHECKED_OUT', @recep8, '2025-07-04 09:00:00', @bk_412);

SET @bk_413 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_413, 'BK2507129918', '2025-07-12', '2025-07-15', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID724093', 1, 1, 4500000, 4700000.0, '2025-06-30 23:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-07-01 00:00:00', @cust4, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_413, @ser_airport, 1, 200000.0, 200000.0, '2025-06-30 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-06-30 23:00:00', @bk_413),
(UUID(), 'CONFIRMED', NULL, '2025-07-01 01:00:00', @bk_413),
(UUID(), 'CHECKED_IN', @recep9, '2025-07-12 12:00:00', @bk_413),
(UUID(), 'CHECKED_OUT', @recep9, '2025-07-15 10:00:00', @bk_413);

SET @bk_414 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_414, 'BK2507188330', '2025-07-18', '2025-07-23', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID130334', 3, 0, 7500000, 7500000, '2025-07-15 02:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-07-15 03:00:00', @cust6, @room10);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-15 02:00:00', @bk_414),
(UUID(), 'CONFIRMED', NULL, '2025-07-15 05:00:00', @bk_414),
(UUID(), 'CHECKED_IN', @recep8, '2025-07-18 12:00:00', @bk_414),
(UUID(), 'CHECKED_OUT', @recep8, '2025-07-23 12:00:00', @bk_414);

SET @bk_415 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_415, 'BK2507283613', '2025-07-28', '2025-08-01', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID748736', 4, 0, 6000000, 6700000.0, '2025-07-20 16:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-07-20 17:00:00', @cust2, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_415, @ser_airport, 2, 200000.0, 400000.0, '2025-07-20 16:00:00'),
(UUID(), @bk_415, @ser_breakfast, 2, 150000.0, 300000.0, '2025-07-20 16:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-07-20 16:00:00', @bk_415),
(UUID(), 'CONFIRMED', NULL, '2025-07-21 10:00:00', @bk_415),
(UUID(), 'CHECKED_IN', @recep10, '2025-07-28 14:00:00', @bk_415),
(UUID(), 'CHECKED_OUT', @recep10, '2025-08-01 10:00:00', @bk_415);

SET @bk_416 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_416, 'BK2508155632', '2025-08-15', '2025-08-17', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID953121', 3, 2, 3000000, 4200000.0, '2025-08-11 11:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-11 12:00:00', @cust2, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_416, @ser_breakfast, 2, 150000.0, 300000.0, '2025-08-11 11:00:00'),
(UUID(), @bk_416, @ser_airport, 3, 200000.0, 600000.0, '2025-08-11 11:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_416, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-11 11:00:00', @bk_416),
(UUID(), 'CONFIRMED', NULL, '2025-08-12 07:00:00', @bk_416),
(UUID(), 'CHECKED_IN', @recep7, '2025-08-15 13:00:00', @bk_416),
(UUID(), 'CHECKED_OUT', @recep7, '2025-08-17 11:00:00', @bk_416);

SET @bk_417 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_417, 'BK2508228990', '2025-08-22', '2025-08-25', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID184339', 2, 0, 4500000, 6150000.0, '2025-08-13 03:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-08-13 04:00:00', @cust5, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_417, @ser_breakfast, 1, 150000.0, 150000.0, '2025-08-13 03:00:00'),
(UUID(), @bk_417, @ser_spa, 3, 500000.0, 1500000.0, '2025-08-13 03:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-13 03:00:00', @bk_417),
(UUID(), 'CONFIRMED', NULL, '2025-08-13 22:00:00', @bk_417),
(UUID(), 'CHECKED_IN', @recep6, '2025-08-22 16:00:00', @bk_417),
(UUID(), 'CHECKED_OUT', @recep6, '2025-08-25 09:00:00', @bk_417);

SET @bk_418 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_418, 'BK2508296032', '2025-08-29', '2025-08-31', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID874266', 2, 2, 3000000, 3500000, '2025-08-19 12:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-19 13:00:00', @cust8, @room10);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_418, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-19 12:00:00', @bk_418),
(UUID(), 'CONFIRMED', NULL, '2025-08-20 07:00:00', @bk_418),
(UUID(), 'CHECKED_IN', @recep2, '2025-08-29 14:00:00', @bk_418),
(UUID(), 'CHECKED_OUT', @recep2, '2025-08-31 08:00:00', @bk_418);

SET @bk_419 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_419, 'BK2509124581', '2025-09-12', '2025-09-18', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID333444', 2, 2, 9000000, 9100000, '2025-08-28 06:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-08-28 07:00:00', @cust5, @room10);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_419, 100000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-08-28 06:00:00', @bk_419),
(UUID(), 'CONFIRMED', NULL, '2025-08-28 11:00:00', @bk_419),
(UUID(), 'CHECKED_IN', @recep2, '2025-09-12 14:00:00', @bk_419),
(UUID(), 'CHECKED_OUT', @recep2, '2025-09-18 08:00:00', @bk_419);

SET @bk_420 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_420, 'BK2510014692', '2025-10-01', '2025-10-07', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID660444', 1, 2, 9000000, 9500000, '2025-09-27 20:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-09-27 21:00:00', @cust3, @room10);
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_420, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-09-27 20:00:00', @bk_420),
(UUID(), 'CONFIRMED', NULL, '2025-09-28 11:00:00', @bk_420),
(UUID(), 'CHECKED_IN', @recep8, '2025-10-01 16:00:00', @bk_420),
(UUID(), 'CHECKED_OUT', @recep8, '2025-10-07 09:00:00', @bk_420);

SET @bk_421 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_421, 'BK2510197358', '2025-10-19', '2025-10-22', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID738573', 1, 0, 4500000, 5150000.0, '2025-10-15 16:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-10-15 17:00:00', @cust8, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_421, @ser_breakfast, 1, 150000.0, 150000.0, '2025-10-15 16:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_421, 500000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-15 16:00:00', @bk_421),
(UUID(), 'CONFIRMED', NULL, '2025-10-15 22:00:00', @bk_421),
(UUID(), 'CHECKED_IN', @recep8, '2025-10-19 15:00:00', @bk_421),
(UUID(), 'CHECKED_OUT', @recep8, '2025-10-22 09:00:00', @bk_421);

SET @bk_422 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_422, 'BK2510303185', '2025-10-30', '2025-11-01', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID388268', 2, 1, 3000000, 3000000, '2025-10-15 01:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2025-10-15 02:00:00', @cust1, @room10);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-15 01:00:00', @bk_422),
(UUID(), 'CONFIRMED', NULL, '2025-10-15 22:00:00', @bk_422),
(UUID(), 'CHECKED_IN', @recep8, '2025-10-30 16:00:00', @bk_422),
(UUID(), 'CHECKED_OUT', @recep8, '2025-11-01 11:00:00', @bk_422);

SET @bk_423 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_423, 'BK2511112931', '2025-11-11', '2025-11-15', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID235579', 1, 2, 6000000, 7500000.0, '2025-10-27 05:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-10-27 06:00:00', @cust8, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_423, @ser_spa, 3, 500000.0, 1500000.0, '2025-10-27 05:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-10-27 05:00:00', @bk_423),
(UUID(), 'CONFIRMED', NULL, '2025-10-27 12:00:00', @bk_423),
(UUID(), 'CHECKED_IN', @recep2, '2025-11-11 12:00:00', @bk_423),
(UUID(), 'CHECKED_OUT', @recep2, '2025-11-15 10:00:00', @bk_423);

SET @bk_424 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_424, 'BK2511288744', '2025-11-28', '2025-12-02', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID507664', 2, 1, 6000000, 6500000.0, '2025-11-21 23:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-11-22 00:00:00', @cust6, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_424, @ser_spa, 1, 500000.0, 500000.0, '2025-11-21 23:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-21 23:00:00', @bk_424),
(UUID(), 'CONFIRMED', NULL, '2025-11-22 05:00:00', @bk_424),
(UUID(), 'CHECKED_IN', @recep1, '2025-11-28 16:00:00', @bk_424),
(UUID(), 'CHECKED_OUT', @recep1, '2025-12-02 08:00:00', @bk_424);

SET @bk_425 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_425, 'BK2512077830', '2025-12-07', '2025-12-08', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID297864', 4, 0, 1500000, 1500000, '2025-11-29 20:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-11-29 21:00:00', @cust6, @room10);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-29 20:00:00', @bk_425),
(UUID(), 'CONFIRMED', NULL, '2025-11-30 04:00:00', @bk_425),
(UUID(), 'CHECKED_IN', @recep3, '2025-12-07 15:00:00', @bk_425),
(UUID(), 'CHECKED_OUT', @recep3, '2025-12-08 09:00:00', @bk_425);

SET @bk_426 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_426, 'BK2512131570', '2025-12-13', '2025-12-14', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID163394', 4, 0, 1500000, 3200000.0, '2025-11-28 02:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-11-28 03:00:00', @cust10, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_426, @ser_airport, 1, 200000.0, 200000.0, '2025-11-28 02:00:00'),
(UUID(), @bk_426, @ser_spa, 3, 500000.0, 1500000.0, '2025-11-28 02:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-11-28 02:00:00', @bk_426),
(UUID(), 'CONFIRMED', NULL, '2025-11-28 07:00:00', @bk_426),
(UUID(), 'CHECKED_IN', @recep6, '2025-12-13 16:00:00', @bk_426),
(UUID(), 'CHECKED_OUT', @recep6, '2025-12-14 08:00:00', @bk_426);

SET @bk_427 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_427, 'BK2512154665', '2025-12-15', '2025-12-21', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID876813', 1, 2, 9000000, 9150000.0, '2025-12-02 02:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2025-12-02 03:00:00', @cust1, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_427, @ser_breakfast, 1, 150000.0, 150000.0, '2025-12-02 02:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-02 02:00:00', @bk_427),
(UUID(), 'CONFIRMED', NULL, '2025-12-02 12:00:00', @bk_427),
(UUID(), 'CHECKED_IN', @recep7, '2025-12-15 12:00:00', @bk_427),
(UUID(), 'CHECKED_OUT', @recep7, '2025-12-21 08:00:00', @bk_427);

SET @bk_428 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_428, 'BK2601016596', '2026-01-01', '2026-01-03', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID156136', 1, 1, 3000000, 3850000.0, '2025-12-30 01:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2025-12-30 02:00:00', @cust8, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_428, @ser_airport, 2, 200000.0, 400000.0, '2025-12-30 01:00:00'),
(UUID(), @bk_428, @ser_breakfast, 1, 150000.0, 150000.0, '2025-12-30 01:00:00');
INSERT INTO extras (extra_id, booking_id, amount, note) VALUES (UUID(), @bk_428, 300000, 'Late check-out or damage fee');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2025-12-30 01:00:00', @bk_428),
(UUID(), 'CONFIRMED', NULL, '2025-12-30 07:00:00', @bk_428),
(UUID(), 'CHECKED_IN', @recep7, '2026-01-01 16:00:00', @bk_428),
(UUID(), 'CHECKED_OUT', @recep7, '2026-01-03 09:00:00', @bk_428);

SET @bk_429 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_429, 'BK2601129217', '2026-01-12', '2026-01-16', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID368442', 1, 2, 6000000, 6750000.0, '2026-01-02 20:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-01-02 21:00:00', @cust3, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_429, @ser_airport, 3, 200000.0, 600000.0, '2026-01-02 20:00:00'),
(UUID(), @bk_429, @ser_breakfast, 1, 150000.0, 150000.0, '2026-01-02 20:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-02 20:00:00', @bk_429),
(UUID(), 'CONFIRMED', NULL, '2026-01-02 23:00:00', @bk_429),
(UUID(), 'CHECKED_IN', @recep7, '2026-01-12 13:00:00', @bk_429),
(UUID(), 'CHECKED_OUT', @recep7, '2026-01-16 08:00:00', @bk_429);

SET @bk_430 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_430, 'BK2601288654', '2026-01-28', '2026-02-01', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID688454', 3, 0, 6000000, 7000000.0, '2026-01-23 11:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-01-23 12:00:00', @cust8, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_430, @ser_spa, 2, 500000.0, 1000000.0, '2026-01-23 11:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-01-23 11:00:00', @bk_430),
(UUID(), 'CONFIRMED', NULL, '2026-01-23 16:00:00', @bk_430),
(UUID(), 'CHECKED_IN', @recep3, '2026-01-28 14:00:00', @bk_430),
(UUID(), 'CHECKED_OUT', @recep3, '2026-02-01 11:00:00', @bk_430);

SET @bk_431 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_431, 'BK2602153888', '2026-02-15', '2026-02-18', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID802354', 2, 0, 4500000, 6000000.0, '2026-02-11 01:00:00', 'CHECKED_OUT', 'CASH', 'PAID', '2026-02-11 02:00:00', @cust2, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_431, @ser_spa, 3, 500000.0, 1500000.0, '2026-02-11 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-11 01:00:00', @bk_431),
(UUID(), 'CONFIRMED', NULL, '2026-02-11 18:00:00', @bk_431),
(UUID(), 'CHECKED_IN', @recep7, '2026-02-15 12:00:00', @bk_431),
(UUID(), 'CHECKED_OUT', @recep7, '2026-02-18 09:00:00', @bk_431);

SET @bk_432 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_432, 'BK2602196761', '2026-02-19', '2026-02-23', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID588588', 3, 0, 6000000, 6000000, '2026-02-09 06:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-02-09 07:00:00', @cust5, @room10);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-09 06:00:00', @bk_432),
(UUID(), 'CONFIRMED', NULL, '2026-02-09 17:00:00', @bk_432),
(UUID(), 'CHECKED_IN', @recep10, '2026-02-19 16:00:00', @bk_432),
(UUID(), 'CHECKED_OUT', @recep10, '2026-02-23 08:00:00', @bk_432);

SET @bk_433 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_433, 'BK2603049178', '2026-03-04', '2026-03-06', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID286616', 3, 1, 3000000, 4300000.0, '2026-02-26 19:00:00', 'CHECKED_OUT', 'BANK_TRANSFER', 'PAID', '2026-02-26 20:00:00', @cust1, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_433, @ser_breakfast, 2, 150000.0, 300000.0, '2026-02-26 19:00:00'),
(UUID(), @bk_433, @ser_spa, 2, 500000.0, 1000000.0, '2026-02-26 19:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-26 19:00:00', @bk_433),
(UUID(), 'CONFIRMED', NULL, '2026-02-27 07:00:00', @bk_433),
(UUID(), 'CHECKED_IN', @recep5, '2026-03-04 14:00:00', @bk_433),
(UUID(), 'CHECKED_OUT', @recep5, '2026-03-06 11:00:00', @bk_433);

SET @bk_434 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_434, 'BK2603076267', '2026-03-07', '2026-03-11', 'Cust6 Doe', '0900001006', 'customer6@gmail.com', 'ID901612', 4, 1, 6000000, 6800000.0, '2026-02-26 06:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-02-26 07:00:00', @cust6, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_434, @ser_breakfast, 2, 150000.0, 300000.0, '2026-02-26 06:00:00'),
(UUID(), @bk_434, @ser_spa, 1, 500000.0, 500000.0, '2026-02-26 06:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-02-26 06:00:00', @bk_434),
(UUID(), 'CONFIRMED', NULL, '2026-02-26 16:00:00', @bk_434),
(UUID(), 'CHECKED_IN', @recep10, '2026-03-07 16:00:00', @bk_434),
(UUID(), 'CHECKED_OUT', @recep10, '2026-03-11 12:00:00', @bk_434);

SET @bk_435 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_435, 'BK2603146966', '2026-03-14', '2026-03-16', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID852332', 3, 1, 3000000, 3450000.0, '2026-03-10 00:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-10 01:00:00', @cust1, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_435, @ser_breakfast, 3, 150000.0, 450000.0, '2026-03-10 00:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-10 00:00:00', @bk_435),
(UUID(), 'CONFIRMED', NULL, '2026-03-10 16:00:00', @bk_435),
(UUID(), 'CHECKED_IN', @recep9, '2026-03-14 12:00:00', @bk_435),
(UUID(), 'CHECKED_OUT', @recep9, '2026-03-16 10:00:00', @bk_435);

SET @bk_436 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_436, 'BK2603307007', '2026-03-30', '2026-04-03', 'Cust10 Doe', '0900001010', 'customer10@gmail.com', 'ID146970', 3, 0, 6000000, 6650000.0, '2026-03-21 07:00:00', 'CANCELLED', 'BANK_TRANSFER', 'UNPAID', NULL, @cust10, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_436, @ser_breakfast, 1, 150000.0, 150000.0, '2026-03-21 07:00:00'),
(UUID(), @bk_436, @ser_spa, 1, 500000.0, 500000.0, '2026-03-21 07:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-21 07:00:00', @bk_436),
(UUID(), 'CANCELLED', @recep2, '2026-03-21 11:00:00', @bk_436);

SET @bk_437 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_437, 'BK2604064762', '2026-04-06', '2026-04-11', 'Cust5 Doe', '0900001005', 'customer5@gmail.com', 'ID878050', 4, 1, 7500000, 7500000, '2026-03-26 22:00:00', 'CHECKED_OUT', 'CREDIT_CARD', 'PAID', '2026-03-26 23:00:00', @cust5, @room10);
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-03-26 22:00:00', @bk_437),
(UUID(), 'CONFIRMED', NULL, '2026-03-27 02:00:00', @bk_437),
(UUID(), 'CHECKED_IN', @recep10, '2026-04-06 15:00:00', @bk_437),
(UUID(), 'CHECKED_OUT', @recep10, '2026-04-11 09:00:00', @bk_437);

SET @bk_438 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_438, 'BK2604233114', '2026-04-23', '2026-04-27', 'Cust1 Doe', '0900001001', 'customer1@gmail.com', 'ID806052', 3, 0, 6000000, 6150000.0, '2026-04-20 14:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-04-20 15:00:00', @cust1, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_438, @ser_breakfast, 1, 150000.0, 150000.0, '2026-04-20 14:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-20 14:00:00', @bk_438),
(UUID(), 'CONFIRMED', NULL, '2026-04-21 10:00:00', @bk_438);

SET @bk_439 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_439, 'BK2605016542', '2026-05-01', '2026-05-06', 'Cust2 Doe', '0900001002', 'customer2@gmail.com', 'ID129431', 1, 0, 7500000, 8300000.0, '2026-04-18 11:00:00', 'CONFIRMED', 'BANK_TRANSFER', 'PAID', '2026-04-18 12:00:00', @cust2, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_439, @ser_breakfast, 2, 150000.0, 300000.0, '2026-04-18 11:00:00'),
(UUID(), @bk_439, @ser_spa, 1, 500000.0, 500000.0, '2026-04-18 11:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-04-18 11:00:00', @bk_439),
(UUID(), 'CONFIRMED', NULL, '2026-04-19 09:00:00', @bk_439);

SET @bk_440 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_440, 'BK2605104985', '2026-05-10', '2026-05-15', 'Cust3 Doe', '0900001003', 'customer3@gmail.com', 'ID916684', 3, 2, 7500000, 8500000.0, '2026-05-05 01:00:00', 'CONFIRMED', 'CREDIT_CARD', 'PAID', '2026-05-05 02:00:00', @cust3, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_440, @ser_spa, 2, 500000.0, 1000000.0, '2026-05-05 01:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-05 01:00:00', @bk_440),
(UUID(), 'CONFIRMED', NULL, '2026-05-05 18:00:00', @bk_440);

SET @bk_441 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_441, 'BK2605168738', '2026-05-16', '2026-05-18', 'Cust4 Doe', '0900001004', 'customer4@gmail.com', 'ID249496', 1, 2, 3000000, 3300000.0, '2026-05-09 21:00:00', 'PENDING', 'BANK_TRANSFER', 'UNPAID', NULL, @cust4, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_441, @ser_breakfast, 2, 150000.0, 300000.0, '2026-05-09 21:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-09 21:00:00', @bk_441);

SET @bk_442 = UUID();
INSERT INTO bookings (booking_id, booking_code, check_in_date, check_out_date, guest_name, guest_phone, guest_email, identity_card, adults, children, room_price, total_price, created_at, booking_status, payment_method, payment_status, paid_at, user_id, room_id) VALUES (@bk_442, 'BK2605303572', '2026-05-30', '2026-06-04', 'Cust8 Doe', '0900001008', 'customer8@gmail.com', 'ID589751', 2, 1, 7500000, 8400000.0, '2026-05-26 18:00:00', 'CONFIRMED', 'CASH', 'PAID', '2026-05-26 19:00:00', @cust8, @room10);
INSERT INTO booking_services (booking_service_id, booking_id, service_id, quantity, unit_price, total_price, created_at) VALUES
(UUID(), @bk_442, @ser_breakfast, 2, 150000.0, 300000.0, '2026-05-26 18:00:00'),
(UUID(), @bk_442, @ser_airport, 3, 200000.0, 600000.0, '2026-05-26 18:00:00');
INSERT INTO booking_status_histories (booking_status_history_id, status, changed_by, changed_at, booking_id) VALUES
(UUID(), 'PENDING', NULL, '2026-05-26 18:00:00', @bk_442),
(UUID(), 'CONFIRMED', NULL, '2026-05-27 13:00:00', @bk_442);

SET FOREIGN_KEY_CHECKS = 1;
