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
<!--主题内容-->
<div class="admin-mian">
    <c:import url="../menu.jsp"></c:import>
    <div class="breadcrumb">
        <span>文章管理</span>
        <span class="divider">/</span>
        <span class="active">文章编辑</span>
    </div>
    <!--内容区域-->
    <div class="list-content">
        <!--块元素-->
        <div class="block">
            <!--修饰块元素名称-->
            <div class="banner">
                <p class="tab fixed">文章编辑</p>
            </div>

            <!--正文内容-->
            <div class="main">
                <form id="form">
                    <input type="hidden" name="id" value="${id}">
                    <!--文本框-->
                    <div class="unit clear">
                        <div class="left"><span class="required">*</span>
                            <p class="subtitle">标题</p></div>
                        <div class="right">
                            <input type="text" class="text" value="${article.title}" name="title" data-type="必填"
                                   error-msg="格式错误" error-pos="42"
                                   placeholder="请输入文章标题"/>
                        </div>
                    </div>

                    <!--下拉选择框-->
                    <div class="unit clear">
                        <div class="left"><p class="subtitle">所属分类</p></div>
                        <div class="right">
                            <select id="type_id" name="typeId">
                                <c:forEach items="${list}" var="id">
                                    <option value="${id.id}"
                                            <c:if test="${article.typeId==id.id}">selected</c:if>>${id.typeName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <!--文章封面-->
                    <div class="unit clear">
                        <div class="left"><p class="subtitle">文章封面</p></div>
                        <div class="right">
                            <div id="container" class="file-container">
                                <div class="cover">
                                    <c:choose>
                                        <c:when test=" ${empty article.cover}">
                                            <img class="upload-img-cover" src=""/>
                                        </c:when>
                                        <c:otherwise>
                                            <img class="upload-img-cover" src="${article.cover}"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <!--如果不需要回显图片，src留空即可-->
                                    <input type="file" class="file" id="upload"
                                           accept="image/gif, image/jpeg, image/jpg, image/png"/>
                                    <input type="hidden" id="cover" name="cover" value=""/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--文本域-->
                    <div class="unit clear">
                        <div class="left"><p class="subtitle">内容</p></div>
                        <div class="right">
                            <div id="edit" class="edit-container">
                                <c:choose>
                                    <c:when test=" ${empty article.content}">
                                    </c:when>
                                    <c:otherwise>${article.content} </c:otherwise>
                                </c:choose>
                            </div>
                            <input type="hidden" id="content" name="content" value=""/>
                            <input type="hidden" id="contentText" name="contentText" value=""/>
                        </div>
                    </div>

                    <!--提交按钮-->
                    <div class="unit clear" style="width: 800px;">
                        <div style="text-align: center;">
                            <!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
                            <input type="button" id="return" class="button no" value="返回"/>
                            <input type="button" id="save" class="button yes" value="保存"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<script>
    javaex.edit({
        id: "edit",
        image: {
            url: "/article/upload.json",	// 请求路径
            param: "file",		// 参数名称，Spring中与MultipartFile的参数名保持一致
            dataType: "url",	// 返回的数据类型：base64 或 url
            isShowOptTip: true,	// 是否显示上传提示
            rtn: "rtnData",	// 后台返回的数据对象，在前台页面用该名字存储
            imgUrl: "data.imgUrl"	// 根据返回的数据对象，获取图片地址。  例如后台返回的数据为：{code: "000000", message: "操作成功！", data: {imgUrl: "/1.jpg"}}
        },
        isInit: true,
        callback: function (rtn) {
            $("#content").val(rtn.html);
            $("#contentText").val(rtn.text.substring(0, 100));
        }
    });
</script>

<script>
    javaex.select({
        id: "type_id",
        isSearch: false
    });

    // 监听点击保存按钮事件
    $("#save").click(function () {
        // 表单验证函数
        if (javaexVerify()) {
            $.ajax({
                url: "/article/save.json",
                type: "post",
                dataType: "json",
                data: $("#form").serialize(),
                success: function (data) {
                    console.log($("#form").serialize())
                    if (data.code == "1") {
                        javaex.optTip({
                            content: data.message,
                            type: "success"
                        });
                        setTimeout(function () {
                            window.location.href = "/article/articles";
                        }, 2000);

                    } else {
                        javaex.optTip({
                            content: data.message,
                            type: "error"
                        });
                    }
                }
            });
        }
    });

    // 监听点击返回按钮事件
    $("#return").click(function () {
        history.back();
    });
    javaex.upload({
        url: "/article/upload.json",
        type: "image",
        param: "file",
        id: "upload",	// <input type="file" />的id
        containerId: "container",	// 容器id
        dataType: "url",	// 返回的数据类型：base64 或 url
        callback: function (rtn) {
            if (rtn.code == "1") {
                var imageUrl = rtn.data.imgUrl;
                $("#container img").attr("src", imageUrl);
                $("#cover").val(imageUrl);
            } else {
                javaex.optTip({
                    content: rtn.message,
                    type: "error"
                });
            }
        }
    });
</script>
</html>