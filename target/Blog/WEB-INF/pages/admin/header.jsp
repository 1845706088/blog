<%--
  User: 今何许
  Date: 2020/4/30
  Time: 13:22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!--字体图标-->
    <link href="/static/pc/css/icomoon.css" rel="stylesheet"/>
    <!--动画-->
    <link href="/static/pc/css/animate.css" rel="stylesheet"/>
    <!--骨架样式-->
    <link href="/static/pc/css/common.css" rel="stylesheet"/>
    <!--皮肤（缇娜）-->
    <link href="/static/pc/css/skin/tina.css" rel="stylesheet"/>
    <!--jquery，不可修改版本-->
    <script src="/static/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="/static/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="/static/pc/js/javaex.min.js"></script>
    <!--表单验证-->
    <script src="/static/pc/js/javaex-formVerify.js"></script>
    <title>Title</title>
</head>
<body>
<!--顶部导航-->
<div class="admin-navbar">
    <div class="admin-container-fluid clear">
        <!--logo名称-->
        <div class="admin-logo">SX博客</div>

        <!--导航-->
        <ul class="admin-navbar-nav fl">
            <li class="active"><a href="/admin/index">总览</a></li>
        </ul>

        <!--右侧-->
        <ul class="admin-navbar-nav fr">
            <li>
                <a href="javascript:;">欢迎您，管理员</a>
                <ul class="dropdown-menu" style="right: 10px;">
                    <li><a href="/admin/login_out">退出账号</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>
</body>
</html>
