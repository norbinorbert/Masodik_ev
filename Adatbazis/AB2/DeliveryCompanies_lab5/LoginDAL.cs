using System.Data.SqlClient;

namespace Deliveries
{
    public class LoginDAL : DALGen
    {
        public string Login(string name, string password, ref string error)
        {
            strSqlConn = $"{strSqlConnTemplate}uid={name};pwd={password}";
            CreateConnection(ref error);
            if (error == "OK")
            {
                return strSqlConn;
            }
            else
            {
                return "";
            }
        }

        public void Register(string name, string password, ref string error)
        {
            strSqlConn = $"{strSqlConnTemplate}Integrated Security=SSPI";
            CreateConnection(ref error);
            if (error == "OK")
            {
                SqlCommand command = new SqlCommand("EXEC sp_new_user @pUserName, @pPassword");

                SqlParameter pUserName = new SqlParameter("@pUserName", name);
                command.Parameters.Add(pUserName);

                SqlParameter pPassword = new SqlParameter("@pPassword", password);
                command.Parameters.Add(pPassword);

                ExecuteNonQuery(command, ref error);
            }
        }
    }
}