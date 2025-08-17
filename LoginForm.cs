using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace PhotoEquipment_RentalMS
{
    public partial class LoginForm : Form
    {
        private DBconnection db;
        public LoginForm(DBconnection connection)
        {
            InitializeComponent();
            this.db = connection;
        }

        public LoginForm()
        {
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
                MessageBox.Show("Please enter username and password", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                

                using (SqlConnection conn = db.GetConnection())
                {
                    conn.Open();
                    string query = "SELECT Role FROM Users WHERE Username=@user AND Password=@pass";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@user", username);
                        cmd.Parameters.AddWithValue("@pass", password);

                        object role = cmd.ExecuteScalar();

                        if (role != null)
                        {
                            string userRole = role.ToString();
                            MessageBox.Show("Login Successful! Role: " + userRole, "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);

                            // فتح واجهة MainForm أو Dashboard بناءً على الدور
                            MainForm mainForm = new MainForm(userRole); // افترض أن MainForm يقبل Role
                            mainForm.Show();
                            this.Hide();
                        }
                        else
                        {
                            MessageBox.Show("Invalid username or password", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Database connection error: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
          


            }
        }
    }
}