using System.Runtime.InteropServices;

namespace Deliveries
{
    public partial class FillForm : Form
    {
        private RestaurantsDAL restaurantsDAL;
        private FoodsDAL foodsDAL;
        private string errMess;
        private int errNumber;
        private string userType;

        public FillForm(string userType)
        {
            InitializeComponent();

            foodsDAL = new FoodsDAL();
            restaurantsDAL = new RestaurantsDAL();
            errMess = "OK";

            this.userType = userType;
        }

        private void FillForm_Load(object sender, EventArgs e)
        {
            switch (userType)
            {
                case "guest":
                    {
                        guestOptions.Visible = true;
                        break;
                    }
                case "user":
                    {
                        userOptions.Visible = true;
                        break;
                    }
                case "admin":
                    {
                        adminOptions.Visible = true;
                        break;
                    }
            }
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
                errMess = errMess + Environment.NewLine +
                    "Error" + errNumber + Environment.NewLine + "Error while filling up ComboBox." + error;
            }
            else
            {
                cbRestaurantFilter.DataSource = restaurantList;
                cbRestaurantFilter.DisplayMember = "RestaurantName";
                cbRestaurantFilter.ValueMember = "RestaurantId";

                List<Restaurant> restaurantListCopy = new List<Restaurant>(restaurantList);
                cbRestaurant.DataSource = restaurantListCopy;
                cbRestaurant.DisplayMember = "RestaurantName";
                cbRestaurant.ValueMember = "RestaurantID";
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
                                           item.Restaurant.RestaurantId,
                                           item.Restaurant.RestaurantName,
                                           item.Restaurant.RestaurantAddress,
                                           item.Restaurant.OpeningHour,
                                           item.Restaurant.ClosingHour,
                                           BitConverter.ToString(item.VerRow));
                    }
                    catch (Exception ex)
                    {
                        errNumber++;
                        if (errMess == "OK") errMess = string.Empty;
                        errMess = errMess + Environment.NewLine +
                            "Error" + errNumber + Environment.NewLine + "Invalid data " + ex.Message;
                    }
                }
            }
            else if (error != "OK")
            {
                errNumber++;
                if (errMess == "OK") errMess = string.Empty;
                errMess = errMess + Environment.NewLine +
                    "Error" + errNumber + Environment.NewLine + "Error filling up DataGridView." + error;
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

        private void showFilter_Click(object sender, EventArgs e)
        {
            showFilterAdmin.Checked = !showFilterAdmin.Checked;
            showFilterUser.Checked = !showFilterUser.Checked;
            showFilterGuest.Checked = !showFilterGuest.Checked;
            panelFilter.Visible = !panelFilter.Visible;
        }

        private void showDelete_Click(object sender, EventArgs e)
        {
            showDeleteAdmin.Checked = !showDeleteAdmin.Checked;
            panelDelete.Visible = !panelDelete.Visible;
        }

        private void showUpdate_Click(object sender, EventArgs e)
        {
            showUpdateAdmin.Checked = !showUpdateAdmin.Checked;
            panelUpdate.Visible = !panelUpdate.Visible;
        }

        private void deleteFromDgvFoods()
        {
            DialogResult result = MessageBox.Show("Are you sure you want to delete the selected row? " +
                "This will potentially delete rows from other tables as well", "Are you sure?", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                string error = string.Empty;
                int selectedFoodID = Convert.ToInt32(dgvFoods.SelectedRows[0].Cells["FoodID"].Value);
                foodsDAL.DeleteFoodByID(selectedFoodID, ref error);
                if (error != "OK")
                {
                    errNumber++;
                    if (errMess == "OK") errMess = string.Empty;
                    errMess = errMess + Environment.NewLine +
                        "Error" + errNumber + Environment.NewLine + "Error deleting row." + errMess;
                }
                else
                {
                    MessageBox.Show("Successfully deleted the selected row");
                    FillDgvFoods(Convert.ToInt32(cbRestaurantFilter.SelectedValue), txtStartingLetterFilter.Text);
                }
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (dgvFoods.SelectedRows.Count != 1)
            {
                MessageBox.Show("Please select exactly 1 row to delete.");
                return;
            }
            deleteFromDgvFoods();

            if (errMess != "OK")
            {
                ErrorForm errorForm = new ErrorForm(errMess);
                errorForm.Show();
                errorForm.Focus();
            }
        }

        private void updateDgvFoods()
        {
            DialogResult result = MessageBox.Show("Are you sure you want to update the selected row?", "Are you sure?", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                string error = string.Empty;
                int selectedFoodID = Convert.ToInt32(dgvFoods.SelectedRows[0].Cells["FoodID"].Value);
                Food current = foodsDAL.GetFoodByID(selectedFoodID, ref error);
                if (error != "OK")
                {
                    errNumber++;
                    if (errMess == "OK")
                        errMess = string.Empty;
                    errMess = errMess + Environment.NewLine +
                        "Error" + errNumber + Environment.NewLine + "Error while updating row." + error;
                    return;
                }

                string oldVersion = (string)dgvFoods.SelectedRows[0].Cells["VerRow"].Value;
                string currVersion = BitConverter.ToString(current.VerRow);

                if (currVersion.Equals(oldVersion))
                {
                    foodsDAL.UpdateFoodByID(selectedFoodID, txtFoodName.Text, txtFoodDescription.Text, (float)nrPrice.Value, (int)cbRestaurant.SelectedValue, ref error);
                    if (error != "OK")
                    {
                        errNumber++;
                        if (errMess == "OK") errMess = string.Empty;
                        errMess = errMess + Environment.NewLine +
                            "Error" + errNumber + Environment.NewLine + "Error updating row." + errMess;
                    }
                    else
                    {
                        MessageBox.Show("Successfully updated the selected row");
                        FillDgvFoods(Convert.ToInt32(cbRestaurantFilter.SelectedValue), txtStartingLetterFilter.Text);
                    }
                    return;
                }

                var oldFood = dgvFoods.SelectedRows[0];
                string oldString = $"Old values: {oldFood.Cells["FoodName"].Value}, {oldFood.Cells["FoodDescription"].Value}, " +
                    $"{oldFood.Cells["FoodPrice"].Value}, {oldFood.Cells["RestaurantName"].Value}";
                string currString = $"Current values: {current.FoodName}, {current.Description}, {current.Price}, {current.Restaurant.RestaurantName}";
                string newString = $"New values: {txtFoodName.Text}, {txtFoodDescription.Text}, {nrPrice.Value}, {cbRestaurant.Text}";
                var taskDialog = TaskDialog.ShowDialog(new TaskDialogPage
                {
                    Caption = "Update unsuccessful",
                    Heading = "Someone has already updated this row, please choose what the new values should be",
                    Text = $"{oldString}\n{currString}\n{newString}",
                    Buttons =
                        {
                            new TaskDialogButton
                            {
                                Text = "Old Value",
                                Tag = 1
                            },new TaskDialogButton
                            {
                                Text = "Current Value",
                                Tag = 2
                            },new TaskDialogButton
                            {
                                Text = "New Value",
                                Tag = 3
                            },
                        }
                });

                switch ((int)taskDialog.Tag)
                {
                    case 1:
                        {
                            foodsDAL.UpdateFoodByID(selectedFoodID, oldFood.Cells["FoodName"].Value.ToString(), oldFood.Cells["FoodDescription"].Value.ToString(),
                                (float)oldFood.Cells["FoodPrice"].Value, (int)oldFood.Cells["RestaurantID"].Value, ref error);
                            break;
                        }
                    case 2:
                        {
                            error = "OK";
                            break;
                        }
                    case 3:
                        {
                            foodsDAL.UpdateFoodByID(selectedFoodID, txtFoodName.Text, txtFoodDescription.Text, (float)nrPrice.Value,
                                (int)cbRestaurant.SelectedValue, ref error);
                            break;
                        }
                    default:
                        {
                            if (error == "OK")
                            {
                                error = "Unexpected error when selecting update values";
                            }
                            break;
                        }
                }

                if (error != "OK")
                {
                    errNumber++;
                    if (errMess == "OK") errMess = string.Empty;
                    errMess = errMess + Environment.NewLine +
                        "Error" + errNumber + Environment.NewLine + "Error updating row." + errMess;
                }
                else
                {
                    MessageBox.Show("Successfully updated the selected row");
                    FillDgvFoods(Convert.ToInt32(cbRestaurantFilter.SelectedValue), txtStartingLetterFilter.Text);
                }
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (dgvFoods.SelectedRows.Count != 1)
            {
                MessageBox.Show("Please select exactly 1 row to update.");
                return;
            }
            if (txtFoodName.Text.Length == 0 || txtFoodDescription.Text.Length == 0 || cbRestaurant.SelectedValue.Equals(-1))
            {
                MessageBox.Show("Please provide a name, a description and a restaurant for the food");
                return;
            }
            updateDgvFoods();
            if (errMess != "OK")
            {
                ErrorForm errorForm = new ErrorForm(errMess);
                errorForm.Show();
                errorForm.Focus();
            }
        }

        private void btnLogout_Click(object sender, EventArgs e)
        {
            new LoginForm().Show();
            Close();
        }
    }
}
