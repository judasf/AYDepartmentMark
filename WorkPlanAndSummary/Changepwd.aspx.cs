using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class ChangePwd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["DeptID"] == null || Session["DeptID"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
        string sql = "select * from departments where id=" +Session["DeptID"].ToString() + " and LoginPwd='" + txtOld.Text + "'";
        DataSet ds = DirectDataAccessor.QueryForDataSet(sql);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string UpdateSql = "update departments set LoginPwd='" + txtRenew.Text + "' where id=" + Session["DeptID"].ToString();
            DirectDataAccessor.Execute(UpdateSql);//打分加IP统计
            ClientScript.RegisterStartupScript(this.GetType(), "info", "alert('密码修改成功！')", true);
        }
        else 
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('旧密码错误，请重新输入！')", true);
        }
    }
}
