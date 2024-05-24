namespace Deliveries
{
    public partial class LoginForm : Form
    {
        private string connectionString;
        private LoginDAL loginDAL;

        public LoginForm()
        {
            InitializeComponent();
            loginDAL = new LoginDAL();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnRegisterPage_Click(object sender, EventArgs e)
        {
            lbError.Visible = false;
            lbConfirm.Visible = true;
            txtConfirm.Visible = true;
            btnLoginPage.Visible = true;
            btnRegister.Visible = true;

            btnLogin.Visible = false;
            btnRegisterPage.Visible = false;
        }

        private void btnLoginPage_Click(object sender, EventArgs e)
        {
            lbError.Visible = false;
            lbConfirm.Visible = false;
            txtConfirm.Visible = false;
            btnLoginPage.Visible = false;
            btnRegister.Visible = false;

            btnLogin.Visible = true;
            btnRegisterPage.Visible = true;
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            lbError.Visible = false;
            string name = txtUsername.Text;
            if (name.Length == 0)
            {
                lbError.Text = "Please provide a name";
                lbError.Visible = true;
                return;
            }

            string password = txtPassword.Text;
            if (password.Length == 0)
            {
                lbError.Text = "Please provide a password";
                lbError.Visible = true;
                return;
            }

            string error = string.Empty;
            connectionString = loginDAL.Login(name, password, ref error);
            if (error != "OK")
            {
                lbError.Text = "User or password incorrect";
                lbError.Visible = true;
                return;
            }

            string userType = "user";
            switch (name)
            {
                case "guest":
                    {
                        userType = "guest";
                        break;
                    }
                case "administrator":
                    {
                        userType = "admin";
                        break;
                    }
            }
            new FillForm(userType).Show();
            Close();
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            lbError.Visible = false;
            string name = txtUsername.Text;
            if (name.Length == 0)
            {
                lbError.Text = "Please provide a name";
                lbError.Visible = true;
                return;
            }
            
            string password = txtPassword.Text;
            if (password.Length == 0)
            {
                lbError.Text = "Please provide a password";
                lbError.Visible = true;
                return;
            }

            string confirm = txtConfirm.Text;
            if (confirm.Length == 0)
            {
                lbError.Text = "Please confirm your password";
                lbError.Visible = true;
                return;
            }

            if (password != confirm)
            {
                lbError.Text = "Passwords don't match";
                lbError.Visible = true;
                return;
            }

            string error = string.Empty;
            loginDAL.Register(name, password, ref error);
            if (error != "OK")
            {
                lbError.Text = "User already exists";
                lbError.Visible = true;
                return;
            }

            btnLoginPage.PerformClick();
        }
    }
}
