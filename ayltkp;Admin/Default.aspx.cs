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
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "$.messager.alert('错误','账号或密码不正确！','error'); ", true);
        else
        {
            if (ConfigurationManager.AppSettings["AdminName"] == name.Value && ConfigurationManager.AppSettings["AdminPwd"] == pwd.Value)
            {
                Session["admin"] = name.Value;
                Server.Transfer("ViewDeptScore.aspx");
            }
            else
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "$.messager.alert('错误','账号或密码不正确！','error'); ", true);
        }
    }
}
