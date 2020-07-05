using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Reflection;
using System.Text;
//using Newtonsoft.Json
using Dapper;
//using System.Data.Linq;


namespace DCurdApi.Model
{
    public class ContractRepository
    {
        private readonly string connectionString;
        public ContractRepository()
        {
            connectionString = @"Data Source=MSPROJECT;Initial Catalog=licDB;User ID=sa;Password=Maple@123;Pooling=False";
        }

        public IDbConnection Connection
        {
            get
            {
                return new SqlConnection(connectionString);
            }
        }
        public void Add(Contract licContract)
        {
            using (SqlConnection sqlCon = new SqlConnection(connectionString))
            {
                string cQuery = @"execute AddEdit_Contract @p_Name,@p_Address,@p_ID,@p_Country,@p_SDate,@p_Gen,@p_Age, @p_dob, @p_flag";
                sqlCon.Open();
                //sqlCon.Execute();

                SqlCommand sqlCmd = new SqlCommand(cQuery, sqlCon);
                sqlCmd.Parameters.AddWithValue("@p_ID", 0);
                sqlCmd.Parameters.AddWithValue("@p_Name", licContract.CustomerName);
                sqlCmd.Parameters.AddWithValue("@p_Address", licContract.Address);
                sqlCmd.Parameters.AddWithValue("@p_Country", licContract.Country);
                sqlCmd.Parameters.AddWithValue("@p_SDate", licContract.SaleDate);
                sqlCmd.Parameters.AddWithValue("@p_Gen", licContract.Gender);
                sqlCmd.Parameters.AddWithValue("@p_Age", licContract.Age);
                sqlCmd.Parameters.AddWithValue("@p_dob", licContract.Dateofbirth);
                sqlCmd.Parameters.AddWithValue("@p_flag", "ADD");
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
            }
        }

        public IEnumerable<Contract> GetAll()
        {
            using (IDbConnection sConn = Connection)
            {
                string cQuery = @"SELECT ContractID ,CustomerName,Address,Gender,Country,Dateofbirth,SaleDate,CoveragePlan,NetPrice  FROM licDB.dbo.Contracts";
                sConn.Open();
                return sConn.Query<Contract>(cQuery);
            }
        }

        public Contract GetById(int cId)
        {
            using (IDbConnection sConn = Connection)
            {
                string cQuery = "SELECT ContractID ,CustomerName,Address,Gender,Country,Dateofbirth,SaleDate,CoveragePlan,NetPrice FROM licdb.dbo.Contracts Where ContractID = @ContractID";
                sConn.Open();
                return sConn.Query<Contract>(cQuery, new { ContractID = cId }).FirstOrDefault();

            }
        }

        public void DeleteById(int cId)
        {
            using (IDbConnection sConn = Connection)
            {
                string cQuery = "DELETE FROM licdb.dbo.Contracts Where ContractID = @ContractID";
                sConn.Open();
                sConn.Execute(cQuery, new { ContractID = cId });

            }
        }

        public void Update(int CId, Contract licContract)
        {
            using (SqlConnection sqlCon = new SqlConnection(connectionString))
            {
                string cQuery = @"execute AddEdit_Contract @p_Name,@p_Address,@p_ID,@p_Country,@p_SDate,@p_Gen,@p_Age, @p_dob, @p_flag";
                sqlCon.Open();
                //sqlCon.Execute();

                SqlCommand sqlCmd = new SqlCommand(cQuery, sqlCon);
                sqlCmd.Parameters.AddWithValue("@p_ID", licContract.ContractID);
                sqlCmd.Parameters.AddWithValue("@p_Name", licContract.CustomerName);
                sqlCmd.Parameters.AddWithValue("@p_Address", licContract.Address);
                sqlCmd.Parameters.AddWithValue("@p_Country", licContract.Country);
                sqlCmd.Parameters.AddWithValue("@p_SDate", licContract.SaleDate);
                sqlCmd.Parameters.AddWithValue("@p_Gen", licContract.Gender);
                sqlCmd.Parameters.AddWithValue("@p_Age", licContract.Age);
                sqlCmd.Parameters.AddWithValue("@p_dob", licContract.Dateofbirth);
                sqlCmd.Parameters.AddWithValue("@p_flag", "MODIFY");
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();

            }
        }

    }
}
