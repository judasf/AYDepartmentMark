<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Marks.aspx.cs" Inherits="Marks" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>服务支撑评价</title>
    <link href="Css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
    <link href="css/style.css" type="text/css" rel="Stylesheet" />
      <%--引入Jquery文件--%>
    <script src="js/easyui/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="js/extJquery.js" type="text/javascript"></script>
    <%--引入easyui文件--%>
    <script src="js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <link href="js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script type="text/javascript">
        //得到重复得分信息
        function getRepeatNum(arr) {
            var res = [];
            var ary = arr.sort();
            for (var i = 0; i < ary.length;) {
                var count = 0;
                for (var j = i; j < ary.length; j++) {
                    if (ary[i] == ary[j])
                        count++;
                }
                res.push(count);
                i += count;
            }
            return res;
        }
        //2019年4月25日增加打分限制。
        //1、10分占比20%；
        //2、8-9分占比30%；
        //3、5-7分占比30%；
        //4、5分以下20%。
        function chkblank() {
            var tjok = true;
            var total = document.getElementById("total").value;
            //得分数组
            var orginArr = [];
            //得分重复结果数组
            var resArr = [];
            //满分数量
            var _10num = 0;
            //8-9分数量
            var _8to9num = 0;
            //5-7分数量
            var _5to7num = 0;
            //5分以下数量
            var _less5num = 0;
            for (i = 0; i < total; i++) {
                var num;
                if ((i + "").length > 1)
                    num = i;
                else
                    num = "0" + i;
                var score = document.getElementById("rep_ctl" + num + "_ddlScore")
                var memo = document.getElementById("rep_ctl" + num + "_memo")
                if (score.value == "0") {
                    tjok = false;
                    break;
                }
                //判断扣分比例高于总分30%时需说明扣分原因
                //if (parseFloat(score.value / score.options[score.length - 1].value) < 0.7 && memo.value == "") {
                //    alert("请填写扣分原因!");
                //    memo.focus();
                //    return false;
                //}
                //判断选择的是否最大值
                if (score.value == score.options[score.length - 1].value)
                    _10num++;
                //计算得分8-9数量
                if (score.value == 8 || score.value == 9)
                    _8to9num++;
                //计算得分5-7数量
                if (score.value >= 5 && score.value <= 7)
                    _5to7num++;
                //计算5分以下数量
                if (score.value < 5)
                    _less5num++;

                //将得分压入数组
                // orginArr.push(score.value);
            }

            //console.log('10:' + _10num);
            //console.log('8,9:' + _8to9num);
            //console.log('5,7:' + _5to7num);
            //console.log('5:' + _less5num);
            /***********计算各阶段得分比例****************/
            if (_10num != (total - Math.round(total * 0.2) - Math.round(total * 0.3) - Math.round(total * 0.3))) {
                alert("10分的数量为" + (total - Math.round(total * 0.2) - Math.round(total * 0.3) - Math.round(total * 0.3)) + "个!");
                return false;
            }
            if (_8to9num != Math.round(total * 0.3)) {
                alert("8-9分的数量为" + Math.round(total * 0.3) + "个!");
                return false;
            }
            if (_5to7num != Math.round(total * 0.3)) {
                alert("5-7分的数量为" + Math.round(total * 0.3) + "个!");
                return false;
            }
            if (_less5num != Math.round(total * 0.2)) {
                alert("5分以下的数量为" + Math.round(total * 0.2) + "个!");
                return false;
            }

            //判断得分相同的数量
            //resArr = getRepeatNum(orginArr);
            ////针对信息化中心处理
            //if (parseInt(total) > 3) {
            //    for (var i = 0; i < resArr.length; i++) {
            //        if (Math.ceil(total * 0.3) < resArr[i]) {
            //            alert("得分相同的数量不要超过" + Math.ceil(total * 0.3) + "个!");
            //            return false;
            //        }
            //    }
            //}
            if (!tjok) {
                alert("请选择所有分值！");
                return false;
            }
            if (confirm("您确定要提交分数吗？提交后将不能更改！"))
                return true;
            else
                return false;
        }
    </script>
