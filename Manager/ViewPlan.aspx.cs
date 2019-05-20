using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class Manager_ViewPlan : System.Web.UI.Page
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
                sql.Append(" SELECT deptname,sn,iteminfo,Measure,results FROM ( ");
                sql.Append(" select deptname,dept.id from Departments AS dept   JOIN ");
                sql.Append(" ManagerMarkRelation ON dept.id=deptid AND mid=@mid ");
                sql.Append(" ) AS d LEFT JOIN ( ");
                sql.Append(" SELECT deptid,ROW_NUMBER () OVER (PARTITION BY deptid ORDER BY id)AS sn, ");
                sql.Append(" ItemInfo,Measure,Results  FROM DeptWorkPlan where  WorkMonth=@workmonth");
                sql.Append(" ) x ON d.id=x.deptid ORDER BY d.id ");
                SqlParameter[] paras = new SqlParameter[] { 
                    new SqlParameter("@mid",Session["mid"]),
                    new SqlParameter("@workmonth",Request.QueryString["ym"])
                };
                DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql.ToString(), paras);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    repList.DataSource = ds;
                    repList.DataBind();
                    MergeCells(repList, "deptname");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "show", "document.getElementById('noScore').style.display = 'block';document.getElementById('scoreList').style.display = 'none';", true);
                }
            }
        }
    }
    /// <summary>
    /// 合并单元格
    /// </summary>
    /// <param name="rep">repeater控件</param>
    /// <param name="idname">要合并的单元格id</param>
    private void MergeCells(Repeater rep, string idname)
    {
        for (int i = rep.Items.Count - 1; i > 0; i--)
        {
            HtmlTableCell oCell_Previous = rep.Items[i - 1].FindControl(idname) as HtmlTableCell;
            HtmlTableCell oCell = rep.Items[i].FindControl(idname) as HtmlTableCell;

            oCell.RowSpan = (oCell.RowSpan == -1) ? 1 : oCell.RowSpan;
            oCell_Previous.RowSpan = (oCell_Previous.RowSpan == -1) ? 1 : oCell_Previous.RowSpan;
            if (oCell.InnerText == oCell_Previous.InnerText)
            {
                oCell.Visible = false;
                oCell_Previous.RowSpan += oCell.RowSpan;
            }
        }
    }
}