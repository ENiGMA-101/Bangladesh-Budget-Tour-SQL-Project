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

-- 14. Table: Accommodations
CREATE TABLE Accommodations (
    Accommodation_ID INT IDENTITY(1,1) PRIMARY KEY,
    Accommodation_Name NVARCHAR(100) NOT NULL,
    Spot_ID INT NOT NULL,
    Type NVARCHAR(50) NOT NULL,
    Address NVARCHAR(200),
    Price_Per_Night DECIMAL(10,2) NOT NULL,
    Contact_Number NVARCHAR(20),
    FOREIGN KEY (Spot_ID) REFERENCES Tourist_Spots(Spot_ID) ON DELETE CASCADE
);

-- 15. Table: Accommodation_Bookings (linking accommodation to bookings)
CREATE TABLE Accommodation_Bookings (
    Accommodation_Booking_ID INT IDENTITY(1,1) PRIMARY KEY,
    Booking_ID INT NOT NULL,
    Accommodation_ID INT NOT NULL,
    Check_In DATE NOT NULL,
    Check_Out DATE NOT NULL,
    Total_Nights INT NOT NULL,
    Total_Cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID) ON DELETE CASCADE,
    FOREIGN KEY (Accommodation_ID) REFERENCES Accommodations(Accommodation_ID)
);

GO

--- Insert Data 

-- Tourist_Spots (20 entries)
INSERT INTO Tourist_Spots (Spot_Name, Location, Description, Entry_Fee, Best_Time_to_Visit) VALUES
('Sajek Valley', 'Rangamati', 'Famous for its scenic beauty and cloud-kissed hills', 50, 'Winter'),
('Ratargul Swamp Forest', 'Sylhet', 'Only swamp forest in Bangladesh', 30, 'Monsoon'),
('Cox''s Bazar', 'Cox''s Bazar', 'World''s longest sea beach', 100, 'Winter'),
('Sundarbans', 'Khulna', 'World''s largest mangrove forest and home of the Royal Bengal Tiger', 150, 'Winter'),
('Srimangal', 'Moulvibazar', 'Land of tea gardens and rolling hills', 20, 'Autumn'),
('Bandarban', 'Bandarban', 'Hill district with tribal villages and waterfalls', 40, 'Winter'),
('Nilgiri', 'Bandarban', 'Hilltop resort with misty views', 60, 'Winter'),
('Lalakhal', 'Sylhet', 'Crystal clear blue river', 25, 'Monsoon'),
('Mahasthangarh', 'Bogura', 'Ancient archaeological site', 30, 'Spring'),
('Kuakata', 'Patuakhali', 'Sea beach famous for both sunrise and sunset', 0, 'Winter'),
('Paharpur', 'Naogaon', 'UNESCO heritage site of an ancient Buddhist monastery', 40, 'Winter'),
('Jaflong', 'Sylhet', 'Stone collection area with river and hills', 35, 'Monsoon'),
('Ahsan Manzil', 'Dhaka', 'Historical pink palace in Dhaka', 20, 'Autumn'),
('Panam City', 'Sonargaon', 'Ancient abandoned city with colonial buildings', 30, 'Winter'),
('Boga Lake', 'Bandarban', 'Crystal clear natural lake in the hills', 20, 'Winter'),
('Rangamati', 'Rangamati', 'Town famous for Kaptai lake and hanging bridge', 25, 'Winter'),
('Madhabkunda Waterfall', 'Sylhet', 'Largest waterfall in Bangladesh', 50, 'Monsoon'),
('Shalban Vihara', 'Comilla', 'Ancient Buddhist monastery ruins', 25, 'Autumn'),
('Sitakunda', 'Chattogram', 'Ecological park and Chandranath hill', 15, 'Winter'),
('Saint Martin''s Island', 'Cox''s Bazar', 'Only coral island of Bangladesh', 100, 'Spring'),
('Tanguar Haor', 'Sunamganj', 'Expansive wetland ecosystem', 40, 'Monsoon');

