-- Create the TourismDB database
CREATE DATABASE TourismDB;
USE TourismDB;

-- Create Destinations table (Table 1)
CREATE TABLE Destinations (
    DestinationID INT PRIMARY KEY AUTO_INCREMENT,
    DestinationName VARCHAR(100) NOT NULL,
    District VARCHAR(50) NOT NULL,
    Description TEXT,
    BestTimeToVisit VARCHAR(100),
    AverageCostPerDay DECIMAL(10, 2),
    ImageURL VARCHAR(255)
);

-- Create Accommodations table (Table 2)
CREATE TABLE Accommodations (
    AccommodationID INT PRIMARY KEY AUTO_INCREMENT,
    DestinationID INT,
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    PricePerNight DECIMAL(10, 2),
    ContactNumber VARCHAR(15),
    Address VARCHAR(255),
    Rating DECIMAL(3, 1),
    FOREIGN KEY (DestinationID) REFERENCES Destinations(DestinationID)
);

-- Create Attractions table (Table 3)
CREATE TABLE Attractions (
    AttractionID INT PRIMARY KEY AUTO_INCREMENT,
    DestinationID INT,
    AttractionName VARCHAR(100) NOT NULL,
    Description TEXT,
    EntryFee DECIMAL(10, 2),
    OpeningHours VARCHAR(100),
    VisitDuration VARCHAR(50),
    FOREIGN KEY (DestinationID) REFERENCES Destinations(DestinationID)
);

-- Create Transportation table (Table 4) - Modified to include destination
CREATE TABLE Transportation (
    TransportationID INT PRIMARY KEY AUTO_INCREMENT,
    DestinationID INT,
    TransportType VARCHAR(50) NOT NULL,
    RouteDetails VARCHAR(255),
    AverageCost DECIMAL(10, 2),
    TravelDuration VARCHAR(50),
    Frequency VARCHAR(100),
    FOREIGN KEY (DestinationID) REFERENCES Destinations(DestinationID)
);

-- Create TourPackages table (Table 5) - Modified to include destinations covered
CREATE TABLE TourPackages (
    PackageID INT PRIMARY KEY AUTO_INCREMENT,
    PackageName VARCHAR(100) NOT NULL,
    Description TEXT,
    Duration INT,
    Price DECIMAL(10, 2),
    MaxGroupSize INT,
    Inclusions TEXT,
    DestinationsCovered VARCHAR(255) -- Stores a comma-separated list of destinations
);

-- Create TourGuides table (Table 6) - Modified to include specialized destinations
CREATE TABLE TourGuides (
    GuideID INT PRIMARY KEY AUTO_INCREMENT,
    GuideName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15),
    Languages VARCHAR(255),
    Experience INT,
    DailyRate DECIMAL(10, 2),
    Rating DECIMAL(3, 1),
    SpecializedDestinations VARCHAR(255) -- Stores info about areas of expertise
);

-- Create Customers table (Table 7)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

-- Create Bookings table (Table 8)
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    PackageID INT,
    GuideID INT,
    BookingDate DATE,
    TravelDate DATE,
    NumberOfPeople INT,
    TotalCost DECIMAL(10, 2),
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PackageID) REFERENCES TourPackages(PackageID),
    FOREIGN KEY (GuideID) REFERENCES TourGuides(GuideID)
);

