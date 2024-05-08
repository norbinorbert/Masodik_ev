using System.Data.SqlClient;

namespace Deliveries
{
    public struct Restaurant
    {
        int restaurantID;
        string restaurantName;
        string restaurantAddress;
        int openingHour;
        int closingHour;

        public int RestaurantId
        {
            get { return restaurantID; }
            set { restaurantID = value; }
        }

        public string RestaurantName
        {
            get { return restaurantName; }
            set { restaurantName = value; }
        }
        public string RestaurantAddress
        {
            get { return restaurantAddress; }
            set { restaurantAddress = value; }
        }

        public int OpeningHour
        {
            get { return openingHour; }
            set { openingHour = value; }
        }
        public int ClosingHour
        {
            get { return closingHour; }
            set { closingHour = value; }
        }

        public Restaurant(int restaurantID, string restaurantName, string restaurantAddress, int openingHour, int closingHour){
            this.restaurantID = restaurantID;
            this.restaurantName = restaurantName;
            this.restaurantAddress = restaurantAddress;
            this.openingHour = openingHour;
            this.closingHour = closingHour;
        }
    }

    public class RestaurantsDAL:DALGen 
    {       
        public List<Restaurant> GetRestaurantList(ref string error)
        {
            string query = "SELECT * FROM Restaurants";
            SqlDataReader dataReader = ExecuteReader(query, ref error);

            List<Restaurant> restaurantList = new List<Restaurant>();

            if (error == "OK")
            {
                Restaurant item = new Restaurant();
                while (dataReader.Read())
                {                   
                    try
                    {
                        item.RestaurantId = Convert.ToInt32(dataReader[0]);
                        item.RestaurantName = dataReader[1].ToString();
                        item.RestaurantAddress = dataReader[2].ToString();
                        item.OpeningHour = Convert.ToInt32(dataReader[3]);
                        item.ClosingHour = Convert.ToInt32(dataReader[4]);
                        restaurantList.Add(item);
                    }
                    catch (Exception ex)
                    {
                        error = "Invalid data " + ex.Message;
                    }
                }
            }
            CloseDataReader(dataReader);

            return restaurantList;
        }
    }
}
