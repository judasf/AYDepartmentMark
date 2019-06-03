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
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "$.messager.alert('错误','账号或密码不为空！','error'); ", true);
        else
        {

            string sql = "select * from ManagerInfo where managername=@name and managerpwd=@pwd";
            SqlParameter[] paras = new SqlParameter[] { 
                new SqlParameter("@name",name.Value),
                new SqlParameter("@pwd",pwd.Value)
            };
            DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql, paras);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["mid"] = ds.Tables[0].Rows[0][0];
                Session["manaName"] = ds.Tables[0].Rows[0][1];
                Response.Redirect("ManagerMarks.aspx");
            }
            else
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "$.messager.alert('错误','账号或密码不正确！','error'); ", true);
        }
    }
}
