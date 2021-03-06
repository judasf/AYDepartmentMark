﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>服务支撑评价系统</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
      <%--引入Jquery文件--%>
    <script src="../js/easyui/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="../js/extJquery.js" type="text/javascript"></script>
    <%--引入easyui文件--%>
    <script src="../js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <link href="../js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script type="text/javascript">

        function s() {
            document.getElementById("name").focus();
        }
        function showTips(id) {
            if (id.value.length <= 0)
                document.getElementById(id.id + "Tip").style.display = "block";
            else
                document.getElementById(id.id + "Tip").style.display = "none";
        }
 
    </script>

</head>
<body onload="s();">
    <form id="form1" runat="server">
    <table border="1" align="right" width="100%" height="96%" cellpadding="0" cellspacing="0"
        bgcolor="#F5F5FF" style="border-collapse: collapse" bordercolor="#6A71A3">
        <tr>
            <td align="center" valign="top" width="25%">
                <br />
               
            </td>
            <td align="center" valign="top">
                <table width="100%" height="600px" border="0" cellpadding="0" cellspacing="5" align="center">
                    <tr>
                        <td  align="center" height="25">
                           
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="center">
                            <p class="head" style="width:80%;line-height:50px"> <b style="font-size: 20px">服务支撑评价后台管理</b></p>
                            <font color='#555555'><b>请输入您的用户名和密码</b></font><br>
                            <br>
                            <table rules="none" width="350" border="1" cellpadding="5" cellspacing="5" align="center"
                                style="border-collapse: collapse" bordercolor="#6A71A3">
                                <tr>
                                    <td align="right" width="40%">
                                        请输入帐号：
                                    </td>
                                    <td width="40%">
                                        <input runat="server" type="text" id="name" size="15" maxlength="15" onblur="showTips(this);" />
                                    </td>
                                    <td width="20%" align="left">
                                        <span id="nameTip">*不能为空</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="40%">
                                        请输入密码：
                                    </td>
                                    <td width="30%">
                                        <input runat="server" type="password" id="pwd" size="15" maxlength="15" onblur="showTips(this);" />
                                    </td>
                                    <td width="20%" align="left">
                                        <span id="pwdTip">*不能为空</span>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <asp:Button ID="login" runat="server" Text="进入" Width="80px" OnClick="login_Click" />
                        </td>
                    </tr>
                    </table>
            </td>
        </tr>
    </table>
         <p style="font-family:'Arial', Gadget, sans-serif;color:#ffffff;text-align:center;"> copyright &copy;服务公司</p>
    </form>
</body>
</html>