-- Insert sample data into Destinations
INSERT INTO Destinations (DestinationName, District, Description, BestTimeToVisit, AverageCostPerDay, ImageURL) VALUES
('Ratargul Swamp Forest', 'Sylhet', 'The only freshwater swamp forest in Bangladesh', 'October-March', 800.00, 'ratargul.jpg'),
('Birishiri', 'Netrokona', 'Beautiful landscape with hills, rivers and ethnic communities', 'November-February', 700.00, 'birishiri.jpg'),
('Boga Lake', 'Bandarban', 'A natural lake nestled in the hills of Bandarban', 'October-April', 900.00, 'bogalake.jpg'),
('Satchari National Park', 'Habiganj', 'Rich biodiversity and home to rare Hoolock Gibbons', 'November-March', 650.00, 'satchari.jpg'),
('Tanguar Haor', 'Sunamganj', 'Ecologically critical wetland with rich biodiversity', 'December-February', 950.00, 'tanguar.jpg'),
('Nijhum Dwip', 'Noakhali', 'Remote island with spotted deer and pristine beaches', 'November-March', 750.00, 'nijhum.jpg'),
('Amiakhum Waterfall', 'Bandarban', 'One of the most beautiful waterfalls in Bangladesh', 'May-September', 850.00, 'amiakhum.jpg'),
('Lalakhal', 'Sylhet', 'Crystal clear blue water canal surrounded by tea gardens', 'Year-round', 780.00, 'lalakhal.jpg'),
('Sonadia Island', 'Cox\'s Bazar', 'Pristine beach with endangered wildlife', 'October-March', 920.00, 'sonadia.jpg'),
('Monpura Island', 'Bhola', 'Unexplored island with natural beauty', 'November-February', 700.00, 'monpura.jpg');

-- Insert sample data into Accommodations
INSERT INTO Accommodations (DestinationID, Name, Type, PricePerNight, ContactNumber, Address, Rating) VALUES
(1, 'Green Forest Resort', 'Resort', 1500.00, '01712345678', 'Gowainghat, Sylhet', 4.2),
(1, 'Ratargul Eco Cottage', 'Cottage', 800.00, '01812345678', 'Near Ratargul Forest, Sylhet', 3.8),
(2, 'Birishiri Tourist Lodge', 'Lodge', 600.00, '01912345678', 'Durgapur, Netrokona', 3.5),
(2, 'China Clay Homestay', 'Homestay', 350.00, '01612345678', 'Birishiri, Netrokona', 4.0),
(3, 'Boga Lake Camp', 'Camp', 450.00, '01512345678', 'Ruma, Bandarban', 3.7),
(4, 'Satchari Eco Resort', 'Eco Resort', 1200.00, '01812345679', 'Chunarughat, Habiganj', 4.1),
(5, 'Tanguar Haor Homestay', 'Homestay', 400.00, '01712345679', 'Dharmapasha, Sunamganj', 3.9),
(6, 'Nijhum Beach Cottage', 'Cottage', 750.00, '01912345679', 'Hatiya, Noakhali', 3.6),
(7, 'Hillside Rest House', 'Rest House', 900.00, '01612345679', 'Thanchi, Bandarban', 4.0),
(8, 'Lalakhal Resort', 'Resort', 1800.00, '01512345679', 'Jaintiapur, Sylhet', 4.5);

-- Insert sample data into Attractions
INSERT INTO Attractions (DestinationID, AttractionName, Description, EntryFee, OpeningHours, VisitDuration) VALUES
(1, 'Boat Ride in Swamp Forest', 'Experience the unique swamp forest from a boat', 200.00, '8:00 AM - 5:00 PM', '1-2 hours'),
(1, 'Forest Trail Walk', 'Guided walking tour through accessible parts of the forest', 150.00, '9:00 AM - 4:00 PM', '1 hour'),
(2, 'Someswari River', 'Beautiful river with crystal clear water', 0.00, 'Open 24/7', '1-3 hours'),
(2, 'China Clay Hills', 'Unique clay hills with panoramic views', 50.00, '8:00 AM - 6:00 PM', '2 hours'),
(3, 'Boga Lake View Point', 'Scenic viewpoint overlooking the lake', 100.00, '6:00 AM - 6:00 PM', '1 hour'),
(4, 'Hoolock Gibbon Trail', 'Trail to spot the rare primates', 200.00, '6:00 AM - 4:00 PM', '3 hours'),
(5, 'Tanguar Haor Boat Tour', 'Boat tour of the vast wetland ecosystem', 300.00, '7:00 AM - 5:00 PM', '4 hours'),
(6, 'Deer Sanctuary', 'Protected area with spotted deer', 150.00, '8:00 AM - 5:00 PM', '2 hours'),
(7, 'Amiakhum Falls Viewpoint', 'Viewing area for the magnificent waterfall', 100.00, '7:00 AM - 5:00 PM', '1-2 hours'),
(8, 'Blue Water Boat Ride', 'Boat tour on the famous blue water canal', 250.00, '8:00 AM - 4:00 PM', '2 hours');

