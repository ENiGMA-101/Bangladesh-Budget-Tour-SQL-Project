# **Tourism Database Project: Tour Underrated Places in Bangladesh at Low Cost**

## **1. Project Description**

The "Tourism Database Project: Tour Underrated Places in Bangladesh at Low Cost" aims to organize information about underrated tourist spots in Bangladesh. The project is designed to help travel agencies, tour operators, and individual tourists efficiently plan trips at a lower cost while exploring unique destinations. The database includes data about tourist spots, tours, tour guides, customers, bookings, transportation, and discounts. It also incorporates efficient payment and emergency management systems.

The database is built with a relational schema to enable seamless management of interconnected data, ensuring data integrity and consistency.


---

## Entity Relationship Diagram
The Entity-Relationship (ER) Diagram below visualizes the relationships between the entities in the TourismDB project. Each entity represents a table, and the relationships between them are defined using primary and foreign keys.

### Entities:
- **Tourist_Spots**: Represents the tourist spots with information like name, description, location, entry fees, and best time to visit.
- **Tours**: Contains details about tours, including tour name, spot ID, tour fee, and duration.
- **Tour_Guides**: Stores information about guides, including their names, contact info, language skills, and experience.
- **Tour_Guide_Assignments**: Links tours to their assigned guides.
- **Customers**: Includes customer details like name, contact info, and preferred language.
- **Bookings**: Stores booking details like booking date, cost, customer ID, and tour ID.
- **Reviews**: Allows customers to provide reviews and ratings for tourist spots.
- **Transportation**: Provides details about available transportation, costs, and availability.
- **Spot_Transport_Links**: Links transportation options to specific tourist spots.
- **Discounts**: Contains information about discounts available for specific tours.
- **Local_Shops**: Lists shops near tourist spots and their offerings.
- **Emergency_Contacts**: Stores emergency contact details for each spot.
- **Online_Payment**: Handles payment information for bookings.

---

## ER Diagram





## Schema Diagram

The schema diagram illustrates the implementation of the database from the ER diagram. It shows the tables, their attributes, and the relationships between them, including primary keys (PK) and foreign keys (FK).

### Schema Features:
- **Primary Key Constraints**: Ensure each table has a unique identifier.
- **Foreign Key Constraints**: Maintain relationships between tables.
- **Default Values and Checks**: Ensure data integrity (e.g., non-negative experience years, valid ratings, etc.).
- **Cascading Deletes**: Automatically remove dependent records when a parent record is deleted.



## Tables and Attributes

### 1. Tourist_Spots Table
Stores information about various tourist spots.

- **Spot_ID** (PK): Unique identifier for each tourist spot.
- **Spot_Name**: Name of the tourist spot.
- **Location**: Location of the tourist spot.
- **Description**: Brief description of the spot.
- **Entry_Fee**: Entry fee for the spot (default: 0.00).
- **Best_Time_to_Visit**: Recommended time to visit.

### 2. Tours Table
Stores details about tours offered for tourist spots.

- **Tour_ID** (PK): Unique identifier for each tour.
- **Tour_Name**: Name of the tour.
- **Spot_ID** (FK): Associated tourist spot (linked to `Tourist_Spots`).
- **Tour_Fee**: Fee for the tour (default: 0.00).
- **Duration**: Duration of the tour.

### 3. Tour_Guides Table
Stores information about tour guides.

- **Guide_ID** (PK): Unique identifier for each guide.
- **Guide_Name**: Name of the tour guide.
- **Contact_Info**: Contact details (unique).
- **Language_Skills**: Languages the guide can speak.
- **Experience_Years**: Years of experience (must be ≥ 0).


### 4. Tour_Guide_Assignments Table
Links guides to specific tours.

- **Assignment_ID** (PK): Unique identifier for each assignment.
- **Tour_ID** (FK): Associated tour (linked to `Tours`).
- **Guide_ID** (FK): Associated guide (linked to `Tour_Guides`).


