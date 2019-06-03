using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class ChangePwd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["mid"] == null || Session["mid"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlParameter[] paras1 = new SqlParameter[] { 
            new SqlParameter("@mid",Session["mid"].ToString()),
            new SqlParameter("@pwd",txtOld.Text)
        };
        SqlParameter[] paras2 = new SqlParameter[] { 
            new SqlParameter("@mid",Session["mid"].ToString()),
            new SqlParameter("@newpwd",txtNew.Text)
        };
        string sql = "select * from ManagerInfo where mid=@mid and ManagerPwd=@pwd";
        DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(),CommandType.Text,sql,paras1);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string UpdateSql = "update ManagerInfo set ManagerPwd=@newpwd where mid=@mid";
            SqlHelper.ExecuteNonQuery(SqlHelper.GetConnection(), CommandType.Text, UpdateSql, paras2);
            ClientScript.RegisterStartupScript(this.GetType(), "info", "alert('密码修改成功！')", true);
        }
        else 
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('旧密码错误，请重新输入！')", true);
        }
    }
}
