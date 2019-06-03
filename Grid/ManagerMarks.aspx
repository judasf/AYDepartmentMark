<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagerMarks.aspx.cs" Inherits="ManagerMarks" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>领导业绩评价</title>
    <link href="../css/style.css" type="text/css" rel="Stylesheet" />
    <script src="../js/My97DatePicker/WdatePicker.js"></script>
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
                if (score.value == "-1") {
                    tjok = false;
                    break;
                }

            }
            if (!tjok) {
                alert("请选择所有分值！");
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
            width="100%"  height="98%" bgcolor="#f5f5ff" border="2">
            <tbody>
                <tr>
                    <td class="head" align="center" height="25">
                        <b style="font-size: 18px;">领导业绩评价系统</b>
                    </td>
                </tr>
                <tr>
                    <td valign="center" bgcolor="#ced4e8" height="18">
                        <font color='#333333' class="smalltxt">&nbsp;&nbsp;[<a href="ManagerMarks.aspx">
                        业绩评价表</a>]&nbsp;&nbsp;[<a href="ChangePwd.aspx">
                    修改密码</a>]&nbsp;&nbsp;[<a href="logout.aspx">退出</a>] </font>
                        <asp:Label ID="lblDeptName" Style="margin-left: 35%; display: inline; text-align: center; color: Black; font-weight: 700;"
                            runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td valign="top" align="center" bgcolor="#f5f5ff">
                        <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                            width="96%" border="1">
                            <tbody>
                                <tr>
                                    <td class="head" align="left">
                                        <b>业绩评价</b>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td>
                                        <p align="left">
                                            <b>评价月份：<asp:DropDownList ID="ddlMarkMonth" runat="server"></asp:DropDownList>
                                                <span style="margin-left:30%;display:inline;">
                                                [<a href="ViewPlan.aspx?ym=<%=DateTime.Now.AddMonths(-1).ToString("yyyy-MM") %>" target="_blank" title="点击查看">被评价部门工作计划</a>]&nbsp;&nbsp;
                                                [<a href="ViewSummary.aspx?ym=<%=DateTime.Now.AddMonths(-1).ToString("yyyy-MM") %>" target="_blank" title="点击查看">被评价部门工作总结</a>]</span>
                                            </b>
                                        </p>
                                        <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                                            width="90%" border="1">
                                            <tbody>
                                                <tr class="bold" align="center" bgcolor="#ced4e8">
                                                    <td width="5%">序号
                                                    </td>
                                                    <td width="20%">部门
                                                    </td>
                                                    <td width="30%">评分
                                                    </td>
                                                    <td>备注
                                                    </td>
                                                </tr>
                                                <asp:Repeater ID="rep" runat="server" OnItemDataBound="rep_ItemDataBound">
                                                    <ItemTemplate>
                                                        <tr align="left">
                                                            <td align="center">
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td>
                                                                <%#Eval("deptname")%><asp:HiddenField ID="deptId" runat="server" Value='<%#Eval("deptid") %>' />
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlScore" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="memo" runat="server" size="60" MaxLength="500"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <tr>
                                                    <td colspan="4" align="left">备注：<br />
                                                        1、打分标准：依据部门月度工作计划及完成情况等内容进行评分。<br />
                                                        2、打分范围：满意（20分）、比较满意（16-19分）、一般（12-15分）、不太满意（8-11分）、非常不满意（0-7分）。
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div align="center">
                                            <asp:Button ID="Button1" runat="server" class="btn" Text="提交" OnClick="Button1_Click"
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
                                    var url = "ManagerView.aspx?ym=" + y;
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
                                    <td class="head">以往业绩评价
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;&nbsp;
                                   <input type="text"  style="width:100px;"  class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy年MM月',readOnly:'true',vel:'ddlYm',realDateFmt:'yyyy-MM'})" />
                                        <input type="hidden" id="ddlYm"  />
                                        &nbsp;&nbsp;
                                    <input onclick="view()" type="button" class="btn" value="查看" />
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
