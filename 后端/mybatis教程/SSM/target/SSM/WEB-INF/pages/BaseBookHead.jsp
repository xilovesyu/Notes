<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="utf-8">
<%--
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">图书管理</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Bootstrap theme</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">查看所有书</a></li>
                <li><a href="#about">添加书</a></li>
                &lt;%&ndash;<li><a href="#contact">Contact</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li role="separator" class="divider"></li>
                        <li class="dropdown-header">Nav header</li>
                        <li><a href="#">Separated link</a></li>
                        <li><a href="#">One more separated link</a></li>
                    </ul>
                </li>&ndash;%&gt;
            </ul>
        </div>
    </div>
</nav>
--%>
<div class="container">
    <div class="navbar navbar-inverse">
        <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse"
                    data-target=".navbar-responsive-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="#">导航栏</a>
        </div>

        <div class="collapse navbar-collapse navbar-responsive-collapse">
            <ul class="nav navbar-nav">
                <li><a href="/book/all">查看所有图书</a></li>
                <li><a href="/book/new">添加新图书</a></li>
                <li><a href="#">更新图书</a></li>
            </ul>
        </div>
    </div>
</div>
