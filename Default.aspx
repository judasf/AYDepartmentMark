<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>����֧������</title>
    <link href="images2/css_login.css" type="text/css" rel="stylesheet" />
    <link href="images2/before_login.css" type="text/css" rel="stylesheet" />
    <!--[if lt IE 7.]>
<script defer type="text/javascript" src="js/pngfix.js"></script>
<![endif]-->

    <script type="text/javascript" src="images2/keyboard.js" language="javascript"></script>

    <style type="text/css">
        body
        {
            background: #0000FF;
        }
        #png
        {
            background: url(ling.png) no-repeat; *background-image:none;*filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="images2/ling.png", sizingMethod="scale");height:200px;width:455px;}</style>

    <script type="text/javascript" src="images2/function.js"></script>

    <script type="text/javascript">
<!---����
        var date = new Date();
        function mois() {
            argnr = mois.arguments.length
            for (var i = 0; i < argnr; i++)
                this[i + 1] = mois.arguments[i]
        }
        var isnMonths = new mois("1��", "2��", "3��", "4��", "5��", "6��", "7��", "8��", "9��", "10��", "11��", "12��");
        var jours = new mois("Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi");
        browserName = navigator.appName;
        browserVer = parseInt(navigator.appVersion);
        if (browserName == "Netscape" && browserVer >= 4 || browserName == "Microsoft Internet Explorer" && browserVer >= 4) version = "nsie4";
        else version = "x";
        if (version == "nsie4") {
            document.write("<span id='day'>" + (date.getDate() < 10 ? "0" + date.getDate() : date.getDate()) + "<\/span><span id='month'>" + isnMonths[date.getMonth() + 1] + "<\/span><span id='year'>" + date.getFullYear() + "<\/span>");
        }
        opacity();
// stop hiding-->
    </script>

    <script type="text/javascript">
        //
        change_theme('theme5');
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="nav">
        <ul class="liste_bgrd">
            <li><a onclick="change_theme('theme1');" href="#">
                <img alt="�̶�Ʈ��" src="images2/ico_bgrd_1.gif" /></a> </li>
            <li><a onclick="change_theme('theme2');" href="#">
                <img alt="��ҵ��Ϣ" src="images2/ico_bgrd_2.gif" /></a> </li>
            <li><a onclick="change_theme('theme3');" href="#">
                <img alt="���鱼��" src="images2/ico_bgrd_3.gif" /></a> </li>
            <li><a onclick="change_theme('theme4');" href="#">
                <img alt="���澭��" src="images2/ico_bgrd_4.gif" /></a> </li>
            <li><a onclick="change_theme('theme5');" href="#">
                <img alt="��Ȼ�λ�" src="images2/ico_bgrd_5.gif" /></a> </li>
        </ul>
    </div>
    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" valign="top">
                <table width="415" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="160" colspan="2">
                        </td>
                    </tr>
                    <tr>
                        <td height="143" colspan="2" valign="top" background="images2/ling.png">
                            <table width="65%" height="135" border="0" align="right" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td height="20">
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="190">
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtUserName" runat="server" Width="185px" class="inputt" onfocus="this.value=''">��¼��</asp:TextBox>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtPassWord" runat="server" class="inputt" TextMode="Password" Width="185px"
                                            value="****" onfocus="this.value=''"  AutoCompleteType="Disabled"></asp:TextBox>
                                    </td>
                                    <td rowspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        
                                        <asp:ImageButton ID="btnLogin" runat="server" ImageUrl="images2/log_an.png" OnClick="btnLogin_Click" />
                                       
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                 
                        <td width="45" align="right" valign="top" class="t12">
                            <%
                               
                                
                                 %>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

