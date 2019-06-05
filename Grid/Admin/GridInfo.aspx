<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GridInfo.aspx.cs" Inherits="Admin_GridInfo" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>网格评价系统后台管理</title>
    <link href="../../CSS/style.css" rel="Stylesheet" />
</head>
<body style="margin: 5px 0;">
    <form id="form1" runat="server">
    <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
        width="100%" bgcolor="#f5f5ff" border="2">
        <tbody>
            <tr>
                <td class="head" align="center" height="25">
                    <b style="font-size: 18px;">网格评价系统后台管理</b>
                </td>
            </tr>
            <tr>
                <td valign="middle" bgcolor="#ced4e8" height="18">
                    &nbsp;&nbsp; <a href="ViewGridScore.aspx"><b style="line-height: 18px; font-size: 14px;">
                        网格评价查询</b></a> &nbsp;&nbsp; <a href="GridInfo.aspx"><b style="line-height: 18px;
                            font-size: 14px;">打分网格管理</b></a> &nbsp;&nbsp; <a href="AdminChangePwd.aspx"><b style="font-size: 14px;">
                                修改密码</b></a>&nbsp;&nbsp; <a href="Logout.aspx"><b style="font-size: 14px;">退出</b></a>
                </td>
            </tr>
            <tr>
                <td valign="top" align="center" bgcolor="#f5f5ff">
                    <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                        width="96%" border="1">
                        <tbody>
                            <tr>
                                <td class="head" align="left">
                                    <b>网格管理</b>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                                        width="90%" border="1" id="scoreList">
                                        <tbody>
                                            <tr class="bold" align="center" bgcolor="#ced4e8">
                                                <td>
                                                    编号
                                                </td>
                                                <td>
                                                    网格名称
                                                </td>
                                                <td>
                                                    密码恢复(默认：wgpj.0)
                                                </td>
                                            </tr>
                                            <asp:Repeater ID="rep" runat="server" onitemcommand="rep_ItemCommand">
                                                <ItemTemplate>
                                                    <tr align="left">
                                                        <td align="center">
                                                            <%# Container.ItemIndex+1%>
                                                        </td>
                                                        <td>
                                                            <%#Eval("GridName")%>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnRecover" class="btn" runat="server" Text="密码恢复" CommandName="btnRecover" CommandArgument='<%#Eval("id") %>' />
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
                </td>
            </tr>
        </tbody>
    </table>
    </form>
</body>
</html>
