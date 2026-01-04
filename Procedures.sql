use mydb;

INSERT INTO customer_details (Guest_ID, GuestFullName, Guest_Contact)
VALUES
(1, 'Anna Smith', '555-1111'),
(2, 'John Doe', '555-2222'),
(3, 'Maria Garcia', '555-3333');

INSERT INTO Bookings (Booking_ID, BookingTime, Guest_ID, TableNo)
VALUES
(1, '2022-10-10', 1, 5),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 1, 2);

SELECT * FROM Bookings;

DELIMITER //

CREATE PROCEDURE CheckBooking(
    IN BookingTime DATE,
    IN TableNo INT
)
BEGIN
    DECLARE booking_status INT DEFAULT 0;

    -- Check if the table is already booked
    SELECT COUNT(*)
    INTO booking_status
    FROM bookings
    WHERE BookingTime = BookingTime
      AND TableNo = TableNo;

    -- Return result
    IF booking_status > 0 THEN
        SELECT CONCAT('Table ', TableNo, ' is already booked') AS BookingStatus;
    ELSE
        SELECT CONCAT('Table ', TableNo, ' is available') AS BookingStatus;
    END IF;

END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN BookingTime DATE,
    IN TableNo INT
)
BEGIN
    DECLARE table_count INT DEFAULT 0;

    START TRANSACTION;

    -- Check if the table is already booked
    SELECT COUNT(*)
    INTO table_count
    FROM Bookings
    WHERE BookingTime = BookingTime
      AND TableNo = TableNo;

    -- If table already booked, rollback
    IF table_count > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', TableNo, ' is already booked - booking cancelled') AS BookingStatus;

    -- If table available, insert and commit
    ELSE
        INSERT INTO Bookings (BookingTime, TableNo, Guest_ID)
        VALUES (BookingTime, TableNo, 1);

        COMMIT;
        SELECT CONCAT('Booking successful for table ', TableNo) AS BookingStatus;
    END IF;

END //

#Task 1
DELIMITER ;

CALL AddValidBooking('2022-10-10', 5);

DELIMITER //

CREATE PROCEDURE AddBooking(
    IN Booking_ID INT,
    IN Guest_ID INT,
    IN BookingTime DATE,
    IN TableNo INT
)
BEGIN
    INSERT INTO bookings (Booking_ID, Guest_ID, BookingTime, TableNo)
    VALUES (Booking_ID, Guest_ID, BookingTime, TableNo);
END //

DELIMITER ;
CALL AddBooking(5, 2, '2022-10-20', 4);

#Task 2
DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN Booking_ID INT,
    IN new_booking_date DATE
)
BEGIN
    UPDATE Bookings
    SET BookingTime = new_booking_date
    WHERE Booking_ID = Booking_id;
END //

DELIMITER ;
CALL UpdateBooking(1, '2022-11-01');
SELECT * FROM bookings WHERE BookingID = 1;


#Task 3

DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN Booking_ID INT
)
BEGIN
    DELETE FROM bookings
    WHERE Booking_ID = Booking_id;

    SELECT CONCAT('Booking ', Booking_ID, ' cancelled') AS BookingStatus;
END //

DELIMITER ;