### 5. Customers Table
Stores information about customers.

- **Customer_ID** (PK): Unique identifier for each customer.
- **Customer_Name**: Name of the customer.
- **Contact_Info**: Contact details (unique).
- **Preferred_Language**: Language preferred by the customer.


### 6. Bookings Table
Stores booking details for tours.

- **Booking_ID** (PK): Unique identifier for each booking.
- **Customer_ID** (FK): Associated customer (linked to `Customers`).
- **Tour_ID** (FK): Associated tour (linked to `Tours`).
- **Booking_Date**: Date of booking.
- **Total_Cost**: Total cost of the booking (default: 0.00).


### 7. Reviews Table
Stores reviews given by customers for tourist spots.

- **Review_ID** (PK): Unique identifier for each review.
- **Spot_ID** (FK): Associated tourist spot (linked to `Tourist_Spots`).
- **Customer_ID** (FK): Associated customer (linked to `Customers`).
- **Review_Text**: Review content.
- **Rating**: Rating given (1 to 5).


### 8. Transportation Table
Stores details about transportation options.

- **Transport_ID** (PK): Unique identifier for each transport option.
- **Transport_Type**: Type of transport (e.g., Bus, Taxi).
- **Cost_Per_Trip**: Cost per trip (default: 0.00).
- **Availability**: Availability details.


### 9. Spot_Transport_Links Table
Links transportation options to tourist spots.

- **Link_ID** (PK): Unique identifier for each link.
- **Spot_ID** (FK): Associated tourist spot (linked to `Tourist_Spots`).
- **Transport_ID** (FK): Associated transport option (linked to `Transportation`).
- **Comments**: Additional details.


### 10. Discounts Table
Stores discount details for tours.

- **Discount_ID** (PK): Unique identifier for each discount.
- **Tour_ID** (FK): Associated tour (linked to `Tours`).
- **Discount_Percentage**: Percentage discount (0 to 100).
- **Start_Date**: Start date of the discount.
- **End_Date**: End date of the discount.


### 11. Local_Shops Table
Stores details about shops near tourist spots.

- **Shop_ID** (PK): Unique identifier for each shop.
- **Shop_Name**: Name of the shop.
- **Spot_ID** (FK): Associated tourist spot (linked to `Tourist_Spots`).
- **Product_Type**: Type of products sold.


### 12. Emergency_Contacts Table
Stores emergency contact details for tourist spots.

- **Contact_ID** (PK): Unique identifier for each contact.
- **Spot_ID** (FK): Associated tourist spot (linked to `Tourist_Spots`).
- **Contact_Type**: Type of contact (e.g., Police, Hospital).
- **Contact_Number**: Contact number (unique).


### 13. Online_Payment Table
Stores details about online payments for bookings.

- **Payment_ID** (PK): Unique identifier for each payment.
- **Booking_ID** (FK): Associated booking (linked to `Bookings`).
- **Payment_Date**: Date of payment.
- **Payment_Amount**: Amount paid.
- **Payment_Method**: Method of payment.
- **Payment_Status**: Status of the payment.
---

## SQL Queries and Results

### Query 1: Retrieve all tourist spots with their descriptions and entry fees
```sql
SELECT Spot_ID, Spot_Name, Description, Entry_Fee
FROM Tourist_Spots
ORDER BY Spot_Name;
```

**Result:**

