# 🏨 Hotel Booking System

A comprehensive hotel booking management system that supports customers, receptionists, and administrators. The system is designed to streamline booking operations, improve customer experience, and optimize hotel management processes.

---

## 📌 Project Overview

This project is developed based on Software Requirements Specification (SRS) standards, aiming to provide a complete solution for hotel booking and management.

The system supports three main roles:
- 👤 Customer: Search and book rooms online  
- 🧑‍💼 Receptionist: Manage bookings and assist customers  
- 🛠️ Administrator: Manage system data and monitor performance  

The platform ensures:
- Role-based access control
- User-friendly interface
- Efficient booking workflow
- Secure data handling

---

## ✨ Features

👤 Customer:
- Register / Login
- Manage personal information
- Change password
- View room list
- Filter rooms (date, type, view, capacity)
- View room details
- Book room
- Cancel booking
- View booking history

🧑‍💼 Receptionist:
- Login
- View available rooms
- Create bookings for customers
- Manage booking list
- Update booking status:
  - Pending
  - Confirmed
  - Check-in
  - Check-out
  - Cancelled
- Manage services used
- Manage extra charges
- Create and handle payments

🛠️ Administrator:
- Login
- Manage customer accounts
- Manage receptionist accounts
- Manage room categories
- Manage room views
- Manage amenities
- Manage rooms
- Manage services
- Manage holiday pricing rules
- View reports and statistics

---

## 🏗️ System Architecture

```text
Frontend (HTML, CSS, JavaScript)
    ↓
Backend (Spring Boot)
    ↓
Database (MySQL)
```

---

## 🧰 Tech Stack

Frontend:
- HTML5, CSS3
- JavaScript
- Bootstrap
- ApexCharts

Backend:
- Java Spring Boot
- Spring Security
- JPA / Hibernate

Database:
- MySQL

---

## 🗄️ Database Overview
Main entities:
- Users
- Roles
- Rooms
- Room Types
- Views
- Amenities
- Bookings
- Services
- Booking Services
- Extras (additional charges)
- Payments
- Price Rules (holidays)

---

## ⚙️ Setup Guide

### 1. Clone Repository
```bash
git clone https://github.com/Long1504/Hotel_Booking_System.git
cd hotel-booking-system
```

### 2. Setup Database
Import SQL file at data/hotel_booking_schema.sql

### 3. Configure Backend
Edit application.properties:
```bash
spring.datasource.url=jdbc:mysql://localhost:3306/hotel_booking_system
spring.datasource.username=root
spring.datasource.password=your_password

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

### 4. Run Backend
```bash
mvn spring-boot:run
```
Backend runs at: http://localhost:8080

### 5. Run Frontend
Open index.html
or
Use Live Server (VS Code)

---

## ▶️ Usage
Customer Flow
Register / Login
Search rooms
View details
Book room
Track booking history
Receptionist Flow
Login
View available rooms
Create booking
Update booking status
Manage services & payments
Admin Flow
Login
Manage system data
Monitor reports & statistics

---

## 🌐 Live Demo

Customer: https://hotel-booking-system-end-user.vercel.app/

Receptionist: https://hotel-booking-system-receptionist.vercel.app/

Admin: https://hotel-booking-system-aruze-admin.vercel.app/

---

## 📦 Deployment
Frontend: Vercel
Backend: Render
Database: Railway