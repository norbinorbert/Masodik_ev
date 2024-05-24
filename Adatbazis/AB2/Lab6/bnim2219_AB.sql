USE master
GO

DROP DATABASE IF EXISTS DeliveryCompanies
GO

CREATE DATABASE DeliveryCompanies 
GO

USE DeliveryCompanies

CREATE TABLE DeliveryCompanies(
	DeliveryCompanyID INT IDENTITY,
	DeliveryCompanyName VARCHAR(50),
	DeliveryCompanyContact VARCHAR(50)
	CONSTRAINT PK_DeliveryCompanies_DeliveryCompanyID PRIMARY KEY (DeliveryCompanyID)
);

CREATE TABLE Drivers(
	DriverID INT IDENTITY,
	DriverSalary INT,
	DriverName VARCHAR(50),
	DriverAddress VARCHAR(100),
	DeliveryCompanyID INT,
	CONSTRAINT PK_Drivers_DriverID PRIMARY KEY (DriverID),
	CONSTRAINT FK_Drivers_DeliveryCompanyID FOREIGN KEY (DeliveryCompanyID) REFERENCES DeliveryCompanies(DeliveryCompanyID)
);

CREATE TABLE Customers(
	CustomerID INT IDENTITY,
	CustomerName VARCHAR(50),
	CustomerAddress VARCHAR(100),
	CustomerPhoneNumber VARCHAR(15),
	CONSTRAINT PK_Customers_CustomerID PRIMARY KEY (CustomerID)
);

CREATE TABLE Restaurants(
	RestaurantID INT IDENTITY,
	RestaurantName VARCHAR(50),
	RestaurantAddress VARCHAR(100),
	OpeningHour INT,
	ClosingHour INT,
	CONSTRAINT PK_Restaurants_RestaurantID PRIMARY KEY(RestaurantID)
);

