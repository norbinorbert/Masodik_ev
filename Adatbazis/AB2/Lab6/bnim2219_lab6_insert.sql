USE DeliveryCompanies
GO

-- generate 100k restaurants
create or alter procedure GenerateRandomRestaurants
as
begin
-- the bulk insert script will be stored in this variable
declare @insert_string varchar(max)
-- MS SQL allows the insertion of maximum 1000 rows at a time, we will keep a counter to add values to the insert_string in this variable
declare @no_of_new_rows int
-- the number of batches, each batch will insert 1000 rows
declare @no_batches int

set @no_batches = 0

-- random variables to be inserted
declare @restaurant_name varchar(100)
declare @restaurant_address varchar(100)
declare @opening_hour int

-- loop through the 100 batches to achieve the insertion of 100.000 new records 
while @no_batches < 100
	begin
		set @insert_string = 'insert into Restaurants (RestaurantName, RestaurantAddress, OpeningHour, ClosingHour) values '
		set @no_of_new_rows = 0
		-- loop through one batch and concatenate the values
		while @no_of_new_rows < 1000
			begin
				-- generate some random values to be inserted
				set @restaurant_name = concat('Restaurant ', @no_batches * 1000 + @no_of_new_rows)
				set @restaurant_address = concat('Address ', @no_batches * 1000 + @no_of_new_rows)
				set @opening_hour = floor(rand()*24)
				
				-- when the first record is added we don't need a comma after the values, the comma is needed after the first record
				if @no_of_new_rows = 0
					set @insert_string = concat(@insert_string, ' (''', @restaurant_name, ''', ''', @restaurant_address, ''', ', @opening_hour, ', ', (@opening_hour + 8) % 24, ') ')
				else 
					set @insert_string = concat(@insert_string, ', (''', @restaurant_name, ''', ''', @restaurant_address , ''', ', @opening_hour, ', ', (@opening_hour + 8) % 24,  ') ')
					
				set @no_of_new_rows = @no_of_new_rows + 1
			end
		-- execute the insert_string that holds the insert statement to be executed
		execute(@insert_string)
		
		set @no_batches = @no_batches + 1
	end
end
GO

-- generate 500k foods
create or alter procedure GenerateRandomFoods
as
begin
-- the bulk insert script will be stored in this variable
declare @insert_string varchar(max)
-- MS SQL allows the insertion of maximum 1000 rows at a time, we will keep a counter to add values to the insert_string in this variable
declare @no_of_new_rows int
-- the number of batches, each batch will insert 1000 rows
declare @no_batches int

set @no_batches = 0

-- random variables to be inserted
declare @food_name varchar(100)
declare @food_desc varchar(100)
declare @price FLOAT
declare @restaurant int

-- loop through the 500 batches to achieve the insertion of 500.000 new records 
while @no_batches < 500
	begin
		set @insert_string = 'insert into Foods (FoodName, FoodDescription, FoodPrice, RestaurantID) values '
		set @no_of_new_rows = 0
		-- loop through one batch and concatenate the values
		while @no_of_new_rows < 1000
			begin
				-- generate some random values to be inserted
				set @food_name = concat('Food ', @no_batches * 1000 + @no_of_new_rows)
				set @food_desc = concat('Description ', @no_batches * 1000 + @no_of_new_rows)
				set @price = rand() * 100
				set @restaurant = floor(rand()*100000 + 1)
				
				-- when the first record is added we don't need a comma after the values, the comma is needed after the first record
				if @no_of_new_rows = 0
					set @insert_string = concat(@insert_string, ' (''', @food_name, ''', ''', @food_desc, ''', ', @price, ', ', @restaurant, ') ')
				else 
					set @insert_string = concat(@insert_string, ', (''', @food_name, ''', ''', @food_desc , ''', ', @price, ', ', @restaurant,  ') ')
					
				set @no_of_new_rows = @no_of_new_rows + 1
			end
		-- execute the insert_string that holds the insert statement to be executed
		execute(@insert_string)
		
		set @no_batches = @no_batches + 1
	end
end
GO


-- generate 100k orderContains
create or alter procedure GenerateRandomOrderContains
as
begin
-- the bulk insert script will be stored in this variable
declare @insert_string varchar(max)
-- MS SQL allows the insertion of maximum 1000 rows at a time, we will keep a counter to add values to the insert_string in this variable
declare @no_of_new_rows int
-- the number of batches, each batch will insert 1000 rows
declare @no_batches int

set @no_batches = 0

-- random variables to be inserted
declare @orderID INT
declare @foodID INT
declare @amount FLOAT

-- loop through the 100 batches to achieve the insertion of 100.000 new records 
while (SELECT COUNT(*) FROM OrderContains) < 100000
	begin
		set @insert_string = 'insert into OrderContains (OrderID, FoodID, Amount) values '
		set @no_of_new_rows = 0
		-- loop through one batch and concatenate the values
		while @no_of_new_rows < 100
			begin
				-- generate some random values to be inserted
				set @orderID = floor(rand() * 11 + 1)
				set @foodID = floor(rand() * 500000 + 1)
				set @amount = floor(rand()*20)
				
				-- when the first record is added we don't need a comma after the values, the comma is needed after the first record
				if @no_of_new_rows = 0
					set @insert_string = concat(@insert_string, ' (', @orderID, ', ', @foodID, ', ', @amount, ') ')
				else 
					set @insert_string = concat(@insert_string, ', (', @orderID, ', ', @foodID, ', ', @amount, ') ')
					
				set @no_of_new_rows = @no_of_new_rows + 1
			end
		-- execute the insert_string that holds the insert statement to be executed
		execute(@insert_string)
		
		set @no_batches = @no_batches + 1
	end
end
GO


exec GenerateRandomRestaurants
exec GenerateRandomFoods
exec GenerateRandomOrderContains
