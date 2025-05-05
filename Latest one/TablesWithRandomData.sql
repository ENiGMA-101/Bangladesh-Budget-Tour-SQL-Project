-- Create Database
CREATE DATABASE TourismDB;
GO
USE TourismDB;
GO

-- 1. Table: Tourist_Spots
CREATE TABLE Tourist_Spots (
    Spot_ID INT IDENTITY(1,1) PRIMARY KEY,
    Spot_Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Entry_Fee DECIMAL(10, 2) DEFAULT 0.00,
    Best_Time_to_Visit NVARCHAR(50) NOT NULL
);

-- 2. Table: Tours
CREATE TABLE Tours (
    Tour_ID INT IDENTITY(1,1) PRIMARY KEY,
    Tour_Name NVARCHAR(100) NOT NULL,
    Spot_ID INT NOT NULL,
    Tour_Fee DECIMAL(10, 2) DEFAULT 0.00,
    Duration NVARCHAR(50) NOT NULL,
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE
);

-- 3. Table: Tour_Guides
CREATE TABLE Tour_Guides (
    Guide_ID INT IDENTITY(1,1) PRIMARY KEY,
    Guide_Name NVARCHAR(100) NOT NULL,
    Contact_Info NVARCHAR(100) UNIQUE,
    Language_Skills NVARCHAR(100) NOT NULL,
    Experience_Years INT CHECK (Experience_Years >= 0)
);

-- 4. Table: Tour_Guide_Assignments
CREATE TABLE Tour_Guide_Assignments (
    Assignment_ID INT IDENTITY(1,1) PRIMARY KEY,
    Tour_ID INT NOT NULL,
    Guide_ID INT NOT NULL,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE,
    FOREIGN KEY (Guide_ID) REFERENCES Tour_Guides(Guide_ID) ON DELETE CASCADE
);

-- 5. Table: Customers
CREATE TABLE Customers (
    Customer_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_Name NVARCHAR(100) NOT NULL,
    Contact_Info NVARCHAR(100) UNIQUE,
    Preferred_Language NVARCHAR(50)
);

-- 6. Table: Bookings
CREATE TABLE Bookings (
    Booking_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Tour_ID INT NOT NULL,
    Booking_Date DATE NOT NULL,
    Total_Cost DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE
);

-- 7. Table: Reviews
CREATE TABLE Reviews (
    Review_ID INT IDENTITY(1,1) PRIMARY KEY,
    Spot_ID INT NOT NULL,
    Customer_ID INT NOT NULL,
    Review_Text NVARCHAR(MAX),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE
);

-- 8. Table: Transportation
CREATE TABLE Transportation (
    Transport_ID INT IDENTITY(1,1) PRIMARY KEY,
    Transport_Type NVARCHAR(50) NOT NULL,
    Cost_Per_Trip DECIMAL(10, 2) DEFAULT 0.00,
    Availability NVARCHAR(50) NOT NULL
);

-- 9. Table: Spot_Transport_Links
CREATE TABLE Spot_Transport_Links (
    Link_ID INT IDENTITY(1,1) PRIMARY KEY,
    Spot_ID INT NOT NULL,
    Transport_ID INT NOT NULL,
    Comments NVARCHAR(MAX),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE,
    FOREIGN KEY (Transport_ID) REFERENCES Transportation(Transport_ID) ON DELETE CASCADE
);

-- 10. Table: Discounts
CREATE TABLE Discounts (
    Discount_ID INT IDENTITY(1,1) PRIMARY KEY,
    Tour_ID INT NOT NULL,
    Discount_Percentage DECIMAL(5, 2) CHECK (Discount_Percentage BETWEEN 0 AND 100),
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    FOREIGN KEY (Tour_ID) REFERENCES Tours(Tour_ID) ON DELETE CASCADE
);

-- 11. Table: Local_Shops
CREATE TABLE Local_Shops (
    Shop_ID INT IDENTITY(1,1) PRIMARY KEY,
    Shop_Name NVARCHAR(100) NOT NULL,
    Spot_ID INT NOT NULL,
    Product_Type NVARCHAR(100),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE
);

-- 12. Table: Emergency_Contacts
CREATE TABLE Emergency_Contacts (
    Contact_ID INT IDENTITY(1,1) PRIMARY KEY,
    Spot_ID INT NOT NULL,
    Contact_Type NVARCHAR(50) NOT NULL,
    Contact_Number NVARCHAR(20) UNIQUE,
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE
);

