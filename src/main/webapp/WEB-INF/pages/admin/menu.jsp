<%--
  User: 今何许
  Date: 2020/4/30
  Time: 13:27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!--主题内容-->
<div class="admin-mian">
    <!--左侧菜单-->
    <div class="admin-aside admin-aside-fixed">
        <h1><span class="admin-nav-name">菜单</span></h1>
        <div id="admin-toc" class="admin-toc">
            <div class="menu-box">
                <div id="menu" class="menu">
                    <ul>
                        <li class="menu-item">
                            <a href="javascript:;">个人中心<i class="icon-keyboard_arrow_left"></i></a>
                            <ul>
                                <li><a href="javascript:page('/admin/user/avatar');">修改头像</a></li>
                                <li><a href="javascript:page('/admin/user/password');">修改密码</a></li>
                            </ul>
                        </li>
                        <li class="menu-item">
                            <a href="javascript:;">分类管理<i class="icon-keyboard_arrow_left"></i></a>
                            <ul>
                                <li><a href="/type/list">文章分类</a></li>
                            </ul>
                        </li>
                        <li class="menu-item">
                            <a href="javascript:;">文章管理<i class="icon-keyboard_arrow_left"></i></a>
                            <ul>
                                <li><a href="/article/articles">文章列表</a></li>
                                <li><a href="/article/recycle">回收站</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var hightUrl = "xxxx";
    javaex.menu({
        id: "menu",
        isAutoSelected: true,
        key: "",
        url: hightUrl
    });

    $(function () {
        // 设置左侧菜单高度
        setMenuHeight();
    });

    /**
     * 设置左侧菜单高度
     */
    function setMenuHeight() {
        var height = document.documentElement.clientHeight - $("#admin-toc").offset().top;
        height = height - 10;
        $("#admin-toc").css("height", height + "px");
    }

    // 控制页面载入
    function page(url) {
        $("#page").attr("src", url);
    }
</script>
</html>
