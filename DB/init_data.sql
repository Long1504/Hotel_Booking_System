USE hotel_booking_system;

SET FOREIGN_KEY_CHECKS = 0;

-- ======================
-- USERS (10)
-- ======================

INSERT INTO users (user_id, username, password, first_name, last_name, gender, email, phone)
VALUES
(UUID(),'user1','123456','John','Doe','MALE','user1@gmail.com','0900000001'),
(UUID(),'user2','123456','Jane','Smith','FEMALE','user2@gmail.com','0900000002'),
(UUID(),'user3','123456','Mike','Brown','MALE','user3@gmail.com','0900000003'),
(UUID(),'user4','123456','Anna','White','FEMALE','user4@gmail.com','0900000004'),
(UUID(),'user5','123456','David','Lee','MALE','user5@gmail.com','0900000005'),
(UUID(),'user6','123456','Emma','Taylor','FEMALE','user6@gmail.com','0900000006'),
(UUID(),'user7','123456','Chris','Wilson','MALE','user7@gmail.com','0900000007'),
(UUID(),'user8','123456','Sophia','Clark','FEMALE','user8@gmail.com','0900000008'),
(UUID(),'user9','123456','Daniel','Hall','MALE','user9@gmail.com','0900000009'),
(UUID(),'user10','123456','Olivia','Allen','FEMALE','user10@gmail.com','0900000010');

-- ======================
-- VIEWS (3)
-- ======================

INSERT INTO views (view_id, view_name, description)
VALUES
(UUID(),'Sea View','Ocean view'),
(UUID(),'City View','City skyline'),
(UUID(),'Garden View','Garden landscape');

-- ======================
-- ROOM TYPES (3)
-- ======================

INSERT INTO room_types (room_type_id, room_type_name, description)
VALUES
(UUID(),'Standard Room','Standard room'),
(UUID(),'Deluxe Room','Deluxe room'),
(UUID(),'Suite Room','Luxury suite');

-- ======================
-- AMENITIES (10)
-- ======================

INSERT INTO amenities (amenity_id, amenity_name, description)
VALUES
(UUID(),'Wifi','Free wifi'),
(UUID(),'Air Conditioner','AC'),
(UUID(),'Television','Smart TV'),
(UUID(),'Mini Bar','Mini fridge'),
(UUID(),'Balcony','Balcony'),
(UUID(),'Bathtub','Bathtub'),
(UUID(),'Hair Dryer','Hair dryer'),
(UUID(),'Safe Box','Safety box'),
(UUID(),'Coffee Maker','Coffee maker'),
(UUID(),'Work Desk','Work desk');

-- ======================
-- GET FK IDS
-- ======================

SET @view_sea = (SELECT view_id FROM views WHERE view_name='Sea View');
SET @view_city = (SELECT view_id FROM views WHERE view_name='City View');
SET @view_garden = (SELECT view_id FROM views WHERE view_name='Garden View');

SET @type_standard = (SELECT room_type_id FROM room_types WHERE room_type_name='Standard Room');
SET @type_deluxe = (SELECT room_type_id FROM room_types WHERE room_type_name='Deluxe Room');
SET @type_suite = (SELECT room_type_id FROM room_types WHERE room_type_name='Suite Room');

-- ======================
-- ROOMS (10)
-- ======================

INSERT INTO rooms (room_id, room_name, room_number, floor, base_price, max_adults, max_children, area, description, room_type_id, view_id)
VALUES
(UUID(),'Standard Room 101','101',1,50,2,1,25,'Standard room',@type_standard,@view_city),
(UUID(),'Standard Room 102','102',1,50,2,1,25,'Standard room',@type_standard,@view_garden),
(UUID(),'Standard Room 103','103',1,50,2,1,25,'Standard room',@type_standard,@view_city),
(UUID(),'Deluxe Room 201','201',2,80,3,1,35,'Deluxe room',@type_deluxe,@view_sea),
(UUID(),'Deluxe Room 202','202',2,80,3,1,35,'Deluxe room',@type_deluxe,@view_sea),
(UUID(),'Deluxe Room 203','203',2,80,3,1,35,'Deluxe room',@type_deluxe,@view_city),
(UUID(),'Suite Room 301','301',3,150,4,2,50,'Suite room',@type_suite,@view_sea),
(UUID(),'Suite Room 302','302',3,150,4,2,50,'Suite room',@type_suite,@view_sea),
(UUID(),'Suite Room 303','303',3,150,4,2,50,'Suite room',@type_suite,@view_garden),
(UUID(),'Suite Room 304','304',3,150,4,2,50,'Suite room',@type_suite,@view_city);

-- ======================
-- ROOM IMAGES
-- 1 MAIN + 5 SUB / ROOM
-- ======================

-- MAIN IMAGE

INSERT INTO room_images (room_image_id,image_url,is_main,room_id)
SELECT UUID(), CONCAT('/images/rooms/',room_number,'_main.jpg'), TRUE, room_id
FROM rooms;

-- SUB IMAGES

INSERT INTO room_images (room_image_id,image_url,is_main,room_id)
SELECT UUID(), CONCAT('/images/rooms/',room_number,'_1.jpg'), FALSE, room_id
FROM rooms;

INSERT INTO room_images (room_image_id,image_url,is_main,room_id)
SELECT UUID(), CONCAT('/images/rooms/',room_number,'_2.jpg'), FALSE, room_id
FROM rooms;

INSERT INTO room_images (room_image_id,image_url,is_main,room_id)
SELECT UUID(), CONCAT('/images/rooms/',room_number,'_3.jpg'), FALSE, room_id
FROM rooms;

INSERT INTO room_images (room_image_id,image_url,is_main,room_id)
SELECT UUID(), CONCAT('/images/rooms/',room_number,'_4.jpg'), FALSE, room_id
FROM rooms;

INSERT INTO room_images (room_image_id,image_url,is_main,room_id)
SELECT UUID(), CONCAT('/images/rooms/',room_number,'_5.jpg'), FALSE, room_id
FROM rooms;

SET FOREIGN_KEY_CHECKS = 1;
