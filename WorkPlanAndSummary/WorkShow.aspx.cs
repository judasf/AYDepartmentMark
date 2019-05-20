using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.OleDb;
using System.Data;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class Datashow : System.Web.UI.Page
{
    public string thisMonth;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            StringBuilder sql = new StringBuilder("SELECT DISTINCT workmonth FROM (");
            sql.Append("SELECT distinct workmonth FROM DeptWorkPlan UNION ");
            sql.Append(" SELECT distinct workmonth FROM DeptWorkSummary) a ORDER BY workmonth desc ");
            DataSet ds1 = DirectDataAccessor.QueryForDataSet(sql.ToString());
            if (ds1.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds1.Tables[0].Rows)
                {
                    ddlYm.Items.Add(new ListItem(dr[0].ToString().Split('-')[0] + "年" + dr[0].ToString().Split('-')[1].Trim() + "月", dr[0].ToString().Trim()));
                }
            }
            else
                ddlYm.Items.Add(new ListItem(DateTime.Now.ToString("yyyy年MM月"), DateTime.Now.ToString("yyyy-MM")));
            //默认显示当月
            BindRept(DateTime.Now.ToString("yyyy-MM"), rep1,"1");
            BindRept(DateTime.Now.ToString("yyyy-MM"), rep2, "2");
            BindRept(DateTime.Now.ToString("yyyy-MM"), rep3, "3");
            BindRept(DateTime.Now.ToString("yyyy-MM"), rep4, "4");
            thisMonth = DateTime.Now.ToString("yyyy年MM月");
           
        }
    }
    private void BindRept(string ym,Repeater repData,string typeid)
    {
        string sql = "select id,deptname from departments where typeid="+typeid;
        DataSet ds = DirectDataAccessor.QueryForDataSet(sql);
        repData.DataSource = ds;
        repData.DataBind();
    }
    protected void Search_Click(object sender,EventArgs e)
    {
        thisMonth = ddlYm.SelectedItem.Text;
    }
}