-- Tours (20 entries, Spot_ID 1 to 20)
INSERT INTO Tours (Tour_Name, Spot_ID, Tour_Fee, Duration) VALUES
('Sajek Adventure', 1, 2500, '2 Days'),
('Ratargul Boat Tour', 2, 1200, '1 Day'),
('Cox''s Bazar Beach Tour', 3, 4000, '3 Days'),
('Sundarban Wildlife Safari', 4, 6000, '3 Days'),
('Srimangal Tea Garden Walk', 5, 800, '1 Day'),
('Bandarban Explorer', 6, 2200, '2 Days'),
('Nilgiri Hill Retreat', 7, 3000, '2 Days'),
('Lalakhal Boat Cruise', 8, 1800, '1 Day'),
('Mahasthangarh Heritage Tour', 9, 1000, '1 Day'),
('Kuakata Sunrise Trip', 10, 1600, '2 Days'),
('Paharpur Ruins Visit', 11, 1100, '1 Day'),
('Jaflong Nature Day', 12, 900, '1 Day'),
('Old Dhaka Heritage', 13, 1200, 'Half Day'),
('Panam City Photowalk', 14, 950, 'Half Day'),
('Boga Lake Trek', 15, 2500, '3 Days'),
('Rangamati Lake Tour', 16, 2100, '2 Days'),
('Waterfall Adventure', 17, 1300, '1 Day'),
('Shalban Vihara History', 18, 1400, '1 Day'),
('Sitakunda Eco Hike', 19, 950, '1 Day'),
('Saint Martin''s Coral Trip', 20, 5000, '3 Days'),
('Tanguar Haor Birdwatch', 21, 1700, '2 Days');

-- Tour_Guides (20 entries)
INSERT INTO Tour_Guides (Guide_Name, Contact_Info, Language_Skills, Experience_Years) VALUES
('Abdul Karim', 'karim.bd@gmail.com', 'Bengali, English', 4),
('Selina Akter', 'selina.bd@gmail.com', 'Bengali, Hindi', 3),
('Rafiq Islam', 'rafiq.islam@gmail.com', 'Bengali, English', 5),
('Nasima Begum', 'nasima.begum@gmail.com', 'Bengali, English', 2),
('Jamal Uddin', 'jamal.bd@gmail.com', 'Bengali, Marma', 6),
('Shirin Ahmed', 'shirin.ahmed@gmail.com', 'Bengali', 3),
('Rezaul Karim', 'rezaul.karim@gmail.com', 'Bengali, English', 7),
('Mukta Rahman', 'mukta.rahman@gmail.com', 'Bengali, English', 2),
('Tarek Aziz', 'tarek.aziz@gmail.com', 'Bengali, Chakma', 4),
('Fahim Chowdhury', 'fahim.chy@gmail.com', 'Bengali, English', 5),
('Rumana Yasmin', 'rumana.yasmin@gmail.com', 'Bengali, English', 3),
('Sazzad Hossain', 'sazzad.hossain@gmail.com', 'Bengali, English', 8),
('Lamia Islam', 'lamia.islam@gmail.com', 'Bengali', 1),
('Shafiqul Islam', 'shafiqul.islam@gmail.com', 'Bengali, English, Hindi', 10),
('Anisur Rahman', 'anisur.rahman@gmail.com', 'Bengali, English', 6),
('Sabina Yasmin', 'sabina.yasmin@gmail.com', 'Bengali, English', 4),
('Belal Ahmed', 'belal.ahmed@gmail.com', 'Bengali', 5),
('Farzana Parvin', 'farzana.parvin@gmail.com', 'Bengali, English', 2),
('Azizul Haque', 'azizul.haque@gmail.com', 'Bengali, English', 9),
('Tahmina Sultana', 'tahmina.sultana@gmail.com', 'Bengali', 3),
('Moinul Islam', 'moinul.islam@gmail.com', 'Bengali, English', 4);

