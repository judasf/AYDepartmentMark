using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Admin_deptinfo : System.Web.UI.Page
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
        string sql = "select id,deptname from departments where ismarking=1";
        DataSet ds = DirectDataAccessor.QueryForDataSet(sql);
        rep.DataSource = ds;
        rep.DataBind();
    }

    protected void rep_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "btnRecover")
        {
            DirectDataAccessor.Execute("UPDATE departments set loginpwd='ayltkp.0' where id='" + e.CommandArgument.ToString() + "'");
            ClientScript.RegisterStartupScript(this.GetType(), "info", "alert('密码恢复成功！')", true);
        }
    }
}
