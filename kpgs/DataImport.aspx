<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataImport.aspx.cs" Inherits="DataImport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>部门员工考评得分公示系统</title>
    <link href="../css/style.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript">
        function chkblank() {

            var ddl = document.getElementById("DropDownList1").value;
            if (ddl=="0") {
                alert("请选择部门！");
                return false;
            }
            var fu = document.getElementById("FileUpload1").value;
            if (fu == "") {
                alert("请选择文件！");
                return false;
            }
            if (confirm("您确定要提交分数吗？提交后将不能更改！"))
                return true;
            else
                return false;

        }

    </script>
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
                                    <b>员工考评得分数据导入</b>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <p align="left">
                                        <b>评分月份：<b id="markmonth" runat="server"></b></b></p>
                                    <table style="border-collapse: collapse" cellspacing="1" cellpadding="3" width="90%">
                                        <tbody>
                                            <tr>
                                                <td class="bold" align="right" >
                                                    请选择部门：
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddldept" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bold" align="right">
                                                    请选择文件：
                                                </td>
                                                <td align="left">
                                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                                </td>
                                            </tr>
                                            <tr >
                                                <td>
                                                
                                              
                                                    </td>
                                                    <td   align="left">  <asp:Button ID="btnExcelToDataTable" class="btn" runat="server" Text="文件上传" OnClick="btnExcelToDataTable_Click"
                                                  OnClientClick="return chkblank();" />
                                                   </td>
                                                   </tr>
                                            </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr><td style="text-align:left;color:Red;">
                            注：
                            请按照人力部要求上传本部门的考核得分excel文件<br />
                            </td></tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    </form>
</body>
</html>