-- Tour_Guide_Assignments (20)
INSERT INTO Tour_Guide_Assignments (Tour_ID, Guide_ID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10),
(11,11),(12,12),(13,13),(14,14),(15,15),
(16,16),(17,17),(18,18),(19,19),(20,20);

-- Customers (20)
INSERT INTO Customers (Customer_Name, Contact_Info, Preferred_Language) VALUES
('Md. Asif Rahman', 'asif.rahman@bdmail.com', 'Bengali'),
('Sadia Islam', 'sadia.islam@bdmail.com', 'English'),
('Zahid Hasan', 'zahid.hasan@bdmail.com', 'Bengali'),
('Khaleda Akter', 'khaleda.akter@bdmail.com', 'Bengali'),
('Farhan Ahmed', 'farhan.ahmed@bdmail.com', 'English'),
('Rumi Parvin', 'rumi.parvin@bdmail.com', 'Bengali'),
('Rayhan Hossain', 'rayhan.hossain@bdmail.com', 'English'),
('Papia Sultana', 'papia.sultana@bdmail.com', 'Bengali'),
('Ayesha Siddiqua', 'ayesha.siddiqua@bdmail.com', 'Bengali'),
('Sohag Mia', 'sohag.mia@bdmail.com', 'Bengali'),
('Mamun Khan', 'mamun.khan@bdmail.com', 'English'),
('Tania Rahman', 'tania.rahman@bdmail.com', 'Bengali'),
('Sakib Al Hasan', 'sakib.al.hasan@bdmail.com', 'English'),
('Rifat Jahan', 'rifat.jahan@bdmail.com', 'Bengali'),
('Jannatul Ferdous', 'jannatul.ferdous@bdmail.com', 'Bengali'),
('Rasel Ahmed', 'rasel.ahmed@bdmail.com', 'English'),
('Nusrat Jahan', 'nusrat.jahan@bdmail.com', 'Bengali'),
('Shuvo Chowdhury', 'shuvo.chowdhury@bdmail.com', 'English'),
('Farzana Haque', 'farzana.haque@bdmail.com', 'Bengali'),
('Arman Hossain', 'arman.hossain@bdmail.com', 'English'),
('Mehedi Hasan', 'mehedi.hasan@bdmail.com', 'Bengali');

-- Bookings (20)
INSERT INTO Bookings (Customer_ID, Tour_ID, Booking_Date, Total_Cost) VALUES
(1,1,'2025-01-10',2500),(2,2,'2025-01-15',1200),(3,3,'2025-01-20',4000),
(4,4,'2025-01-25',6000),(5,5,'2025-01-28',800),(6,6,'2025-02-01',2200),
(7,7,'2025-02-05',3000),(8,8,'2025-02-10',1800),(9,9,'2025-02-14',1000),
(10,10,'2025-02-17',1600),(11,11,'2025-02-20',1100),(12,12,'2025-02-22',900),
(13,13,'2025-02-25',1200),(14,14,'2025-02-27',950),(15,15,'2025-03-01',2500),
(16,16,'2025-03-05',2100),(17,17,'2025-03-10',1300),(18,18,'2025-03-12',1400),
(19,19,'2025-03-15',950),(20,20,'2025-03-20',5000);

