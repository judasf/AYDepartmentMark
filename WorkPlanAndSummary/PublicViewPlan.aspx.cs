using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class PublicViewSummary : System.Web.UI.Page
{
    public string dpName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["deptid"] == null || Request.QueryString["deptid"] == "" || Request.QueryString["ym"] == null || Request.QueryString["ym"] == "")
            {
                Response.Write("请求出错！");
                Response.End();
            }
            else
            {

                if (!string.IsNullOrEmpty(Request.QueryString["deptid"]))
                {
                    DataSet dsname = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, "Select deptname from departments where id=@deptid", new SqlParameter("@deptid", Request.QueryString["deptid"]));
                    if (dsname.Tables[0].Rows.Count == 1)
                        dpName = dsname.Tables[0].Rows[0][0].ToString();
                }
                string scoreDate = Request.QueryString["ym"];
                StringBuilder sql = new StringBuilder();
                sql.Append("SELECT ROW_NUMBER () OVER (ORDER BY id)AS sn,  ");
                sql.Append(" ItemInfo,Measure,Results  FROM DeptWorkPlan  where  ");
                sql.Append("Deptid=@deptid AND WorkMonth=@workmonth ");
                SqlParameter[] paras = new SqlParameter[] { 
                    new SqlParameter("@deptid",Request.QueryString["deptid"]),
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