-- 13. Table: Online_Payment
CREATE TABLE Online_Payment (
    Payment_ID INT IDENTITY(1,1) PRIMARY KEY,
    Booking_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Amount DECIMAL(10, 2) NOT NULL,
    Payment_Method NVARCHAR(50) NOT NULL,
    Payment_Status NVARCHAR(50) NOT NULL,
    FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID) ON DELETE CASCADE
);
GO

-- Insert data into tables 

-- Insert data into Tourist_Spots
INSERT INTO Tourist_Spots (Spot_Name, Location, Description, Entry_Fee, Best_Time_to_Visit)
VALUES
('Sajek Valley', 'Rangamati', 'Beautiful valley surrounded by hills', 50.00, 'Winter'),
('Ratargul Swamp Forest', 'Sylhet', 'Freshwater swamp forest', 30.00, 'Monsoon'),
('Boga Lake', 'Bandarban', 'Scenic lake in the hills', 20.00, 'Winter'),
('Kuakata', 'Patuakhali', 'Sea beach with sunrise and sunset views', 0.00, 'Winter'),
('Shalban Vihara', 'Comilla', 'Ancient Buddhist monastery', 25.00, 'Autumn'),
('Paharpur', 'Naogaon', 'UNESCO World Heritage Site', 40.00, 'Winter'),
('Lalakhal', 'Sylhet', 'Crystal-clear blue river', 10.00, 'Monsoon'),
('Sundarbans', 'Khulna', 'World’s largest mangrove forest', 100.00, 'Winter'),
('Madhabkunda Waterfall', 'Sylhet', 'Largest waterfall in Bangladesh', 50.00, 'Monsoon'),
('Ahsan Manzil', 'Dhaka', 'Historical royal palace', 20.00, 'Autumn'),
('Panam City', 'Sonargaon', 'Ancient abandoned city', 30.00, 'Winter'),
('Bandarban Golden Temple', 'Bandarban', 'Buddhist temple on a hilltop', 40.00, 'Autumn'),
('Nilgiri', 'Bandarban', 'Hilltop resort with panoramic views', 60.00, 'Winter'),
('Patenga Beach', 'Chittagong', 'Popular beach with scenic views', 0.00, 'Winter'),
('Rangamati Hanging Bridge', 'Rangamati', 'Famous bridge over Kaptai Lake', 20.00, 'Autumn');

-- Insert data into Tours
INSERT INTO Tours (Tour_Name, Spot_ID, Tour_Fee, Duration)
VALUES
('Sajek Adventure', 1, 2000.00, '2 Days'),
('Sylhet Nature Tour', 2, 1500.00, '1 Day'),
('Boga Lake Trek', 3, 2500.00, '3 Days'),
('Kuakata Beach Experience', 4, 1000.00, '1 Day'),
('Shalban Historical Tour', 5, 1200.00, '1 Day'),
('Paharpur Heritage Tour', 6, 2200.00, '2 Days'),
('Lalakhal Boat Cruise', 7, 800.00, 'Half Day'),
('Sundarbans Eco Adventure', 8, 5000.00, '3 Days'),
('Madhabkunda Waterfall Hike', 9, 1400.00, '1 Day'),
('Ahsan Manzil Museum Tour', 10, 600.00, 'Half Day'),
('Panam City Exploration', 11, 800.00, 'Half Day'),
('Golden Temple Spiritual Visit', 12, 1000.00, '1 Day'),
('Nilgiri Hilltop Retreat', 13, 3000.00, '2 Days'),
('Patenga Beach Leisure', 14, 500.00, 'Half Day'),
('Rangamati Scenic Tour', 15, 1000.00, '1 Day');

