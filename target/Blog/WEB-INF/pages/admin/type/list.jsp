<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<!--主题内容-->
<div class="admin-mian">
    <c:import url="../menu.jsp"></c:import>
    <div class="breadcrumb">
        <span>分类管理</span>
        <span class="divider">/</span>
        <span class="active">文章分类</span>
    </div>
    <!--内容区域-->
    <div class="list-content">
        <!--块元素-->
        <div class="block">
            <!--页面有多个表格时，可以用于标识表格-->
            <h2>文章分类</h2>
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
                    <div class="input-group">
                        <input type="text" class="text" placeholder="提示信息"/>
                        <button class="button blue">搜索</button>
                    </div>
                </div>
                <!--表格上方的操作元素，添加、删除等-->
                <div class="operation-wrap">
                    <div class="buttons-wrap">
                        <button id="add" class="button blue radius-3"><span class="icon-plus"></span> 添加</button>
                        <button id="save" class="button green radius-3"><span class="icon-check"></span> 保存</button>
                        <button id="delete" class="button red radius-3"><span class="icon-close2"></span> 删除</button>
                    </div>
                </div>
                <table id="table" class="table color2">
                    <thead>
                    <tr>
                        <th class="checkbox"><input type="checkbox" class="fill listen-1"/>&nbsp;</th>
                        <th >序号</th>
                        <th >分类名称</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="l" varStatus="status">
                        <tr>
                            <td class="checkbox"><input type="checkbox" name="id" class="fill listen-1-2"
                                                        value="${l.id}"/>&nbsp;
                            </td>
                            <td><input style="width:30%"type="text" class="text"  name="sort" data-type="正整数"
                                       error-msg="必须输入正整数"
                                       value="${l.sort}"/></td>
                            <td><input style="width:30%" value="${l.typeName}" type="text" class="text"  name="name"
                                       data-type="必填" placeholder="请输入分类名称"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var idArr = new Array();
    var sortArr = new Array();
    var nameArr = new Array();
    $("#add").click(function () {
        var html = '';
        html += '<tr>';
        html += '<td class="checkbox"><input type="checkbox" name="id" class="fill listen-1-2" value="${l.id}"/> </td>';
        html += '<td><input type="text" style="width:30%"class="text"name="sort" data-type="正整数" error-msg="必须输入正整数" value="${l.sort}"/></td>';
        html += '<td><input type="text" value=""style="width:30%" class="text"  name="name" data-type="必填" placeholder="请输入分类名称"/></td>';
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