using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PhotoEquipment_RentalMS
{
    public partial class ServerName : Form
    {
        public  ServerName()
        {
            InitializeComponent();
        }

        private void Guna2Button1_Click(object sender, EventArgs e)
        {
            string server = txt_ServerName.Text;
            DBconnection dBconnection = new DBconnection(server);
            string newServerName = dBconnection.ServerName;
            MessageBox.Show(newServerName);
            this.Hide();
            LoginForm LoginForm = new LoginForm(dBconnection);
            LoginForm.ShowDialog();
              
        }

        private void ServerName_Load(object sender, EventArgs e)
        {

        }
    }
}
