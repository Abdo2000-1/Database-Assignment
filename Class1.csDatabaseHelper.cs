using System.Data;
using System.Data.SqlClient;

namespace MediaProductionManagementSystem
{
    public class DatabaseHelper
    {
        // Using the exact connection string requested
        private readonly string connectionString = @"Data Source=DESKTOP-REMQ7IG;Initial Catalog=MediaProduction;Integrated Security=True";

        /// <summary>
        /// Returns a new SqlConnection object using the provided connection string.
        /// </summary>
        public SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }

        /// <summary>
        /// Executes a SELECT query and returns the result as a DataTable.
        /// </summary>
        public DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        /// <summary>
        /// Executes INSERT, UPDATE, or DELETE queries and returns the number of affected rows.
        /// </summary>
        public int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    conn.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }
    }
}