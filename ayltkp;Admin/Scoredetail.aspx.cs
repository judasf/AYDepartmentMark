using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
public partial class Admin_ScoreDetail : System.Web.UI.Page
{
    public string deptName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["deptId"] == null || Request.QueryString["deptId"] == "" || Request.QueryString["year"] == null || Request.QueryString["year"] == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
            else
            {
                string deptNameSql = "select DeptName from Departments where id=" + Request.QueryString["deptId"];
                DataSet deptDs = DirectDataAccessor.QueryForDataSet(deptNameSql);
                deptName = deptDs.Tables[0].Rows[0][0].ToString();
                string scoreDate = Request.QueryString["year"] + "-" + Request.QueryString["month"];
                StringBuilder sql = new StringBuilder();
                sql.Append(" SELECT c.DeptName,score,memo,b.Time FROM (SELECT * FROM dbo.DeptMarkRelation WHERE ByMarkDeptId = @deptId) a LEFT JOIN dbo.Marks b ON a.deptid = b.deptid AND b.ByMarkDeptID = @deptId AND b.MarkMonth = @markmonth JOIN Departments c ON  a.deptID = c.ID ");
                DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql.ToString(), new SqlParameter[] { new SqlParameter("@deptId", Request.QueryString["deptId"]), new SqlParameter("@markmonth", scoreDate) });
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
