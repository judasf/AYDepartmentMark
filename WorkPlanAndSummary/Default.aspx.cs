using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
public partial class Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void login_Click(object sender, EventArgs e)
    {
        if (name.Value == "" && pwd.Value == "")
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('用户名或密码错误,请重新输入!')", true);
        else
        {

            string sql = "select * from departments where deptname=@name and LoginPwd=@pwd and hasSp=1";
            SqlParameter[] paras = new SqlParameter[] { 
                new SqlParameter("@name",name.Value),
                new SqlParameter("@pwd",pwd.Value)
            };
            DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql, paras);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["DeptID"] = ds.Tables[0].Rows[0][0];
                Session["DeptName"] = ds.Tables[0].Rows[0][2];
                Response.Redirect("AddSummaryInfo.aspx");
            }
            else
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('用户名或密码错误,请重新输入!')", true);
        }
    }
}
