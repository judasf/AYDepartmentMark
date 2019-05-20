using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
public partial class Marks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["ClassID"] == null || Session["ClassID"].ToString() == "" || Session["DeptID"] == null || Session["DeptID"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='Default.aspx';</script>");
            else
            {
                if(Session["DeptName"]!=null)
                lblDeptName.Text = "当前用户："+Session["DeptName"].ToString();

                //markmonth.InnerText = DateTime.Now.AddMonths(-1).ToString("yyyy年MM月");
                ddlMarkMonth.Items.Clear();
                if (DateTime.Now.ToString("yyyyMM") == "201803")
                {
                    ddlMarkMonth.Items.Add(new ListItem("2018年02月", "2018-02"));
                    ddlMarkMonth.Items.Add(new ListItem("2018年01月", "2018-01"));
                } 
                else
                    ddlMarkMonth.Items.Add(new ListItem(DateTime.Now.AddMonths(-1).ToString("yyyy年MM月"), DateTime.Now.AddMonths(-1).ToString("yyyy-MM")));

                //绑定Repepater开始  
                string relationTableName = "Class" + Session["ClassID"].ToString() + "Relation";
                DataSet ds = DirectDataAccessor.QueryForDataSet(" select x.deptid,d.deptname from departments d join " + relationTableName + " x on x.deptid=d.id order by d.id");
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
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('对不起，您当月已经评分，请不要重复操作！')", true);
            return;
        }
        else
        {
            string insertSql;
            foreach (RepeaterItem ctrl in rep.Items)
            {
                HiddenField byMarkDeptID = (HiddenField)ctrl.FindControl("deptId");//被打分部门id
                DropDownList ddlScore = (DropDownList)ctrl.FindControl("ddlScore");
                TextBox memo = (TextBox)ctrl.FindControl("memo");

                insertSql = "Insert Marks(DeptID,ByMarkDeptID,Score,Memo,MarkMonth) values(" + Session["DeptID"].ToString() + "," + byMarkDeptID.Value + ",'" + ddlScore.Text + "','" + memo.Text + "','"+localDate+"')";
                DirectDataAccessor.Execute(insertSql);
                //计算被评分部门得分，更新部门得分表开始
                string scoreSql = "select score from marks where ByMarkDeptID=" + byMarkDeptID.Value + " and MarkMonth='" + localDate + "'";
                DataSet scoreDs = DirectDataAccessor.QueryForDataSet(scoreSql);
                int totalScore = 0;
                string deptScore;//部门得分
                int scoreCount = scoreDs.Tables[0].Rows.Count;
                for (int i = 0; i < scoreCount; i++)
                {
                    totalScore += int.Parse(scoreDs.Tables[0].Rows[i][0].ToString());
                }
                deptScore = (double.Parse(totalScore.ToString()) / scoreCount).ToString("f2");
                //更新部门得分表
                DirectDataAccessor.Execute("exec UpdateDeptScore " + byMarkDeptID.Value + ",'" + localDate + "','" + deptScore + "'");
                //计算被评分部门得分，更新部门得分表结束

                ClientScript.RegisterStartupScript(this.GetType(), "info", "alert('评分成功！')", true);
            }

        }
         
    }
    protected void rep_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.EditItem)
        {
            HiddenField byMarkDeptID = (HiddenField)e.Item.FindControl("deptId");//被打分部门id
            string scoreNum = DirectDataAccessor.QueryForDataSet("select scorenum from departments where id=" + byMarkDeptID.Value).Tables[0].Rows[0][0].ToString();
            DropDownList ddlScore = e.Item.FindControl("ddlScore") as DropDownList;
            ddlScore.Items.Add(new ListItem("请选择分值","0"));
            for (int i = 1; i <= int.Parse(scoreNum); i++) {
                ddlScore.Items.Add(new ListItem(i.ToString()));
            }

        }
    }
}
