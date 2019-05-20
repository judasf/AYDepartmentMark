using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.OleDb;
using System.Data;
using org.in2bits.MyXls;
using System.Text;

public partial class DataImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin"] == null || Session["admin"].ToString() == "")
                Response.Write("<script type='text/javascript'>alert('请重新登陆！');window.location.href='default.aspx';</script>");
            else
            bindDept();


        }
    }
    private void bindDept()
    {
        markmonth.InnerHtml = DateTime.Now.AddMonths(-1).ToString("yyyy年MM月");
        DataSet deptDs = DirectDataAccessor.QueryForDataSet("select id,DeptName from Departments where (id>5 and id<24) or id>28");

        ddldept.Items.Add(new ListItem("请选择部门", "0"));
        foreach (DataRow dr in deptDs.Tables[0].Rows)
        {
            ddldept.Items.Add(new ListItem(dr["DeptName"].ToString(), dr["id"].ToString()));
        }

    }

    protected void btnExcelToDataTable_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("~") + @"\kpgs\upfiles\" + DateTime.Now.AddMonths(-1).ToString("yyyyMM");
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }

        if (!FileUpload1.HasFile)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert( '请先选择EXCEL文件! ');", true);

            return;
        }
        if (Path.GetExtension(FileUpload1.PostedFile.FileName) != ".xls" && Path.GetExtension(FileUpload1.PostedFile.FileName) != ".xlsx")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert( '文件格式不正确!请选择正确的EXCEL文件! ');", true);
            return;
        }


        string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        string filepath = path + "\\" + fileName;
        if (File.Exists(filepath))
        {
            File.Delete(filepath);
            //ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert( '该文件已导入，请选择其他文件! ');", true);
            //return;
        }
        FileUpload1.PostedFile.SaveAs(path + "\\" + fileName);
        string uppath = @"upfiles/" + DateTime.Now.AddMonths(-1).ToString("yyyyMM") + "/" + fileName;
        //文件导入
       // ExcelImport(filepath);
        StringBuilder sql = new StringBuilder();
        sql.Append("IF EXISTS (SELECT * FROM  EmpExcelPath  WHERE deptname ='" + ddldept.SelectedItem.Text + "' ");
        sql.Append(" and deptid='" + ddldept.SelectedValue + "') ");
        sql.Append(" Update  EmpExcelPath set filepath='" + uppath + "',uptime='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' ");
        sql.Append(" where deptname='" + ddldept.SelectedItem.Text + "' and deptid='" + ddldept.SelectedValue + "'");
        sql.Append(" ELSE ");
        sql.Append(" Insert into  EmpExcelPath values('" + ddldept.SelectedValue + "','" + ddldept.SelectedItem.Text + "','" + uppath + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')");
        DirectDataAccessor.Execute(sql.ToString());
        ClientScript.RegisterStartupScript(this.GetType(), "succ", "alert( '[" + ddldept.SelectedItem.Text + "]考评得分文件上传成功! ');", true);
    }
    /// <summary>
    /// 将Excel数据导入数据库
    /// </summary>
    /// <param name="filePath">上传的Excel文件路径</param>
    /// <param name="sheetName">取数据的单元表的名称：网运成本明细、其他业务及管理费用明细</param>
    private void ExcelImport(string filePath)
    {
        XlsDocument xls = new XlsDocument(@filePath);//打开EXCLE
        //获得Excel中的指定一个工作页
        Worksheet sheet = xls.Workbook.Worksheets[0];
        string sql = "";
        //读取数据 循环每sheet工作页的第5行开始
        for (int i = 2; i < sheet.Rows.Count; i++)
        {
            //读取第一行第一列
            string c1 = Convert.ToString(sheet.Rows[ushort.Parse(i.ToString())].GetCell(1).Value);
            if (c1 == "")
                break;
            else
            {
                
                //    第一行第2列
                string c2 = Convert.ToString(sheet.Rows[ushort.Parse(i.ToString())].GetCell(2).Value);
              
                 //    第一行第3列
                string c3 = sheet.Rows[ushort.Parse(i.ToString())].CellCount < 3 ? "" : String.Format("{0:F2}",sheet.Rows[ushort.Parse(i.ToString())].GetCell(3).Value);
        
               sql += "Insert into employeescore values('" + c1 + "','" + c2 + "','" + c3 + "','" + ddldept.SelectedItem.Text + "','" + markmonth.InnerText + "');";
            }
        }
        DataSet ds = DirectDataAccessor.QueryForDataSet("select count(*) from employeescore where deptname='" + ddldept.SelectedItem.Text + "' and scoremonth='" + markmonth.InnerText + "'");
        if (ds.Tables[0].Rows[0][0].ToString() != "0")
        {
            string info = ddldept.SelectedItem.Text + markmonth.InnerText + "的考评得分已导入，请不要重复操作! ";
            ClientScript.RegisterStartupScript(this.GetType(), "info", "alert( '" + info + "');", true);
            return;
        }
        else
        {
            DirectDataAccessor.Execute(sql);
            ClientScript.RegisterStartupScript(this.GetType(), "succ", "alert( '数据导入成功! ');", true);
        }
    }
}
