namespace Deliveries
{
    public partial class FillForm : Form
    {
        private RestaurantsDAL restaurantsDAL;
        private FoodsDAL foodsDAL;
        private string errMess;
        private int errNumber;
       
        public FillForm()
        {
            InitializeComponent();
            string error = string.Empty;
            foodsDAL = new FoodsDAL(ref error);
            if (error != "OK")
            {
                errNumber = 1;
                errMess = "Error"+errNumber+Environment.NewLine+"Couldn't create Foods object " + error;
            }
            else
            {
                errMess = "OK";
                restaurantsDAL = new RestaurantsDAL();
            }
        }

        private void FillForm_Load(object sender, EventArgs e)
        {
            if (errMess == "OK")
            {
                FillCbRestaurants();

                FillDgvFoods(-1, "");
            }            
        }

        private void FillCbRestaurants()
        {
            string error = string.Empty;
            List<Restaurant> restaurantList = new List<Restaurant>();
            restaurantList.Add(new Restaurant(-1, "", "", 0, 0));
            restaurantList.AddRange(restaurantsDAL.GetRestaurantList(ref error));

            if (error != "OK")
            {
                errNumber++;
                if (errMess == "OK") 
                    errMess = string.Empty;
                errMess = errMess + Environment.NewLine+ 
                    "Error"+errNumber+Environment.NewLine+"Error while filling up ComboBox." + error;
            }
            else
            {
                cbRestaurantFilter.DataSource = restaurantList;
                cbRestaurantFilter.DisplayMember = "RestaurantName";
                cbRestaurantFilter.ValueMember = "RestaurantId";
            }
            
        }

        private void FillDgvFoods(int restaurantID, string prefix)
        {
            string error = string.Empty;
            dgvFoods.Rows.Clear();
            List<Food> foodList = foodsDAL.GetFoodListDataSet(restaurantID, prefix, ref error);

            if ((foodList.Count != 0) && (error == "OK"))
            {
                foreach (Food item in foodList)
                {
                    try
                    {
                        dgvFoods.Rows.Add(item.FoodId,
                                           item.FoodName,
                                           item.Description,
                                           item.Price,
                                           item.RestaurantFood.RestaurantId,
                                           item.RestaurantFood.RestaurantName,
                                           item.RestaurantFood.RestaurantAddress,
                                           item.RestaurantFood.OpeningHour,
                                           item.RestaurantFood.ClosingHour);
                    }
                    catch (Exception ex)
                    {
                        errNumber++;
                        if (errMess == "OK") errMess = string.Empty;
                        errMess = errMess + Environment.NewLine + 
                            "Error"+errNumber+Environment.NewLine+"Invalid data " + ex.Message;
                    }
                }
            }
            else if (error != "OK")
            {
                errNumber++;
                if (errMess == "OK") errMess = string.Empty;
                errMess = errMess + Environment.NewLine + 
                    "Error"+errNumber+Environment.NewLine+"Error filling up DataGridView." + error;
            }
        }

        private void btnFilter_Click(object sender, EventArgs e)
        {
            FillDgvFoods(Convert.ToInt32(cbRestaurantFilter.SelectedValue), txtStartingLetterFilter.Text);

            if (errMess != "OK")
            {
                ErrorForm errorForm = new ErrorForm(errMess);
                errorForm.Show();
                errorForm.Focus();
            }
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void FillForm_Shown(object sender, EventArgs e)
        {
            if (errMess != "OK")
            {
                ErrorForm errorForm = new ErrorForm(errMess);
                errorForm.Show();
                errorForm.Focus();
            }
        }     
    }
}
