using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Admin_ManagerInfo : System.Web.UI.Page
{
    public string showYear;
    public string showMonth;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Session["admin"] == null || Session["admin"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
            else
                BindRep();
        }
    }
    private void BindRep()
    {
        string sql = "select mid,managername from ManagerInfo";
        DataSet ds = DirectDataAccessor.QueryForDataSet(sql);
        rep.DataSource = ds;
        rep.DataBind();
    }

    protected void rep_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "btnRecover")
        {
            DirectDataAccessor.Execute("UPDATE ManagerInfo set managerpwd='123456' where mid='" + e.CommandArgument.ToString() + "'");
            ClientScript.RegisterStartupScript(this.GetType(), "info", "alert('密码恢复成功！')", true);
        }
    }
}
