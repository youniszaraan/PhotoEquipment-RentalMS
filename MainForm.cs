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
    public partial class MainForm : Form
    {
        private string userRole;

        public MainForm()
        {
            InitializeComponent();
        }

        public MainForm(string userRole)
        {
            InitializeComponent();
            this.userRole = userRole;
        }

        private void Pnlmenu_Paint(object sender, PaintEventArgs e)
        {

        }
        private void btnequipment_Click(object sender, EventArgs e)
        {
        }

        private void Btnequipment_Click_1(object sender, EventArgs e)
        {
            pnltables.Controls.Clear();
            Equipment equipmentForm = new Equipment(); // الفورم الذي أنشأته
            equipmentForm.TopLevel = false;
           /// equipmentForm.FormBorderStyle = FormBorderStyle.None;
            equipmentForm.Dock = DockStyle.Fill;
            pnltables.Controls.Add(equipmentForm);
            equipmentForm.Show();

        }

        private void Btnemployee_Click(object sender, EventArgs e)
        {

            pnltables.Controls.Clear();
           EmployeesForm Em = new EmployeesForm(); // الفورم الذي أنشأته
           Em.TopLevel = false;
           Em.FormBorderStyle = FormBorderStyle.None;
            Em.Dock = DockStyle.Fill;
            pnltables.Controls.Add(Em);
            Em.Show();
        }

        private void Btncustomer_Click(object sender, EventArgs e)
        {

            pnltables.Controls.Clear();
           CustomerForm Em = new CustomerForm(); // الفورم الذي أنشأته
            Em.TopLevel = false;
           // Em.FormBorderStyle = FormBorderStyle.None;
            Em.Dock = DockStyle.Fill;
            pnltables.Controls.Add(Em);
            Em.Show();
        }

        private void Btnphotographer_Click(object sender, EventArgs e)
        {

            pnltables.Controls.Clear();
            PhotographerForm Em = new PhotographerForm(); // الفورم الذي أنشأته
            Em.TopLevel = false;
            // Em.FormBorderStyle = FormBorderStyle.None;
            Em.Dock = DockStyle.Fill;
            pnltables.Controls.Add(Em);
            Em.Show();
        }

        private void Btnrentals_Click(object sender, EventArgs e)
        {

            pnltables.Controls.Clear();
            RentalForm Em = new RentalForm(); // الفورم الذي أنشأته
            Em.TopLevel = false;
            // Em.FormBorderStyle = FormBorderStyle.None;
            Em.Dock = DockStyle.Fill;
            pnltables.Controls.Add(Em);
            Em.Show();
        }

        private void Btnpayment_Click(object sender, EventArgs e)
        {

            pnltables.Controls.Clear();
          PaymentForm Em = new PaymentForm(); // الفورم الذي أنشأته
            Em.TopLevel = false;
            // Em.FormBorderStyle = FormBorderStyle.None;
            Em.Dock = DockStyle.Fill;
            pnltables.Controls.Add(Em);
            Em.Show();
        }

        private void Btnguarantee_Click(object sender, EventArgs e)
        {

            pnltables.Controls.Clear();
           GaranteeForm Em = new GaranteeForm(); // الفورم الذي أنشأته
            Em.TopLevel = false;
            // Em.FormBorderStyle = FormBorderStyle.None;
            Em.Dock = DockStyle.Fill;
            pnltables.Controls.Add(Em);
            Em.Show();
        }

        private void Btnexpenses_Click(object sender, EventArgs e)
        {

            pnltables.Controls.Clear();
           ExpensesForm Em = new ExpensesForm(); // الفورم الذي أنشأته
            Em.TopLevel = false;
            // Em.FormBorderStyle = FormBorderStyle.None;
            Em.Dock = DockStyle.Fill;
            pnltables.Controls.Add(Em);
            Em.Show();
        }

        private void Btnhome_Click(object sender, EventArgs e)
        {
            this.Hide();
            Application.Exit();
           
        }
    }
}
