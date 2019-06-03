<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <title>网格评价系统</title>
    <link href="../Css/Style.css" rel="stylesheet" />
     <%--引入Jquery文件--%>
    <script src="../js/easyui/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="../js/extJquery.js" type="text/javascript"></script>
    <%--引入easyui文件--%>
    <script src="../js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <link href="../js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
   <div id="win" class="easyui-window" title="My Window" style="width:600px;height:400px"   
        data-options="modal:true,closable:false,    
                collapsible:false,minimizable:false,maximizable:false">   
    Window Content    
</div>  

    </form>
</body>
</html>