CREATE TABLE Foods(
	FoodID INT IDENTITY,
	FoodName VARCHAR(30),
	FoodDescription VARCHAR(200),
	FoodPrice FLOAT,
	RestaurantID INT,
	VerRow rowversion,
	CONSTRAINT PK_Foods_FoodID PRIMARY KEY (FoodID),
	CONSTRAINT FK_Foods_RestaurantID FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

CREATE TABLE Orders(
	OrderID INT IDENTITY,
	OrderPrice FLOAT,
	OrderDate DATE,
	OrderHour INT,
	DeliveryCompanyID INT,
	CustomerID INT,
	DriverID INT,
	CONSTRAINT PK_Orders_OrderID PRIMARY KEY (OrderID),
	CONSTRAINT FK_Orders_DeliveryCompanyID FOREIGN KEY (DeliveryCompanyID) REFERENCES DeliveryCompanies(DeliveryCompanyID),
	CONSTRAINT FK_Orders_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
	CONSTRAINT FK_Orders_DriverID FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

CREATE TABLE OrderContains(
	OrderID INT,
	FoodID INT,
	Amount INT,
	CONSTRAINT PK_OrderContains_OrderID_FoodID PRIMARY KEY (OrderID, FoodID),
	CONSTRAINT FK_OrderContains_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderContains_FoodID FOREIGN KEY (FoodID) REFERENCES Foods(FoodID)
);

-- Inserting records into DeliveryCompanies table
INSERT INTO DeliveryCompanies (DeliveryCompanyName, DeliveryCompanyContact)
VALUES ('Fast Delivery', 'contact@fastdelivery.com'),
       ('Swift Couriers', 'info@swiftcouriers.com');

-- Inserting records into Drivers table
INSERT INTO Drivers (DriverSalary, DriverName, DriverAddress, DeliveryCompanyID)
VALUES (2500, 'John Smith', '123 Main Street, Cityville', 1),
       (2800, 'Emma Johnson', '456 Elm Street, Townsville', 2),
       (2700, 'Michael Brown', '789 Oak Street, Villagetown', 1);

-- Inserting records into Customers table
INSERT INTO Customers (CustomerName, CustomerAddress, CustomerPhoneNumber)
VALUES ('Alice Johnson', '101 Maple Avenue, Villagetown', '555-1234'),
       ('Bob Davis', '202 Pine Street, Cityville', '555-5678'),
       ('Charlie Wilson', '303 Cedar Street, Townsville', '555-9012');

-- Inserting records into Restaurants table
INSERT INTO Restaurants (RestaurantName, RestaurantAddress, OpeningHour, ClosingHour)
VALUES ('Pizza Palace', '10 Cherry Lane, Cityville', 10, 22),
       ('Burger Barn', '20 Apple Street, Townsville', 11, 23),
       ('Taco Tavern', '30 Orange Avenue, Villagetown', 12, 21);

-- Inserting records into Foods table
INSERT INTO Foods (FoodName, FoodDescription, FoodPrice, RestaurantID)
VALUES ('Pepperoni Pizza', 'Classic pizza topped with pepperoni slices', 10.99, 1),
       ('Cheeseburger', 'Juicy beef patty with melted cheese', 8.49, 2),
       ('Chicken Tacos', 'Soft tacos filled with seasoned chicken', 7.99, 3),
       ('Margherita Pizza', 'Traditional pizza with fresh tomatoes and basil', 9.99, 1),
	   ('Vegetarian Pizza', 'Pizza topped with assorted vegetables', 11.99, 1),
       ('BBQ Chicken Pizza', 'Pizza with BBQ sauce and grilled chicken', 12.49, 1),
       ('Mushroom Swiss Burger', 'Beef burger with mushrooms and Swiss cheese', 9.99, 2),
       ('Fish Tacos', 'Soft tacos filled with battered fish and coleslaw', 8.99, 3),
       ('Margherita Burger', 'Burger with fresh tomatoes, mozzarella, and basil', 10.49, 2),
       ('Steak Tacos', 'Soft tacos filled with grilled steak and onions', 11.99, 3),
       ('Hawaiian Pizza', 'Pizza with ham, pineapple, and cheese', 11.49, 1),
       ('Veggie Burger', 'Burger made with plant-based patty and veggies', 10.99, 2),
       ('Shrimp Tacos', 'Soft tacos filled with grilled shrimp and avocado', 12.99, 3),
       ('Supreme Pizza', 'Pizza loaded with various toppings', 12.99, 1);

-- Inserting records into Orders table
INSERT INTO Orders (OrderPrice, OrderDate, OrderHour, DeliveryCompanyID, CustomerID, DriverID)
VALUES (10.99, '2024-03-16', 12, 1, 1, 1),
       (18.49, '2024-03-16', 13, 2, 2, 2),
       (28.49, '2024-03-18', 13, 2, 2, 2),
       (84.49, '2024-03-11', 13, 2, 2, 2),
       (85.49, '2024-03-12', 13, 2, 2, 2),
       (68.49, '2024-03-13', 13, 2, 2, 2),
       (78.49, '2024-03-14', 13, 2, 2, 2),
       (48.49, '2024-03-15', 13, 2, 2, 2),
       (88.49, '2024-01-16', 13, 2, 2, 2),
       (98.49, '2024-02-16', 13, 2, 2, 2),
       (79.99, '2024-04-16', 14, 1, 3, 3);

-- Inserting records into OrderContains table
INSERT INTO OrderContains (FoodID, OrderID, Amount)
VALUES (1, 1, 1),
       (2, 2, 1),
       (3, 3, 1),
       (4, 1, 1);

GO
CREATE OR ALTER TRIGGER foodDelete
ON Foods
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM OrderContains
	WHERE FoodID IN (SELECT FoodID FROM deleted)

	DELETE FROM Foods
	WHERE FoodID IN (SELECT FoodID FROM deleted)
END
GO