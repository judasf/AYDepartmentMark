﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Admin_ViewDeptScore : System.Web.UI.Page
{
    public string showYear;
    public string showMonth;
    protected void Page_Load(object sender, EventArgs e)
    {
        //ddlYm.Value = DateTime.Now.AddMonths(-1).ToString("yyyy-MM");
        if (!IsPostBack)
        {
            if (Session["admin"] == null || Session["admin"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");

            else
            {
                DateTime dt = DateTime.Now.AddMonths(-1);
                showYear = dt.ToString("yyyy");
                showMonth = dt.ToString("MM");
                BindRep(showYear + "-" + showMonth);
                ddlYm.Value = dt.ToString("yyyy-MM");
            }
        }
    }
    private void BindRep(string ym)
    {
        string isExist = "select * from DeptScore where scoredate='" + ym + "'";
        DataSet existDs = DirectDataAccessor.QueryForDataSet(isExist);
        if (existDs.Tables[0].Rows.Count > 0)
        {
            string sql = "select d.id,d.deptname,x.score from departments d left join ( select d.id,s.score from departments d";
            sql += "  join DeptScore s on s.deptid=d.id where s.scoredate='" + ym + "') x";
            sql += " on x.id=d.id  where d.scoreNum<>0 ";
            DataSet ds = DirectDataAccessor.QueryForDataSet(sql);
            rep.DataSource = ds;
            rep.DataBind();
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "show", "document.getElementById('noScore').style.display = 'block';document.getElementById('scoreList').style.display = 'none';", true);
        }
    }
    protected void Search_Click(object sender, EventArgs e)
    {
        BindRep(ddlYm.Value);
        showYear = ddlYm.Value.Split('-')[0].Trim();
        showMonth = ddlYm.Value.Split('-')[1].Trim();
    }
}
