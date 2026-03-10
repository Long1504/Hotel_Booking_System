USE hotel_booking_system;

-- =========================
-- ROLES
-- =========================
INSERT INTO roles (role_id, role_name) VALUES
('r1', 'ADMIN'),
('r2', 'RECEPTIONIST'),
('r3', 'CUSTOMER');

-- =========================
-- USERS (10)
-- =========================
INSERT INTO users VALUES
('u1','user1','123456','Nguyen','An','MALE','user1@email.com','0900000001','ACTIVE',NOW(),NULL),
('u2','user2','123456','Tran','Binh','MALE','user2@email.com','0900000002','ACTIVE',NOW(),NULL),
('u3','user3','123456','Le','Chi','FEMALE','user3@email.com','0900000003','ACTIVE',NOW(),NULL),
('u4','user4','123456','Pham','Dung','FEMALE','user4@email.com','0900000004','ACTIVE',NOW(),NULL),
('u5','user5','123456','Hoang','Giang','FEMALE','user5@email.com','0900000005','ACTIVE',NOW(),NULL),
('u6','user6','123456','Vu','Hung','MALE','user6@email.com','0900000006','ACTIVE',NOW(),NULL),
('u7','user7','123456','Do','Khanh','MALE','user7@email.com','0900000007','ACTIVE',NOW(),NULL),
('u8','user8','123456','Bui','Linh','FEMALE','user8@email.com','0900000008','ACTIVE',NOW(),NULL),
('u9','user9','123456','Dang','Minh','MALE','user9@email.com','0900000009','ACTIVE',NOW(),NULL),
('u10','user10','123456','Ngo','Phuong','FEMALE','user10@email.com','0900000010','ACTIVE',NOW(),NULL);

-- =========================
-- ROLES_USERS
-- =========================
INSERT INTO roles_users VALUES
('r3','u1'),
('r3','u2'),
('r3','u3'),
('r3','u4'),
('r3','u5'),
('r3','u6'),
('r3','u7'),
('r3','u8'),
('r3','u9'),
('r3','u10');

-- =========================
-- ROOM TYPES (3)
-- =========================
INSERT INTO room_types VALUES
('rt1','Standard','Basic room for 2 people',NULL),
('rt2','Deluxe','Bigger room with better interior',NULL),
('rt3','Suite','Luxury suite room',NULL);

-- =========================
-- VIEWS (3)
-- =========================
INSERT INTO views VALUES
('v1','City View','View of the city',NULL),
('v2','Sea View','View of the ocean',NULL),
('v3','Garden View','View of the garden',NULL);

-- =========================
-- AMENITIES (10)
-- =========================
INSERT INTO amenities VALUES
('a1','Wifi','High speed internet',NULL),
('a2','Air Conditioner','Cooling system',NULL),
('a3','TV','Smart television',NULL),
('a4','Mini Bar','Mini refrigerator',NULL),
('a5','Bathtub','Luxury bathtub',NULL),
('a6','Balcony','Private balcony',NULL),
('a7','Coffee Maker','Coffee machine',NULL),
('a8','Hair Dryer','Hair dryer',NULL),
('a9','Safe','Electronic safe',NULL),
('a10','Work Desk','Working desk',NULL);

-- =========================
-- ROOMS (10)
-- =========================
INSERT INTO rooms VALUES
('room1','Standard Room 1','101',1,800000,2,1,25,'Comfortable standard room','AVAILABLE',NULL,'rt1','v1'),
('room2','Standard Room 2','102',1,800000,2,1,25,'Comfortable standard room','AVAILABLE',NULL,'rt1','v3'),
('room3','Standard Room 3','103',1,850000,2,1,27,'Standard room with balcony','AVAILABLE',NULL,'rt1','v1'),
('room4','Deluxe Room 1','201',2,1200000,2,2,35,'Deluxe city view room','AVAILABLE',NULL,'rt2','v1'),
('room5','Deluxe Room 2','202',2,1300000,2,2,38,'Deluxe garden view','AVAILABLE',NULL,'rt2','v3'),
('room6','Deluxe Room 3','203',2,1400000,3,2,40,'Deluxe sea view','AVAILABLE',NULL,'rt2','v2'),
('room7','Suite Room 1','301',3,2000000,3,2,50,'Luxury suite room','AVAILABLE',NULL,'rt3','v2'),
('room8','Suite Room 2','302',3,2100000,3,2,52,'Luxury sea suite','AVAILABLE',NULL,'rt3','v2'),
('room9','Suite Room 3','303',3,1900000,3,2,48,'Suite garden view','AVAILABLE',NULL,'rt3','v3'),
('room10','Suite Room 4','304',3,2200000,4,2,60,'Presidential suite','AVAILABLE',NULL,'rt3','v2');

-- =========================
-- ROOM AMENITIES
-- =========================
INSERT INTO rooms_amenities VALUES
('room1','a1'),('room1','a2'),('room1','a3'),
('room2','a1'),('room2','a2'),('room2','a3'),
('room3','a1'),('room3','a2'),('room3','a6'),
('room4','a1'),('room4','a2'),('room4','a4'),('room4','a10'),
('room5','a1'),('room5','a2'),('room5','a4'),('room5','a6'),
('room6','a1'),('room6','a2'),('room6','a4'),('room6','a7'),
('room7','a1'),('room7','a2'),('room7','a4'),('room7','a5'),('room7','a6'),
('room8','a1'),('room8','a2'),('room8','a4'),('room8','a5'),('room8','a7'),
('room9','a1'),('room9','a2'),('room9','a5'),
('room10','a1'),('room10','a2'),('room10','a4'),('room10','a5'),('room10','a6');

-- =========================
-- ROOM IMAGES
-- =========================
INSERT INTO room_images VALUES
('img1','/images/room1.jpg',TRUE,'room1'),
('img2','/images/room2.jpg',TRUE,'room2'),
('img3','/images/room3.jpg',TRUE,'room3'),
('img4','/images/room4.jpg',TRUE,'room4'),
('img5','/images/room5.jpg',TRUE,'room5'),
('img6','/images/room6.jpg',TRUE,'room6'),
('img7','/images/room7.jpg',TRUE,'room7'),
('img8','/images/room8.jpg',TRUE,'room8'),
('img9','/images/room9.jpg',TRUE,'room9'),
('img10','/images/room10.jpg',TRUE,'room10');