-- Insert sample data into Transportation (modified table)
INSERT INTO Transportation (DestinationID, TransportType, RouteDetails, AverageCost, TravelDuration, Frequency) VALUES
(1, 'Local Bus', 'Sylhet City to Gowainghat', 200.00, '1.5 hours', 'Every 2 hours'),
(1, 'Boat', 'Final approach by boat', 300.00, '20 minutes', 'Regular during daylight'),
(2, 'Local Bus', 'Netrokona Town to Birishiri', 180.00, '1 hour', 'Every 3 hours'),
(3, 'Shared Jeep', 'Bandarban to Ruma', 400.00, '3 hours', 'Twice daily'),
(4, 'Local Bus', 'Habiganj to Satchari entrance', 150.00, '45 minutes', 'Every hour'),
(5, 'Boat', 'Dharmapasha to Tanguar Haor', 350.00, '1.5 hours', 'Morning and noon'),
(6, 'Launch', 'Hatiya Ghat to Nijhum Dwip', 250.00, '2 hours', 'Once daily'),
(7, 'Shared Jeep', 'Bandarban to Thanchi', 450.00, '4 hours', 'Morning only'),
(8, 'Reserved CNG', 'Sylhet city to Lalakhal', 800.00, '1 hour', 'On demand'),
(9, 'Boat', 'Cox\'s Bazar to Sonadia Island', 400.00, '1 hour', 'Weather dependent');

-- Insert sample data into TourPackages (modified table)
INSERT INTO TourPackages (PackageName, Description, Duration, Price, MaxGroupSize, Inclusions, DestinationsCovered) VALUES
('Hidden Sylhet Explorer', 'Explore the undiscovered gems of Sylhet region', 3, 4500.00, 10, 'Accommodation, Local Transport, Guide, Breakfast', 'Ratargul Swamp Forest, Lalakhal, Satchari National Park'),
('Hill Tribe Experience', 'Experience the culture of indigenous communities in Chittagong Hill Tracts', 4, 6000.00, 8, 'Accommodation, Transport, Guide, Meals', 'Boga Lake, Amiakhum Waterfall'),
('Wetland Wonder', 'Discover the unique ecosystem of haors and beels', 2, 3200.00, 12, 'Boat Tours, Accommodation, Guide, Breakfast', 'Tanguar Haor'),
('Island Hopping Adventure', 'Visit multiple off-the-beaten-path islands', 5, 8000.00, 6, 'All Transport, Accommodation, Guide, Meals', 'Nijhum Dwip, Sonadia Island, Monpura Island'),
('Budget Bandarban', 'Affordable exploration of Bandarban\'s natural beauty', 3, 4000.00, 15, 'Basic Accommodation, Shared Transport, Guide', 'Boga Lake, Amiakhum Waterfall'),
('Eco Retreat Package', 'Sustainable tourism in pristine natural areas', 4, 7500.00, 8, 'Eco-friendly Accommodations, Organic Meals, Guide, Activities', 'Satchari National Park, Tanguar Haor'),
('Weekend Escape', 'Quick getaway to nearby hidden gems', 2, 3000.00, 10, 'Transport, Accommodation, Breakfast, Activities', 'Birishiri');