-- Insert data into Tour_Guides
INSERT INTO Tour_Guides (Guide_Name, Contact_Info, Language_Skills, Experience_Years)
VALUES
('John Doe', 'john@example.com', 'English, Bengali', 5),
('Jane Smith', 'jane@example.com', 'Bengali', 3),
('Ali Khan', 'ali@example.com', 'English, Bengali, Hindi', 7),
('Maria Gomez', 'maria@example.com', 'Bengali, Spanish', 4),
('Arif Ahmed', 'arif@example.com', 'Bengali', 6),
('Sadia Rahman', 'sadia@example.com', 'English, Bengali', 2),
('Faruk Hossain', 'faruk@example.com', 'Bengali', 8),
('Nadia Hasan', 'nadia@example.com', 'Bengali, English', 5),
('Rafiq Islam', 'rafiq@example.com', 'Bengali', 10),
('Mehedi Hasan', 'mehedi@example.com', 'English', 1),
('Shakib Al Hasan', 'shakib@example.com', 'Bengali', 3),
('Kamal Uddin', 'kamal@example.com', 'English, Bengali', 4),
('Tania Akter', 'tania@example.com', 'Bengali', 6),
('Ziaur Rahman', 'ziaur@example.com', 'English, Bengali', 7),
('Fahmida Yasmin', 'fahmida@example.com', 'Bengali', 3);

-- Insert data into Customers
INSERT INTO Customers (Customer_Name, Contact_Info, Preferred_Language)
VALUES
('Alice Johnson', 'alice@example.com', 'English'),
('Bob Smith', 'bob@example.com', 'Bengali'),
('Charlie Brown', 'charlie@example.com', 'English'),
('Diana Prince', 'diana@example.com', 'Bengali'),
('Edward Cullen', 'edward@example.com', 'English'),
('Fiona Gallagher', 'fiona@example.com', 'Bengali'),
('George Weasley', 'george@example.com', 'English'),
('Hannah Abbott', 'hannah@example.com', 'Bengali'),
('Isaac Newton', 'isaac@example.com', 'English'),
('Jack Sparrow', 'jack@example.com', 'Bengali'),
('Karen Smith', 'karen@example.com', 'Bengali'),
('Liam Hemsworth', 'liam@example.com', 'English'),
('Mia Wallace', 'mia@example.com', 'Bengali'),
('Noah Centineo', 'noah@example.com', 'English'),
('Olivia Wilde', 'olivia@example.com', 'Bengali');

-- Insert data into Discounts
INSERT INTO Discounts (Tour_ID, Discount_Percentage, Start_Date, End_Date)
VALUES
(1, 10.00, '2025-05-01', '2025-05-10'),
(2, 15.00, '2025-05-05', '2025-05-15'),
(3, 20.00, '2025-06-01', '2025-06-10'),
(4, 5.00, '2025-05-20', '2025-05-30'),
(5, 12.00, '2025-07-01', '2025-07-10'),
(6, 8.00, '2025-06-15', '2025-06-25'),
(7, 10.00, '2025-06-01', '2025-06-15'),
(8, 25.00, '2025-05-10', '2025-05-20'),
(9, 5.00, '2025-05-15', '2025-05-25'),
(10, 7.00, '2025-06-10', '2025-06-20'),
(11, 10.00, '2025-07-01', '2025-07-15'),
(12, 15.00, '2025-05-25', '2025-06-05'),
(13, 20.00, '2025-06-15', '2025-06-30'),
(14, 5.00, '2025-06-01', '2025-06-10'),
(15, 10.00, '2025-07-05', '2025-07-15');

-- Insert data into Bookings
INSERT INTO Bookings (Customer_ID, Tour_ID, Booking_Date, Total_Cost)
VALUES
(1, 1, '2025-05-01', 2000.00),
(2, 2, '2025-05-02', 1500.00),
(3, 3, '2025-05-03', 2500.00),
(4, 4, '2025-05-04', 1000.00),
(5, 5, '2025-05-05', 1200.00),
(6, 6, '2025-05-06', 2200.00),
(7, 7, '2025-05-07', 800.00),
(8, 8, '2025-05-08', 5000.00),
(9, 9, '2025-05-09', 1400.00),
(10, 10, '2025-05-10', 600.00),
(11, 11, '2025-05-11', 800.00),
(12, 12, '2025-05-12', 1000.00),
(13, 13, '2025-05-13', 3000.00),
(14, 14, '2025-05-14', 500.00),
(15, 15, '2025-05-15', 1000.00),
-- Sajek Valley Tours (Tour_ID: 1, Spot_ID: 1)
(1, 1, '2025-05-01', 2000.00),
(2, 1, '2025-05-02', 2000.00),
(3, 1, '2025-05-03', 2000.00),
(4, 1, '2025-05-04', 2000.00),

