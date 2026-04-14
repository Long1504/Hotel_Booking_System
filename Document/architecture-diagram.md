# System Architecture Diagram – Hotel Booking System

## 1. Overview

Architecture Diagram dưới đây mô tả chi tiết cách các thành phần của hệ thống **Hotel Booking System** tương tác với nhau.

Hệ thống được thiết kế theo kiến trúc **multi-layer architecture**, bao gồm:

- Client Layer
- Frontend Layer
- API Layer
- Business Logic Layer
- Data Access Layer
- Data Storage Layer

Kiến trúc này giúp hệ thống:

- dễ bảo trì
- dễ mở rộng
- tách biệt rõ ràng các thành phần

---

# 2. High Level System Architecture

```mermaid
flowchart LR

User["User Browser"]

subgraph Client Layer
Browser["Web Browser"]
end

subgraph Frontend Layer
HTML["HTML Pages"]
CSS["CSS / Bootstrap"]
JS["JavaScript"]
Assets["Static Assets\nImages / CSS / JS"]
end

subgraph API Layer
API["REST API\nSpring Boot Controllers"]
end

subgraph Business Logic Layer
RoomService["Room Service"]
BookingService["Booking Service"]
UserService["User Service"]
end

subgraph Data Access Layer
RoomRepo["Room Repository"]
BookingRepo["Booking Repository"]
UserRepo["User Repository"]
end

subgraph Storage Layer
DB[(MySQL Database)]
ImageStorage["Room Images\n/public/images/rooms"]
end

User --> Browser
Browser --> HTML
HTML --> CSS
HTML --> JS
JS --> API

API --> RoomService
API --> BookingService
API --> UserService

RoomService --> RoomRepo
BookingService --> BookingRepo
UserService --> UserRepo

RoomRepo --> DB
BookingRepo --> DB
UserRepo --> DB

HTML --> ImageStorage
```

---

# 3. Backend Internal Architecture

Backend sử dụng **Spring Boot Layered Architecture**.

```mermaid
flowchart TB

Client["Frontend (HTML/JS)"]

subgraph SpringBootApplication
Controller["Controller Layer\nREST Endpoints"]
Service["Service Layer\nBusiness Logic"]
Repository["Repository Layer\nSpring Data JPA"]
end

Database[(MySQL Database)]

Client --> Controller
Controller --> Service
Service --> Repository
Repository --> Database
Database --> Repository
Repository --> Service
Service --> Controller
Controller --> Client
```

---

# 4. Component Architecture

Sơ đồ dưới đây mô tả chi tiết các component chính trong hệ thống.

```mermaid
flowchart TB

User["User"]

subgraph Frontend
Home["Home Page"]
RoomList["Room List Page"]
RoomDetail["Room Detail Page"]
BookingPage["Booking Page"]
end

subgraph Backend
RoomController["RoomController"]
BookingController["BookingController"]

RoomService["RoomService"]
BookingService["BookingService"]

RoomRepository["RoomRepository"]
BookingRepository["BookingRepository"]
end

subgraph Database
RoomsTable[(Rooms Table)]
BookingsTable[(Bookings Table)]
UsersTable[(Users Table)]
end

User --> Home
Home --> RoomList
RoomList --> RoomDetail
RoomDetail --> BookingPage

RoomList --> RoomController
RoomDetail --> RoomController
BookingPage --> BookingController

RoomController --> RoomService
BookingController --> BookingService

RoomService --> RoomRepository
BookingService --> BookingRepository

RoomRepository --> RoomsTable
BookingRepository --> BookingsTable
BookingRepository --> UsersTable
```

---

# 5. Deployment Architecture

Deployment diagram mô tả cách hệ thống được triển khai trong môi trường runtime.

```mermaid
flowchart LR

User["User Browser"]

subgraph ClientMachine
Browser["Chrome / Firefox / Edge"]
end

subgraph WebServer
Frontend["HTML / CSS / JavaScript"]
end

subgraph ApplicationServer
SpringBoot["Spring Boot Application"]
end

subgraph DatabaseServer
MySQL[(MySQL Database)]
end

subgraph FileStorage
Images["Room Images Storage\n/public/images/rooms"]
end

User --> Browser
Browser --> Frontend
Frontend --> SpringBoot
SpringBoot --> MySQL
SpringBoot --> Images
MySQL --> SpringBoot
SpringBoot --> Frontend
Frontend --> Browser
```

---

# 6. Detailed Request Flow

Luồng xử lý request khi user truy cập danh sách phòng.

```mermaid
sequenceDiagram

participant User
participant Browser
participant Frontend
participant API
participant Service
participant Repository
participant Database

User->>Browser: Open website
Browser->>Frontend: Load HTML/CSS/JS

Frontend->>API: GET /api/rooms
API->>Service: getAllRooms()

Service->>Repository: findAllRooms()

Repository->>Database: SELECT * FROM rooms
Database-->>Repository: return rooms

Repository-->>Service: rooms list
Service-->>API: room data
API-->>Frontend: JSON response

Frontend-->>Browser: Render room list
Browser-->>User: Display rooms
```

---

# 7. Booking Process Flow

Luồng đặt phòng của hệ thống.

```mermaid
sequenceDiagram

participant User
participant Frontend
participant Backend
participant Database

User->>Frontend: Select room and booking date

Frontend->>Backend: POST /api/bookings

Backend->>Database: Validate room availability
Database-->>Backend: Room available

Backend->>Database: INSERT booking
Database-->>Backend: Success

Backend-->>Frontend: Booking confirmation
Frontend-->>User: Show booking success message
```

---

# 8. Scalability Considerations

Trong tương lai, hệ thống có thể mở rộng thêm:

- Load Balancer
- API Gateway
- Microservices
- Cloud Storage cho ảnh
- Redis caching
- Authentication Server

Ví dụ kiến trúc mở rộng:

```
User
 ↓
Load Balancer
 ↓
Spring Boot API Cluster
 ↓
MySQL Cluster
```
