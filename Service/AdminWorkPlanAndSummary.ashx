<%@ WebHandler Language="C#" Class="AdminWorkPlanAndSummary" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Reflection;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
/// <summary>
/// 覆盖问题征集
/// </summary>
public class AdminWorkPlanAndSummary : IHttpHandler, IRequiresSessionState
{
    HttpRequest Request;
    HttpResponse Response;
    HttpSessionState Session;
    HttpServerUtility Server;
    HttpCookie Cookie;

    public void ProcessRequest(HttpContext context)
    {
        //不让浏览器缓存
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";
        context.Response.ContentType = "text/plain";

        Request = context.Request;
        Response = context.Response;
        Session = context.Session;
        Server = context.Server;
        //判断登陆状态
        if (Session["admin_work"] == null)
        {
            Response.Write("{\"success\":false,\"msg\":\"登陆超时，请重新登陆后再进行操作！\"}");
            return;
        }
        string method = HttpContext.Current.Request.PathInfo.Substring(1);
        if (method.Length != 0)
        {
            MethodInfo methodInfo = this.GetType().GetMethod(method);
            if (methodInfo != null)
            {
                methodInfo.Invoke(this, null);
            }
            else
                Response.Write("{\"success\":false,\"msg\":\"Method Not Matched !\"}");
        }
        else
        {
            Response.Write("{\"success\":false,\"msg\":\"Method not Found !\"}");
        }
    }
    /// <summary>
    /// 保存工作总结
    /// </summary>
    public void AdminSaveWorkSummary()
    {
        //判断上个月的工作总结是否已录入
        List<SqlParameter> _paras = new List<SqlParameter>();
        _paras.Add(new SqlParameter("@deptid", Request.Form["DeptID"]));
        _paras.Add(new SqlParameter("@workmonth", Request.Form["workmonth"]));
        DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, "SELECT id FROM  DeptWorkSummary WHERE deptid=@deptid AND workmonth=@workmonth", _paras.ToArray());
        if (ds.Tables[0].Rows.Count > 0)
        {
            Response.Write("{\"success\":false,\"msg\":\"" + Request.Form["workmonth"] + "工作总结已录入！\"}");
            return;
        }
        //获取数据行数
        int rowsCount = 0;
        Int32.TryParse(Request.Form["rowsCount"], out rowsCount);
        if (rowsCount == 0)
        {
            Response.Write("{\"success\":false,\"msg\":\"请录入工作总结\"}");
            return;
        }
        //根据数据行数生成sql语句和参数列表
        StringBuilder sql = new StringBuilder();
        List<SqlParameter> paras = new List<SqlParameter>();
        paras.AddRange(_paras);
        for (int i = 1; i <= rowsCount; i++)
        {
            sql.Append("insert into DeptWorkSummary values(@deptid,@workmonth,@classid" + i.ToString() + ",@workitem" + i.ToString() + ",@measure" + i.ToString() + ",@results" + i.ToString() + ",getdate());");
            paras.Add(new SqlParameter("@classid" + i.ToString(), Request.Form["classid" + i.ToString()]));
            paras.Add(new SqlParameter("@workitem" + i.ToString(), Server.HtmlEncode(Request.Form["workitem" + i.ToString()])));
            paras.Add(new SqlParameter("@measure" + i.ToString(), Server.HtmlEncode(Request.Form["measure" + i.ToString()])));
            paras.Add(new SqlParameter("@results" + i.ToString(), Server.HtmlEncode(Request.Form["results" + i.ToString()])));
        }
        int result = SqlHelper.ExecuteNonQuery(SqlHelper.GetConnection(), CommandType.Text, sql.ToString(), paras.ToArray());
        if (result > 0)
            Response.Write("{\"success\":true,\"msg\":\"提交成功\"}");
        else
            Response.Write("{\"success\":false,\"msg\":\"执行出错\"}");
    }
    /// <summary>
    /// 保存工作计划
    /// </summary>
    public void AdminSaveWorkPlan()
    {
        //判断上个月的工作总结是否已录入
        List<SqlParameter> _paras = new List<SqlParameter>();
        _paras.Add(new SqlParameter("@deptid", Request.Form["DeptID"]));
        _paras.Add(new SqlParameter("@workmonth", Request.Form["workmonth"]));
        DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, "SELECT id FROM  DeptWorkPlan WHERE deptid=@deptid AND workmonth=@workmonth", _paras.ToArray());
        if (ds.Tables[0].Rows.Count > 0)
        {
            Response.Write("{\"success\":false,\"msg\":\"" + Request.Form["workmonth"] + "工作计划已录入！\"}");
            return;
        }
        //获取数据行数
        int rowsCount = 0;
        Int32.TryParse(Request.Form["rowsCount"], out rowsCount);
        if (rowsCount == 0)
        {
            Response.Write("{\"success\":false,\"msg\":\"请录入工作计划\"}");
            return;
        }
        //根据数据行数生成sql语句和参数列表
        StringBuilder sql = new StringBuilder();
        List<SqlParameter> paras = new List<SqlParameter>();
        paras.AddRange(_paras);
        for (int i = 1; i <= rowsCount; i++)
        {
            sql.Append("insert into DeptWorkPlan values(@deptid,@workmonth,@workitem" + i.ToString() + ",@measure" + i.ToString() + ",@results" + i.ToString() + ",getdate());");
            paras.Add(new SqlParameter("@workitem" + i.ToString(), Server.HtmlEncode(Request.Form["workitem" + i.ToString()])));
            paras.Add(new SqlParameter("@measure" + i.ToString(), Server.HtmlEncode(Request.Form["measure" + i.ToString()])));
            paras.Add(new SqlParameter("@results" + i.ToString(), Server.HtmlEncode(Request.Form["results" + i.ToString()])));
        }
        int result = SqlHelper.ExecuteNonQuery(SqlHelper.GetConnection(), CommandType.Text, sql.ToString(), paras.ToArray());
        if (result > 0)
            Response.Write("{\"success\":true,\"msg\":\"提交成功\"}");
        else
            Response.Write("{\"success\":false,\"msg\":\"执行出错\"}");
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}