![1](https://github.com/user-attachments/assets/f51bc34e-5f15-48af-a451-3e952df66dd0)



### Query 2: Find the total number of customers who booked tours
```sql
SELECT COUNT(*) AS Total_Customers
FROM Customers;
```

**Result:**

![2](https://github.com/user-attachments/assets/528bf023-d93a-4341-8a70-c8a7831a3d19)



### Query 3: Get the total revenue for each tour
```sql
SELECT T.Tour_Name, SUM(B.Total_Cost) AS Total_Revenue
FROM Bookings B
JOIN Tours T ON B.Tour_ID = T.Tour_ID
GROUP BY T.Tour_Name
ORDER BY Total_Revenue DESC;
```

**Result:**

![3](https://github.com/user-attachments/assets/0d436ff1-e9ad-4119-ab3f-65482def0e97)



### Query 4: List all available discounts and their validity periods
```sql
SELECT D.Discount_ID, T.Tour_Name, D.Discount_Percentage, D.Start_Date, D.End_Date
FROM Discounts D
JOIN Tours T ON D.Tour_ID = T.Tour_ID
ORDER BY D.Start_Date;
```

**Result:**

![4](https://github.com/user-attachments/assets/d0343292-dbf7-41eb-9e50-46fcd53c8835)




### Query 5: Find the reviews and average rating for each tourist spot
```sql
SELECT TS.Spot_Name, COUNT(R.Review_ID) AS Total_Reviews, AVG(R.Rating) AS Avg_Rating
FROM Reviews R
JOIN Tourist_Spots TS ON R.Spot_ID = TS.Spot_ID
GROUP BY TS.Spot_Name
ORDER BY Avg_Rating DESC;
```

**Result:**

![5](https://github.com/user-attachments/assets/039b569c-19d6-4a9d-8eb0-5fa7be49c25b)




### Query 6: Retrieve the busiest guide (the guide assigned to the highest number of tours)
```sql
SELECT TG.Guide_Name, COUNT(TGA.Assignment_ID) AS Total_Assignments
FROM Tour_Guide_Assignments TGA
JOIN Tour_Guides TG ON TGA.Guide_ID = TG.Guide_ID
GROUP BY TG.Guide_Name
ORDER BY Total_Assignments DESC;
```

**Result:**

![6](https://github.com/user-attachments/assets/98840fd4-ba67-459b-a9fc-15f73a823ba4)




### Query 7: Find customers who made payments using a specific method (e.g., 'Credit Card')
```sql
SELECT C.Customer_Name, C.Contact_Info, OP.Payment_Method
FROM Online_Payment OP
JOIN Bookings B ON OP.Booking_ID = B.Booking_ID
JOIN Customers C ON B.Customer_ID = C.Customer_ID
WHERE OP.Payment_Method = 'Credit Card';
```

**Result:**

![7](https://github.com/user-attachments/assets/bf229c34-c39f-41f9-9b49-7c96757cffa7)




### Query 8: List all transportation options available for a specific tourist spot
```sql
SELECT TS.Spot_Name, T.Transport_Type, T.Cost_Per_Trip
FROM Spot_Transport_Links STL
JOIN Tourist_Spots TS ON STL.Spot_ID = TS.Spot_ID
JOIN Transportation T ON STL.Transport_ID = T.Transport_ID
WHERE TS.Spot_Name = 'Sajek Valley';
```

**Result:**

![8](https://github.com/user-attachments/assets/202782d9-8f4d-437a-9d4a-cd04c7b38bc6)




### Query 9: Get the total number of bookings per tourist spot
```sql
SELECT TS.Spot_Name, COUNT(B.Booking_ID) AS Total_Bookings
FROM Bookings B
JOIN Tours T ON B.Tour_ID = T.Tour_ID
JOIN Tourist_Spots TS ON T.Spot_ID = TS.Spot_ID
GROUP BY TS.Spot_Name
ORDER BY Total_Bookings DESC;
```

**Result:**

![9](https://github.com/user-attachments/assets/be959ac9-69a3-4955-bbd0-42546e1418d6)




### Query 10: Retrieve emergency contact details for each tourist spot
```sql
SELECT TS.Spot_Name, EC.Contact_Type, EC.Contact_Number
FROM Emergency_Contacts EC
JOIN Tourist_Spots TS ON EC.Spot_ID = TS.Spot_ID
ORDER BY TS.Spot_Name;
```

**Result:**

![10](https://github.com/user-attachments/assets/a6a0f68f-cebc-443e-9ed0-6f553ab8b3dc)



---

# **Complex Engineering Problem (CEP) Explanation**


### **Why is this Project a Complex Engineering Problem?**

The **"Tourism Database Project"** qualifies as a **Complex Engineering Problem (CEP)** because it involves diverse technical, operational, and societal challenges. The project requires in-depth engineering knowledge, careful design, and innovative solutions to address interconnected sub-problems. Below, we discuss how this project meets the key attributes of a CEP.

---

### **Attributes of a Complex Engineering Problem in this Project**

#### **1. Depth of Knowledge Required (P1)**
This project cannot be resolved without applying in-depth engineering knowledge in:
- **Database Design**: The relational schema is developed using theoretical principles like normalization, foreign key relationships, and cascading rules.
- **SQL and Query Optimization**: Advanced SQL techniques are used to manage data and retrieve meaningful insights efficiently.
- **Scalability and Integrity**: The database must support growing data (e.g., more tourist spots, customers, bookings) while maintaining performance and data integrity.

#### **2. Range of Conflicting Requirements (P2)**
The project involves balancing conflicting requirements from multiple stakeholders:
- **Tourists** demand affordable and user-friendly booking systems.
- **Travel Agencies** aim for maximized revenue and efficient operations.
- **Database Administrators** focus on maintaining integrity, scalability, and security.

These conflicting needs make the problem challenging and require trade-offs in design and implementation.

#### **3. Depth of Analysis Required (P3)**
The solution requires abstract thinking and originality:
- Abstracting real-world tourism requirements into a relational database model.
- Designing queries to handle complex scenarios, such as calculating total revenue, managing guide assignments, and evaluating tourist reviews.
- Handling edge cases like overlapping discounts or invalid payment statuses.

#### **4. Familiarity with Issues (P4)**
The issues addressed in this project are not frequently encountered in standard database design:
- Integrating tourism-specific features such as emergency contacts, local shops, and transportation links.
- Supporting multilingual data for diverse customer groups.
- Maintaining flexibility for future enhancements like loyalty programs or dynamic pricing.

#### **5. Extent of Applicable Codes (P5)**
The project adheres to industry standards and best practices in:
- **Database Design**: Following normalization principles and enforcing data constraints.
- **Security Practices**: Ensuring payment and customer data are secure.
- **Scalability**: Ensuring the database can handle large datasets efficiently.

#### **6. Extent of Stakeholder Involvement and Conflicting Requirements (P6)**
The project involves diverse stakeholders:
- **Tourists**: Need access to affordable tours, reviews, and transportation options.
- **Travel Agencies**: Require detailed operational reports and revenue analysis.
- **Tour Guides**: Need fair assignment to tours.
- **Administrators**: Must manage and maintain the database efficiently.

Each group has varying priorities, leading to conflicting requirements that must be balanced.

#### **7. Interdependence (P7)**
The project involves multiple interdependent components:
- **Tourist Spots** depend on transportation and reviews for accessibility and popularity.
- **Tours** link to spots, guides, customers, and discounts.
- **Bookings** rely on customers, tours, and payment systems.
- **Emergency Contacts** and **Local Shops** enhance tourist safety and experience.

Failure in one component (e.g., improper guide assignment or payment issues) could disrupt the entire system.

---

## Conclusion
This database system provides a comprehensive solution for managing information about underrated tourist destinations in Bangladesh that can be visited on a budget. The system enables budget-conscious travelers to discover new places, find affordable accommodations, and plan their trips efficiently.
The TourismDB project successfully organizes and manages data related to affordable and underrated tourist destinations in Bangladesh. It demonstrates the capability of relational databases in handling interconnected data, ensuring data consistency and integrity. This project is a valuable tool for enhancing the tourism experience in Bangladesh.

For the SQL file and further details, refer to the accompanying [SQL Script](./Latest%20one/TablesWithRandomData.sql).
