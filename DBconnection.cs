using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Windows.Forms;
public class DBConnection
{
    private MySqlConnection connection;

    public DBConnection()
    {
        string connectionString = "server=localhost;database=photoEquipmentRentalMS;uid=root;pwd=;";
        connection = new MySqlConnection(connectionString);
    }

    public MySqlConnection GetConnection()
    {
        return connection;
    }

    public void Open()
    {
        if (connection.State == System.Data.ConnectionState.Closed)
        {
            connection.Open();
        }
    }

    public void Close()
    {
        if (connection.State == System.Data.ConnectionState.Open)
        {
            connection.Close();
        }
    }
}
