# Tourism Database Project: Tour Underrated Places in Bangladesh at Low Cost

## Topic Description
This project focuses on creating a database system to manage information about underrated tourist destinations in Bangladesh that can be visited on a budget. The system will help tourists discover lesser-known places, understand cost structures, find suitable accommodations, explore local transportation options, and learn about the unique attractions each location offers. 

The database serves as a comprehensive resource for budget-conscious travelers looking to explore Bangladesh beyond the typical tourist spots.

---

## Entity Relationship Diagram
### Key Entities and Relationships
1. **Destinations** - Contains information about underrated places in Bangladesh.
2. **Accommodations** - Various lodging options available at each destination.
3. **Attractions** - Points of interest at each destination.
4. **Transportation** - Methods to reach destinations and move around locally.
5. **TourPackages** - Pre-designed tour options with cost details.
6. **TourGuides** - Information about available tour guides.
7. **Customers** - Information about tourists using the system.
8. **Bookings** - Records of customer reservations.

### Entity Relationships:
- A Destination can have multiple Accommodations (one-to-many).
- A Destination can have multiple Attractions (one-to-many).
- A Destination can be served by multiple Transportation options (many-to-many via `DestinationTransport`).
- A TourPackage can include multiple Destinations (managed through package details).
- A TourGuide can be assigned to multiple Bookings (one-to-many).
- A Customer can make multiple Bookings (one-to-many).
- A TourPackage can have multiple Bookings (one-to-many).

---

## ER Diagram

![ERDIAGRAM1 drawio](https://github.com/user-attachments/assets/108fde3e-e759-47fa-92f5-86603c675a2b)




## Schema Diagram

```-- Will update from Sanjid --```


### Tables and Attributes

1. **Destinations Table**  
   Stores information about tourist destinations.
   - `DestinationID` (PK)
   - `DestinationName`
   - `District`
   - `Description`
   - `BestTimeToVisit`
   - `AverageCostPerDay`
   - `ImageURL`

2. **Accommodations Table**  
   Stores lodging details near tourist spots.
   - `AccommodationID` (PK)
   - `DestinationID` (FK)
   - `Name`
   - `Type` (Hotel, Homestay, Hostel, etc.)
   - `PricePerNight`
   - `ContactNumber`
   - `Address`
   - `Rating`

3. **Attractions Table**  
   Stores attractions for each destination.
   - `AttractionID` (PK)
   - `DestinationID` (FK)
   - `AttractionName`
   - `Description`
   - `EntryFee`
   - `OpeningHours`
   - `VisitDuration`

4. **Transportation Table**  
   Stores transportation options for destinations.
   - `TransportationID` (PK)
   - `DestinationID` (FK)
   - `TransportType`
   - `RouteDetails`
   - `AverageCost`
   - `TravelDuration`
   - `Frequency`

5. **TourPackages Table**  
   Stores information about curated tour packages.
   - `PackageID` (PK)
   - `PackageName`
   - `Description`
   - `Duration`
   - `Price`
   - `MaxGroupSize`
   - `Inclusions`
   - `DestinationsCovered`

6. **TourGuides Table**  
   Stores information about available tour guides.
   - `GuideID` (PK)
   - `GuideName`
   - `ContactNumber`
   - `Languages`
   - `Experience`
   - `DailyRate`
   - `Rating`
   - `SpecializedDestinations`

7. **Customers Table**  
   Stores customer details.
   - `CustomerID` (PK)
   - `CustomerName`
   - `Email`
   - `Phone`
   - `Address`

8. **Bookings Table**  
   Stores booking records.
   - `BookingID` (PK)
   - `CustomerID` (FK)
   - `PackageID` (FK)
   - `GuideID` (FK)
   - `BookingDate`
   - `TravelDate`
   - `NumberOfPeople`
   - `TotalCost`
   - `PaymentStatus`

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


---

### Query 2: Find the total number of customers who booked tours
```sql
SELECT COUNT(*) AS Total_Customers
FROM Customers;
```

**Result:**

![2](https://github.com/user-attachments/assets/528bf023-d93a-4341-8a70-c8a7831a3d19)


---

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


---

### Query 4: List all available discounts and their validity periods
```sql
SELECT D.Discount_ID, T.Tour_Name, D.Discount_Percentage, D.Start_Date, D.End_Date
FROM Discounts D
JOIN Tours T ON D.Tour_ID = T.Tour_ID
ORDER BY D.Start_Date;
```

**Result:**

![4](https://github.com/user-attachments/assets/d0343292-dbf7-41eb-9e50-46fcd53c8835)


---


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


---


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



---


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



---


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


---


### Query 1: Get the total number of bookings per tourist spot
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



---


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


## Conclusion
This database system provides a comprehensive solution for managing information about underrated tourist destinations in Bangladesh that can be visited on a budget. The system enables budget-conscious travelers to discover new places, find affordable accommodations, and plan their trips efficiently.

For the SQL file and further details, refer to the accompanying [SQL Script](./tourismDB.sql).
