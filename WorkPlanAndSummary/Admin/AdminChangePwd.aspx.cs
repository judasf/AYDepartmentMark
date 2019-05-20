using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Xml;
public partial class AdminChangePwd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin_work"] == null || Session["admin_work"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (txtOld.Text == "")
            ClientScript.RegisterStartupScript(this.GetType(), "info2", "alert('请输入老密码！');", true);
        else
        {
            if (txtNew.Text == "")
                ClientScript.RegisterStartupScript(this.GetType(), "info1", "alert('请输入新密码！');", true);
            else
            {
                if (ConfigurationManager.AppSettings["WorkPwd"] == txtOld.Text)
                {
                  // Response.Write(HttpContext.Current.Server.MapPath("../web.config"));
                    Modify("WorkPwd", txtNew.Text);
                    /*
                    configuration = ConfigurationManager.OpenExeConfiguration(exePath);

                    //取得AppSetting节 
                    appSection = configuration.AppSettings;

                    //赋值并保存 
                    appSection.Settings["AdminPwd"].Value = txtRenew.Text;
                    configuration.Save(); 
* */
                  
                    ClientScript.RegisterStartupScript(this.GetType(), "info", "alert('密码修改成功！');", true);
                     
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('旧密码错误，请重新输入！');", true);
                }
            }
        }
    }
    /// <summary> 
    /// 修改web.config文件appsettings配置节中的add里的value属性 
    /// </summary> 
    /// <remarks> 
    /// 注意，调用该函数后，会使整个web application重启，导致当前所有的会话丢失 /// </remarks> 
    /// <param name="key">要修改的键key</param> 
    /// <param name="strvalue">修改后的value</param> 
    /// <exception cref="">找不到相关的键</exception> 
    /// <exception cref="">权限不够，无法保存到web.config文件中</exception>

    private void Modify(string key, string strvalue)
    {
        string xpath = "/configuration/appSettings/add[@key='Count']";
        XmlDocument domwebconfig = new XmlDocument();

        domwebconfig.Load(HttpContext.Current.Server.MapPath("../../web.config"));
        XmlNode addkey = domwebconfig.SelectSingleNode((xpath.Replace("Count", key)));
        if (addkey == null)
        {
            throw new ArgumentException("没有找到<add key=" + key + " value=.../>的配置节");
        }
        addkey.Attributes["value"].InnerText = strvalue;
        domwebconfig.Save(HttpContext.Current.Server.MapPath("../../web.config"));

    }


}
