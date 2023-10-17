<%--
  Created by IntelliJ IDEA.
  User: xijiaxiang
  Date: 2017/6/3
  Time: 14:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文件上传</title>
</head>
<body>
<div>
    <form action="uploadfile" enctype="multipart/form-data" method="post">
        <input type="file" name="file"/><br/>
        <input type="submit" value="上传"/>

    </form>
</div>
</body>
</html>
