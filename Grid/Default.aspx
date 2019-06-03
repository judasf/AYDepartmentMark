<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head runat="server">
    <title>网格评价系统</title>
    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <%--引入Jquery文件--%>
    <script src="../js/easyui/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="../js/extJquery.js" type="text/javascript"></script>
    <%--引入easyui文件--%>
    <script src="../js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <link href="../js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <style>
        body { margin: 4px; padding: 0; background-color: #6A71A3; color: #3F3849; font-family: Verdana,Arial; }
    </style>
</head>
<body>

    <div class="well" style="padding: 5px; background: #eee; width: 450px; height: 400px; margin: 10% auto; text-align: center;">

        <form id="form2" runat="server" class="form-horizontal">
            <h2 style="text-align: center; margin: 50px; padding-bottom: 10px; border-bottom: 2px solid #6A71A3;">网格评价系统</h2>
            <div class="form-group">
                <label for="name" class="col-sm-4 control-label">账号</label>
                <div class="col-sm-6">
                    <input runat="server" type="text" class="form-control "  id="name" placeholder="账号" />
                </div>
            </div>
            <div class="form-group">
                <label for="pwd" class="col-sm-4 control-label">密码</label>
                <div class="col-sm-6">
                    <input runat="server" type="password" class="form-control" id="pwd" placeholder="密码" />
                </div>
            </div>
            <div class="form-group">
                <asp:Button ID="login" class="btn btn-primary" style="margin-top:20px;width:120px;" runat="server" Text="登陆" OnClick="login_Click" />
            </div>
        </form>
    </div>
</body>
</html>

