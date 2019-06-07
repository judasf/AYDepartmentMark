using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class Admin_ViewDeptScore : System.Web.UI.Page
{
    public string showYear;
    public string showMonth;
    protected void Page_Load(object sender, EventArgs e)
    {
        //ddlYm.Value = DateTime.Now.AddMonths(-1).ToString("yyyy-MM");
        if (!IsPostBack)
        {
            if (Session["admin"] == null || Session["admin"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");

            else
            {
                DateTime dt = DateTime.Now.AddMonths(-1);
                showYear = dt.ToString("yyyy");
                showMonth = dt.ToString("MM");
                BindRep(showYear + "-" + showMonth);
                ddlYm.Value = dt.ToString("yyyy-MM");
            }
        }
    }
    private void BindRep(string ym)
    {
        string isExist = "select * from Marks where MarkMonth=@ym";
        DataSet existDs = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, isExist, new SqlParameter("@ym", ym));
        if (existDs.Tables[0].Rows.Count > 0)
        {
            string sql = "SELECT a.id,a.DeptName,b.Score FROM (SELECT id, DeptName FROM dbo.Departments WHERE scoreNum <> 0)a LEFT JOIN(SELECT ByMarkDeptID, CONVERT(DECIMAL(5, 2), AVG(CAST(Score AS DECIMAL(5, 2))))AS score FROM Marks WHERE MarkMonth = @ym GROUP BY ByMarkDeptID) b ON a.id = b.ByMarkDeptID  ";
            DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql, new SqlParameter("@ym", ym));
            rep.DataSource = ds;
            rep.DataBind();
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "show", "document.getElementById('noScore').style.display = 'block';document.getElementById('scoreList').style.display = 'none';", true);
        }
    }
    protected void Search_Click(object sender, EventArgs e)
    {
        if (ddlYm.Value.Length == 0)
            Response.Write("<script type='text/javascript'>alert('请选择月份！');</script>");
        else
        {
            BindRep(ddlYm.Value);
            showYear = ddlYm.Value.Split('-')[0].Trim();
            showMonth = ddlYm.Value.Split('-')[1].Trim();
        }
    }
}
