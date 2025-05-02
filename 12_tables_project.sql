CREATE DATABASE TourismDB;
USE TourismDB;

-- 1. Table: Tourist_Spots
CREATE TABLE Tourist_Spots (
    Spot_ID INT PRIMARY KEY AUTO_INCREMENT,
    Spot_Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Description TEXT,
    Entry_Fee DECIMAL(10, 2) DEFAULT 0.00,
    Best_Time_to_Visit VARCHAR(50) NOT NULL
);

-- 2. Table: Tours
CREATE TABLE Tours (
    Tour_ID INT PRIMARY KEY AUTO_INCREMENT,
    Tour_Name VARCHAR(100) NOT NULL,
    Spot_ID INT NOT NULL,
    Tour_Fee DECIMAL(10, 2) DEFAULT 0.00,
    Duration VARCHAR(50) NOT NULL,
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3. Table: Tour_Guides
CREATE TABLE Tour_Guides (
    Guide_ID INT PRIMARY KEY AUTO_INCREMENT,
    Guide_Name VARCHAR(100) NOT NULL,
    Contact_Info VARCHAR(100) UNIQUE,
    Language_Skills VARCHAR(100) NOT NULL,
    Experience_Years INT CHECK (Experience_Years >= 0)
);

-- 4. Table: Tour_Guide_Assignments
CREATE TABLE Tour_Guide_Assignments (
    Assignment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Tour_ID INT NOT NULL,
    Guide_ID INT NOT NULL,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Guide_ID) REFERENCES Tour_Guides(Guide_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Table: Customers
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) NOT NULL,
    Contact_Info VARCHAR(100) UNIQUE,
    Preferred_Language VARCHAR(50)
);

-- 6. Table: Bookings
CREATE TABLE Bookings (
    Booking_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Tour_ID INT NOT NULL,
    Booking_Date DATE NOT NULL,
    Total_Cost DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Table: Reviews
CREATE TABLE Reviews (
    Review_ID INT PRIMARY KEY AUTO_INCREMENT,
    Spot_ID INT NOT NULL,
    Customer_ID INT NOT NULL,
    Review_Text TEXT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 8. Table: Transportation
CREATE TABLE Transportation (
    Transport_ID INT PRIMARY KEY AUTO_INCREMENT,
    Transport_Type VARCHAR(50) NOT NULL,
    Cost_Per_Trip DECIMAL(10, 2) DEFAULT 0.00,
    Availability VARCHAR(50) NOT NULL
);

-- 9. Table: Spot_Transport_Links
CREATE TABLE Spot_Transport_Links (
    Link_ID INT PRIMARY KEY AUTO_INCREMENT,
    Spot_ID INT NOT NULL,
    Transport_ID INT NOT NULL,
    Comments TEXT,
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Transport_ID) REFERENCES Transportation(Transport_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 10. Table: Discounts
CREATE TABLE Discounts (
    Discount_ID INT PRIMARY KEY AUTO_INCREMENT,
    Tour_ID INT NOT NULL,
    Discount_Percentage DECIMAL(5, 2) CHECK (Discount_Percentage BETWEEN 0 AND 100),
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 11. Table: Local_Shops
CREATE TABLE Local_Shops (
    Shop_ID INT PRIMARY KEY AUTO_INCREMENT,
    Shop_Name VARCHAR(100) NOT NULL,
    Spot_ID INT NOT NULL,
    Product_Type VARCHAR(100),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 12. Table: Emergency_Contacts
CREATE TABLE Emergency_Contacts (
    Contact_ID INT PRIMARY KEY AUTO_INCREMENT,
    Spot_ID INT NOT NULL,
    Contact_Type VARCHAR(50) NOT NULL,
    Contact_Number VARCHAR(20) UNIQUE,
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
