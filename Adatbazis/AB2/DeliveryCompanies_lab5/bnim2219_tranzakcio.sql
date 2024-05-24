USE DeliveryCompanies
GO

CREATE OR ALTER PROCEDURE sp_rendeles(@pName VARCHAR(50), @pAddress VARCHAR(100), @pPhone VARCHAR(15), @pDate DATE, @pHour INT, 
								@pDeliveryCompanyID INT, @pFoodIDs VARCHAR(100), @pFoodAmounts VARCHAR(100), @pOutputHour INT OUT)
AS BEGIN
SET NOCOUNT ON
--check if company exists
IF NOT EXISTS(SELECT 1 FROM DeliveryCompanies WHERE DeliveryCompanyID = @pDeliveryCompanyID)
BEGIN
	RAISERROR('This company doesn''t exist', 11, 1)
	RETURN -1
END

--check if date and time are correct (in the future)
IF DATEDIFF(D, GETDATE(), @pDate) < 0
BEGIN
	RAISERROR('Please provide a valid date', 11, 2)
	RETURN -2
END
IF (DATEDIFF(D, GETDATE(), @pDate) = 0 AND @pHour <= DATEPART(HOUR, GETDATE())
	OR @pHour < 0 OR @pHour >= 24)
BEGIN
	RAISERROR('Please provide a valid hour', 11, 3)
	RETURN -3
END

--check if there are the same number of IDs and amounts provided
SELECT value AS FoodID INTO #tmpFoods FROM STRING_SPLIT(@pFoodIDs, ' ')
SELECT value AS Amount INTO #tmpAmounts FROM STRING_SPLIT(@pFoodAmounts, ' ')

