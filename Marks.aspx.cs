using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class Marks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["DeptID"] == null || Session["DeptID"].ToString() == "")
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "$.messager.alert('错误','请重新登陆！','error',function(){window.location.href='Default.aspx';}); ", true);
            else
            {
                if (Session["DeptName"] != null)
                    lblDeptName.Text = "当前用户：" + Session["DeptName"].ToString();

                //markmonth.InnerText = DateTime.Now.AddMonths(-1).ToString("yyyy年MM月");
                ddlMarkMonth.Items.Clear();
                //if (DateTime.Now.ToString("yyyyMM") == "201803")
                //{
                //    ddlMarkMonth.Items.Add(new ListItem("2018年02月", "2018-02"));
                //    ddlMarkMonth.Items.Add(new ListItem("2018年01月", "2018-01"));
                //} 
                //else
                ddlMarkMonth.Items.Add(new ListItem(DateTime.Now.AddMonths(-1).ToString("yyyy年MM月"), DateTime.Now.AddMonths(-1).ToString("yyyy-MM")));

                //绑定Repepater开始  
                DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnection(), CommandType.Text, "SELECT a.ByMarkDeptId, b.DeptName FROM dbo.DeptMarkRelation a JOIN dbo.Departments b ON  a.ByMarkDeptId = b.ID WHERE a.DeptID = @deptid", new SqlParameter("@deptid", Session["DeptID"]));
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
        string isMarkSql = "select *  from Marks where DeptID=" + Session["DeptID"].ToString() + " and MarkMonth='" + localDate + "'";
        DataSet ds = DirectDataAccessor.QueryForDataSet(isMarkSql);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "info", "$.messager.alert('提醒','对不起，您当月已经评分，请不要重复操作！','info'); ", true);
            return;
        }
        else
        {
            string insertSql;
            SqlParameter[] para;
            foreach (RepeaterItem ctrl in rep.Items)
            {
                HiddenField byMarkDeptID = (HiddenField)ctrl.FindControl("deptId");//被打分部门id
                DropDownList ddlScore = (DropDownList)ctrl.FindControl("ddlScore");
                TextBox memo = (TextBox)ctrl.FindControl("memo");
                para = new SqlParameter[] { new SqlParameter("@deptid", Session["DeptID"].ToString()), new SqlParameter("@byMarkDeptID", byMarkDeptID.Value), new SqlParameter("@ddlScore", ddlScore.Text), new SqlParameter("@memo", memo.Text), new SqlParameter("@localDate", localDate) };

                insertSql = "Insert Marks values(@deptid,@byMarkDeptID,@ddlScore,@memo,getdate(),@localDate)";
                SqlHelper.ExecuteNonQuery(SqlHelper.GetConnection(), CommandType.Text, insertSql, para);
                //计算被评分部门得分，更新部门得分表开始
                //string scoreSql = "select score from marks where ByMarkDeptID=" + byMarkDeptID.Value + " and MarkMonth='" + localDate + "'";
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
            ClientScript.RegisterStartupScript(this.GetType(), "info", "alert('评价成功！');window.location.href=window.location.href;", true);

        }

    }
    protected void rep_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.EditItem)
        {
            HiddenField byMarkDeptID = (HiddenField)e.Item.FindControl("deptId");//被打分部门id
            string scoreNum = DirectDataAccessor.QueryForDataSet("select scorenum from departments where id=" + byMarkDeptID.Value).Tables[0].Rows[0][0].ToString();
            DropDownList ddlScore = e.Item.FindControl("ddlScore") as DropDownList;
            ddlScore.Items.Add(new ListItem("请选择分值", "0"));
            for (int i = 1; i <= int.Parse(scoreNum); i++)
            {
                ddlScore.Items.Add(new ListItem(i.ToString()));
            }

        }
    }
}