-- Reviews (20)
INSERT INTO Reviews (Spot_ID, Customer_ID, Review_Text, Rating) VALUES
(1,1,'Amazing mountain views!',5),(2,2,'Loved the swamp forest adventure.',4),
(3,3,'Beach was clean and beautiful.',5),(4,4,'Saw deer and monkeys in Sundarbans.',4),
(5,5,'Had a great tea garden walk.',5),(6,6,'Lovely waterfalls and tribal villages.',4),
(7,7,'Nilgiri was misty and magical.',5),(8,8,'Lalakhal river was so blue.',5),
(9,9,'Historical place, very interesting.',4),(10,10,'Sunrise at Kuakata was breathtaking.',5),
(11,11,'Ancient ruins worth visiting.',4),(12,12,'Stones and river made Jaflong unique.',5),
(13,13,'Palace is well maintained.',5),(14,14,'Panam City is a photographer''s dream.',5),
(15,15,'Trek to Boga Lake was tough but rewarding.',4),
(16,16,'Boating on Kaptai lake was fun.',5),
(17,17,'Biggest waterfall I''ve seen!',5),(18,18,'Loved the ancient monastery ruins.',4),
(19,19,'Great spot for hiking.',4),(20,20,'Island paradise!',5);

-- Transportation (20)
INSERT INTO Transportation (Transport_Type, Cost_Per_Trip, Availability) VALUES
('Bus', 600, 'Daily'),('Jeep', 1500, 'On Demand'),('CNG', 300, 'Daily'),
('Boat', 800, 'On Demand'),('Train', 900, 'Twice Daily'),('Rickshaw', 50, 'Hourly'),
('Microbus', 1000, 'On Demand'),('Cycle', 100, 'Hourly'),('Ferry', 500, 'Daily'),
('Car', 2000, 'On Demand'),('Helicopter', 15000, 'On Demand'),
('Speedboat', 2000, 'On Demand'),('Pickup', 1300, 'On Demand'),
('Electric Scooter', 400, 'Hourly'),('Tourist Bus', 2000, 'Daily'),
('Launch', 1000, 'Daily'),('Shared Taxi', 700, 'Daily'),
('AC Bus', 1200, 'Daily'),('Tempo', 400, 'Hourly'),('Horse Carriage', 300, 'On Demand');

-- Spot_Transport_Links (20)
INSERT INTO Spot_Transport_Links (Spot_ID, Transport_ID, Comments) VALUES
(1,1,'Direct buses from Dhaka.'),(2,4,'Boat rides available.'),(3,5,'Train and bus available.'),
(4,9,'Ferry from Mongla.'),(5,1,'Bus from Sylhet.'),(6,2,'Jeep for hill travel.'),
(7,2,'Jeep from Bandarban town.'),(8,4,'Boat from Tamabil.'),(9,5,'Train from Dhaka.'),
(10,1,'Bus from Barisal.'),(11,1,'Bus from Dhaka.'),(12,3,'CNG from Sylhet.'),
(13,6,'Rickshaw in Old Dhaka.'),(14,1,'Bus from Dhaka.'),(15,2,'Jeep from Ruma.'),
(16,4,'Boat on Kaptai Lake.'),(17,1,'Bus from Sylhet.'),(18,1,'Bus from Comilla.'),
(19,2,'Jeep from Sitakunda Bazar.'),(20,9,'Boat from Teknaf.');

-- Discounts (20)
INSERT INTO Discounts (Tour_ID, Discount_Percentage, Start_Date, End_Date) VALUES
(1,10,'2025-01-01','2025-01-15'),(2,12,'2025-01-05','2025-01-20'),
(3,15,'2025-01-20','2025-01-31'),(4,20,'2025-02-01','2025-02-10'),
(5,8,'2025-01-28','2025-02-05'),(6,10,'2025-02-01','2025-02-10'),
(7,5,'2025-02-06','2025-02-15'),(8,12,'2025-02-10','2025-02-20'),
(9,7,'2025-02-14','2025-02-24'),(10,10,'2025-02-17','2025-02-27'),
(11,9,'2025-02-20','2025-02-28'),(12,7,'2025-02-22','2025-03-02'),
(13,15,'2025-02-25','2025-03-05'),(14,6,'2025-02-27','2025-03-07'),
(15,10,'2025-03-01','2025-03-11'),(16,13,'2025-03-05','2025-03-15'),
(17,8,'2025-03-10','2025-03-20'),(18,10,'2025-03-12','2025-03-22'),
(19,11,'2025-03-15','2025-03-25'),(20,20,'2025-03-20','2025-03-30'),
(1, 10, '2025-05-05', '2025-05-15'),
(2, 15, '2025-05-01', '2025-05-20'),
(3, 20, '2025-05-10', '2025-05-17'),
(4, 8, '2025-05-09', '2025-05-13'),
(5, 12, '2025-05-07', '2025-05-12');

