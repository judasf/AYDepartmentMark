﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewDeptScore.aspx.cs" Inherits="Admin_ViewDeptScore" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>领导业绩评价系统</title>
    <link href="../../CSS/style.css" rel="Stylesheet" />
    <script src="../../js/My97DatePicker/WdatePicker.js"></script>
</head>
<body style="margin: 5px 0;">
    <form id="form1" runat="server">
    <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
        width="100%" bgcolor="#f5f5ff" border="2" height="97%">
        <tbody>
            <tr>
                <td class="head" align="center" height="25">
                    <b style="font-size: 18px;">领导业绩评价系统后台管理</b>
                </td>
            </tr>
            <tr>
                <td valign="middle" bgcolor="#ced4e8" height="18">
                    &nbsp;&nbsp; <b style="line-height: 18px; font-size: 14px;">以往业绩评价查询：</b>
                   <input type="text"  style="width:100px;"  class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy年MM月',readOnly:'true',vel:'ddlYm',realDateFmt:'yyyy-MM'})" />
                    <asp:HiddenField ID="ddlYm" runat="server"/>   
                    <asp:Button ID="Search" runat="server" class="btn" Text="查看" OnClick="Search_Click" />
                        &nbsp;&nbsp; <a href="ManagerInfo.aspx"><b style="line-height: 18px; font-size: 14px;">公司领导管理</b></a>
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
                                    <b>业绩评价</b>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <p align="left">
                                        <input type="hidden" value="<%=showYear %>" id="hidYear" />
                                        <input type="hidden" value="<%=showMonth %>" id="hidMonth" />
                                        <b>分数月份：<%=showYear %>年<%=showMonth %>月份</b></p>
                                    <b id="noScore" style="display: none; height: 400px;">没有本月评分信息！ </b>
                                    <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                                        width="90%" border="1" id="scoreList">
                                        <tbody>
                                            <tr class="bold" align="center" bgcolor="#ced4e8">
                                                <td>
                                                    编号
                                                </td>
                                                <td>
                                                    部门
                                                </td>
                                                <td width="40%">
                                                    部门得分
                                                </td>
                                                <td>
                                                    详细得分
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
                            var iTop = (window.screen.height - 30 - 600) / 2; //获得窗口的垂直位置;  
                            var iLeft = (window.screen.width - 10 - 800) / 2; //获得窗口的水平位置; 
                            var url = "ScoreDetail.aspx?year=" + y + "&month=" + m + "&deptId=" + id;
                            window.open(url, "view", "resizable=no,scrollbars=yes,location=no,toolbar=no,menubar=no,status=no,width=800,height=600,top=" + iTop + ",left=" + iLeft);
                        }
                    </script>
                     
                </td>
            </tr>
        </tbody>
    </table>
    </form>
</body>
</html>
