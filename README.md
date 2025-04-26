# Tourism Database Project: Underrated Places in Bangladesh at Low Cost

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

## Schema Diagram
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

### Query 1: Find all destinations with average cost per day less than 1000 BDT
```sql
SELECT DestinationName, District, AverageCostPerDay
FROM Destinations
WHERE AverageCostPerDay < 1000
ORDER BY AverageCostPerDay;
```

**Result:**
| DestinationName       | District    | AverageCostPerDay |
|-----------------------|-------------|-------------------|
| Birishiri            | Netrokona   | 700.00            |
| Monpura Island       | Bhola       | 700.00            |
| Nijhum Dwip          | Noakhali    | 750.00            |
| Lalakhal             | Sylhet      | 780.00            |
| Ratargul Swamp Forest| Sylhet      | 800.00            |
| Amiakhum Waterfall   | Bandarban   | 850.00            |
| Boga Lake            | Bandarban   | 900.00            |
| Tanguar Haor         | Sunamganj   | 950.00            |

---

### Query 2: Find all accommodations with their destination names where price per night is less than 500 BDT
```sql
SELECT a.Name, a.Type, a.PricePerNight, d.DestinationName
FROM Accommodations a
JOIN Destinations d ON a.DestinationID = d.DestinationID
WHERE a.PricePerNight < 500
ORDER BY a.PricePerNight;
```

**Result:**
| Name                 | Type        | PricePerNight | DestinationName |
|----------------------|-------------|---------------|-----------------|
| China Clay Homestay  | Homestay    | 350.00        | Birishiri       |
| Tanguar Haor Homestay| Homestay    | 400.00        | Tanguar Haor    |
| Boga Lake Camp       | Camp        | 450.00        | Boga Lake       |

---

### Query 3: Find the names of all the tour guides who are involved in advising
```sql
SELECT g.GuideName, g.Languages, g.Experience, g.SpecializedDestinations
FROM TourGuides g
WHERE g.SpecializedDestinations LIKE '%Advisor%'
ORDER BY g.GuideName;
```

**Result:**
| GuideName      | Languages            | Experience | SpecializedDestinations         |
|----------------|----------------------|------------|---------------------------------|
| Kamal Hossain | Bengali, English     | 7          | Ratargul Swamp Forest, Advisor |
| Mina Begum     | Bengali, English     | 3          | Nijhum Dwip, Advisor           |
| Rashed Khan    | Bengali, English, Chakma | 10     | Boga Lake, Advisor             |

---

## Conclusion
This database system provides a comprehensive solution for managing information about underrated tourist destinations in Bangladesh that can be visited on a budget. The system enables budget-conscious travelers to discover new places, find affordable accommodations, and plan their trips efficiently.

For the SQL file and further details, refer to the accompanying [SQL Script](./tourismDB.sql).
