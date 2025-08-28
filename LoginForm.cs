using System;
using System.Data;
using System.Windows.Forms;
using MySql.Data.MySqlClient; // بدل SqlClient

namespace PhotoEquipment_RentalMS
{
    public partial class LoginForm : Form
    {
        private DBConnection db;

        public LoginForm(DBConnection connection)
        {
            InitializeComponent();
            this.db = connection;
        }

        public LoginForm()
        {
            InitializeComponent();
            this.db = new DBConnection(); // لو ما تم تمريرها، أنشئ اتصال جديد
        }

        // زر الخروج
        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        // إظهار/إخفاء كلمة المرور
        private void chkShowPassword_CheckedChanged(object sender, EventArgs e)
        {
            txtPassword.UseSystemPasswordChar = !chkShowPassword.Checked;
        }

        // زر Login
        private void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("Please enter username and password", "Warning",
                                MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                db.Open(); // افتح الاتصال

                string query = @"
                    SELECT e.Role 
                    FROM Users u
                    INNER JOIN Employees e ON u.EmployeeID = e.EmployeeID
                    WHERE u.Username=@user AND u.PasswordHash=@pass";

                using (MySqlCommand cmd = new MySqlCommand(query, db.GetConnection()))
                {
                    cmd.Parameters.AddWithValue("@user", username);
                    cmd.Parameters.AddWithValue("@pass", password); // لاحقًا ممكن نضيف hashing

                    object role = cmd.ExecuteScalar();

                    if (role != null)
                    {
                        string userRole = role.ToString();
                        MessageBox.Show("Login Successful! Role: " + userRole,
                                        "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);

                        // فتح واجهة MainForm أو Dashboard بناءً على الدور
                        MainForm mainForm = new MainForm(userRole);
                        mainForm.Show();
                        this.Hide();
                    }
                    else
                    {
                        MessageBox.Show("Invalid username or password", "Error",
                                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Database connection error: " + ex.Message,
                                "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                db.Close(); // أغلق الاتصال دائماً
            }
        }
    }
}
