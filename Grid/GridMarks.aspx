<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GridMarks.aspx.cs" Inherits="GridMarks" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>网格评价系统</title>
    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/style.css" type="text/css" rel="Stylesheet" />
    <script src="../js/My97DatePicker/WdatePicker.js"></script>
    <%--引入Jquery文件--%>
    <script src="../js/easyui/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="../js/extJquery.js" type="text/javascript"></script>
    <%--引入easyui文件--%>
    <script src="../js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <link href="../js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script type="text/javascript">
        function chkblank() {
            var tjok = true;
            var total = document.getElementById("total").value;
            for (i = 0; i < total; i++) {
                var num;
                if ((i + "").length > 1)
                    num = i;
                else
                    num = "0" + i;
                var score = document.getElementById("rep_ctl" + num + "_ddlScore")
                if (score.value == "0") {
                    tjok = false;
                    break;
                }

            }
            if (!tjok) {
                $.messager.alert("提示", "请选择所有分值！", 'info');
                return false;
            }
            if (confirm("您确定要提交分数吗？提交后将不能更改！"))
                return true;
            else
                return false;
        }
    </script>
</head>
<body style="margin: 0;">
    <form id="form1" runat="server">
        <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
            width="100%" height="98%" bgcolor="#f5f5ff" border="2">
            <tbody>
                <tr>
                    <td class="head" align="center" height="25">
                        <b style="font-size: 18px;">网格评价系统</b>
                    </td>
                </tr>
                <tr>
                    <td valign="center" bgcolor="#ced4e8" height="18">
                        <font color='#333333' class="smalltxt">&nbsp;&nbsp;[<a href="ManagerMarks.aspx">
                        网格评价表</a>]&nbsp;&nbsp;[<a href="ChangePwd.aspx">
                    修改密码</a>]&nbsp;&nbsp;[<a href="logout.aspx">退出</a>] </font>
                        <asp:Label ID="lblDeptName" Style="margin-left: 35%; display: inline; text-align: center; color: Black; font-weight: 700;"
                            runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td valign="top" align="center" bgcolor="#f5f5ff">
                        <table class="table" style="width: 96%;text-align:center;" border="1">
                            <tbody>
                                <tr>
                                    <td class="head" align="left">
                                        <b>网格评价</b>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td>
                                        <p align="left">
                                            <b>评分月份：
                                                <asp:DropDownList ID="ddlMarkMonth" runat="server" style="width:90px;"></asp:DropDownList>
                                            </b>
                                        </p>
                                        <table class="table-condensed  table-hover" style="border-collapse: collapse; width: 90%;margin:0 auto;" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                                            border="1">
                                            <thead>
                                                <tr class="bold" bgcolor="#ced4e8">
                                                    <td style="text-align:center" width="5%">序号
                                                    </td>
                                                    <td   style="text-align:center"  width="20%">网格名称
                                                    </td>
                                                    <td  style="text-align:center"  width="30%">评分
                                                    </td>
                                                    <td  style="text-align:center" >备注
                                                    </td>
                                                </tr>
                                                </thead>
                                            <tbody>
                                                <asp:Repeater ID="rep" runat="server" OnItemDataBound="rep_ItemDataBound">
                                                    <ItemTemplate>
                                                        <tr align="left">
                                                            <td  style="vertical-align: middle;text-align:center">
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td style="vertical-align: middle;text-align:center">
                                                                <%#Eval("GridName")%><asp:HiddenField ID="ByMarkGridId" runat="server" Value='<%#Eval("ByMarkGridId") %>' />
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlScore" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox class="form-control" ID="memo" runat="server" size="60" MaxLength="500"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <tr>
                                                    <td colspan="4" align="left">备注：<br />
                                                        1、打分标准：依据网格支撑及工作情况进行评分。<br />
                                                        2、打分范围：满意（10分）、比较满意（8-9分）、一般（6-7分）、不满意（1-5分）。
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div align="center">
                                            <asp:Button ID="Button1" style="margin-top:20px;width:80px;height:30px;" runat="server" class="btn btn-primary" Text="提交" OnClick="Button1_Click"
                                                OnClientClick="return chkblank();" />
                                            <asp:HiddenField ID="total" runat="server" />
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <script type="text/javascript">

                            function view() {
                                var y = document.getElementById("ddlYm").value;
                                if (y.length == 0)
                                    alert('请选择日期！');
                                else {
                                    var url = "GridView.aspx?ym=" + y;
                                    var iTop = (window.screen.height - 30 - 600) / 2; //获得窗口的垂直位置;  
                                    var iLeft = (window.screen.width - 10 - 800) / 2; //获得窗口的水平位置;  
                                    window.open(url, "view", "resizable=no,scrollbars=yes,location=no,toolbar=no,menubar=no,status=no,width=800,height=600,top=" + iTop + ",left=" + iLeft);
                                }
                            }
                        </script>
                        <table style="border-collapse: collapse; margin-top: 5px;" bordercolor="#6a71a3"
                            cellspacing="1" cellpadding="3" width="96%" border="1">
                            <tbody align="left">
                                <tr bgcolor="#9fb5ec">
                                    <td class="head">以往评价
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;&nbsp;
                                   <input type="text" style="width: 100px;" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy年MM月',readOnly:'true',vel:'ddlYm',realDateFmt:'yyyy-MM'})" />
                                        <input type="hidden" id="ddlYm" />
                                        &nbsp;&nbsp;
                                    <input onclick="view()" type="button" class="btn btn-primary" value="查看" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
</body>
</html>
