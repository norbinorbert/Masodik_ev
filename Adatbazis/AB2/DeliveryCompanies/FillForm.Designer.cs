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
            cbRestaurantFilter = new ComboBox();
            lbRestaurantName = new Label();
            lbStartingLetter = new Label();
            txtStartingLetterFilter = new TextBox();
            ((System.ComponentModel.ISupportInitialize)dgvFoods).BeginInit();
            SuspendLayout();
            // 
            // btnExit
            // 
            btnExit.Location = new Point(1022, 842);
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
            btnFilter.Location = new Point(1022, 74);
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
            dgvFoods.Columns.AddRange(new DataGridViewColumn[] { foodId, foodName, foodDescription, foodPrice, restaurantId, restaurantName, restaurantAddress, openingHour, closingHour });
            dgvFoods.Location = new Point(47, 148);
            dgvFoods.Margin = new Padding(4, 6, 4, 6);
            dgvFoods.Name = "dgvFoods";
            dgvFoods.ReadOnly = true;
            dgvFoods.RowHeadersWidth = 62;
            dgvFoods.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvFoods.Size = new Size(1099, 648);
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
            // cbRestaurantFilter
            // 
            cbRestaurantFilter.DropDownStyle = ComboBoxStyle.DropDownList;
            cbRestaurantFilter.FormattingEnabled = true;
            cbRestaurantFilter.Location = new Point(201, 80);
            cbRestaurantFilter.Margin = new Padding(4, 6, 4, 6);
            cbRestaurantFilter.Name = "cbRestaurantFilter";
            cbRestaurantFilter.Size = new Size(220, 33);
            cbRestaurantFilter.TabIndex = 25;
            // 
            // lbRestaurantName
            // 
            lbRestaurantName.AutoSize = true;
            lbRestaurantName.Location = new Point(42, 84);
            lbRestaurantName.Name = "lbRestaurantName";
            lbRestaurantName.Size = new Size(147, 25);
            lbRestaurantName.TabIndex = 32;
            lbRestaurantName.Text = "Restaurant Name";
            // 
            // lbStartingLetter
            // 
            lbStartingLetter.AutoSize = true;
            lbStartingLetter.Location = new Point(541, 84);
            lbStartingLetter.Name = "lbStartingLetter";
            lbStartingLetter.Size = new Size(102, 25);
            lbStartingLetter.TabIndex = 32;
            lbStartingLetter.Text = "Food Prefix";
            // 
            // txtStartingLetterFilter
            // 
            txtStartingLetterFilter.Location = new Point(649, 81);
            txtStartingLetterFilter.Name = "txtStartingLetterFilter";
            txtStartingLetterFilter.Size = new Size(190, 31);
            txtStartingLetterFilter.TabIndex = 33;
            // 
            // FillForm
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1183, 930);
            Controls.Add(dgvFoods);
            Controls.Add(lbRestaurantName);
            Controls.Add(btnExit);
            Controls.Add(btnFilter);
            Controls.Add(cbRestaurantFilter);
            Controls.Add(lbStartingLetter);
            Controls.Add(txtStartingLetterFilter);
            Margin = new Padding(3, 4, 3, 4);
            Name = "FillForm";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "FillForm";
            Load += FillForm_Load;
            Shown += FillForm_Shown;
            ((System.ComponentModel.ISupportInitialize)dgvFoods).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnFilter;
        private System.Windows.Forms.DataGridView dgvFoods;
        private System.Windows.Forms.ComboBox cbRestaurantFilter;
        private System.Windows.Forms.Label lbRestaurantName;
        private System.Windows.Forms.Label lbStartingLetter;
        private System.Windows.Forms.TextBox txtStartingLetterFilter;
        private DataGridViewTextBoxColumn foodId;
        private DataGridViewTextBoxColumn foodName;
        private DataGridViewTextBoxColumn foodDescription;
        private DataGridViewTextBoxColumn foodPrice;
        private DataGridViewTextBoxColumn restaurantId;
        private DataGridViewTextBoxColumn restaurantName;
        private DataGridViewTextBoxColumn restaurantAddress;
        private DataGridViewTextBoxColumn openingHour;
        private DataGridViewTextBoxColumn closingHour;
    }
}