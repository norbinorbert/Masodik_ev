using System.Data;
using System.Data.SqlClient;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Deliveries
{
    public struct Food
    {
        int foodId;
        string foodName;
        string description;
        float price;
        Restaurant restaurant;
        byte[] verRow;

        public int FoodId
        {
            get { return foodId; }
            set { foodId = value; }
        }

        public string FoodName
        {
            get { return foodName; }
            set { foodName = value; }
        }

        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        public Restaurant Restaurant
        {
            get { return restaurant; }
            set { restaurant = value; }
        }

        public float Price
        {
            get { return price; }
            set { price = value; }
        }
        public byte[] VerRow
        {
            get { return verRow; }
            set { verRow = value; }
        }
    }

    public class FoodsDAL : DALGen
    {
        public FoodsDAL(ref string error)
        {
            CreateConnection(ref error);
        }

        public List<Food> GetFoodListDataSet(int restaurantID, string prefix, ref string error)
        {
            SqlCommand query = new SqlCommand("SELECT FoodID, FoodName, FoodDescription, FoodPrice, VerRow, R.RestaurantID, RestaurantName, RestaurantAddress, OpeningHour, " +
                "ClosingHour FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID WHERE (@RID IS NULL OR R.RestaurantID = @RID) AND F.FoodName LIKE @prefix");

            SqlParameter RID = new SqlParameter("@RID", DBNull.Value);
            if (restaurantID > 0)
            {
                RID.Value = restaurantID;
            }
            query.Parameters.Add(RID);

            if (prefix == null)
            {
                prefix = "";
            }
            SqlParameter restaurantPrefix = new SqlParameter("@prefix", $"{prefix}%");
            query.Parameters.Add(restaurantPrefix);

            DataSet ds_table = new DataSet();
            ds_table = ExecuteDS(query, ref error);

            List<Food> foodList = new List<Food>();

            if (error == "OK")
            {
                Food item = new Food();
                foreach (DataRow r in ds_table.Tables[0].Rows)
                {                    
                    try
                    {
                        item.FoodId = Convert.ToInt32(r["FoodID"]);
                        item.FoodName = r["FoodName"].ToString();
                        item.Description = r["FoodDescription"].ToString();
                        item.Price = Convert.ToSingle(r["FoodPrice"]);
                        item.Restaurant = new Restaurant(Convert.ToInt32(r["RestaurantID"]), r["RestaurantName"].ToString(), r["RestaurantAddress"].ToString(),
                            Convert.ToInt32(r["OpeningHour"]), Convert.ToInt32(r["ClosingHour"]));
                        item.VerRow = (byte[])r["VerRow"];
                    }
                    catch (Exception ex)
                    {
                        error = "Invalid data " + ex.Message;
                    }

                    foodList.Add(item);
                }
            }
            return foodList;
        }

        public void DeleteFoodByID(int foodID, ref string error)
        {
            SqlCommand deleteCommand = new SqlCommand("DELETE From Foods WHERE FoodID = @foodID");

            SqlParameter ID = new SqlParameter("@foodID", foodID);
            deleteCommand.Parameters.Add(ID);

            ExecuteNonQuery(deleteCommand, ref error);
        }

        public Food GetFoodByID(int foodID, ref string error)
        {
            SqlCommand query = new SqlCommand("SELECT FoodID, FoodName, FoodDescription, FoodPrice, VerRow, R.RestaurantID, RestaurantName, RestaurantAddress, OpeningHour, " + 
                "ClosingHour FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID WHERE F.FoodID = @foodID");

            SqlParameter ID = new SqlParameter("@foodID", foodID);
            query.Parameters.Add(ID);

            DataSet ds_table = new DataSet();
            ds_table = ExecuteDS(query, ref error);
            
            Food food = new Food();
            if (error == "OK")
            {
                DataRow r = ds_table.Tables[0].Rows[0];
                try
                {
                    food.FoodId = Convert.ToInt32(r["FoodID"]);
                    food.FoodName = r["FoodName"].ToString();
                    food.Description = r["FoodDescription"].ToString();
                    food.Price = Convert.ToSingle(r["FoodPrice"]);
                    food.Restaurant = new Restaurant(Convert.ToInt32(r["RestaurantID"]), r["RestaurantName"].ToString(), r["RestaurantAddress"].ToString(),
                        Convert.ToInt32(r["OpeningHour"]), Convert.ToInt32(r["ClosingHour"]));
                    food.VerRow = (byte[])r["VerRow"];
                }
                catch (Exception ex)
                {
                    error = "Invalid data " + ex.Message;
                }
            }

            return food;
        }

        public void UpdateFoodByID(int foodID, string foodName, string foodDescription, float foodPrice, int restaurantID, ref string error) 
        {
            SqlCommand updateCommand = new SqlCommand("UPDATE Foods SET FoodName = @foodName, FoodDescription = @foodDescription," +
                                                        "FoodPrice = @foodPrice, RestaurantID = @RID WHERE FoodID = @foodID ");

            SqlParameter ID = new SqlParameter("@foodID", foodID);
            updateCommand.Parameters.Add(ID);

            SqlParameter name = new SqlParameter("@foodName", foodName);
            updateCommand.Parameters.Add(name);

            SqlParameter description = new SqlParameter("@foodDescription", foodDescription);
            updateCommand.Parameters.Add(description);

            SqlParameter price = new SqlParameter("@foodPrice", foodPrice);
            updateCommand.Parameters.Add(price);

            SqlParameter RID = new SqlParameter("@RID", restaurantID);
            updateCommand.Parameters.Add(RID);

            ExecuteNonQuery(updateCommand, ref error);
        }
    }
}
