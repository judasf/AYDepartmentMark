using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
public partial class AdminAddPlanInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (Request.QueryString["DeptID"] == null || Request.QueryString["workmonth"].ToString() == null)
            {

                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.opener.location.href='Default.aspx';</script>");
                return;
            }
            else
            {
                if (Request.QueryString["DeptID"] !="")
                {
                    lblDeptName.Text = SqlHelper.ExecuteScalar(SqlHelper.GetConnection(), CommandType.Text, "select DeptName from Departments where id=@id",new SqlParameter("@id",Request.QueryString["DeptID"])).ToString();
                    deptid.Value = Request.QueryString["DeptID"];
                }
               if (Request.QueryString["workmonth"] !=""|| Request.QueryString["workmonth"].Length==6)
               {
                   lblMonth.Text = Request.QueryString["workmonth"].Substring(0, 4) + "年" + Request.QueryString["workmonth"].Substring(5, 2)+"月";
                   workmonth.Value = Request.QueryString["workmonth"];
               }

            }
        }
    }
}
