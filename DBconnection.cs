using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace PhotoEquipment_RentalMS
{
  public  class  DBconnection
   {
        public string ServerName;
        public string sqlserver;

     public DBconnection(String server)
      {
            ServerName = server;
             sqlserver = $"Data Source= {  ServerName}; Initial Catalog=PhotoEquibment_RentalDB;Integrated Security=True";

      }
        // دالة ترجع اتصال جاهز
        public  SqlConnection GetConnection()
        {
            return new SqlConnection(sqlserver);
        }


    }
}