-- Sylhet Nature Tour (Tour_ID: 2, Spot_ID: 2)
(5, 2, '2025-05-05', 1500.00),
(6, 2, '2025-05-06', 1500.00),
(7, 2, '2025-05-07', 1500.00),

-- Boga Lake Trek (Tour_ID: 3, Spot_ID: 3)
(8, 3, '2025-05-08', 2500.00),
(9, 3, '2025-05-09', 2500.00),

-- Kuakata Beach Experience (Tour_ID: 4, Spot_ID: 4)
(10, 4, '2025-05-10', 1000.00),
(11, 4, '2025-05-11', 1000.00),

-- Shalban Historical Tour (Tour_ID: 5, Spot_ID: 5)
(12, 5, '2025-05-12', 1200.00),
(13, 5, '2025-05-13', 1200.00),
(14, 5, '2025-05-14', 1200.00),

-- Paharpur Heritage Tour (Tour_ID: 6, Spot_ID: 6)
(15, 6, '2025-05-15', 2200.00),
(1, 6, '2025-05-16', 2200.00),

-- Lalakhal Boat Cruise (Tour_ID: 7, Spot_ID: 7)
(2, 7, '2025-05-17', 800.00),
(3, 7, '2025-05-18', 800.00),

-- Sundarbans Eco Adventure (Tour_ID: 8, Spot_ID: 8)
(4, 8, '2025-05-19', 5000.00),
(5, 8, '2025-05-20', 5000.00),
(6, 8, '2025-05-21', 5000.00);

-- Insert data into Reviews
INSERT INTO Reviews (Spot_ID, Customer_ID, Review_Text, Rating)
VALUES
(1, 1, 'Amazing experience in Sajek Valley!', 5),
(1, 2, 'Breathtaking views and great weather.', 4),
(1, 3, 'Had a great time, but crowded.', 4),
(2, 4, 'Ratargul Swamp Forest was serene and peaceful.', 5),
(2, 5, 'Interesting place to visit during monsoon.', 4),
(2, 6, 'A bit difficult to access, but worth it.', 3),
(3, 7, 'Boga Lake is a hidden gem!', 5),
(3, 8, 'Incredible natural beauty.', 4),
(3, 9, 'Challenging trek, but rewarding.', 4),
(4, 10, 'Kuakata Beach is perfect for relaxation.', 5),
(4, 11, 'Loved watching the sunrise and sunset.', 5),
(4, 12, 'Clean and peaceful beach.', 4),
(5, 13, 'Shalban Vihara is a must-visit for history lovers.', 5),
(5, 14, 'Well-maintained and informative.', 4),
(5, 15, 'A glimpse into ancient history.', 4),
(6, 1, 'Paharpur Heritage Site is impressive.', 5),
(6, 2, 'A UNESCO World Heritage Site worth visiting.', 5),
(6, 3, 'Rich in history and culture.', 4),
(7, 4, 'Lalakhal’s crystal-clear water is mesmerizing.', 5),
(7, 5, 'A beautiful spot for boating.', 5),
(7, 6, 'Loved the serene atmosphere.', 4),
(8, 7, 'Sundarbans is a paradise for nature enthusiasts.', 5),
(8, 8, 'Saw the Royal Bengal Tiger!', 5),
(8, 9, 'A unique mangrove forest experience.', 5),
(9, 10, 'Madhabkunda Waterfall is stunning.', 5),
(9, 11, 'The hike was worth it.', 4),
(9, 12, 'Beautiful and refreshing.', 4),
(10, 13, 'Ahsan Manzil is a beautiful historical palace.', 5),
(10, 14, 'Well-preserved and informative.', 4),
(10, 15, 'A must-visit for history buffs.', 4);

