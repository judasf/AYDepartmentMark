<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminChangePwd.aspx.cs" Inherits="AdminChangePwd" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>服务支撑评价系统后台查询</title>
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
    <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
        width="100%" bgcolor="#f5f5ff" border="2">
        <tbody>
            <tr>
                <td class="head" align="center" height="25">
                    <b style="font-size: 18px;">服务支撑评价系统后台管理</b>
                </td>
            </tr>
            <tr>
                <td valign="middle" bgcolor="#ced4e8" height="18">
           &nbsp;&nbsp; <a href="Viewdeptscore.aspx"><b style="line-height: 18px; font-size: 14px;">
                        考核分数查询</b></a> &nbsp;&nbsp; <a href="deptinfo.aspx"><b style="line-height: 18px;
                            font-size: 14px;">打分部门管理</b></a> &nbsp;&nbsp; <a href="AdminChangePwd.aspx"><b style="font-size: 14px;">
                                修改密码</b></a>&nbsp;&nbsp; <a href="Logout.aspx"><b style="font-size: 14px;">退出</b></a>
                </td>
            </tr>
            <tr>
                <td valign="top" align="center" bgcolor="#f5f5ff">
                    <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="0" cellpadding="3" 
                        width="96%" border="1">
                        <tr>
                            <td class="head" align="left">
                                <b>修改密码</b>    
                            </td>
                        </tr>
                        <tr align="center">
                                                    <td>
                                <table bordercolor="#6a71a3" cellspacing="0" cellpadding="0" width="50%" border="1"  style="line-height:35px;"
                                    id="scoreList">
                                    <tr class="bold" align="center" bgcolor="#ced4e8">
                                        <td colspan="2">
                                            修改密码
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="25%" align="right">
                                             原密码：
                                        </th>
                                        <td align="left">
                                           &nbsp;
                                           <asp:TextBox ID="txtOld" runat="server" TextMode="Password"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="25%" align="right">
                                              新密码：
                                        </th>
                                        <td align="left">
                                         &nbsp;
                                       <asp:TextBox ID="txtNew" runat="server" TextMode="Password"></asp:TextBox>
                                        </td>
                                    </tr>
                                      <tr>
                                        <th width="25%" align="right">
                                              确认密码：
                                        </th>
                                        <td align="left">
                                         &nbsp;
                                        <asp:TextBox ID="txtRenew" runat="server" TextMode="Password"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="2" height="40px">
                                           <asp:Button ID="Button1" runat="server" Text="提交" class="btn"  OnClientClick="return chkpwd();"
                                OnClick="Button1_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>

                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    </form>
</body>
</html>
