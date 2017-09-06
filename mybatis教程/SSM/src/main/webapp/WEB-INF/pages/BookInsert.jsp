<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="zh-CN">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<head>
    <title>插入一本书</title>
    <link href="/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="/jquery/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="/bootstrap/js/bootstrap.js" type="text/javascript"></script>
</head>
<body>
<%@ include file="BaseBookHead.jsp" %>
<div class="container">
    <form class="form-horizontal" action="/book/insert" method="post" modelAttribute="book">
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">书名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="name" name="name" placeholder="书名" value="${book.name}"/>
            </div>
        </div>
        <div class="form-group">
            <label for="number" class="col-sm-2 control-label">价格</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="number" name="number" placeholder="价格"
                       value="${book.number}"/>
                <form:errors path="book.number" cssStyle="color:red"></form:errors>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-4">
                <input type="submit" class="btn btn-default" value="提交"/>
            </div>
        </div>
    </form>
</div>
</body>
</html>
