# Hotel-Reservation-Analytics
An end-to-end MySQL business analytics project for StayPoint Hospitality that models relational database architecture, executes exploratory data analysis, and delivers actionable insights on booking demand, guest behavior, stay fulfillment, staff utilization, and operational bottlenecks across properties.
# 🏨 Hotel Reservation Operations Analytics

An end-to-end MySQL Business Analytics project analyzing hotel reservation operations, guest behavior, stay outcomes, and resource utilization for **StayPoint Hospitality**.

---

## 📌 Project Overview
StayPoint Hospitality operates multiple hotel properties offering diverse room types, managed by front-desk and housekeeping personnel. This project empowers the **Operations** and **Guest Experience** teams by transitioning raw transactional data into data-driven insights. 

Using **MySQL**, the project covers everything from database schema design and data modeling to exploratory data analysis (EDA) and complex objective-based business queries.

---

## 🏗️ Database Schema & ER Diagram
The relational database consists of **6 core tables** interconnected via primary and foreign keys:

* **`hotels`**: Stores property details (City, Star Rating, Total Rooms, Opened Date).
* **`rooms`**: Tracks individual room specifications (Room Type, Floor Number, Max Occupancy, Price per Night).
* **`guests`**: Maintains customer profiles (City, Guest Type, Loyalty Tier, Account Creation Date).
* **`staff`**: Records employee data (Department, Hire Date, Rating, Active Status).
* **`bookings`**: Captures reservation transactions (Booking Date, Room Type Requested, Booking Channel, Total Amount).
* **`stays`**: Logs fulfillment outcomes (Check-in/Out Dates, Status, Nights Stayed, Service Requests, Duration in Hours).

### **Entity-Relationship (ER) Diagram**
![ER Diagram](docs/ER_Diagram.png)

---

## 📂 Dataset Overview
| Table Name | Description | Approximate Rows | Columns |
| :--- | :--- | :--- | :--- |
| **`guests`** | Customer demographic and loyalty information | 350 | 7 |
| **`hotels`** | Property locations and ratings | 25 | 6 |
| **`rooms`** | Room inventory, pricing, and capacities | 600 | 7 |
| **`bookings`** | Customer reservation records | 2,800 | 8 |
| **`stays`** | Check-in, check-out, and stay fulfillment details | 3,200 | 10 |
| **`staff`** | Employee details and performance ratings | 70 | 6 |

---

## 🚀 Project Sprints & Execution

### **Sprint 1: Business & Data Understanding**
* Interpreted the ER diagram to map out table dependencies and foreign key relationships.
* Formulated logical workflows for multi-table analytical scenarios (e.g., identifying repeat guests, tracking booking channel revenue, correlating room capacity with service requests).

### **Sprint 2: Database Setup & Data Import**
* Designed and executed DDL scripts to create relational tables with appropriate constraints (`PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `DEFAULT`).
* Imported and validated CSV datasets into MySQL.

### **Sprint 3: Basic Data Exploration**
* Wrote foundational queries to inspect database metrics:
  * Total counts of guests, bookings, and stays.
  * Active staff members and available room types.
  * Total booking revenues and average booking durations.

### **Sprint 4: Objective-Based Advanced Analysis**
* **4.1 Understand Booking Demand**: Evaluated booking volumes across hotels, channels, requested room types, and temporal trends.
* **4.2 Understand Guest Booking Behaviour**: Segmented customers by booking frequency, lifetime spend, loyalty tier, and guest types (Individual vs. Corporate).
* **4.3 Evaluate Stay Performance**: Analyzed fulfillment outcomes (Checked-out, Cancelled, No-show, In-progress) across different properties and periods.
* **4.4 Understand Staff & Room Performance**: Examined staff workload distribution, stay durations, and room utilization rates.
* **4.5 Identify Booking & Stay Problems**: Investigated cancellation drivers, operational bottlenecks, and correlations between high service requests and stay outcomes.

---

## 🛠️ Tech Stack & Tools
* **Database Management System:** MySQL
* **Query Language:** SQL (DDL, DML, Joins, Aggregations, Window Functions, Subqueries)
* **Documentation & Modeling:** MySQL Workbench (ER Diagram), Microsoft Word / Markdown

---

## 📂 Repository Structure
```text
├── data/                      # Source CSV datasets
├── sql/                       # SQL scripts (Schema setup, Exploration, Analytics)
├── docs/                      # ER Diagram and project documentation
└── README.md                  # Project documentation
