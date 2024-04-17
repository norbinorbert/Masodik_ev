using System.Data;
using System.Data.SqlClient;

namespace Deliveries
{
    public abstract class DALGen
    {
        protected static bool isConnected;

        protected static SqlConnection sqlConnection;

        protected string strSqlConn = "Data Source=DESKTOP-D5DG5A4;Initial Catalog=DeliveryCompanies;Integrated Security=SSPI";
        
        protected void CreateConnection(ref string errMess)
        {
            if (isConnected != true)
            {
                try
                {
                    sqlConnection = new SqlConnection(strSqlConn);

                    sqlConnection.Open();
                    errMess = "OK";
                }
                catch (SqlException ex)
                {
                    errMess = ex.Message;
                }
                finally
                {
                    if (sqlConnection != null)
                    {
                        sqlConnection.Close();
                    }
                }
            }
        }

        private void OpenConnection(ref string errMess)
        {
            if (isConnected == false)
            {
                try
                {
                    sqlConnection.Open();
                    isConnected = true;
                    errMess = "OK";
                }
                catch (SqlException ex)
                {
                    errMess = ex.Message;
                }
            }
        }

        private void CloseConnection()
        {
            if (isConnected == true)
            {
                sqlConnection.Close();
                isConnected = false;
            }
        }

        protected SqlDataReader ExecuteReader(string sQuery, ref string errMess)
        {
            SqlDataReader sqlDataReader = null;
            try
            {
                OpenConnection(ref errMess);

                SqlCommand sqlCommand = new SqlCommand(sQuery,sqlConnection);

                sqlDataReader = sqlCommand.ExecuteReader();
                errMess = "OK";               
            }
            catch (Exception e)
            {
                errMess = e.Message;
                CloseDataReader(sqlDataReader);
            }
            return sqlDataReader;
        }

        protected void CloseDataReader(SqlDataReader rdr)
        {
            if (rdr != null)
                rdr.Close();
            CloseConnection();
        }

        protected DataSet ExecuteDS(string query, ref string errMess)
        {
            DataSet dataSet = new DataSet();
            try
            {
                OpenConnection(ref errMess);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(query, sqlConnection);
              
                dataAdapter.Fill(dataSet);

                errMess = "OK";
            }
            catch (SqlException e)
            {
                errMess = e.Message;
            }
            finally
            {
                if (sqlConnection != null)
                {
                    CloseConnection();
                }
            }
            return dataSet;
        }
    }
}