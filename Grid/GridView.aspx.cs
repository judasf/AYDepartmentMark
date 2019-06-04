using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
public partial class GridView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["mid"] == null || Session["mid"].ToString() == "" || Request.QueryString["ym"] == null || Request.QueryString["ym"] == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
            else
            {
               
                string scoreDate = Request.QueryString["ym"] ;
                StringBuilder sql = new StringBuilder();
                sql.Append("select  d.deptname,x.score,x.memo  from departments d join ");
                sql.Append(" ManagerMarkForDeptsInfo x  on ");
                sql.Append("x.bymarkdeptid=d.id where x.mid=" + Session["mid"].ToString() + " and ");
                sql.Append("MarkMonth='" + scoreDate + "' ");
                DataSet ds = DirectDataAccessor.QueryForDataSet(sql.ToString());
                if (ds.Tables[0].Rows.Count > 0)
                {
                    repList.DataSource = ds;
                    repList.DataBind();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "show", "document.getElementById('noScore').style.display = 'block';document.getElementById('scoreList').style.display = 'none';", true);
                }
            }
        }
    }
}