using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;


public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write((double.Parse("26") / 6).ToString("f2"));
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (txtUserName.Text == "" && txtPassWord.Text == "")
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('用户名或密码错误,请重新输入!')", true);
        else
        {
            string sql = "select * from departments where deptname=@name and LoginPwd=@pwd and ismarking=1";
            SqlParameter[] paras = new SqlParameter[] { 
                new SqlParameter("@name",txtUserName.Text),
                new SqlParameter("@pwd",txtPassWord.Text)
            };
            DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql, paras);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["DeptID"] = ds.Tables[0].Rows[0][0];
                Session["ClassID"] = ds.Tables[0].Rows[0][1];
                Session["DeptName"] = ds.Tables[0].Rows[0][2];
                Response.Redirect("Marks.aspx");
            }
            else
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('用户名或密码错误,请重新输入!')", true);
        }

    }
   
}
