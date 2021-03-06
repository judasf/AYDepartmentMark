﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ScoreDetail.aspx.cs" Inherits="Admin_ScoreDetail" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>详细评分信息</title>
    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin: 5px 0;">
    <form id="form1" runat="server">
        <table border="2" width="100%" height="100%" cellpadding="6" cellspacing="0" bgcolor="#F5F5FF"
            style="border-collapse: collapse" bordercolor="#F5F5FF">
            <tr>
                <td class="head" align="center" height="25">
                    <b style="font-size: 18px;">服务支撑评价系统</b>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5FF" align="center" valign="top">
                    <p align="left">
                        <b>得分月份：<%=Request.QueryString["year"] %>年<%=Request.QueryString["month"] %>月份</b>&nbsp;&nbsp;&nbsp;&nbsp;<b>部门名称:<%=deptName %></b>
                    </p>
                    <b id="noScore" style="display: none;">没有本月评分信息！</b>
                    <table class="table-hover" border="1" width="90%" cellspacing="1" cellpadding="3" style="border-collapse: collapse;"
                        bordercolor='#6A71A3' id="scoreList">
                        <thead>
                            <tr bgcolor='#CED4E8' align="center" class="bold">
                                <td>编号
                                </td>
                                <td>部门
                                </td>
                                <td>得分
                                </td>
                                <td>备注
                                </td>
                                <td>评分时间
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="repList" runat="server">
                                <ItemTemplate>
                                    <tr align="center">
                                        <td>
                                            <%#Container.ItemIndex+1 %>
                                        </td>
                                        <td>
                                            <%#Eval("deptname") %>
                                        </td>
                                        <td>
                                            <%#Eval("score")%>
                                        </td>
                                        <td>
                                            <%#Eval("memo")%>
                                        </td>
                                        <td>
                                            <%#Eval("Time")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
