using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.OleDb;
using System.Data;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class Datashow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRept();
        }
    }
    private void BindRept() {
        string sql = "select a.id,a.deptname,isnull(b.filepath,'#') as fp from departments as a left join empexcelpath as b on a.id=b.deptid where  (a.id>5 and a.id<24) or a.id>28";
        DataSet ds = DirectDataAccessor.QueryForDataSet(sql);
        repData.DataSource = ds;
        repData.DataBind();
    }
}