-- Insert data into Online_Payment
INSERT INTO Online_Payment (Booking_ID, Payment_Date, Payment_Amount, Payment_Method, Payment_Status)
VALUES
(1, '2025-05-01', 2000.00, 'Credit Card', 'Completed'),
(2, '2025-05-02', 1500.00, 'Mobile Banking', 'Completed'),
(3, '2025-05-03', 2500.00, 'Debit Card', 'Completed'),
(4, '2025-05-04', 1000.00, 'Cash', 'Pending'),
(5, '2025-05-05', 1200.00, 'Mobile Banking', 'Completed'),
(6, '2025-05-06', 2200.00, 'Credit Card', 'Completed'),
(7, '2025-05-07', 800.00, 'Mobile Banking', 'Completed'),
(8, '2025-05-08', 5000.00, 'Credit Card', 'Completed'),
(9, '2025-05-09', 1400.00, 'Debit Card', 'Completed'),
(10, '2025-05-10', 600.00, 'Cash', 'Pending'),
(11, '2025-05-11', 800.00, 'Mobile Banking', 'Completed'),
(12, '2025-05-12', 1000.00, 'Credit Card', 'Completed'),
(13, '2025-05-13', 3000.00, 'Mobile Banking', 'Completed'),
(14, '2025-05-14', 500.00, 'Cash', 'Pending'),
(15, '2025-05-15', 1000.00, 'Credit Card', 'Completed');

-- Insert data into Tour_Guide_Assignments
INSERT INTO Tour_Guide_Assignments (Tour_ID, Guide_ID)
VALUES
(1, 1), -- John Doe assigned to Sajek Adventure
(2, 1), -- John Doe assigned to Sylhet Nature Tour
(3, 2), -- Jane Smith assigned to Boga Lake Trek
(4, 2), -- Jane Smith assigned to Kuakata Beach Experience
(5, 3), -- Ali Khan assigned to Shalban Historical Tour
(6, 3), -- Ali Khan assigned to Paharpur Heritage Tour
(7, 3), -- Ali Khan assigned to Lalakhal Boat Cruise
(8, 4), -- Maria Gomez assigned to Sundarbans Eco Adventure
(9, 4), -- Maria Gomez assigned to Madhabkunda Waterfall Hike
(10, 5), -- Arif Ahmed assigned to Ahsan Manzil Museum Tour
(11, 5), -- Arif Ahmed assigned to Panam City Exploration
(12, 5), -- Arif Ahmed assigned to Golden Temple Spiritual Visit
(13, 6), -- Sadia Rahman assigned to Nilgiri Hilltop Retreat
(14, 6), -- Sadia Rahman assigned to Patenga Beach Leisure
(15, 7), -- Faruk Hossain assigned to Rangamati Scenic Tour
(1, 3), -- Ali Khan assigned again to Sajek Adventure
(2, 3), -- Ali Khan assigned again to Sylhet Nature Tour
(5, 4), -- Maria Gomez assigned again to Shalban Historical Tour
(6, 4), -- Maria Gomez assigned again to Paharpur Heritage Tour
(7, 5); -- Arif Ahmed assigned again to Lalakhal Boat Cruise

-- Insert data into Transportation
INSERT INTO Transportation (Transport_Type, Cost_Per_Trip, Availability)
VALUES
('Bus', 500.00, 'Daily'),
('Jeep', 1200.00, 'On Demand'),
('Motorbike', 800.00, 'Hourly'),
('Helicopter', 15000.00, 'On Demand'),
('Rickshaw', 200.00, 'Daily'),
('Bicycle', 300.00, 'Hourly'),
('Private Car', 2500.00, 'On Demand'),
('Shared Microbus', 700.00, 'Daily'),
('CNG Auto Rickshaw', 400.00, 'On Demand'),
('Pickup Truck', 1000.00, 'Daily'),
('Electric Scooter', 600.00, 'Hourly');

-- Insert data into Spot_Transport_Links (for Sajek Valley)
INSERT INTO Spot_Transport_Links (Spot_ID, Transport_ID, Comments)
VALUES
(1, 1, 'Buses are available from Dhaka to Sajek Valley via Khagrachari.'),
(1, 2, 'Jeep services are available for local transportation in Sajek Valley.'),
(1, 3, 'Motorbike rentals can be arranged for exploring nearby areas.'),
(1, 4, 'Helicopter tours can be booked for scenic aerial views of Sajek Valley.'),
(1, 5, 'Rickshaws are available for short local trips in the valley.'),
(1, 6, 'Bicycles can be rented for eco-friendly exploration.'),
(1, 7, 'Private cars can be hired for comfortable travel.'),
(1, 8, 'Shared microbuses are available for budget travelers.'),
(1, 9, 'CNG auto-rickshaws can be hired for local trips.'),
(1, 10, 'Pickup trucks are available for group travel.'),
(1, 11, 'Electric scooters are available for quick and eco-friendly rides.');