</head>
<body style="margin: 0;">
    <form id="form1" runat="server">
        <table style="border-collapse: collapse" bordercolor="#f5f5ff" cellspacing="0" cellpadding="6"
            width="100%" bgcolor="#f5f5ff" border="2">
            <tbody>
                <tr>
                    <td class="head" align="center" height="25">
                        <b style="font-size: 18px;">服务支撑评价系统</b>
                    </td>
                </tr>
                <tr>
                    <td valign="center" bgcolor="#ced4e8" height="18">
                        <font class="smalltxt" color="#333333" style="margin-left: 10px;"><a href="Marks.aspx">部门打分表</a> <a href="ChangePwd.aspx">修改密码</a> <a href="LogOut.aspx">退出</a> </font>
                        <asp:Label ID="lblDeptName" Style="margin-left: 35%; display: inline; text-align: center; color: Black; font-weight: 700;"
                            runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td valign="top" align="center" bgcolor="#f5f5ff">
                        <table style="border-collapse: collapse" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                            width="96%" border="1">
                            <tbody>
                                <tr>
                                    <td class="head" align="left">
                                        <b>考核评分</b>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td>
                                        <p align="left">
                                            <b>评分月份：<%--<b id="markmonth" runat="server"></b>--%>
                                                <asp:DropDownList ID="ddlMarkMonth" runat="server"></asp:DropDownList>
                                            </b>
                                        </p>
                                        <table class="table-hover table-condensed" style="border-collapse: collapse; margin: 0 auto 20px auto;" bordercolor="#6a71a3" cellspacing="1" cellpadding="3"
                                            border="1" width="90%">
                                            <thead>
                                                <tr class="bold" align="center" bgcolor="#ced4e8">
                                                    <td>编号
                                                    </td>
                                                    <td>部门
                                                    </td>
                                                    <td width="40%">评分
                                                    </td>
                                                    <td>备注
                                                    </td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rep" runat="server" OnItemDataBound="rep_ItemDataBound">
                                                    <ItemTemplate>
                                                        <tr align="left">
                                                            <td align="center">
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td>
                                                                <%#Eval("deptname")%><asp:HiddenField ID="deptId" runat="server" Value='<%#Eval("ByMarkDeptId") %>' />
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlScore" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="memo" runat="server" size="40" MaxLength="500"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <tr>
                                                    <td colspan="4">备注：<br />
                                                        1、扣分比例高于评价总分30%时需在备注里面填写扣分原因<br />
                                                        2、各部门得分比例：<span style="color: red; display: inline;">(1)10分占比20%；(2)8-9分占比30%；(3)5-7分占比30%；(4)5分以下20%。</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div align="center">
                                            <asp:Button ID="Button1" runat="server" class="btn btn-primary" Text="提交" OnClick="Button1_Click"
                                                OnClientClick="return chkblank();" />
                                            <asp:HiddenField ID="total" runat="server" />
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <script type="text/javascript">

                            function view() {
                                var y = document.getElementById("ddlYm").value;
                                if (y.length == 0)
                                $.messager.alert('提醒','请选择月份！','info'); 
                                else {
                                    var url = "view.aspx?ym=" + y;
                                    window.open(url, "view", "resizable=yes,scrollbars=yes,location=no,toolbar=no,menubar=no,status=no");
                                }
                            }
                        </script>
                        <table style="border-collapse: collapse; margin-top: 5px;" bordercolor="#6a71a3"
                            cellspacing="1" cellpadding="3" width="96%" border="1">
                            <tbody align="left">
                                <tr bgcolor="#9fb5ec">
                                    <td class="head">以往考核指标管理
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;&nbsp;
                                        <input type="text" style="width: 100px;" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy年MM月',readOnly:'true',vel:'ddlYm',realDateFmt:'yyyy-MM'})" />
                                        <input type="hidden" id="ddlYm" />
                                        <input onclick="view()" type="button" class="btn btn-info" value="查看" />
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
