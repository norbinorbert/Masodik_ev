namespace Deliveries
{
    partial class LoginForm
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
            lbUsername = new Label();
            txtUsername = new TextBox();
            txtPassword = new TextBox();
            lbPassword = new Label();
            lbConfirm = new Label();
            txtConfirm = new TextBox();
            lbError = new Label();
            btnLogin = new Button();
            btnRegisterPage = new Button();
            btnExit = new Button();
            btnLoginPage = new Button();
            btnRegister = new Button();
            SuspendLayout();
            // 
            // lbUsername
            // 
            lbUsername.AutoSize = true;
            lbUsername.Font = new Font("Segoe UI", 12F);
            lbUsername.Location = new Point(206, 45);
            lbUsername.Name = "lbUsername";
            lbUsername.Size = new Size(121, 32);
            lbUsername.TabIndex = 0;
            lbUsername.Text = "Username";
            // 
            // txtUsername
            // 
            txtUsername.Location = new Point(152, 80);
            txtUsername.Name = "txtUsername";
            txtUsername.Size = new Size(223, 31);
            txtUsername.TabIndex = 1;
            // 
            // txtPassword
            // 
            txtPassword.Location = new Point(152, 175);
            txtPassword.Name = "txtPassword";
            txtPassword.PasswordChar = '*';
            txtPassword.Size = new Size(223, 31);
            txtPassword.TabIndex = 2;
            // 
            // lbPassword
            // 
            lbPassword.AutoSize = true;
            lbPassword.Font = new Font("Segoe UI", 12F);
            lbPassword.Location = new Point(206, 140);
            lbPassword.Name = "lbPassword";
            lbPassword.Size = new Size(111, 32);
            lbPassword.TabIndex = 3;
            lbPassword.Text = "Password";
            // 
            // lbConfirm
            // 
            lbConfirm.AutoSize = true;
            lbConfirm.Font = new Font("Segoe UI", 12F);
            lbConfirm.Location = new Point(161, 247);
            lbConfirm.Name = "lbConfirm";
            lbConfirm.Size = new Size(204, 32);
            lbConfirm.TabIndex = 4;
            lbConfirm.Text = "Confirm Password";
            lbConfirm.Visible = false;
            // 
            // txtConfirm
            // 
            txtConfirm.Location = new Point(152, 282);
            txtConfirm.Name = "txtConfirm";
            txtConfirm.PasswordChar = '*';
            txtConfirm.Size = new Size(223, 31);
            txtConfirm.TabIndex = 5;
            txtConfirm.Visible = false;
            // 
            // lbError
            // 
            lbError.Anchor = AnchorStyles.None;
            lbError.AutoSize = true;
            lbError.Font = new Font("Segoe UI", 12F);
            lbError.ForeColor = Color.Red;
            lbError.Location = new Point(12, 500);
            lbError.Name = "lbError";
            lbError.Size = new Size(50, 32);
            lbError.TabIndex = 6;
            lbError.Text = "asd";
            lbError.TextAlign = ContentAlignment.MiddleCenter;
            lbError.Visible = false;
            // 
            // btnLogin
            // 
            btnLogin.Location = new Point(186, 334);
            btnLogin.Name = "btnLogin";
            btnLogin.Size = new Size(154, 42);
            btnLogin.TabIndex = 7;
            btnLogin.Text = "Login";
            btnLogin.UseVisualStyleBackColor = true;
            btnLogin.Click += btnLogin_Click;
            // 
            // btnRegisterPage
            // 
            btnRegisterPage.Location = new Point(186, 417);
            btnRegisterPage.Name = "btnRegisterPage";
            btnRegisterPage.Size = new Size(154, 42);
            btnRegisterPage.TabIndex = 8;
            btnRegisterPage.Text = "Register page";
            btnRegisterPage.UseVisualStyleBackColor = true;
            btnRegisterPage.Click += btnRegisterPage_Click;
            // 
            // btnExit
            // 
            btnExit.Location = new Point(205, 553);
            btnExit.Name = "btnExit";
            btnExit.Size = new Size(112, 45);
            btnExit.TabIndex = 9;
            btnExit.Text = "Exit";
            btnExit.UseVisualStyleBackColor = true;
            btnExit.Click += btnExit_Click;
            // 
            // btnLoginPage
            // 
            btnLoginPage.Location = new Point(186, 334);
            btnLoginPage.Name = "btnLoginPage";
            btnLoginPage.Size = new Size(154, 42);
            btnLoginPage.TabIndex = 10;
            btnLoginPage.Text = "Login page";
            btnLoginPage.UseVisualStyleBackColor = true;
            btnLoginPage.Visible = false;
            btnLoginPage.Click += btnLoginPage_Click;
            // 
            // btnRegister
            // 
            btnRegister.Location = new Point(186, 417);
            btnRegister.Name = "btnRegister";
            btnRegister.Size = new Size(154, 42);
            btnRegister.TabIndex = 11;
            btnRegister.Text = "Register";
            btnRegister.UseVisualStyleBackColor = true;
            btnRegister.Visible = false;
            btnRegister.Click += btnRegister_Click;
            // 
            // LoginForm
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(542, 620);
            Controls.Add(btnExit);
            Controls.Add(lbError);
            Controls.Add(txtConfirm);
            Controls.Add(lbConfirm);
            Controls.Add(lbPassword);
            Controls.Add(txtPassword);
            Controls.Add(txtUsername);
            Controls.Add(lbUsername);
            Controls.Add(btnRegister);
            Controls.Add(btnLogin);
            Controls.Add(btnLoginPage);
            Controls.Add(btnRegisterPage);
            Name = "LoginForm";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "LoginForm";
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label lbUsername;
        private TextBox txtUsername;
        private TextBox txtPassword;
        private Label lbPassword;
        private Label lbConfirm;
        private TextBox txtConfirm;
        private Label lbError;
        private Button btnLogin;
        private Button btnRegisterPage;
        private Button btnExit;
        private Button btnLoginPage;
        private Button btnRegister;
    }
}