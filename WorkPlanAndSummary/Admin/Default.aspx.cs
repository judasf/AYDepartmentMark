using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void login_Click(object sender, EventArgs e)
    {
        if (name.Value == "" && pwd.Value == "")
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('用户名或密码错误,请重新输入!')", true);
        else
        {
            if(ConfigurationManager.AppSettings["WorkName"]==name.Value &&ConfigurationManager.AppSettings["WorkPwd"]==pwd.Value)
            {
                Session["admin_work"] = name.Value;
                Response.Redirect("WorkSummary.aspx");
            }           
            else
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('用户名或密码错误,请重新输入!')", true);
        }
    }
}
