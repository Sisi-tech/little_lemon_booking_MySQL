use little_lemon_booking;
create table Customers (
CustomerID int primary key,
FullName varchar(255),
ContactNumber varchar(255),
Email varchar(255)
);
create table Bookings (
BookingID int primary key,
TableNumber int,
BookingDate date,
CustomerID int,
foreign key (CustomerID) references Customers(CustomerID)
);

DELIMITER //
CREATE PROCEDURE CheckBooking(IN BookingDateParam DATE, IN TableNumberParam INT, OUT Result VARCHAR(255))
BEGIN
	DECLARE bookingExists INT;
	SELECT COUNT(*) INTO bookingExists FROM Bookings WHERE BookingDate = BookingDateParam AND TableNumber = TableNumberParam;
	IF bookingExists > 0 THEN
		SET Result = CONCAT('Table ', TableNumberParam, ' is already booked');
	ELSE 
		SET Result = CONCAT('Table ', TableNumberParam, ' is available');
	END IF;
END//
DELIMITER ;
CALL CheckBooking('2024-02-10', 3, @Result);
select @Result;

DELIMITER //
CREATE PROCEDURE AddBooking(INOUT bookingID int, INOUT tableNumb int, INOUT bookingDate DATE, INOUT customerID INT, OUT Result VARCHAR(255))
BEGIN
	INSERT INTO Bookings (BookingID, TableNumber, BookingDate, CustomerID)
    VALUES (bookingID, tableNumb, bookingDate, customerID);
    SET Result = 'New booking added';
END//
DELIMITER ;
select * from Bookings;
SET @bookingID := 3;
SET @tableNumb := 4;
SET @bookingDate := '2024-02-11';
SET @customerID := 3;
CALL AddBooking(@bookingID, @tableNumb, @bookingDate, @customerID, @Result);
SELECT @Result;

SET SQL_SAFE_UPDATES = 0;
DELIMITER //
CREATE PROCEDURE UpdateBooking(INOUT bookingID INT, INOUT bookingDate DATE, OUT Confirmation VARCHAR(255))
BEGIN
	UPDATE Bookings 
    SET BookingDate = bookingDate 
    WHERE BookingID = bookingID;
    SET Confirmation = CONCAT('Booking ', bookingID, ' updated');
END//
DELIMITER ;
SET @the_bookingID = 2;
SET @the_bookingDate = '2024-02-12';
CALL UpdateBooking(@the_bookingID, @the_bookingDate, @Confirmation);
select @Confirmation;

DELIMITER //
CREATE PROCEDURE CancelBooking(IN cancelBookingID INT, OUT Confirmation VARCHAR(255))
BEGIN
	DELETE FROM Bookings WHERE BookingID = cancelBookingID;
    SET Confirmation = CONCAT('Booking ', cancelBookingID, ' cancelled');
END//
DELIMITER ;
SET @cancelBookingID = 2;
CALL CancelBooking(@cancelBookingID, @Confirmation);
SELECT @Confirmation;




