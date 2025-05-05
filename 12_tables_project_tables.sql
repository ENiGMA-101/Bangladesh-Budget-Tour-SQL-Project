-- 1. Create the database
CREATE DATABASE TourismDB;
GO

-- 2. Use the database
USE TourismDB;
GO

-- 3. Table: Tourist_Spots
CREATE TABLE Tourist_Spots (
    Spot_ID INT PRIMARY KEY IDENTITY(1,1),
    Spot_Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Entry_Fee NUMERIC(10, 2) DEFAULT 0.00,
    Best_Time_to_Visit NVARCHAR(50) NOT NULL
);

-- 4. Table: Tours
CREATE TABLE Tours (
    Tour_ID INT PRIMARY KEY IDENTITY(1,1),
    Tour_Name NVARCHAR(100) NOT NULL,
    Spot_ID INT NOT NULL,
    Tour_Fee NUMERIC(10, 2) DEFAULT 0.00,
    Duration NVARCHAR(50) NOT NULL,
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Table: Tour_Guides
CREATE TABLE Tour_Guides (
    Guide_ID INT PRIMARY KEY IDENTITY(1,1),
    Guide_Name NVARCHAR(100) NOT NULL,
    Contact_Info NVARCHAR(100) UNIQUE,
    Language_Skills NVARCHAR(100) NOT NULL,
    Experience_Years INT CHECK (Experience_Years >= 0)
);

-- 6. Table: Tour_Guide_Assignments
CREATE TABLE Tour_Guide_Assignments (
    Assignment_ID INT PRIMARY KEY IDENTITY(1,1),
    Tour_ID INT NOT NULL,
    Guide_ID INT NOT NULL,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Guide_ID) REFERENCES Tour_Guides(Guide_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Table: Customers
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY IDENTITY(1,1),
    Customer_Name NVARCHAR(100) NOT NULL,
    Contact_Info NVARCHAR(100) UNIQUE,
    Preferred_Language NVARCHAR(50)
);

-- 8. Table: Bookings
CREATE TABLE Bookings (
    Booking_ID INT PRIMARY KEY IDENTITY(1,1),
    Customer_ID INT NOT NULL,
    Tour_ID INT NOT NULL,
    Booking_Date DATE NOT NULL,
    Total_Cost NUMERIC(10, 2) DEFAULT 0.00,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 9. Table: Reviews
CREATE TABLE Reviews (
    Review_ID INT PRIMARY KEY IDENTITY(1,1),
    Spot_ID INT NOT NULL,
    Customer_ID INT NOT NULL,
    Review_Text NVARCHAR(MAX),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 10. Table: Transportation
CREATE TABLE Transportation (
    Transport_ID INT PRIMARY KEY IDENTITY(1,1),
    Transport_Type NVARCHAR(50) NOT NULL,
    Cost_Per_Trip NUMERIC(10, 2) DEFAULT 0.00,
    Availability NVARCHAR(50) NOT NULL
);

-- 11. Table: Spot_Transport_Links
CREATE TABLE Spot_Transport_Links (
    Link_ID INT PRIMARY KEY IDENTITY(1,1),
    Spot_ID INT NOT NULL,
    Transport_ID INT NOT NULL,
    Comments NVARCHAR(MAX),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Transport_ID) REFERENCES Transportation(Transport_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 12. Table: Discounts
CREATE TABLE Discounts (
    Discount_ID INT PRIMARY KEY IDENTITY(1,1),
    Tour_ID INT NOT NULL,
    Discount_Percentage NUMERIC(5, 2) CHECK (Discount_Percentage BETWEEN 0 AND 100),
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 13. Table: Local_Shops
CREATE TABLE Local_Shops (
    Shop_ID INT PRIMARY KEY IDENTITY(1,1),
    Shop_Name NVARCHAR(100) NOT NULL,
    Spot_ID INT NOT NULL,
    Product_Type NVARCHAR(100),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 14. Table: Emergency_Contacts
CREATE TABLE Emergency_Contacts (
    Contact_ID INT PRIMARY KEY IDENTITY(1,1),
    Spot_ID INT NOT NULL,
    Contact_Type NVARCHAR(50) NOT NULL,
    Contact_Number NVARCHAR(20) UNIQUE,
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE ON UPDATE CASCADE
);




--Queries starts here 


-- 1. List all tourist spots with their entry fee and best time to visit
SELECT Spot_Name, Entry_Fee, Best_Time_to_Visit
FROM Tourist_Spots;

-- 2. Find all tours for a specific tourist spot
SELECT t.Tour_Name, t.Tour_Fee, t.Duration
FROM Tours t
INNER JOIN Tourist_Spots s ON t.Spot_ID = s.Spot_ID
WHERE s.Spot_Name = 'Spot Name Here';

-- 3. Retrieve all guides who speak a specific language
SELECT Guide_Name, Contact_Info, Experience_Years
FROM Tour_Guides
WHERE Language_Skills LIKE '%Language Here%';

-- 4. List all bookings along with customer names and total cost
SELECT b.Booking_ID, c.Customer_Name, b.Total_Cost
FROM Bookings b
INNER JOIN Customers c ON b.Customer_ID = c.Customer_ID;

-- 5. Get the average rating for a specific tourist spot
SELECT AVG(Rating * 1.0) AS Average_Rating -- Multiply by 1.0 to ensure decimal result
FROM Reviews
WHERE Spot_ID = (SELECT Spot_ID FROM Tourist_Spots WHERE Spot_Name = 'Spot Name Here');

-- 6. Find transportation options for a specific tourist spot
SELECT t.Transport_Type, t.Cost_Per_Trip, t.Availability
FROM Transportation t
INNER JOIN Spot_Transport_Links l ON t.Transport_ID = l.Transport_ID
INNER JOIN Tourist_Spots s ON l.Spot_ID = s.Spot_ID
WHERE s.Spot_Name = 'Spot Name Here';

-- 7. List all discounts available for tours along with dates
SELECT d.Tour_ID, d.Discount_Percentage, d.Start_Date, d.End_Date
FROM Discounts d
INNER JOIN Tours t ON d.Tour_ID = t.Tour_ID;

-- 8. Get the shops available at a specific tourist spot and their product types
SELECT ls.Shop_Name, ls.Product_Type
FROM Local_Shops ls
INNER JOIN Tourist_Spots s ON ls.Spot_ID = s.Spot_ID
WHERE s.Spot_Name = 'Spot Name Here';

-- 9. Find emergency contacts for a specific tourist spot
SELECT ec.Contact_Type, ec.Contact_Number
FROM Emergency_Contacts ec
INNER JOIN Tourist_Spots s ON ec.Spot_ID = s.Spot_ID
WHERE s.Spot_Name = 'Spot Name Here';

-- 10. List all guides assigned to a specific tour
SELECT g.Guide_Name, g.Contact_Info
FROM Tour_Guide_Assignments a
INNER JOIN Tour_Guides g ON a.Guide_ID = g.Guide_ID
INNER JOIN Tours t ON a.Tour_ID = t.Tour_ID
WHERE t.Tour_Name = 'Tour Name Here';


