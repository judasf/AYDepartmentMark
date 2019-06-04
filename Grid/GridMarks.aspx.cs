using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
public partial class GridMarks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Session["gid"] == null || Session["gid"].ToString() == "")
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "$.messager.alert('错误','请重新登陆！','error',function(){window.location.href='Default.aspx';}); ", true);
            //Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
            else
            {
                if (Session["gname"] != null)
                    lblDeptName.Text = "当前用户：" + Session["gname"].ToString();

                //markmonth.InnerText = DateTime.Now.AddMonths(-1).ToString("yyyy年MM月");
                ddlMarkMonth.Items.Clear();
                ddlMarkMonth.Items.Add(new ListItem(DateTime.Now.AddMonths(-1).ToString("yyyy年MM月"), DateTime.Now.AddMonths(-1).ToString("yyyy-MM")));

                //绑定Repepater开始  
                DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, "SELECT a.ByMarkGridId, b.GridName FROM dbo.G_GridMarkRelation a JOIN dbo.G_GridInfo b ON  a.ByMarkGridId = b.ID WHERE a.GridID = @gid", new SqlParameter("@gid", Session["gid"]));
                total.Value = ds.Tables[0].Rows.Count.ToString();
                rep.DataSource = ds;
                rep.DataBind();
                //绑定Repepater结束
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        //判断部门当月是已打分
        //当前日期:格式 2009-03
        //string localDate = DateTime.Now.AddMonths(-1).ToString("yyyy-MM");
        string localDate = ddlMarkMonth.SelectedValue;
        string isMarkSql = "select *  from ManagerMarkForDeptsInfo where Mid=" + Session["mid"].ToString() + " and MarkMonth='" + localDate + "'";
        DataSet ds = DirectDataAccessor.QueryForDataSet(isMarkSql);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('对不起，您当月已经评分，请不要重复操作！')", true);
            return;
        }
        else
        {
            bool flag = true;
            string insertSql;
            foreach (RepeaterItem ctrl in rep.Items)
            {
                HiddenField byMarkDeptID = (HiddenField)ctrl.FindControl("deptId");//被打分部门id
                DropDownList ddlScore = (DropDownList)ctrl.FindControl("ddlScore");
                TextBox memo = (TextBox)ctrl.FindControl("memo");
                if (ddlScore.SelectedValue == "0")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('请选择所有分值！')", true);
                    //return;
                    flag = false;
                    break;

                }
                insertSql = "Insert Into ManagerMarkForDeptsInfo values(" + Session["Mid"].ToString() + "," + byMarkDeptID.Value + ",'" + ddlScore.Text + "','" + memo.Text + "',getdate(),'" + localDate + "')";
                DirectDataAccessor.Execute(insertSql);
                //计算被评分部门得分，更新部门得分表开始
                string scoreSql = "select score,IsDuputy from ManagerMarkForDeptsInfo AS a JOIN ManagerInfo AS b ";
                scoreSql += " ON a.mid=b.Mid where ByMarkDeptID=" + byMarkDeptID.Value + " and MarkMonth='" + localDate + "'";
                DataSet scoreDs = DirectDataAccessor.QueryForDataSet(scoreSql);
                double totalScore = 0.0;
                string deptScore;//部门得分:正职*0.6+副职*0.4
                foreach (DataRow dr in scoreDs.Tables[0].Rows)
                {
                    //if (byMarkDeptID.Value == "33" || byMarkDeptID.Value == "43")
                    //    totalScore = double.Parse(dr[0].ToString());
                    //else
                    //{
                    if (dr[1].ToString() == "0")
                        totalScore += double.Parse(dr[0].ToString()) * 0.6;
                    else if (dr[1].ToString() == "1")
                    {
                        totalScore += double.Parse(dr[0].ToString()) * 0.4;
                    }
                    //}
                }
                deptScore = totalScore.ToString("f2");
                //更新部门得分表
                DirectDataAccessor.Execute("exec UpdateManagerMarkDeptScore " + byMarkDeptID.Value + ",'" + localDate + "','" + deptScore + "'");
                //计算被评分部门得分，更新部门得分表结束
            }
            if (flag)
                ClientScript.RegisterStartupScript(this.GetType(), "info", "alert('评价成功！');window.location.href=window.location.href;", true);

        }

    }
    protected void rep_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.EditItem)
        {
            HiddenField ByMarkGridId = (HiddenField)e.Item.FindControl("ByMarkGridId");//被打分网格id
            string scoreNum = DirectDataAccessor.QueryForDataSet("select scorenum from G_GridInfo where id=" + ByMarkGridId.Value).Tables[0].Rows[0][0].ToString();
            DropDownList ddlScore = e.Item.FindControl("ddlScore") as DropDownList;
            ddlScore.Items.Add(new ListItem("请选择分值", "0"));
            for (int i = 1; i <= int.Parse(scoreNum); i++)
            {
                ddlScore.Items.Add(new ListItem(i.ToString()));
            }

        }
        //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.EditItem)
        //{
        //    //HiddenField byMarkDeptID = (HiddenField)e.Item.FindControl("deptId");//被打分部门id
        //    //string scoreNum = DirectDataAccessor.QueryForDataSet("select scorenum from departments where id=" + byMarkDeptID.Value).Tables[0].Rows[0][0].ToString();
        //    DropDownList ddlScore = e.Item.FindControl("ddlScore") as DropDownList;
        //    ddlScore.Items.Add(new ListItem("请选择分值", "-1"));
        //    for (int i = 10; i >= 0; i--)
        //    {
        //        ddlScore.Items.Add(new ListItem(i.ToString()));
        //    }

        //}
    }
}