-- Insert data into Emergency_Contacts
INSERT INTO Emergency_Contacts (Spot_ID, Contact_Type, Contact_Number)
VALUES
(1, 'Police', '999'),
(1, 'Hospital', '01700123456'),
(1, 'Fire Service', '01700987654'),
(2, 'Police', '01600123456'),
(2, 'Rescue Team', '01600987654'),
(3, 'Police', '01500123456'),
(3, 'Local Guide Office', '01500987654'),
(4, 'Hospital', '01400123456'),
(4, 'Fire Service', '01400987654'),
(5, 'Police', '01300123456'),
(5, 'Tourist Helpdesk', '01300987654'),
(6, 'Police', '01200123456'),
(6, 'Archaeological Department', '01200987654'),
(7, 'Local Authority', '01100123456'),
(7, 'Police', '01100987654'),
(8, 'Forest Department', '01800123456'),
(8, 'Rescue Team', '01800987654'),
(9, 'Police', '01700112233'),
(9, 'Tourist Helpdesk', '01700997788'),
(10, 'Museum Authority', '01900123456'),
(10, 'Police', '01900987654');




-- Queries

-- 1. Retrieve all tourist spots with their descriptions and entry fees
SELECT Spot_ID, Spot_Name, Description, Entry_Fee
FROM Tourist_Spots
ORDER BY Spot_Name;

-- 2. Find the total number of customers who booked tours
SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- 3. Get the total revenue for each tour
SELECT T.Tour_Name, SUM(B.Total_Cost) AS Total_Revenue
FROM Bookings B
JOIN Tours T ON B.Tour_ID = T.Tour_ID
GROUP BY T.Tour_Name
ORDER BY Total_Revenue DESC;

-- 4. List all available discounts and their validity periods
SELECT D.Discount_ID, T.Tour_Name, D.Discount_Percentage, D.Start_Date, D.End_Date
FROM Discounts D
JOIN Tours T ON D.Tour_ID = T.Tour_ID
ORDER BY D.Start_Date;

-- 5. Find the reviews and average rating for each tourist spot
SELECT TS.Spot_Name, COUNT(R.Review_ID) AS Total_Reviews, AVG(R.Rating) AS Avg_Rating
FROM Reviews R
JOIN Tourist_Spots TS ON R.Spot_ID = TS.Spot_ID
GROUP BY TS.Spot_Name
ORDER BY Avg_Rating DESC;

-- 6. Retrieve the busiest guide (the guide assigned to the highest number of tours)
SELECT TG.Guide_Name, COUNT(TGA.Assignment_ID) AS Total_Assignments
FROM Tour_Guide_Assignments TGA
JOIN Tour_Guides TG ON TGA.Guide_ID = TG.Guide_ID
GROUP BY TG.Guide_Name
ORDER BY Total_Assignments DESC;

-- 7. Find customers who made payments using a specific method (e.g., 'Credit Card')
SELECT C.Customer_Name, C.Contact_Info, OP.Payment_Method
FROM Online_Payment OP
JOIN Bookings B ON OP.Booking_ID = B.Booking_ID
JOIN Customers C ON B.Customer_ID = C.Customer_ID
WHERE OP.Payment_Method = 'Credit Card';

-- 8. List all transportation options available for a specific tourist spot
SELECT TS.Spot_Name, T.Transport_Type, T.Cost_Per_Trip
FROM Spot_Transport_Links STL
JOIN Tourist_Spots TS ON STL.Spot_ID = TS.Spot_ID
JOIN Transportation T ON STL.Transport_ID = T.Transport_ID
WHERE TS.Spot_Name = 'Sajek Valley';

-- 9. Get the total number of bookings per tourist spot
SELECT TS.Spot_Name, COUNT(B.Booking_ID) AS Total_Bookings
FROM Bookings B
JOIN Tours T ON B.Tour_ID = T.Tour_ID
JOIN Tourist_Spots TS ON T.Spot_ID = TS.Spot_ID
GROUP BY TS.Spot_Name
ORDER BY Total_Bookings DESC;

-- 10. Retrieve emergency contact details for each tourist spot
SELECT TS.Spot_Name, EC.Contact_Type, EC.Contact_Number
FROM Emergency_Contacts EC
JOIN Tourist_Spots TS ON EC.Spot_ID = TS.Spot_ID
ORDER BY TS.Spot_Name;
