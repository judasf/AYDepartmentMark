<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkShow.aspx.cs" Inherits="Datashow" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>部门工作计划总结</title>
    <link href="../css/style.css" type="text/css" rel="Stylesheet" />
    <style>
        td a{color:#f55813;
            
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
            width="100%" bgcolor="#f5f5ff" border="2" height="97%">
            <tbody>
                <tr>
                    <td class="head" align="center" height="25">
                        <b style="font-size: 18px;">部门工作计划总结</b>
                    </td>
                </tr>
                <tr>
                    <td valign="top" align="center" bgcolor="#f5f5ff">
                        <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                            width="96%" height="97%" border="1">
                            <tbody>
                                <tr height="35">
                                    <td class="head" align="left">
                                        <b>部门工作计划总结查询</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" style="padding: 10px;" valign="top">
                                        <p style="text-align: left; color: #f00; font-size: 14px;">
                                            选择月份：<asp:DropDownList ID="ddlYm" runat="server">
                                            </asp:DropDownList>
                                            <asp:Button ID="Search" runat="server" class="btn" Text="查询" OnClick="Search_Click" />
                                            <b style="margin-left: 27%;">数据月份：<%=thisMonth %></b>
                                        </p>
                                        <table style="border-collapse: collapse"  cellspacing="1" cellpadding="3"
                                            width="90%">
                                            <tbody>
                                                <tr>
                                                    <td width="25%" valign="top">
                                                        <table width="100%" style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3" border="1">
                                                            <tr class="bold" align="center">
                                                                <td colspan="3">县公司</td>
                                                            </tr>
                                                            <asp:Repeater ID="rep1" runat="server">
                                                                <ItemTemplate>
                                                                    <tr align="center">

                                                                        <td width="55%">
                                                                            <%#Eval("deptname")%>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewPlan(<%#Eval("id") %>);">计划</a>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewSummary(<%#Eval("id") %>);">总结</a>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </table>
                                                    </td>
                                                    <td width="25%" valign="top">
                                                        <table width="100%" style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3" border="1">
                                                            <tr class="bold" align="center">
                                                                <td colspan="3">前台营收部门</td>
                                                            </tr>
                                                            <asp:Repeater ID="rep2" runat="server">
                                                                <ItemTemplate>
                                                                    <tr align="center">

                                                                        <td width="55%">
                                                                            <%#Eval("deptname")%>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewPlan(<%#Eval("id") %>);">计划</a>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewSummary(<%#Eval("id") %>);">总结</a>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </table>
                                                    </td>
                                                    <td width="25%" valign="top">
                                                        <table width="100%" style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3" border="1">
                                                            <tr class="bold" align="center">
                                                                <td colspan="3">业务管理支撑部门</td>
                                                            </tr>
                                                            <asp:Repeater ID="rep3" runat="server">
                                                                <ItemTemplate>
                                                                    <tr align="center">

                                                                        <td width="55%">
                                                                            <%#Eval("deptname")%>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewPlan(<%#Eval("id") %>);">计划</a>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewSummary(<%#Eval("id") %>);">总结</a>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </table>
                                                    </td>
                                                    <td width="25%" valign="top">
                                                        <table width="100%" style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3" border="1">
                                                            <tr class="bold" align="center">
                                                                <td colspan="3">职能部门</td>
                                                            </tr>
                                                            <asp:Repeater ID="rep4" runat="server">
                                                                <ItemTemplate>
                                                                    <tr align="center">

                                                                        <td width="55%">
                                                                            <%#Eval("deptname")%>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewPlan(<%#Eval("id") %>);">计划</a>
                                                                        </td>
                                                                        <td width="20%">
                                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewSummary(<%#Eval("id") %>);">总结</a>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </table>
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <script type="text/javascript">
        var viewSummary = function (id) {
            var y = document.getElementById("ddlYm").value;
            var iTop = (window.screen.height - 30 - 600) / 2; //获得窗口的垂直位置;  
            var iLeft = (window.screen.width - 10 - 800) / 2; //获得窗口的水平位置; 
            var url = "PublicViewSummary.aspx?ym=" + y + "&deptId=" + id;
            window.open(url, "view", "resizable=no,scrollbars=yes,location=no,toolbar=no,menubar=no,status=no,width=800,height=600,top=" + iTop + ",left=" + iLeft);
        };
        var viewPlan = function (id) {
            var y = document.getElementById("ddlYm").value;
            var iTop = (window.screen.height - 30 - 600) / 2; //获得窗口的垂直位置;  
            var iLeft = (window.screen.width - 10 - 800) / 2; //获得窗口的水平位置; 
            var url = "PublicViewPlan.aspx?ym=" + y + "&deptId=" + id;
            window.open(url, "view", "resizable=no,scrollbars=yes,location=no,toolbar=no,menubar=no,status=no,width=800,height=600,top=" + iTop + ",left=" + iLeft);
        };
    </script>
</body>
</html>