-- Local_Shops (20)
INSERT INTO Local_Shops (Shop_Name, Spot_ID, Product_Type) VALUES
('Sajek Souvenirs',1,'Handicrafts'),('Ratargul Snacks',2,'Snacks'),
('Beach Shells',3,'Shell accessories'),('Sundarban Honey',4,'Honey'),
('Srimangal Tea House',5,'Tea'),('Tribal Handlooms',6,'Shawls'),
('Nilgiri Crafts',7,'Craftworks'),('Lalakhal Pottery',8,'Clay items'),
('Bogura Sweets',9,'Sweets'),('Kuakata Shop',10,'Souvenirs'),
('Paharpur Books',11,'Books'),('Jaflong Stones',12,'Stones'),
('Dhaka Gifts',13,'Gifts'),('Panam Bazaar',14,'Antiques'),
('Boga Lake Snacks',15,'Snacks'),('Rangamati Bamboo',16,'Bamboo crafts'),
('Sylhet Lemon',17,'Lemon'),('Comilla Clay',18,'Clay pots'),
('Sitakunda Plants',19,'Plants'),('Saint Martin Coconut',20,'Coconut oil');

-- Emergency_Contacts (20)
INSERT INTO Emergency_Contacts (Spot_ID, Contact_Type, Contact_Number) VALUES
(1,'Police','01700000001'),(2,'Hospital','01700000002'),(3,'Fire','01700000003'),
(4,'Rescue','01700000004'),(5,'Police','01700000005'),(6,'Hospital','01700000006'),
(7,'Fire','01700000007'),(8,'Rescue','01700000008'),(9,'Police','01700000009'),
(10,'Hospital','01700000010'),(11,'Fire','01700000011'),(12,'Rescue','01700000012'),
(13,'Police','01700000013'),(14,'Hospital','01700000014'),(15,'Fire','01700000015'),
(16,'Rescue','01700000016'),(17,'Police','01700000017'),(18,'Hospital','01700000018'),
(19,'Fire','01700000019'),(20,'Rescue','01700000020');

-- Online_Payment (20)
INSERT INTO Online_Payment (Booking_ID, Payment_Date, Payment_Amount, Payment_Method, Payment_Status) VALUES
(1,'2025-01-10',2500,'Credit Card','Completed'),(2,'2025-01-15',1200,'Mobile Banking','Completed'),
(3,'2025-01-20',4000,'Debit Card','Completed'),(4,'2025-01-25',6000,'Bkash','Completed'),
(5,'2025-01-28',800,'Cash','Completed'),(6,'2025-02-01',2200,'Credit Card','Pending'),
(7,'2025-02-05',3000,'Nagad','Completed'),(8,'2025-02-10',1800,'Rocket','Completed'),
(9,'2025-02-14',1000,'Bkash','Completed'),(10,'2025-02-17',1600,'Credit Card','Completed'),
(11,'2025-02-20',1100,'Mobile Banking','Completed'),(12,'2025-02-22',900,'Nagad','Completed'),
(13,'2025-02-25',1200,'Cash','Completed'),(14,'2025-02-27',950,'Bkash','Completed'),
(15,'2025-03-01',2500,'Credit Card','Completed'),(16,'2025-03-05',2100,'Rocket','Completed'),
(17,'2025-03-10',1300,'Bkash','Completed'),(18,'2025-03-12',1400,'Credit Card','Completed'),
(19,'2025-03-15',950,'Mobile Banking','Completed'),(20,'2025-03-20',5000,'Nagad','Completed');

