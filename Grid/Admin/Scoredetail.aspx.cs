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
            if (Request.QueryString["gid"] == null || Request.QueryString["gid"] == "" || Request.QueryString["year"] == null || Request.QueryString["year"] == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
            else
            {
                string deptNameSql = "select GridName from G_GridInfo where id=" + Request.QueryString["gid"];
                DataSet deptDs = DirectDataAccessor.QueryForDataSet(deptNameSql);
                deptName = deptDs.Tables[0].Rows[0][0].ToString();
                string scoreDate = Request.QueryString["year"] + "-" + Request.QueryString["month"];
                StringBuilder sql = new StringBuilder();
                sql.Append(" SELECT c.GridName,score,memo,b.Time FROM (SELECT * FROM dbo.G_GridMarkRelation WHERE ByMarkGridId = @gid) a LEFT JOIN dbo.G_GridMarksInfo b ON a.GridID = b.GridID AND b.ByMarkGridID = @gid AND b.MarkMonth = @markmonth JOIN dbo.G_GridInfo c ON  a.GridID = c.ID ");
               
                DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql.ToString(), new SqlParameter[] { new SqlParameter("@gid", Request.QueryString["gid"]), new SqlParameter("@markmonth", scoreDate) }
                    );
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
