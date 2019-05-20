using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
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
                string whereStr = "";
                switch (Int32.Parse(Request.QueryString["deptId"]))
                {
                    case 6://政企客户事业部
                        whereStr = "where de.classid=1 or de.classid=3";
                        break;
                    case 10://创新业务支撑中心
                        whereStr = "where de.classid=1";
                        break;
                    case 11://市场营销部
                        whereStr = "where de.classid=1 or de.classid=2 or de.classid=5  or de.classid=6 or de.classid=7 or de.classid=9 or de.classid=10";
                        break;
                    case 17://互联网与电子商务运营中心
                        whereStr = "where de.classid=1 or de.classid=5  or de.classid=6 ";
                        break;
                    case 18://运行维护部
                    case 25://网络发展部
                        whereStr = "where de.classid=1 or de.classid=3 or de.classid=5 or de.classid=8";
                        break;
                    case 19://网络维护中心
                    case 21://客户支撑中心
                        whereStr = "where de.classid=1 or de.classid=3 or de.classid=5 or de.classid=6";
                        break;
                    case 20://网络优化中心
                        whereStr = "where de.classid=1  or de.classid=5 or de.classid=6";
                        break;
                    case 22://信息化服务中心
                        whereStr = "where (de.classid>=1 and de.classid<=7) or de.classid=10";
                        break;
                    case 23://综合服务支撑中心
                        whereStr = "where (de.classid>=1 and de.classid<=8)";
                        break;
                    case 24://客户服务部
                        whereStr = "where (de.classid>=5 and de.classid<=9) or de.classid=1";
                        break;
                    case 26://财务部
                    case 27://综合部
                    case 28://人力资源部
                    case 29://党群工作部
                    case 30://资产运营与物资管理部
                    case 31://工会
                        whereStr = "where (de.classid>=5 and de.classid<=10) or de.classid=1 or de.classid=3 ";
                        break;
                }
             

                StringBuilder sql = new StringBuilder();
                sql.Append("select de.deptname,z.score,z.memo,z.time from departments de left join ( ");
                sql.Append("select  d.id,d.deptname,x.score,x.memo,x.Time  from departments d join ( ");
                sql.Append("select m.deptid,m.score,m.memo,m.Time from marks m join departments d on ");
                sql.Append("m.ByMarkDeptID=d.id where m.ByMarkDeptID=" + Request.QueryString["deptId"] + " and  ");
                sql.Append("MarkMonth='" + scoreDate + "')x on  x.deptid=d.id) z ");
                sql.Append(" on de.id=z.id " + whereStr);
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
