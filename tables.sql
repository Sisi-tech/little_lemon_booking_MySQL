use little_lemon_booking;
create table Orders (
OrderID INT PRIMARY KEY,
MenuID INT,
CustomerID INT,
TotalCost Decimal,
FOREIGN KEY (MenuID) REFERENCES Menus(MenuID),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE MenuItems (
MenuItemsID INT PRIMARY KEY,
CourseName VARCHAR(255),
StarterName VARCHAR(255),
DesertName VARCHAR(255)
);
CREATE TABLE Menus (
MenuID INT PRIMARY KEY,
MenuItemsID INT,
MenuName VARCHAR(255),
Cuisine VARCHAR(255),
FOREIGN KEY (MenuItemsID) REFERENCES MenuItems(MenuItemsID)
);

DELIMITER //
CREATE PROCEDURE GetMaxQuantity(OUT Result VARCHAR(255), OUT maxNum INT)
BEGIN
	SELECT 'Max Quantity in Order' INTO Result;
    SELECT MAX(TotalCost) INTO maxNum FROM Orders;
END //
DELIMITER ;