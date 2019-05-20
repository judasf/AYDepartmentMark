<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>领导业绩评价系统</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../js/easyui/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('table:first', 'form').css('height', $(window).height() - 40);
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table border="1" align="right" width="100%" height="100%" cellpadding="0" cellspacing="0"
            bgcolor="#F5F5FF" style="border-collapse: collapse" bordercolor="#6A71A3">
            <tr>

                <td align="center" valign="top">
                    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="5" align="center">
                        <tr>
                            <td align="center" height="25"></td>
                        </tr>
                        <tr>
                            <td valign="middle" align="center">
                                <p class="head" style="width: 50%; height: 50px; line-height: 50px;"><b style="font-size: 20px;">领导业绩评价系统</b></p>
                                <font color='#555555'><b>请输入您的帐号和密码</b></font><br>
                                <br />
                                <table rules="none" width="350" border="1" cellpadding="0" cellspacing="5" align="center"
                                    style="border-collapse: collapse" bordercolor="#6A71A3">
                                    <tr height="30">
                                        <td align="right" width="40%">请输入帐号：
                                        </td>
                                        <td width="40%">
                                            <input runat="server" type="text" id="name" size="15" maxlength="15" />
                                        </td>
                                        <td width="20%" align="left"></td>
                                    </tr>
                                    <tr height="30">
                                        <td align="right" width="40%">请输入密码：
                                        </td>
                                        <td width="30%">
                                            <input runat="server" type="password" id="pwd" size="15" maxlength="15" />
                                        </td>
                                        <td width="20%" align="left"></td>
                                    </tr>
                                </table>
                                <br />
                                <asp:Button ID="login" Style="cursor: pointer;" runat="server" Text="登陆" Width="80px" Height="30px" OnClick="login_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25"></td>
                        </tr>
                        <tr>
                            <td align="center" height="25"></td>
                        </tr>
                    </table>
                    <p style="font-family:'Arial', Gadget, sans-serif;color:#ffffff;"> copyright &copy;安阳市联通公司</p>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

