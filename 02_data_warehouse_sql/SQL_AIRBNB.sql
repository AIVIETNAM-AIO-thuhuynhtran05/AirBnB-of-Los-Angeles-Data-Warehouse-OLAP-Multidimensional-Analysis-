-- ======================================
-- 1. T?o database

-- ======================================
Create database final;
Use final;
-- =========================================
-- 1. T?o các b?ng v?i ID t? t?ng
-- =========================================

CREATE TABLE [Fact_Listing] (
  [listing_id] BIGINT PRIMARY KEY,
  [host_id] INT,
  [room_id] INT,
  [location_id] INT,
  [price] INT,
  [availability_365] INT,
  [reviews_per_month] FLOAT,
  [number_of_reviews] INT,
  [review_scores_rating] FLOAT,
  [first_review] DATE,
  [last_review] DATE
);



CREATE TABLE [Fact_Raw] (
    [listing_id] BIGINT PRIMARY KEY,                -- ID g?c c?a listing
    [host_id] INT,    
    host_since date,
    -- ID c?a host (lookup sang Dim_Host)    
    -- Thông tin lo?i phòng (lookup sang Dim_RoomType + Dim_PropertyType)
    [room_type] NVARCHAR(255),
    [property_type] NVARCHAR(255),
    [accommodates] INT,
    [bathrooms] FLOAT,
    [bedrooms] INT,
    [beds] INT,
    -- Thông tin v? trí (lookup sang Dim_Location + Dim_LocationGroup)
    [neighbourhood_group_cleansed] NVARCHAR(500),
    [neighbourhood_cleansed] NVARCHAR(500),
    [latitude] FLOAT,
    [longitude] FLOAT,
    -- Thông tin ??t phòng (lookup sang Dim_BookingOption)
    [instant_bookable] BIT,
    -- Thông tin review (lookup sang Dim_Time n?u c?n)
    [first_review] DATE,
    [last_review] DATE,
    -- Các measure (thông tin ??nh l??ng th?c t?)
    [price] INT,
    [availability_365] INT,
    [reviews_per_month] FLOAT,
    [number_of_reviews] INT,
    [review_scores_rating] FLOAT
);
GO



CREATE TABLE [Dim_Time] (
  [time_key] INT IDENTITY(1,1) PRIMARY KEY,
  [full_date] DATE,
  [month] INT,
  [quarter] INT,
  [year] INT
);
GO



CREATE TABLE [Dim_Host] (
  [host_id] INT PRIMARY KEY,
  [host_name] NVARCHAR(1000),
  [host_since] DATE,
  [time_key] INT,
  [host_response_rate] FLOAT,
  [host_acceptance_rate] FLOAT,
  [host_is_superhost] BIT,
  [experience_years] INT
);
GO

CREATE TABLE [Dim_Host_final] (
  [host_id] INT PRIMARY KEY,
  [host_name] NVARCHAR(1000),
  [host_since] DATE,
  [time_key] INT,
  [host_response_rate] FLOAT,
  [host_acceptance_rate] FLOAT,
  [host_is_superhost] BIT,
  [experience_years] INT
);
GO

GO



CREATE TABLE [Dim_RoomType] (
  [room_id] INT IDENTITY(1,1) PRIMARY KEY,
  [room_type] NVARCHAR(255),,
  [accommodates] INT,
  [bathrooms] FLOAT,
  [bedrooms] INT,
  [beds] INT,
  property_type nvarchar(255)
);
GO




CREATE TABLE [Dim_Location] (
  [location_id] INT IDENTITY(1,1) PRIMARY KEY,
  [neighbourhood_cleansed] NVARCHAR(500),
  [latitude] FLOAT,
  [longitude] FLOAT,
  [neighbourhood_group_cleansed] NVARCHAR(500)
);
GO



-- =========================================
-- 2. T?o các ràng bu?c khóa ngo?i
-- =========================================

ALTER TABLE Fact_Listing 
ADD FOREIGN KEY (host_id) REFERENCES Dim_Host(host_id),
    FOREIGN KEY (room_id) REFERENCES Dim_RoomType(room_id),
    FOREIGN KEY (location_id) REFERENCES Dim_Location(location_id),
    FOREIGN KEY (booking_option_id) REFERENCES Dim_BookingOption(booking_option_id);
