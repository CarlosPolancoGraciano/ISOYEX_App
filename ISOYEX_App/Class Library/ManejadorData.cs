using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Text;

namespace ISOYEX_App
{
    public class ManejadorData
    {
        private static SqlConnection GetConnection() 
        {
            ///ISOYEX ConnectionString
            SqlConnection cnn = new SqlConnection("Data Source=.;Initial Catalog=ISOYEX;Integrated Security=True");
            return cnn;
        }

        private static DataTable GetTableFromCommand(SqlCommand cmd)
        {
            cmd.CommandTimeout = 300;
            SqlDataAdapter d = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            //debug(cmd);
            try
            {
                d.Fill(dt);
            }
            catch (InvalidOperationException InvalidOperExcep)
            {
                throw InvalidOperExcep;
            }

            catch (SqlException SQLexcep)
            {
                throw SQLexcep;
            }
            
            return dt;
        }

        private static void OCConn(SqlCommand cmd)
        {
            if (cmd == null) return;


            if (!(cmd.Connection == null))
            {
                if (cmd.Connection.State == ConnectionState.Open)
                {
                    cmd.Connection.Close();
                    cmd.Dispose();
                }
                else 
                {
                    cmd.Connection.Open();
                }
            }
            

        }

        private static void debug(SqlCommand cmd)
        {

            StringBuilder sss = new StringBuilder(256, 16384);

            String begin = Environment.NewLine + @"-----------------------------------------" + Environment.NewLine;
            String parametro = @"{0}='{1}'";
            String parametroEntero = @"{0}={1}";

            sss.Append(begin);

            if (cmd.CommandType == CommandType.StoredProcedure)
            {
                sss.AppendFormat("EXEC ");
            }

            sss.AppendFormat("{0} ", cmd.CommandText);
            sss.AppendLine("");

            SqlParameter last_item = null;
            if (cmd.Parameters.Count > 0)
            {
                last_item = cmd.Parameters[cmd.Parameters.Count - 1];
            }
            foreach (SqlParameter item in cmd.Parameters)
            {

                if (item.ParameterName[0] != '@') { sss.Append("@"); }

                if (item.SqlDbType == SqlDbType.Int)
                {
                    sss.AppendFormat(parametroEntero, item.ParameterName, item.Value);
                }
                else
                {
                    sss.AppendFormat(parametro, item.ParameterName, item.Value);
                }

                if (last_item != item) { sss.Append(",\n"); }
            }

            sss.Append(begin);
            sss.AppendLine("");

            System.Diagnostics.Debug.Write(sss.ToString());
        }

        public static DataTable Exec_Stp( String stp_name, char c, params String[] vars)
        {
            SqlCommand cmd = null;
            DataTable t = null;
            SqlTransaction ot = null;
            try
            {
                
                cmd = GetConnection().CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = stp_name;

                if ((vars != null) && (vars.Length >= 2))
                {
                    for (int i = 0; i < vars.Length; i = i + 2)
                    {
                        cmd.Parameters.AddWithValue(vars[i], vars[i + 1]);
                    }
                }

                if (c.Equals('m'))
                {
                    
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    t = GetTableFromCommand(cmd);
                    debug(cmd);
                }

                return t;

            }
            catch (SqlException excep)
            {

                throw excep;
            }
            catch (Exception excep)
            {

                ot.Rollback();
                throw excep;
            }
            finally
            {
                OCConn(cmd);
            }
        }
        
    }
}