-- Accommodations (20)
INSERT INTO Accommodations (Accommodation_Name, Spot_ID, Type, Address, Price_Per_Night, Contact_Number) VALUES
('Sajek Resort', 1, 'Resort', 'Sajek Valley, Rangamati', 3500, '01711111111'),
('Valley View Cottage', 1, 'Guest House', 'Sajek Valley', 2500, '01711112222'),
('Swamp Forest Inn', 2, 'Hotel', 'Ratargul, Sylhet', 2000, '01722221111'),
('Cox Beach Hotel', 3, 'Hotel', 'Cox''s Bazar', 4000, '01733331111'),
('Tiger Point Resort', 4, 'Resort', 'Sundarbans', 5500, '01744441111'),
('Tea Heaven', 5, 'Hotel', 'Srimangal', 2200, '01755551111'),
('Bandarban Hill Resort', 6, 'Resort', 'Bandarban', 3000, '01766661111'),
('Nilgiri Stay', 7, 'Guest House', 'Nilgiri', 3200, '01777771111'),
('Lalakhal Cottage', 8, 'Hotel', 'Lalakhal', 1800, '01788881111'),
('Heritage Inn', 9, 'Guest House', 'Mahasthangarh', 2000, '01799991111'),
('Kuakata Sea Breeze', 10, 'Hotel', 'Kuakata', 2100, '01811111111'),
('Paharpur Resthouse', 11, 'Guest House', 'Paharpur', 1700, '01822222222'),
('Jaflong Resort', 12, 'Resort', 'Jaflong', 2300, '01833333333'),
('Pink Palace Hotel', 13, 'Hotel', 'Dhaka', 2600, '01844444444'),
('Panam Heritage Stay', 14, 'Hotel', 'Panam City', 2400, '01855555555'),
('Boga Lake Eco Resort', 15, 'Resort', 'Boga Lake', 2700, '01866666666'),
('Lake View Resort', 16, 'Hotel', 'Rangamati', 2800, '01877777777'),
('Waterfall Inn', 17, 'Guest House', 'Madhabkunda', 1800, '01888888888'),
('Shalban Resort', 18, 'Resort', 'Comilla', 2200, '01899999999'),
('Sitakunda Guest House', 19, 'Guest House', 'Sitakunda', 1600, '01911111111'),
('Saint Martin Coral Resort', 20, 'Resort', 'Saint Martin''s', 3700, '01922222222');

-- Accommodation_Bookings (20, match Booking_ID/Accommodation_ID)
INSERT INTO Accommodation_Bookings (Booking_ID, Accommodation_ID, Check_In, Check_Out, Total_Nights, Total_Cost) VALUES
(1,1,'2025-01-10','2025-01-12',2,7000),(2,2,'2025-01-15','2025-01-17',2,5000),
(3,3,'2025-01-20','2025-01-22',2,4000),(4,4,'2025-01-25','2025-01-28',3,12000),
(5,5,'2025-01-28','2025-01-29',1,5500),(6,6,'2025-02-01','2025-02-04',3,6600),
(7,7,'2025-02-05','2025-02-07',2,6000),(8,8,'2025-02-10','2025-02-11',1,1800),
(9,9,'2025-02-14','2025-02-16',2,4000),(10,10,'2025-02-17','2025-02-20',3,6300),
(11,11,'2025-02-20','2025-02-22',2,3400),(12,12,'2025-02-22','2025-02-23',1,2300),
(13,13,'2025-02-25','2025-02-26',1,2600),(14,14,'2025-02-27','2025-02-28',1,2400),
(15,15,'2025-03-01','2025-03-03',2,5400),(16,16,'2025-03-05','2025-03-07',2,5600),
(17,17,'2025-03-10','2025-03-11',1,1800),(18,18,'2025-03-12','2025-03-14',2,4400),
(19,19,'2025-03-15','2025-03-16',1,1600),(20,20,'2025-03-20','2025-03-23',3,11100);





