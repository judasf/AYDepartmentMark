<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePwd.aspx.cs" Inherits="ChangePwd" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>修改密码</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function chkpwd() {
            if (document.getElementById("txtNew").value != document.getElementById("txtRenew").value) {
                alert("两次输入的新密码不同！请重新输入");
                return false;
            }
            else
                return true;
        }

    </script>

</head>
<body style="margin: 5px 0;">
    <form id="form1" runat="server">
        <table border="2" width="100%" height="100%" cellpadding="6" cellspacing="0" bgcolor="#F5F5FF"
            style="border-collapse: collapse" bordercolor="#F5F5FF">
            <tr>
                <td class="head" align="center" height="25">
                    <b style="font-size: 18px;">网格评价系统</b>
                </td>
            </tr>
            <tr>
                <td bgcolor='#CED4E8' valign='middle' height="18">
                    <font color='#333333' class="smalltxt">&nbsp;&nbsp;[<a href="GridMarks.aspx">
                        网格评价表</a>]&nbsp;&nbsp;[<a href="ChangePwd.aspx">
                    修改密码</a>]&nbsp;&nbsp;[<a href="logout.aspx">退出</a>] </font>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5FF" align="center" valign="top">
                    <br>
                    <br>
                    <table border="1" width="420" cellspacing="1" cellpadding="5" style="border-collapse: collapse"
                        bordercolor='#6A71A3'>
                        <tr>
                            <td class="head" colspan="2">&nbsp;<b>修改密码</b>
                            </td>
                        </tr>
                        <tr>
                            <td>原密码：
                            </td>
                            <td>
                                <asp:TextBox ID="txtOld" runat="server" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>新密码：
                            </td>
                            <td>
                                <asp:TextBox ID="txtNew" runat="server" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>确认密码：
                            </td>
                            <td>
                                <asp:TextBox ID="txtRenew" runat="server" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Button ID="Button1" runat="server" class="btn" Text="提交"
                                    OnClientClick="return chkpwd();" OnClick="Button1_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="80%" valign="top">&nbsp;
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

