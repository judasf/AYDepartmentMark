<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Datashow.aspx.cs" Inherits="Datashow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>部门员工考评得分公示系统</title>
    <link href="../css/style.css" type="text/css" rel="Stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
        width="100%" bgcolor="#f5f5ff" border="2">
        <tbody>
            <tr>
                <td class="head" align="center" height="25">
                    <b style="font-size: 18px;">部门员工考评得分公示系统</b>
                </td>
            </tr>
            <tr>
                <td valign="center" bgcolor="#ced4e8" height="18">
                </td>
            </tr>
            <tr>
                <td valign="top" align="center" bgcolor="#f5f5ff">
                    <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                        width="96%" border="1">
                        <tbody>
                            <tr>
                                <td class="head" align="left">
                                    <b>员工考评得分公示</b>
                                </td>
                            </tr>
                            <tr >
                                <td align="center" style="padding:10px;">
                                    <p style="text-align:left;color:#f00;font-size:14px;">
                                    注：点击部门名称下载最新的部门考评得分文件
                                    </p>
                                    <ul class="deptfiles">
                                        <asp:Repeater ID="repData" runat="server">
                                            <ItemTemplate>
                                                <li><a href="<%#Eval("fp") %>">
                                                    <%#Eval("deptname")%></a></li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
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