--- Queries

-- 1. List all tourist spots with their entry fees
SELECT Spot_Name, Location, Entry_Fee
FROM Tourist_Spots
ORDER BY Spot_Name;

-- 2. Show all tours and their related tourist spot
SELECT T.Tour_Name, S.Spot_Name, T.Tour_Fee, T.Duration
FROM Tours T
JOIN Tourist_Spots S ON T.Spot_ID = S.Spot_ID;

-- 3. Find all available guides and their experience
SELECT Guide_Name, Language_Skills, Experience_Years
FROM Tour_Guides;

-- 4. See which guide is assigned to which tour
SELECT TG.Guide_Name, T.Tour_Name
FROM Tour_Guide_Assignments GA
JOIN Tour_Guides TG ON GA.Guide_ID = TG.Guide_ID
JOIN Tours T ON GA.Tour_ID = T.Tour_ID
ORDER BY TG.Guide_Name;

-- 5. List all customers who booked a tour
SELECT DISTINCT C.Customer_Name, C.Contact_Info
FROM Bookings B
JOIN Customers C ON B.Customer_ID = C.Customer_ID;

-- 6. Show bookings with customer, tour name and booking date
SELECT C.Customer_Name, T.Tour_Name, B.Booking_Date, B.Total_Cost
FROM Bookings B
JOIN Customers C ON B.Customer_ID = C.Customer_ID
JOIN Tours T ON B.Tour_ID = T.Tour_ID
ORDER BY B.Booking_Date DESC;

-- 7. Display reviews for any spot (example: Sajek Valley)
SELECT C.Customer_Name, R.Review_Text, R.Rating
FROM Reviews R
JOIN Customers C ON R.Customer_ID = C.Customer_ID
JOIN Tourist_Spots S ON R.Spot_ID = S.Spot_ID
WHERE S.Spot_Name = 'Sajek Valley';

-- 8. List all transport types available for a spot (example: Cox's Bazar)
SELECT S.Spot_Name, T.Transport_Type, T.Cost_Per_Trip
FROM Spot_Transport_Links STL
JOIN Tourist_Spots S ON STL.Spot_ID = S.Spot_ID
JOIN Transportation T ON STL.Transport_ID = T.Transport_ID
WHERE S.Spot_Name = 'Cox''s Bazar';

-- 9. Show current discounts for tours (if any)
SELECT T.Tour_Name, D.Discount_Percentage, D.Start_Date, D.End_Date
FROM Discounts D
JOIN Tours T ON D.Tour_ID = T.Tour_ID
WHERE GETDATE() BETWEEN D.Start_Date AND D.End_Date;

-- 10. List all accommodations available at a spot (example: Srimangal)
SELECT S.Spot_Name, A.Accommodation_Name, A.Type, A.Price_Per_Night
FROM Accommodations A
JOIN Tourist_Spots S ON A.Spot_ID = S.Spot_ID
WHERE S.Spot_Name = 'Srimangal';

-- 11. Show all emergency contacts for a spot (example: Sundarbans)
SELECT S.Spot_Name, E.Contact_Type, E.Contact_Number
FROM Emergency_Contacts E
JOIN Tourist_Spots S ON E.Spot_ID = S.Spot_ID
WHERE S.Spot_Name = 'Sundarbans';

-- 12. Find all bookings with accommodation details (customer, hotel, check-in, check-out)
SELECT C.Customer_Name, A.Accommodation_Name, AB.Check_In, AB.Check_Out, AB.Total_Cost
FROM Accommodation_Bookings AB
JOIN Bookings B ON AB.Booking_ID = B.Booking_ID
JOIN Customers C ON B.Customer_ID = C.Customer_ID
JOIN Accommodations A ON AB.Accommodation_ID = A.Accommodation_ID
ORDER BY AB.Check_In DESC;
