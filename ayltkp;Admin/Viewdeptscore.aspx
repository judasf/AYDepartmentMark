<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewDeptScore.aspx.cs" Inherits="Admin_ViewDeptScore" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>服务支撑评价系统后台查询</title>
    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link href="../CSS/style.css" rel="Stylesheet" />
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js"></script>
</head>
<body style="margin: 5px 0;">
    <form id="form1" runat="server">
    <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
        width="100%" bgcolor="#f5f5ff" border="2">
        <tbody>
            <tr>
                <td class="head" align="center" height="25">
                    <b style="font-size: 18px;">服务支撑评价系统后台查询</b>
                </td>
            </tr>
            <tr>
                <td valign="middle" bgcolor="#ced4e8" height="18">
                    &nbsp;&nbsp; <b style="line-height: 18px; font-size: 14px;">以往考核分数查询：</b>
                     <input type="text"  style="width:100px;"  class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy年MM月',readOnly:'true',vel:'ddlYm',realDateFmt:'yyyy-MM'})" />
                    <asp:HiddenField ID="ddlYm" runat="server"/>            
                    <asp:Button ID="Search" runat="server" class="btn btn-info" Text="查看" OnClick="Search_Click" />
                        &nbsp;&nbsp; <a href="deptinfo.aspx"><b style="line-height: 18px; font-size: 14px;">打分部门管理</b></a>
                    &nbsp;&nbsp; <a href="AdminChangePwd.aspx"><b style="font-size: 14px;">修改密码</b></a>&nbsp;&nbsp;
                    <a href="Logout.aspx"><b style="font-size: 14px;">退出</b></a>
                </td>
            </tr>
            <tr>
                <td valign="top" align="center" bgcolor="#f5f5ff">
                    <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                        width="96%" border="1">
                        <tbody>
                            <tr>
                                <td class="head" align="left">
                                    <b>考核评分</b>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <p align="left">
                                        <input type="hidden" value="<%=showYear %>" id="hidYear" />
                                        <input type="hidden" value="<%=showMonth %>" id="hidMonth" />
                                        <b>分数月份：<%=showYear %>年<%=showMonth %>月份</b></p>
                                    <b id="noScore" style="display: none; height: 400px;">没有本月评分信息！ </b>
                                    <table class="table-condensed table-hover" style="border-collapse: collapse;width: 70%;margin:0 auto;" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                                        border="1" id="scoreList">
                                        <tbody>
                                            <tr class="bold" align="center" bgcolor="#ced4e8">
                                                <td>
                                                    编号
                                                </td>
                                                <td>
                                                    部门
                                                </td>
                                                <td width="40%">
                                                    部门得分(平均分)
                                                </td>
                                                <td>
                                                    详细分数
                                                </td>
                                            </tr>
                                            <asp:Repeater ID="rep" runat="server">
                                                <ItemTemplate>
                                                    <tr align="left">
                                                        <td align="center">
                                                            <%# Container.ItemIndex+1%>
                                                        </td>
                                                        <td>
                                                            <%#Eval("deptname")%>
                                                        </td>
                                                        <td>
                                                            <%#Eval("score") %>
                                                        </td>
                                                        <td>
                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewDetail(<%#Eval("id") %>);">详细得分信息</a>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <script type="text/javascript">
                        function viewDetail(id) {
                            var y = document.getElementById("hidYear").value;
                            var m = document.getElementById("hidMonth").value;
                            var url = "ScoreDetail.aspx?year=" + y + "&month=" + m + "&deptId=" + id;
                            window.open(url, "view", "resizable=yes,scrollbars=yes,location=no,toolbar=no,menubar=no,status=no");
                        }
                    </script>
                </td>
            </tr>
        </tbody>
    </table>
    </form>
</body>
</html>
