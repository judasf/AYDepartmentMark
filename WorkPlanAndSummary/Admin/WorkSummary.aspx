<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkSummary.aspx.cs" Inherits="Admin_WorkSummary" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>安阳联通部门工作计划总结后台管理</title>
    <link href="../../CSS/style.css" rel="Stylesheet" />
     <%--引入Jquery文件--%>
    <script src="../../js/easyui/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="../../js/extJquery.js" type="text/javascript"></script>
    <%--引入easyui文件--%>
    <script src="../../js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <link href="../../js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
</head>
<body style="margin: 5px 0;">
    <form id="form1" runat="server">
    <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
        width="100%" bgcolor="#f5f5ff" border="2" height="97%">
        <tbody>
            <tr>
                <td class="head" align="center" height="25">
                    <b style="font-size: 18px;">安阳联通部门工作计划总结后台管理</b>
                </td>
            </tr>
            <tr>
                <td valign="middle" bgcolor="#ced4e8" height="18">
                    &nbsp;&nbsp; <b style="line-height: 18px; font-size: 14px;">工作总结查询：</b>
                    <asp:DropDownList ID="ddlYm" runat="server">
                    </asp:DropDownList>
                    <asp:Button ID="Search" runat="server" class="btn" Text="查询" OnClick="Search_Click" />
                        &nbsp;&nbsp; <a href="WorkPlan.aspx"><b style="line-height: 18px; font-size: 14px;">工作计划查询</b></a> &nbsp;&nbsp; <a href="DeptInfo.aspx"><b style="line-height: 18px; font-size: 14px;">部门管理</b></a>
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
                                    <b>工作总结</b>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <p align="left">
                                        <b>月份：<%=thisMonth %></b></p>
                                    
                                    <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                                        width="50%" border="1" id="scoreList">
                                        <tbody>
                                            <tr class="bold" align="center" bgcolor="#ced4e8">
                                                <td>
                                                    编号
                                                </td>
                                                <td>
                                                    部门
                                                </td>
                                                <td>
                                                    工作总结是否录入
                                                </td>
                                                <td>
                                                    工作总结详情
                                                </td>
                                            </tr>
                                            <asp:Repeater ID="rep" runat="server">
                                                <ItemTemplate>
                                                    <tr align="center">
                                                        <td>
                                                            <%# Container.ItemIndex+1%>
                                                        </td>
                                                        <td>
                                                            <%#Eval("deptname")%>
                                                        </td>
                                                        <td>
                                                             <%#handleHasSp(Eval("id").ToString(),ddlYm.Text,Eval("hassp").ToString()) %>
                                                        </td>
                                                        <td>
                                                            <a title="点击查看" style="cursor: pointer;" onclick="viewDetail(<%#Eval("id") %>);">工作总结详情</a>
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
                            var y = document.getElementById("ddlYm").value;
                            var iTop = (window.screen.height - 30 - 600) / 2; //获得窗口的垂直位置;  
                            var iLeft = (window.screen.width - 10 - 800) / 2; //获得窗口的水平位置; 
                            var url = "../PublicViewSummary.aspx?ym=" + y + "&deptId=" + id;
                            window.open(url, "view", "resizable=no,scrollbars=yes,location=no,toolbar=no,menubar=no,status=no,width=800,height=600,top=" + iTop + ",left=" + iLeft);
                        }
                        var addSummary = function (deptid, month) {
                            var url = "AdminAddSummaryInfo.aspx?deptid=" + deptid + "&workmonth=" + month;
                            var iTop = (window.screen.height - 30 - 768) / 2; //获得窗口的垂直位置;  
                            var iLeft = (window.screen.width - 10 - 1024) / 2; //获得窗口的水平位置;  
                            window.open(url, "view", "resizable=no,scrollbars=yes,location=no,toolbar=no,menubar=no,status=no,width=1024,height=768,top=" + iTop + ",left=" + iLeft);
                        }
                    </script>
                     
                </td>
            </tr>
        </tbody>
    </table>
    </form>
</body>
</html>
