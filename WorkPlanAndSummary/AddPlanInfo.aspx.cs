using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
public partial class AddPlanInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["DeptID"] = 36;
        //Session["DeptName"] = "人力资源部";
        if (!IsPostBack)
        {

            if (Session["DeptID"] == null || Session["DeptID"].ToString() == "")
            {

                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
                return;
            }
            else
            {
                if (Session["DeptName"] != null)
                {
                    lblDeptName.Text = "当前用户：" + Session["DeptName"].ToString();
                }
                //绑定下拉列表框
                DataSet ds1 = DirectDataAccessor.QueryForDataSet("select WorkMonth from DeptWorkPlan group by WorkMonth order by WorkMonth desc ");
                foreach (DataRow dr in ds1.Tables[0].Rows)
                {
                    ddlYm.Items.Add(new ListItem(dr[0].ToString().Split('-')[0] + "年" + dr[0].ToString().Split('-')[1].Trim() + "月", dr[0].ToString().Trim()));
                }

            }
        }
    }
}
