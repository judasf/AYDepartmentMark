using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Data.SqlClient;
public partial class Admin_WorkPlan : System.Web.UI.Page
{
    public string thisMonth;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Session["admin_work"] == null || Session["admin_work"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");

            else
            {
                DataSet ds1 = DirectDataAccessor.QueryForDataSet("select workmonth from DeptWorkPlan group by workmonth order by workmonth desc ");
                foreach (DataRow dr in ds1.Tables[0].Rows)
                {
                    ddlYm.Items.Add(new ListItem(dr[0].ToString().Split('-')[0] + "年" + dr[0].ToString().Split('-')[1].Trim() + "月", dr[0].ToString().Trim()));
                }
                /////
               //默认显示当月
                BindRep(DateTime.Now.ToString("yyyy-MM"));
                thisMonth = DateTime.Now.ToString("yyyy年MM月");
            }
        }

    }
    private void BindRep(string ym)
    {
        StringBuilder sql = new StringBuilder();
        sql.Append(" SELECT d.id,deptname,isnull(deptid,0) as hassp FROM ( ");
        sql.Append(" select deptname,id from Departments WHERE hasSp=1) AS d ");
        sql.Append(" LEFT JOIN ( ");
        sql.Append(" SELECT deptid FROM DeptWorkPlan  WHERE WorkMonth=@workmonth GROUP BY deptid ");
        sql.Append(" ) x ON d.id=x.deptid ORDER BY d.id ");
        DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, sql.ToString(), new SqlParameter("@workmonth",ym));
        rep.DataSource = ds;
        rep.DataBind();
    }
    protected void Search_Click(object sender, EventArgs e)
    {
        BindRep(ddlYm.Text);
        thisMonth = ddlYm.SelectedItem.Text;
    }
    public string handleHasSp(string deptid, string workmonth, string hassp)
    {
        string str = "";
        if (hassp == "0")//未录入
        {
            str = string.Format("<a href=\"javascript:void(0);\" title=\"点击补录工作计划\" class=\"easyui-tooltip\" onclick=\"addPlan('{0}','{1}');\"><b style='color:red;'>未录入</b></a>", deptid, workmonth);
        }
        else
        {
                str = "已录入";
        }

        return str;
    }
}