-- Insert sample data into TourGuides (modified table)
INSERT INTO TourGuides (GuideName, ContactNumber, Languages, Experience, DailyRate, Rating, SpecializedDestinations) VALUES
('Kamal Hossain', '01712345680', 'Bengali, English', 7, 1000.00, 4.7, 'Ratargul Swamp Forest, Local Advisor'),
('Sonia Rahman', '01812345680', 'Bengali, English, Hindi', 5, 1200.00, 4.5, 'Sylhet Region, Bird Watching'),
('Rashed Khan', '01912345680', 'Bengali, English, Chakma', 10, 1500.00, 4.8, 'Boga Lake, Local Advisor'),
('Mina Begum', '01612345680', 'Bengali, English', 3, 800.00, 4.0, 'Nijhum Dwip, Local Advisor'),
('Arif Ahmed', '01512345680', 'Bengali, English, Marma', 8, 1300.00, 4.6, 'Bandarban Region, Trekking Expert'),
('Shahana Akhter', '01712345681', 'Bengali, English, Hindi', 6, 1100.00, 4.3, 'Tanguar Haor, Bird Watching'),
('Mizan Chowdhury', '01812345681', 'Bengali, English', 9, 1400.00, 4.7, 'Lalakhal, Cultural Expert'),
('Nadia Islam', '01912345681', 'Bengali, English, German', 4, 1300.00, 4.4, 'Cox\'s Bazar Region, Marine Life');

-- Insert sample data into Customers
INSERT INTO Customers (CustomerName, Email, Phone, Address) VALUES
('Rahim Ahmed', 'rahim@email.com', '01723456789', 'Dhaka'),
('Farida Begum', 'farida@email.com', '01823456789', 'Chittagong'),
('Mahfuz Ali', 'mahfuz@email.com', '01923456789', 'Khulna'),
('Nishat Khan', 'nishat@email.com', '01623456789', 'Rajshahi'),
('Omar Faruk', 'omar@email.com', '01523456789', 'Sylhet'),
('Taslima Akter', 'taslima@email.com', '01723456780', 'Barisal'),
('Zahir Uddin', 'zahir@email.com', '01823456780', 'Rangpur'),
('Sultana Yasmin', 'sultana@email.com', '01923456780', 'Mymensingh'),
('Kabir Hossain', 'kabir@email.com', '01623456780', 'Comilla'),
('Nargis Akhter', 'nargis@email.com', '01523456780', 'Jessore');

-- Insert sample data into Bookings
INSERT INTO Bookings (CustomerID, PackageID, GuideID, BookingDate, TravelDate, NumberOfPeople, TotalCost, PaymentStatus) VALUES
(1, 1, 1, '2025-01-10', '2025-02-15', 2, 9000.00, 'Paid'),
(2, 3, 6, '2025-01-15', '2025-03-05', 4, 12800.00, 'Paid'),
(3, 2, 3, '2025-01-20', '2025-02-25', 2, 12000.00, 'Pending'),
(4, 5, 5, '2025-02-01', '2025-03-15', 3, 12000.00, 'Paid'),
(5, 4, 4, '2025-02-05', '2025-04-10', 2, 16000.00, 'Paid'),
(6, 7, 7, '2025-02-10', '2025-02-28', 5, 15000.00, 'Pending'),
(7, 6, 8, '2025-02-15', '2025-03-20', 2, 15000.00, 'Paid'),
(8, 1, 2, '2025-02-20', '2025-04-05', 6, 27000.00, 'Pending'),
(9, 3, 6, '2025-03-01', '2025-04-15', 2, 6400.00, 'Paid'),
(10, 5, 5, '2025-03-05', '2025-04-20', 4, 16000.00, 'Pending');

-- Query 1: Find all destinations with average cost per day less than 1000 BDT
SELECT DestinationName, District, AverageCostPerDay
FROM Destinations
WHERE AverageCostPerDay < 1000
ORDER BY AverageCostPerDay;

-- Query 2: Find all accommodations with their destination names where price per night is less than 500 BDT
SELECT a.Name, a.Type, a.PricePerNight, d.DestinationName
FROM Accommodations a
JOIN Destinations d ON a.DestinationID = d.DestinationID
WHERE a.PricePerNight < 500
ORDER BY a.PricePerNight;

-- Query 3: Find the names of all the tour guides who are involved in advising
SELECT g.GuideName, g.Languages, g.Experience, g.SpecializedDestinations
FROM TourGuides g
WHERE g.SpecializedDestinations LIKE '%Advisor%'
ORDER BY g.GuideName;
