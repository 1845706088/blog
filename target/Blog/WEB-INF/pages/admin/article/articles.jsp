<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  User: 今何许
  Date: 2020/4/30
  Time: 12:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>后台管理</title>
</head>
<body>
<c:import url="../header.jsp"></c:import>
<div class="admin-mian">
    <!--主题内容-->
    <c:import url="../menu.jsp"></c:import>
    <div class="breadcrumb">
        <span>文章管理</span>
        <span class="divider">/</span>
        <span class="active">文章列表</span>
    </div>
    <!--内容区域-->
    <div class="list-content">
        <!--块元素-->
        <div class="block">
            <!--页面有多个表格时，可以用于标识表格-->
            <h2>文章列表</h2>
            <!--右上角的返回按钮-->
            <a href="javascript:history.back();">
                <button class="button indigo radius-3" style="position: absolute;right: 20px;top: 16px;"><span
                        class="icon-arrow_back"></span> 返回
                </button>
            </a>

            <!--正文内容-->
            <div class="main">
                <!--表格上方的搜索操作-->
                <div class="admin-search">
                    <select id="type_id" name="typeId">
                        <c:forEach items="${list}" var="id">
                            <option value="${id.id}"
                                    <c:if test="${id.id==typeId}">selected</c:if>>${id.typeName}</option>
                        </c:forEach>
                    </select>
                    <input type="text" id="date2" class="ex-date" style="width: 220px;" value="" readonly/>
                    <div class="input-group">
                        <input type="text" class="text" value="${title}" id="title" placeholder="标题"/>
                        <button class="button blue" onclick="search()">搜索</button>
                    </div>
                </div>
                <!--表格上方的操作元素，添加、删除等-->
                <div class="operation-wrap">
                    <div class="buttons-wrap">
                        <a href="/article/edit">
                            <button id="add" class="button blue radius-3"><span class="icon-plus"></span> 添加</button>
                        </a>
                        <button id="save" class="button green radius-3"><span class="icon-check"></span> 保存</button>
                        <button id="delete" class="button red radius-3"><span class="icon-close2"></span> 删除</button>
                    </div>
                </div>
                <table id="table" class="table color2">
                    <thead>
                    <tr>
                        <th class="checkbox"><input type="checkbox" class="fill listen-1"/>&nbsp;</th>
                        <th style="width: 80px">序号</th>
                        <th>分类</th>
                        <th>文章标题</th>
                        <th>阅读量</th>
                        <th>撰写日期</th>
                        <th>编辑</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${fn:length(pageInfo.list)==0}">
                            <tr>
                                <td colspan="6" style="text-align: center">暂无数据</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${pageInfo.list}" var="l" varStatus="status">
                                <tr>
                                    <td class="checkbox"><input type="checkbox" name="id" class="fill listen-1-2"
                                                                value="${l.id}"/>&nbsp;
                                    </td>
                                    <td>${status.index+1}</td>
                                    <td>${l.typeName}</td>
                                    <td>${l.title}</td>
                                    <td>${l.viewCount}</td>
                                    <td>${l.updateTime}</td>
                                    <td>
                                        <a href="/article/edit?id=${l.id}">
                                            <button class="button wathet radius-3"><span class="icon-colorize1"></span>
                                                编辑
                                            </button>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
                <%--分页--%>
                <div class="page">
                    <ul id="page" class="pagination"></ul>
                </div>
                <!--块元素-->
                <div class="block no-shadow">
                    <!--banner用来修饰块元素的名称-->
                    <div class="banner">
                        <p class="tab fixed">批量操作</p>
                    </div>
                    <!--正文内容-->
                    <div class="main">
                        <div style="margin: 30px">
                            <label> <input type="radio" class="fill" name="radio" value="move"/>移动分类</label>
                            <select id="type_id2">
                                <c:forEach items="${list}" var="id">
                                    <option value="${id.id}">${id.typeName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div style="margin: 30px">
                            <input type="radio" style="margin: 50px" class="fill" value="recycle" name="radio"/>回收
                        </div>
                        <button style="float: right" id="submit" class="button green"><span
                                class="icon-paper-plane-o"></span> 提交
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    //批量提交
    $("#submit").click(function () {
        var idArr = new Array();
        $(':checkbox[name="id"]:checked').each(function () {
            idArr.push($(this).val());
        });
        if (idArr.length == 0) {
            javaex.optTip({
                content: "至少选择一条记录",
                type: "error"
            });
            return;
        }
        var opt = $(':radio[name="radio"]:checked').val();
        if (opt == "move") {
            var typeId = $("#type_id2").val();
            console.log(idArr, typeId);
            $.ajax({
                url: "/article/move.json",
                type: "post",
                traditional: "true",
                dataType: "json",
                data: {
                    "idArr": idArr,
                    "typeId": typeId
                },
                success: function (data) {
                    if (data.code == "1") {
                        javaex.message({
                            content: data.message,
                            type: "success"
                        });
                        setTimeout(function () {
                            //刷新页面
                            window.location.reload();
                        }, 2000);

                    } else {
                        javaex.message({
                            content: data.message,
                            type: "error"
                        });
                    }
                }
            });

        } else if (opt == "recycle") {
            $.ajax({
                url: "/article/update_status.json",
                type: "post",
                traditional: "true",
                dataType: "json",
                data: {
                    "idArr": idArr,
                    "status": "0"
                },
                success: function (data) {
                    if (data.code == "1") {
                        javaex.message({
                            content: data.message,
                            type: "success"
                        });
                        setTimeout(function () {
                            //刷新页面
                            window.location.reload();
                        }, 2000);

                    } else {
                        javaex.message({
                            content: data.message,
                            type: "error"
                        });
                    }
                }
            });
        }
    });
    javaex.select({
        id: "type_id2",
        isSearch: false,
    });
    javaex.select({
        id: "type_id",
        isSearch: false,
    });
    var startDate = "";
    var endDate = "";
    javaex.date({
        id: "date2",		// 承载日期组件的id
        monthNum: 2,		// 2代表选择范围日期
        startDate: "${startDate}",	// 开始日期
        endDate: "${endDate}",		// 结束日期
        alignment: "right",
        // 重新选择日期之后返回一个时间对象
        callback: function (rtn) {
            startDate = rtn.startDate;
            endDate = rtn.endDate;
        }
    });
    var currentPage = "${pageInfo.pageNum}";
    var pageCount = "${pageInfo.pages}";
    javaex.page({
        id: "page",
        pageCount: pageCount,	// 总页数
        currentPage: currentPage,// 默认选中第几页
        position: "left",
        callback: function (rtn) {
            search(rtn.pageNum);
        }
    });

    function search(pageNum) {
        if (pageNum == undefined) {
            pageNum = 1;
        }
        var typeId = $("#type_id").val();
        var title = $("#title").val();
        window.location.href = "/article/articles?pageNum=" + pageNum + "&typeId=" + typeId + "&startDate=" + startDate + "&endDate=" + endDate + "&title=" + title;
    }

    var idArr = new Array();
    var sortArr = new Array();
    var nameArr = new Array();
    $("#add").click(function () {
        var html = '';
        html += '<tr>';
        html += '<td class="checkbox"><input type="checkbox" name="id" class="fill listen-1-2" value="${l.id}"/> </td>';
        html += '<td><input type="text" class="text" style="width:30%" name="sort" data-type="正整数" error-msg="必须输入正整数" value="${l.sort}"/></td>';
        html += '<td><input type="text" value="" class="text" style="width:30%" name="name" data-type="必填" placeholder="请输入分类名称"/></td>';
        html += '</tr>';
        $("#table tbody").append(html);
        javaex.render();
    });
    $("#save").click(function () {
        if (javaexVerify()) {
            idArr = [];
            sortArr = [];
            nameArr = [];
            $(':checkbox[name="id"]').each(function () {
                idArr.push($(this).val());
            });
            $(':input[name="sort"]').each(function () {
                sortArr.push($(this).val());
            });
            $(':input[name="name"]').each(function () {
                nameArr.push($(this).val());
            });
            $.ajax({
                url: "/type/save.json",
                type: "post",
                traditional: "true",
                dataType: "json",
                data: {
                    "idArr": idArr,
                    "sortArr": sortArr,
                    "nameArr": nameArr
                },
                success: function (data) {
                    if (data.code == "1") {
                        javaex.message({
                            content: data.message,
                            type: "success"
                        });
                        setTimeout(function () {
                            //刷新页面
                            window.location.reload();
                        }, 2000);

                    } else {
                        javaex.message({
                            content: data.message,
                            type: "error"
                        });
                    }
                }
            });
        }
    });
    $("#delete").click(function () {
        idArr = [];
        $(":checkbox[name='id']:checked").each(function () {
            var id = $(this).val();
            if (id != "") {
                idArr.push(id);
            }
        });
        //为空前台刷新
        if (idArr.length == 0) {
            $(":checkbox[name='id']:checked").each(function () {
                $(this).parent().parent().parent().remove();
            });

        } else {
            $.ajax({
                url: "/type/delete.json",
                type: "post",
                traditional: "true",
                dataType: "json",
                data: {
                    "idArr": idArr
                },
                success: function (data) {
                    if (data.code == "1") {
                        javaex.message({
                            content: data.message,
                            type: "success"
                        });
                        setTimeout(function () {
                            //刷新页面
                            window.location.reload();
                        }, 2000);

                    } else {
                        javaex.message({
                            content: data.message,
                            type: "error"
                        });
                    }
                }
            });

        }
    });
</script>
</html>