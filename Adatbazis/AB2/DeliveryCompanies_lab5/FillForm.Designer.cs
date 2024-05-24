namespace Deliveries
{
    partial class FillForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            btnExit = new Button();
            btnFilter = new Button();
            dgvFoods = new DataGridView();
            foodId = new DataGridViewTextBoxColumn();
            foodName = new DataGridViewTextBoxColumn();
            foodDescription = new DataGridViewTextBoxColumn();
            foodPrice = new DataGridViewTextBoxColumn();
            restaurantId = new DataGridViewTextBoxColumn();
            restaurantName = new DataGridViewTextBoxColumn();
            restaurantAddress = new DataGridViewTextBoxColumn();
            openingHour = new DataGridViewTextBoxColumn();
            closingHour = new DataGridViewTextBoxColumn();
            VerRow = new DataGridViewTextBoxColumn();
            cbRestaurantFilter = new ComboBox();
            lbRestaurantName = new Label();
            lbStartingLetter = new Label();
            txtStartingLetterFilter = new TextBox();
            panelFilter = new Panel();
            panelDelete = new Panel();
            btnDelete = new Button();
            lbDelete = new Label();
            menu = new MenuStrip();
            guestOptions = new ToolStripMenuItem();
            showFilterGuest = new ToolStripMenuItem();
            userOptions = new ToolStripMenuItem();
            showFilterUser = new ToolStripMenuItem();
            showNewOrderUser = new ToolStripMenuItem();
            showOrdersUser = new ToolStripMenuItem();
            adminOptions = new ToolStripMenuItem();
            showFilterAdmin = new ToolStripMenuItem();
            showDeleteAdmin = new ToolStripMenuItem();
            showUpdateAdmin = new ToolStripMenuItem();
            panelUpdate = new Panel();
            lbFoodPrice = new Label();
            nrPrice = new NumericUpDown();
            cbRestaurant = new ComboBox();
            lbRestaurant = new Label();
            txtFoodDescription = new TextBox();
            lbFoodDescription = new Label();
            txtFoodName = new TextBox();
            btnUpdate = new Button();
            lbFoodName = new Label();
            btnLogout = new Button();
            ((System.ComponentModel.ISupportInitialize)dgvFoods).BeginInit();
            panelFilter.SuspendLayout();
            panelDelete.SuspendLayout();
            menu.SuspendLayout();
            panelUpdate.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)nrPrice).BeginInit();
            SuspendLayout();
            // 
            // btnExit
            // 
            btnExit.Location = new Point(1022, 871);
            btnExit.Margin = new Padding(4, 6, 4, 6);
            btnExit.Name = "btnExit";
            btnExit.Size = new Size(124, 44);
            btnExit.TabIndex = 28;
            btnExit.Text = "Exit";
            btnExit.UseVisualStyleBackColor = true;
            btnExit.Click += btnExit_Click;
            // 
            // btnFilter
            // 
            btnFilter.Location = new Point(140, 97);
            btnFilter.Margin = new Padding(4, 6, 4, 6);
            btnFilter.Name = "btnFilter";
            btnFilter.Size = new Size(124, 44);
            btnFilter.TabIndex = 27;
            btnFilter.Text = "Filter";
            btnFilter.UseVisualStyleBackColor = true;
            btnFilter.Click += btnFilter_Click;
            // 
            // dgvFoods
            // 
            dgvFoods.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgvFoods.Columns.AddRange(new DataGridViewColumn[] { foodId, foodName, foodDescription, foodPrice, restaurantId, restaurantName, restaurantAddress, openingHour, closingHour, VerRow });
            dgvFoods.Location = new Point(47, 235);
            dgvFoods.Margin = new Padding(4, 6, 4, 6);
            dgvFoods.Name = "dgvFoods";
            dgvFoods.ReadOnly = true;
            dgvFoods.RowHeadersWidth = 62;
            dgvFoods.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvFoods.Size = new Size(1099, 624);
            dgvFoods.TabIndex = 26;
            // 
            // foodId
            // 
            foodId.HeaderText = "FoodID";
            foodId.MinimumWidth = 8;
            foodId.Name = "foodId";
            foodId.ReadOnly = true;
            foodId.Visible = false;
            foodId.Width = 150;
            // 
            // foodName
            // 
            foodName.HeaderText = "FoodName";
            foodName.MinimumWidth = 8;
            foodName.Name = "foodName";
            foodName.ReadOnly = true;
            foodName.Width = 125;
            // 
            // foodDescription
            // 
            foodDescription.HeaderText = "FoodDescription";
            foodDescription.MinimumWidth = 8;
            foodDescription.Name = "foodDescription";
            foodDescription.ReadOnly = true;
            foodDescription.Width = 150;
            // 
            // foodPrice
            // 
            foodPrice.HeaderText = "FoodPrice";
            foodPrice.MinimumWidth = 8;
            foodPrice.Name = "foodPrice";
            foodPrice.ReadOnly = true;
            foodPrice.Width = 150;
            // 
            // restaurantId
            // 
            restaurantId.HeaderText = "RestaurantID";
            restaurantId.MinimumWidth = 8;
            restaurantId.Name = "restaurantId";
            restaurantId.ReadOnly = true;
            restaurantId.Visible = false;
            restaurantId.Width = 150;
            // 
            // restaurantName
            // 
            restaurantName.HeaderText = "RestaurantName";
            restaurantName.MinimumWidth = 8;
            restaurantName.Name = "restaurantName";
            restaurantName.ReadOnly = true;
            restaurantName.Width = 150;
            // 
            // restaurantAddress
            // 
            restaurantAddress.HeaderText = "RestaurantAddress";
            restaurantAddress.MinimumWidth = 8;
            restaurantAddress.Name = "restaurantAddress";
            restaurantAddress.ReadOnly = true;
            restaurantAddress.Width = 160;
            // 
            // openingHour
            // 
            openingHour.HeaderText = "OpeningHour";
            openingHour.MinimumWidth = 8;
            openingHour.Name = "openingHour";
            openingHour.ReadOnly = true;
            openingHour.Width = 150;
            // 
            // closingHour
            // 
            closingHour.HeaderText = "ClosingHour";
            closingHour.MinimumWidth = 8;
            closingHour.Name = "closingHour";
            closingHour.ReadOnly = true;
            closingHour.Width = 150;
            // 
            // VerRow
            // 
            VerRow.HeaderText = "VerRow";
            VerRow.MinimumWidth = 8;
            VerRow.Name = "VerRow";
            VerRow.ReadOnly = true;
            VerRow.Visible = false;
            VerRow.Width = 150;
            // 
            // cbRestaurantFilter
            // 
            cbRestaurantFilter.DropDownStyle = ComboBoxStyle.DropDownList;
            cbRestaurantFilter.FormattingEnabled = true;
            cbRestaurantFilter.Location = new Point(167, 17);
            cbRestaurantFilter.Margin = new Padding(4, 6, 4, 6);
            cbRestaurantFilter.Name = "cbRestaurantFilter";
            cbRestaurantFilter.Size = new Size(220, 33);
            cbRestaurantFilter.TabIndex = 25;
            // 
            // lbRestaurantName
            // 
            lbRestaurantName.AutoSize = true;
            lbRestaurantName.Location = new Point(13, 17);
            lbRestaurantName.Name = "lbRestaurantName";
            lbRestaurantName.Size = new Size(147, 25);
            lbRestaurantName.TabIndex = 32;
            lbRestaurantName.Text = "Restaurant Name";
            // 
            // lbStartingLetter
            // 
            lbStartingLetter.AutoSize = true;
            lbStartingLetter.Location = new Point(13, 60);
            lbStartingLetter.Name = "lbStartingLetter";
            lbStartingLetter.Size = new Size(102, 25);
            lbStartingLetter.TabIndex = 32;
            lbStartingLetter.Text = "Food Prefix";
            // 
            // txtStartingLetterFilter
            // 
            txtStartingLetterFilter.Location = new Point(167, 57);
            txtStartingLetterFilter.Name = "txtStartingLetterFilter";
            txtStartingLetterFilter.Size = new Size(220, 31);
            txtStartingLetterFilter.TabIndex = 33;
            // 
            // panelFilter
            // 
            panelFilter.BorderStyle = BorderStyle.FixedSingle;
            panelFilter.Controls.Add(lbRestaurantName);
            panelFilter.Controls.Add(cbRestaurantFilter);
            panelFilter.Controls.Add(lbStartingLetter);
            panelFilter.Controls.Add(btnFilter);
            panelFilter.Controls.Add(txtStartingLetterFilter);
            panelFilter.Location = new Point(47, 36);
            panelFilter.Name = "panelFilter";
            panelFilter.Size = new Size(396, 178);
            panelFilter.TabIndex = 34;
            // 
            // panelDelete
            // 
            panelDelete.BorderStyle = BorderStyle.FixedSingle;
            panelDelete.Controls.Add(btnDelete);
            panelDelete.Controls.Add(lbDelete);
            panelDelete.Location = new Point(449, 36);
            panelDelete.Name = "panelDelete";
            panelDelete.Size = new Size(203, 178);
            panelDelete.TabIndex = 35;
            panelDelete.Visible = false;
            // 
            // btnDelete
            // 
            btnDelete.Location = new Point(40, 100);
            btnDelete.Name = "btnDelete";
            btnDelete.Size = new Size(112, 39);
            btnDelete.TabIndex = 1;
            btnDelete.Text = "Delete";
            btnDelete.UseVisualStyleBackColor = true;
            btnDelete.Click += btnDelete_Click;
            // 
            // lbDelete
            // 
            lbDelete.AutoSize = true;
            lbDelete.Location = new Point(15, 25);
            lbDelete.Name = "lbDelete";
            lbDelete.Size = new Size(168, 25);
            lbDelete.TabIndex = 0;
            lbDelete.Text = "Select row to delete";
            // 
            // menu
            // 
            menu.ImageScalingSize = new Size(24, 24);
            menu.Items.AddRange(new ToolStripItem[] { guestOptions, userOptions, adminOptions });
            menu.Location = new Point(0, 0);
            menu.Name = "menu";
            menu.Size = new Size(1183, 24);
            menu.TabIndex = 37;
            menu.Text = "menuStrip2";
            // 
            // guestOptions
            // 
            guestOptions.DropDownItems.AddRange(new ToolStripItem[] { showFilterGuest });
            guestOptions.Name = "guestOptions";
            guestOptions.Size = new Size(92, 29);
            guestOptions.Text = "Options";
            guestOptions.Visible = false;
            // 
            // showFilterGuest
            // 
            showFilterGuest.Checked = true;
            showFilterGuest.CheckState = CheckState.Checked;
            showFilterGuest.Name = "showFilterGuest";
            showFilterGuest.Size = new Size(270, 34);
            showFilterGuest.Text = "Filter foods";
            showFilterGuest.Click += showFilter_Click;
            // 
            // userOptions
            // 
            userOptions.DropDownItems.AddRange(new ToolStripItem[] { showFilterUser, showNewOrderUser, showOrdersUser });
            userOptions.Name = "userOptions";
            userOptions.Size = new Size(92, 29);
            userOptions.Text = "Options";
            userOptions.Visible = false;
            // 
            // showFilterUser
            // 
            showFilterUser.Checked = true;
            showFilterUser.CheckState = CheckState.Checked;
            showFilterUser.Name = "showFilterUser";
            showFilterUser.Size = new Size(270, 34);
            showFilterUser.Text = "Filter foods";
            showFilterUser.Click += showFilter_Click;
            // 
            // showNewOrderUser
            // 
            showNewOrderUser.Name = "showNewOrderUser";
            showNewOrderUser.Size = new Size(270, 34);
            showNewOrderUser.Text = "Make an order";
            // 
            // showOrdersUser
            // 
            showOrdersUser.Name = "showOrdersUser";
            showOrdersUser.Size = new Size(270, 34);
            showOrdersUser.Text = "My orders";
            // 
            // adminOptions
            // 
            adminOptions.DropDownItems.AddRange(new ToolStripItem[] { showFilterAdmin, showDeleteAdmin, showUpdateAdmin });
            adminOptions.Name = "adminOptions";
            adminOptions.Size = new Size(92, 29);
            adminOptions.Text = "Options";
            adminOptions.Visible = false;
            // 
            // showFilterAdmin
            // 
            showFilterAdmin.Checked = true;
            showFilterAdmin.CheckState = CheckState.Checked;
            showFilterAdmin.Name = "showFilterAdmin";
            showFilterAdmin.Size = new Size(270, 34);
            showFilterAdmin.Text = "Filter foods";
            showFilterAdmin.Click += showFilter_Click;
            // 
            // showDeleteAdmin
            // 
            showDeleteAdmin.Name = "showDeleteAdmin";
            showDeleteAdmin.Size = new Size(270, 34);
            showDeleteAdmin.Text = "Delete food";
            showDeleteAdmin.Click += showDelete_Click;
            // 
            // showUpdateAdmin
            // 
            showUpdateAdmin.Name = "showUpdateAdmin";
            showUpdateAdmin.Size = new Size(270, 34);
            showUpdateAdmin.Text = "Update food";
            showUpdateAdmin.Click += showUpdate_Click;
            // 
            // panelUpdate
            // 
            panelUpdate.BorderStyle = BorderStyle.FixedSingle;
            panelUpdate.Controls.Add(lbFoodPrice);
            panelUpdate.Controls.Add(nrPrice);
            panelUpdate.Controls.Add(cbRestaurant);
            panelUpdate.Controls.Add(lbRestaurant);
            panelUpdate.Controls.Add(txtFoodDescription);
            panelUpdate.Controls.Add(lbFoodDescription);
            panelUpdate.Controls.Add(txtFoodName);
            panelUpdate.Controls.Add(btnUpdate);
            panelUpdate.Controls.Add(lbFoodName);
            panelUpdate.Location = new Point(658, 36);
            panelUpdate.Name = "panelUpdate";
            panelUpdate.Size = new Size(488, 178);
            panelUpdate.TabIndex = 38;
            panelUpdate.Visible = false;
            // 
            // lbFoodPrice
            // 
            lbFoodPrice.AutoSize = true;
            lbFoodPrice.Location = new Point(46, 94);
            lbFoodPrice.Name = "lbFoodPrice";
            lbFoodPrice.Size = new Size(49, 25);
            lbFoodPrice.TabIndex = 40;
            lbFoodPrice.Text = "Price";
            // 
            // nrPrice
            // 
            nrPrice.AllowDrop = true;
            nrPrice.DecimalPlaces = 2;
            nrPrice.ImeMode = ImeMode.On;
            nrPrice.Increment = new decimal(new int[] { 1, 0, 0, 131072 });
            nrPrice.Location = new Point(126, 92);
            nrPrice.Name = "nrPrice";
            nrPrice.Size = new Size(180, 31);
            nrPrice.TabIndex = 39;
            nrPrice.TextAlign = HorizontalAlignment.Center;
            // 
            // cbRestaurant
            // 
            cbRestaurant.DropDownStyle = ComboBoxStyle.DropDownList;
            cbRestaurant.FormattingEnabled = true;
            cbRestaurant.Location = new Point(126, 132);
            cbRestaurant.Margin = new Padding(4, 6, 4, 6);
            cbRestaurant.Name = "cbRestaurant";
            cbRestaurant.Size = new Size(220, 33);
            cbRestaurant.TabIndex = 34;
            // 
            // lbRestaurant
            // 
            lbRestaurant.AutoSize = true;
            lbRestaurant.Location = new Point(18, 135);
            lbRestaurant.Name = "lbRestaurant";
            lbRestaurant.Size = new Size(95, 25);
            lbRestaurant.TabIndex = 34;
            lbRestaurant.Text = "Restaurant";
            // 
            // txtFoodDescription
            // 
            txtFoodDescription.Location = new Point(126, 52);
            txtFoodDescription.Name = "txtFoodDescription";
            txtFoodDescription.Size = new Size(220, 31);
            txtFoodDescription.TabIndex = 36;
            // 
            // lbFoodDescription
            // 
            lbFoodDescription.AutoSize = true;
            lbFoodDescription.Font = new Font("Segoe UI", 9F, FontStyle.Regular, GraphicsUnit.Point, 0);
            lbFoodDescription.Location = new Point(18, 55);
            lbFoodDescription.Name = "lbFoodDescription";
            lbFoodDescription.Size = new Size(102, 25);
            lbFoodDescription.TabIndex = 35;
            lbFoodDescription.Text = "Description";
            // 
            // txtFoodName
            // 
            txtFoodName.Location = new Point(126, 15);
            txtFoodName.Name = "txtFoodName";
            txtFoodName.Size = new Size(220, 31);
            txtFoodName.TabIndex = 34;
            // 
            // btnUpdate
            // 
            btnUpdate.Location = new Point(364, 61);
            btnUpdate.Name = "btnUpdate";
            btnUpdate.Size = new Size(112, 79);
            btnUpdate.TabIndex = 1;
            btnUpdate.Text = "Update selected";
            btnUpdate.UseVisualStyleBackColor = true;
            btnUpdate.Click += btnUpdate_Click;
            // 
            // lbFoodName
            // 
            lbFoodName.AutoSize = true;
            lbFoodName.Font = new Font("Segoe UI", 9F, FontStyle.Regular, GraphicsUnit.Point, 0);
            lbFoodName.Location = new Point(17, 18);
            lbFoodName.Name = "lbFoodName";
            lbFoodName.Size = new Size(103, 25);
            lbFoodName.TabIndex = 0;
            lbFoodName.Text = "Food name";
            // 
            // btnLogout
            // 
            btnLogout.Location = new Point(868, 871);
            btnLogout.Margin = new Padding(4, 6, 4, 6);
            btnLogout.Name = "btnLogout";
            btnLogout.Size = new Size(124, 44);
            btnLogout.TabIndex = 39;
            btnLogout.Text = "Logout";
            btnLogout.UseVisualStyleBackColor = true;
            btnLogout.Click += btnLogout_Click;
            // 
            // FillForm
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1183, 930);
            Controls.Add(btnLogout);
            Controls.Add(panelUpdate);
            Controls.Add(panelDelete);
            Controls.Add(panelFilter);
            Controls.Add(dgvFoods);
            Controls.Add(btnExit);
            Controls.Add(menu);
            Margin = new Padding(3, 4, 3, 4);
            Name = "FillForm";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "FillForm";
            Load += FillForm_Load;
            Shown += FillForm_Shown;
            ((System.ComponentModel.ISupportInitialize)dgvFoods).EndInit();
            panelFilter.ResumeLayout(false);
            panelFilter.PerformLayout();
            panelDelete.ResumeLayout(false);
            panelDelete.PerformLayout();
            menu.ResumeLayout(false);
            menu.PerformLayout();
            panelUpdate.ResumeLayout(false);
            panelUpdate.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)nrPrice).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private MenuStrip menu;
        private ToolStripMenuItem adminOptions;
        private ToolStripMenuItem showFilterAdmin;
        private Panel panelFilter;
        private Label lbRestaurantName;
        private Label lbStartingLetter;
        private ComboBox cbRestaurantFilter;
        private TextBox txtStartingLetterFilter;
        private Button btnFilter;

        private ToolStripMenuItem showDeleteAdmin;
        private Panel panelDelete;
        private Label lbDelete;
        private Button btnDelete;

        private ToolStripMenuItem showUpdateAdmin;
        private Panel panelUpdate;
        private Label lbFoodName;
        private Label lbFoodDescription;
        private Label lbFoodPrice;
        private Label lbRestaurant;
        private TextBox txtFoodName;
        private TextBox txtFoodDescription;
        private NumericUpDown nrPrice;
        private ComboBox cbRestaurant;
        private Button btnUpdate;

        private DataGridView dgvFoods;
        private DataGridViewTextBoxColumn foodId;
        private DataGridViewTextBoxColumn foodName;
        private DataGridViewTextBoxColumn foodDescription;
        private DataGridViewTextBoxColumn foodPrice;
        private DataGridViewTextBoxColumn restaurantId;
        private DataGridViewTextBoxColumn restaurantName;
        private DataGridViewTextBoxColumn restaurantAddress;
        private DataGridViewTextBoxColumn openingHour;
        private DataGridViewTextBoxColumn closingHour;
        private DataGridViewTextBoxColumn VerRow;

        private Button btnExit;
        private Button btnLogout;
        private ToolStripMenuItem guestOptions;
        private ToolStripMenuItem userOptions;
        private ToolStripMenuItem showFilterUser;
        private ToolStripMenuItem showNewOrderUser;
        private ToolStripMenuItem showOrdersUser;
        private ToolStripMenuItem showFilterGuest;
    }
}