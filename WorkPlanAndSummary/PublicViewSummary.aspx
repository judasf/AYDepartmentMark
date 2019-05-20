<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PublicViewSummary.aspx.cs" Inherits="PublicViewSummary" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
--%><html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>工作总结详情</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin: 5px 0;">
    <form id="form1" runat="server">
        <table border="2" width="100%" height="98%" cellpadding="6" cellspacing="0" bgcolor="#F5F5FF"
            style="border-collapse: collapse" bordercolor="#F5F5FF">
            <tr>
                <td bgcolor="#F5F5FF" align="center" valign="top">
                    <p style="text-align: center; font-weight: 700; font-size: 14pt;">
                        中国联通安阳市分公司<%=dpName %><%=Request.QueryString["ym"].Replace("-","年")+"月" %>工作总结
                    </p>
                    <b id="noScore" style="display: none;"><%=Request.QueryString["ym"].Replace("-","年")+"月" %>工作总结尚未录入！</b>
                    <table border="1" width="96%" cellspacing="1" cellpadding="3" style="border-collapse: collapse;" bordercolor='#6A71A3' id="scoreList">
                        <tr bgcolor='#CED4E8' align="center" class="bold">

                            <td width="6%">类别
                            </td>
                              <td width="4%">序号
                            </td>
                            <td width="30%">工作项目
                            </td>
                            <td width="30%">主要措施
                            </td>
                            <td width="30%">进度成效
                            </td>
                        </tr>
                        <asp:Repeater ID="repList" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td id="className" runat="server"><%#Eval("classname") %></td>
                                    <td align="center"><%#Eval("sn") %></td>
                                    <td valign="top"><%#Eval("iteminfo")%></td>
                                    <td valign="top"><%#Eval("measure")%></td>
                                    <td valign="top"><%#Eval("results")%></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

