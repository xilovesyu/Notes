<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<html lang="zh-CN">
<head>
    <title>列表</title>
    <link href="/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="/jquery/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="/bootstrap/js/bootstrap.js" type="text/javascript"></script>
</head>
<body>
<%@ include file="BaseBookHead.jsp" %>
<div class="container">
    <table class="table table-striped">
        <c:forEach items="${booklist}" var="item">
            <tr>
                <td> ${item.bookId }</td>
                <td>${item.name }</td>
                <td>${item.number }</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
