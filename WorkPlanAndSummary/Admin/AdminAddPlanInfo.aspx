<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminAddPlanInfo.aspx.cs" Inherits="AdminAddPlanInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>部门工作计划总结录入</title>
    <link href="../css/style.css" type="text/css" rel="Stylesheet" />
    <style type="text/css">
        table textarea { width: 290px; height: 60px; }
        table img { cursor: pointer; }
    </style>
    <%--引入Jquery文件--%>
    <script src="../../js/easyui/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="../../js/extJquery.js" type="text/javascript"></script>
    <%--引入easyui文件--%>
    <script src="../../js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <link href="../../js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script type="text/javascript">
        //添加工作计划
        var addPlan = function () {
            var planHtml = $('<tr><td><textarea name="workitem" class="easyui-validatebox" required></textarea></td><td><textarea name="measure" class="easyui-validatebox" required></textarea></td><td><textarea name="results"></textarea></td><td><img src="../../images/del.png"alt="删除"onclick="delPlan(this);"/></td></tr>').appendTo('#planInfo');
            $.parser.parse(planHtml);
        };
        //删除工作计划
        var delPlan = function (obj) {
            $(obj).parent().parent().remove();
        };
        //提交表单
        var formSubmit = function () {
            if ($('#form1').form('validate')) {
                $.messager.confirm('询问', '您确定提交该月工作计划？提交后则不能修改！', function (r) {
                    if (r) {
                        var url = '../../service/AdminWorkPlanAndSummary.ashx/AdminSaveWorkPlan';
                        //要post的json数据
                        var postDate = {};
                        //有数据的行编号
                        var rowsNum = 0;
                        //遍历每一行表格
                        $.each($('tr', '#planInfo'), function (index) {
                            //剔除标题行
                            if (index > 0) {
                                //获取工作项目的值
                                var itemValue = $('textarea[name="workitem"]', this).val();
                                //剔除工作项目为空的行数据
                                if (itemValue != undefined && itemValue.trim().length > 0) {
                                    rowsNum++;
                                    //遍历每一行要提交的数据
                                    $.each($(':input', this).serializeArray(), function (i) {
                                        //设置要提交的键/值对
                                        postDate[this['name'] + rowsNum] = this['value'];
                                    });
                                }
                            }
                        })
                        //插入总数据行数
                        postDate['rowsCount'] = rowsNum;
                        postDate['deptid'] = $('#deptid').val();
                        postDate['workmonth'] = $('#workmonth').val();
                        $.messager.progress({
                            title: '提示',
                            text: '数据提交中，请稍后....'
                        });
                        $.post(url, postDate, function (result) {
                            $.messager.progress('close');
                            if (result.success) {
                                $.messager.alert('提示', result.msg, 'info', function () {
                                    window.opener.location.reload();
                                    window.close();
                                });
                            } else {
                                $.messager.alert('提示', result.msg, 'error');
                            }
                        }, 'json');
                    }
                });
            }
        };
    </script>
</head>
<body style="margin: 0;">
    <form id="form1" runat="server">
        <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
            width="100%" bgcolor="#f5f5ff" border="2">
            <tbody>
                <tr>
                    <td class="head" align="center" height="25">
                        <b style="font-size: 18px;">部门工作计划录入</b>
                    </td>
                </tr>
                <tr>
                    <td valign="top" align="center" bgcolor="#f5f5ff">
                        <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                            width="96%" border="1">
                            <tbody>
                                <tr align="center">
                                    <td>
                                        <asp:HiddenField ID="deptid" runat="server" />
                                        <asp:HiddenField ID="workmonth" runat="server" />
                                        <p style="text-align: center; font-weight: 700; font-size: 14pt;">
                                            中国联通安阳市分公司<asp:Literal ID="lblDeptName" runat="server"></asp:Literal><asp:Literal ID="lblMonth" runat="server"></asp:Literal>工作计划
                                        </p>
                                        <fieldset style="padding: 10px; width: 1200px; margin-bottom: 10px;" align="left">
                                            <legend style="font-size: 16px; color: #6A71A3;"><b>工作计划录入</b></legend>
                                            <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                                                width="1000" border="1" align="center" id="planInfo">
                                                <tbody>
                                                    <tr class="bold" align="center" bgcolor="#ced4e8">
                                                        <td width="32%">工作项目
                                                        </td>
                                                        <td width="32%">主要措施
                                                        </td>
                                                        <td width="32%">进度成效
                                                        </td>
                                                        <td width="4%">操作
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <textarea name="workitem" class="easyui-validatebox" required></textarea>
                                                        </td>
                                                        <td>
                                                            <textarea name="measure" class="easyui-validatebox" required></textarea></td>
                                                        <td>
                                                            <textarea name="results"></textarea></td>
                                                        <td>
                                                            <img src="../../images/plus.png" alt="添加" onclick="addPlan();" /></td>
                                                    </tr>

                                                </tbody>
                                            </table>
                                            <div align="center" style="margin-top: 5px;">
                                                <input type="button" value="提交工作计划" class="btn" onclick="formSubmit();" />
                                            </div>
                                        </fieldset>
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
