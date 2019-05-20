using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class ViewPlan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["DeptID"] == null || Session["DeptID"].ToString() == "" || Request.QueryString["ym"] == null || Request.QueryString["ym"] == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
            else
            {
               
                string scoreDate = Request.QueryString["ym"] ;
                StringBuilder sql = new StringBuilder();
                sql.Append("SELECT ROW_NUMBER () OVER (ORDER BY id)AS sn,  ");
                sql.Append(" ItemInfo,Measure,Results  FROM DeptWorkPlan  where  ");
                sql.Append("Deptid=@deptid AND WorkMonth=@workmonth ");
                SqlParameter[] paras = new SqlParameter[] { 
                    new SqlParameter("@deptid",Session["DeptID"]),
                    new SqlParameter("@workmonth",Request.QueryString["ym"])
                };
                DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql.ToString(), paras);
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