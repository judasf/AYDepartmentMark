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

        //判断网格当月是否已打分
        //当前日期:格式 2009-03
        //string localDate = DateTime.Now.AddMonths(-1).ToString("yyyy-MM");
        string localDate = ddlMarkMonth.SelectedValue;
        string isMarkSql = "select *  from G_GridMarksInfo where GridID=" + Session["gid"].ToString() + " and MarkMonth='" + localDate + "'";
        DataSet ds = DirectDataAccessor.QueryForDataSet(isMarkSql);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "info", "$.messager.alert('提醒','对不起，您当月已经评分，请不要重复操作！','info'); ", true);
            return;
        }
        else
        {
            bool flag = true;
            string insertSql;
            SqlParameter[] para;
            foreach (RepeaterItem ctrl in rep.Items)
            {
                HiddenField byMarkGridID = (HiddenField)ctrl.FindControl("ByMarkGridId");//被打分部门id
                DropDownList ddlScore = (DropDownList)ctrl.FindControl("ddlScore");
                TextBox memo = (TextBox)ctrl.FindControl("memo");
                if (ddlScore.SelectedValue == "0")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "info", "$.messager.alert('提醒','请选择所有分值','info'); ", true);
                    //return;
                    flag = false;
                    break;

                }
                para = new SqlParameter[] {new SqlParameter("@gid", Session["gid"].ToString()),new SqlParameter("@byMarkGridID", byMarkGridID.Value),new SqlParameter("@ddlScore",ddlScore.Text),new SqlParameter("@memo",memo.Text),new SqlParameter("@localDate",localDate) };
                insertSql = "Insert G_GridMarksInfo values(@gid,@byMarkGridID,@ddlScore,@memo,getdate(),@localDate)";
                SqlHelper.ExecuteNonQuery(SqlHelper.GetConnection(), CommandType.Text, insertSql, para);
                //计算被评分部门得分，更新部门得分表开始
                //string scoreSql = "select score from G_GridMarksInfo where ByMarkDeptID=" + byMarkGridID.Value + " and MarkMonth='" + localDate + "'";
                //DataSet scoreDs = DirectDataAccessor.QueryForDataSet(scoreSql);
                //int totalScore = 0;
                //string deptScore;//部门得分
                //int scoreCount = scoreDs.Tables[0].Rows.Count;
                //for (int i = 0; i < scoreCount; i++)
                //{
                //    totalScore += int.Parse(scoreDs.Tables[0].Rows[i][0].ToString());
                //}
                //deptScore = (double.Parse(totalScore.ToString()) / scoreCount).ToString("f2");
                ////更新部门得分表
                //DirectDataAccessor.Execute("exec UpdateDeptScore " + byMarkDeptID.Value + ",'" + localDate + "','" + deptScore + "'");
                //计算被评分部门得分，更新部门得分表结束
            }
            ////计算被评分部门得分，更新部门得分表开始
            //string score = SqlHelper.ExecuteScalar(SqlHelper.GetConnection(), CommandType.Text, "SELECT  CONVERT(DECIMAL(5,2),AVG(CAST(Score AS DECIMAL(5,2)))) FROM G_GridMarksInfo WHERE MarkMonth=@localdate AND ByMarkGridID=1");
            //StringBuilder sql = new StringBuilder();
            //sql.Append(" IF EXISTS(SELECT * FROM dbo.G_GridScore WHERE GridID=1 AND ScoreDate='2019-01') ");
            //sql.Append("  ")
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
    }
}
