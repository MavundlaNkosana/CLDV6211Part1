USE master
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'EventEase')
DROP DATABASE EventEase
CREATE DATABASE EventEase

USE EventEase

CREATE TABLE Venue (
    VenueId INT PRIMARY KEY IDENTITY(1,1),
    VenueName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    Capacity INT NOT NULL,
    ImageUrl NVARCHAR(500) NULL
);

CREATE TABLE Event (
    EventId INT PRIMARY KEY IDENTITY(1,1),
    EventName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    VenueId INT NULL,
    CONSTRAINT FK_Event_Venue FOREIGN KEY (VenueId) REFERENCES Venue(VenueId)
);

CREATE TABLE Booking (
    BookingId INT PRIMARY KEY IDENTITY(1,1),
    EventId INT NOT NULL,
    VenueId INT NOT NULL,
    BookingDate DATETIME NOT NULL DEFAULT GETDATE(),
    IsConfirmed BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Booking_Event FOREIGN KEY (EventId) REFERENCES Event(EventId),
    CONSTRAINT FK_Booking_Venue FOREIGN KEY (VenueId) REFERENCES Venue(VenueId),
    CONSTRAINT UQ_Event_Venue UNIQUE (EventId, VenueId)
);