using System.Data;

namespace Deliveries
{
    public struct Food
    {
        int foodId;
        string foodName;
        string description;
        float price;
        Restaurant restaurantFood;

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

        public Restaurant RestaurantFood
        {
            get { return restaurantFood; }
            set { restaurantFood = value; }
        }

        public float Price
        {
            get { return price; }
            set { price = value; }
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
            string query = "SELECT FoodID, FoodName, FoodDescription, FoodPrice, R.RestaurantID, RestaurantName, RestaurantAddress, OpeningHour, ClosingHour " +
                "FROM Foods F JOIN Restaurants R ON F.RestaurantID = R.RestaurantID";

            if (restaurantID > 0)
            {
                query += " WHERE R.RestaurantID = " + restaurantID;
            }
            if (prefix != null)
            {
                query += " AND F.FoodName LIKE '" + prefix + "%'";
            }

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
                        item.RestaurantFood = new Restaurant(Convert.ToInt32(r["RestaurantID"]), r["RestaurantName"].ToString(), r["RestaurantAddress"].ToString(),
                            Convert.ToInt32(r["OpeningHour"]), Convert.ToInt32(r["ClosingHour"]));
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
    }
}