IF (SELECT COUNT(*) FROM #tmpFoods) != (SELECT COUNT(*) FROM #tmpAmounts)
BEGIN
	RAISERROR('The foodIDs and the amounts do not match in length', 11, 4)
	RETURN -4
END

DECLARE amountCursor CURSOR FOR (SELECT * FROM #tmpAmounts)
DECLARE foodIDCursor CURSOR FOR (SELECT * FROM #tmpFoods)
OPEN foodIDCursor
OPEN amountCursor
DECLARE @foodID VARCHAR(5)
DECLARE @amount VARCHAR(5)
FETCH NEXT FROM foodIDCursor INTO @foodID
FETCH NEXT FROM amountCursor INTO @amount

--check which restaurant closes the soonest
DECLARE @latestHour INT
SET @latestHour = 24
--calculate prices in case the order is correct
DECLARE @orderPrice FLOAT
SET @orderPrice = 0
DECLARE @foodPrice FLOAT
WHILE @@FETCH_STATUS = 0  
BEGIN
	--check if all food IDs are correct
	IF NOT EXISTS (SELECT 1 FROM Foods WHERE FoodID = @foodID)
	BEGIN
		RAISERROR('Please provide valid FoodIDs', 11, 5)
		CLOSE foodIDCursor
		DEALLOCATE foodIDCursor
		CLOSE amountCursor
		DEALLOCATE amountCursor
		RETURN -5
	END

	DECLARE @closing INT
	SELECT @closing = ClosingHour FROM Restaurants R JOIN Foods F ON R.RestaurantID = F.RestaurantID
		WHERE F.FoodID = @foodID
	--check if restaurants are open
	IF (SELECT OpeningHour FROM Restaurants R JOIN Foods F ON R.RestaurantID = F.RestaurantID 
		WHERE F.FoodID = @foodID) > @pHour OR
		@closing <= @pHour
	BEGIN
		RAISERROR('One of the restaurants is closed at the provided time, 
				please choose other food or another time', 11, 6)
		CLOSE foodIDCursor
		DEALLOCATE foodIDCursor
		CLOSE amountCursor
		DEALLOCATE amountCursor
		RETURN -6
	END

	--check if all amounts are numbers
	IF TRY_CAST(@amount AS INT) IS NULL OR TRY_CAST(@amount AS INT) <= 0
	BEGIN
		RAISERROR('Please provide positive numbers for the amounts', 11, 7)
		CLOSE foodIDCursor
		DEALLOCATE foodIDCursor
		CLOSE amountCursor
		DEALLOCATE amountCursor
		RETURN -7
	END

	--save the latest hour when the order can still be ordered
	IF @closing <= @latestHour
	BEGIN
		SET @latestHour = @closing
	END

	SELECT @foodPrice = FoodPrice FROM Foods WHERE FoodID = @foodID
	SET @orderPrice = @orderPrice + @foodPrice * @amount
	FETCH NEXT FROM foodIDCursor INTO @foodID 
	FETCH NEXT FROM amountCursor INTO @amount
END
CLOSE foodIDCursor
CLOSE amountCursor

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
--if customer doesn't exist then insert information about them into the table
IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerName = @pName 
				AND CustomerAddress = @pAddress AND CustomerPhoneNumber = @pPhone)
BEGIN
	INSERT INTO Customers VALUES(@pName, @pAddress, @pPhone)
	IF @@ERROR != 0
	BEGIN
		DEALLOCATE foodIDCursor
		DEALLOCATE amountCursor
		RAISERROR('Unexpected error. Please rerun the command', 11, 8)
		ROLLBACK
		RETURN -8
	END
END

--get the newly inserted customerID
DECLARE @customerID INT
SELECT @customerID = CustomerID FROM Customers WHERE CustomerName = @pName 
	AND CustomerAddress = @pAddress AND CustomerPhoneNumber = @pPhone

--get a the first driver that is available on that day and hour
DECLARE @driverID INT
SELECT TOP 1 @driverID = A.DriverID 
FROM (SELECT DISTINCT(D.DriverID)
	FROM Drivers D JOIN DeliveryCompanies DC ON D.DeliveryCompanyID = DC.DeliveryCompanyID
		WHERE DC.DeliveryCompanyID = @pDeliveryCompanyID
	EXCEPT
	SELECT DISTINCT(O.DriverID)
	FROM Drivers D JOIN DeliveryCompanies DC ON D.DeliveryCompanyID = DC.DeliveryCompanyID
		JOIN Orders O ON O.DeliveryCompanyID = DC.DeliveryCompanyID
	WHERE O.OrderDate = @pDate AND O.OrderHour = @pHour AND DC.DeliveryCompanyID = @pDeliveryCompanyID) A

--if there is a driver, then we can insert the new order and the order items
IF @driverID IS NOT NULL
BEGIN
	--new order
	INSERT INTO Orders (OrderPrice, OrderDate, OrderHour, DeliveryCompanyID, CustomerID, DriverID)
	VALUES (@orderPrice, @pDate, @pHour, @pDeliveryCompanyID, @customerID, @driverID)
	IF @@ERROR != 0
	BEGIN
		DEALLOCATE foodIDCursor
		DEALLOCATE amountCursor
		RAISERROR('Unexpected error. Please rerun the command', 11, 8)
		ROLLBACK
		RETURN -8
	END
	--newly inserted orderID
	DECLARE @orderID INT
	SELECT @orderID = OrderID FROM Orders WHERE OrderDate = @pDate AND OrderHour = @pHour AND OrderPrice = @orderPrice
		AND DeliveryCompanyID = @pDeliveryCompanyID AND CustomerID = @customerID AND DriverID = @driverID
	
	--insert the items in the OrderContains table
	OPEN foodIDCursor
	OPEN amountCursor
	FETCH NEXT FROM foodIDCursor INTO @foodID 
	FETCH NEXT FROM amountCursor INTO @amount
	WHILE @@FETCH_STATUS = 0  
	BEGIN
		INSERT INTO OrderContains (OrderID, FoodID, Amount)
		VALUES (@orderID, @foodID, @amount)
		IF @@ERROR != 0
		BEGIN
			DEALLOCATE foodIDCursor
			DEALLOCATE amountCursor
			RAISERROR('Unexpected error. Please rerun the command', 11, 8)
			ROLLBACK
			RETURN -8
		END
		FETCH NEXT FROM foodIDCursor INTO @foodID 
		FETCH NEXT FROM amountCursor INTO @amount
	END
	CLOSE foodIDCursor
	CLOSE amountCursor
	DEALLOCATE foodIDCursor
	DEALLOCATE amountCursor
	COMMIT
	RETURN 0
END

--if there are no drivers available at the provided hour then iterate through the remaining hours in the day
DECLARE @i INT
SET @i = @pHour + 1
WHILE @i < @latestHour
BEGIN
	SELECT TOP 1 @driverID = A.DriverID 
	FROM (SELECT DISTINCT(D.DriverID)
		FROM Drivers D JOIN DeliveryCompanies DC ON D.DeliveryCompanyID = DC.DeliveryCompanyID
		WHERE DC.DeliveryCompanyID = @pDeliveryCompanyID
		EXCEPT
		SELECT DISTINCT(O.DriverID)
		FROM Drivers D JOIN DeliveryCompanies DC ON D.DeliveryCompanyID = DC.DeliveryCompanyID
			JOIN Orders O ON O.DeliveryCompanyID = DC.DeliveryCompanyID AND O.DriverID = D.DriverID
		WHERE O.OrderDate = @pDate AND O.OrderHour = @i AND DC.DeliveryCompanyID = @pDeliveryCompanyID) A

	IF @driverID IS NOT NULL
	BEGIN
		SET @pOutputHour = @i
		RAISERROR('Can''t order at provided hour. Please check output for the next available hour', 6, 9)
		DEALLOCATE foodIDCursor
		DEALLOCATE amountCursor
		ROLLBACK
		RETURN -9
	END
	SET @i = @i + 1
END

DEALLOCATE foodIDCursor
DEALLOCATE amountCursor
RAISERROR('Can''t complete order on the selected day. Please select another day', 11, 10)
ROLLBACK
RETURN -10
END
GO

/*
--food amounts incorrect
DECLARE @output INT
DECLARE @return INT
EXEC @return = sp_rendeles 'Name', 'Address', '0712312312', '2025-05-17', 17, 1, '1 2 3', '3 a 3', @output OUT
SELECT @output OutputParam, @return ReturnValue

--new user gets inserted and everything goes as planned
DECLARE @output INT
DECLARE @return INT
EXEC @return = sp_rendeles 'Name', 'Address', '0712312312', '2025-04-18', 19, 1, '1 2 3', '2 2 2', @output OUT
SELECT @output OutputParam, @return ReturnValue


--not available at current hour
EXEC sp_rendeles 'Name', 'Address', '0712312312', '2025-04-18', 19, 1, '1 2 3', '2 2 2', null
DECLARE @output INT
DECLARE @return INT
EXEC @return = sp_rendeles 'Name', 'Address', '0712312312', '2025-04-18', 19, 1, '1 2 3', '2 2 2', @output OUT
SELECT @output OutputParam, @return ReturnValue

--not available today
EXEC sp_rendeles 'Name', 'Address', '0712312312', '2025-04-18', 19, 2, '1 2 3', '2 2 2', null
EXEC sp_rendeles 'Name', 'Address', '0712312312', '2025-04-18', 20, 2, '1 2 3', '2 2 2', null
DECLARE @output INT
DECLARE @return INT
EXEC @return = sp_rendeles 'Name', 'Address', '0712312312', '2025-04-18', 19, 2, '1 2 3', '2 2 2', @output OUT
SELECT @output OutputParam, @return ReturnValue

SELECT * FROM Drivers
SELECT * FROM Customers
SELECT * FROM Restaurants
SELECT * FROM Foods
SELECT * FROM Orders
SELECT * FROM OrderContains
*/