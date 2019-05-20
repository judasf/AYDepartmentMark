﻿using System;
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
                sql.Append("SELECT classname,ROW_NUMBER () OVER (PARTITION BY workclassid ORDER BY a.id)AS sn,  ");
                sql.Append(" ItemInfo,a.Measure,a.Results  FROM DeptWorkSummary AS a  ");
                sql.Append("JOIN DeptWorkClassInfo AS b ON a.WorkClassId = b.ID AND ");
                sql.Append("a.Deptid=@deptid AND a.WorkMonth=@workmonth ");
                SqlParameter[] paras = new SqlParameter[] { 
                    new SqlParameter("@deptid",Request.QueryString["deptid"]),
                    new SqlParameter("@workmonth",Request.QueryString["ym"])
                };
                DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql.ToString(), paras);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    repList.DataSource = ds;
                    repList.DataBind();
                    MergeCells(repList, "className");
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