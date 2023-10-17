### web.xml文件详解

 

　　前言：一般的web工程中都会用到web.xml，web.xml主要用来配置，可以方便的开发web工程。web.xml主要用来配置Filter、Listener、Servlet等。但是要说明的是web.xml并不是必须的，一个web工程可以没有web.xml文件。

#### 一、WEB工程加载web.xml过程
&emsp;&emsp; 经过个人测试，WEB工程加载顺序与元素节点在文件中的配置顺序无关。即不会因为 filter 写在 listener 的前面而会先加载 filter。WEB容器的加载顺序是：ServletContext -> context-param -> listener -> filter -> servlet。并且这些元素可以配置在文件中的任意位置。
&emsp;&emsp; 加载过程顺序如下：
&emsp;&emsp; 启动一个WEB项目的时候，WEB容器会去读取它的配置文件web.xml，读取<listener>和<context-param>两个结点。 
&emsp;&emsp; 紧急着，容创建一个ServletContext（servlet上下文），这个web项目的所有部分都将共享这个上下文。 容器将<context-param>转换为键值对，并交给servletContext。 容器创建<listener>中的类实例，创建监听器。 
####二、web.xml文件元素详解
#####1、schema
&emsp;&emsp; web.xml的模式文件是由Sun公司定义的，每个web.xml文件的根元素<web-app>中，都必须标明这个 web.xml使用的是哪个模式文件。其它的元素都放在<web-app></web-app>之中。
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.4" 
    xmlns="http://java.sun.com/xml/ns/j2ee" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee 
        http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">
</web-app>
```
#####2、<icon>Web应用图标
指出IDE和GUI工具用来表示Web应用的大图标和小图标。
```xml
<icon>
    <small-icon>/images/app_small.gif</small-icon>
    <large-icon>/images/app_large.gif</large-icon>
</icon>
```
#####3、<display-name>Web应用名称
提供GUI工具可能会用来标记这个特定的Web应用的一个名称
```xml
<display-name>Tomcat Example</display-name>
```
#####4、<disciption>Web应用描述

　　给出于此相关的说明性文本
  
```xml
<disciption>Tomcat Example servlets and JSP pages.</disciption>
```
#####5、<context-param>上下文参数

　　声明应用范围内的初始化参数。它用于向 ServletContext提供键值对，即应用程序上下文信息。我们的listener, filter等在初始化时会用到这些上下文中的信息。在servlet里面可以通过getServletContext().getInitParameter("context/param")得到。
```xml
<context-param>
    <param-name>ContextParameter</para-name>
    <param-value>test</param-value>
    <description>It is a test parameter.</description>
</context-param>
```
#####6、<filter>过滤器

　　将一个名字与一个实现javaxs.servlet.Filter接口的类相关联。
```xml
<filter>
    <filter-name>setCharacterEncoding</filter-name>
    <filter-class>com.myTest.setCharacterEncodingFilter</filter-class>
    <init-param>
        <param-name>encoding</param-name>
        <param-value>UTF-8</param-value>
    </init-param>
</filter>
<filter-mapping>
    <filter-name>setCharacterEncoding</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```
#####7、<listener>监听器
```xml
<listener> 
    <listerner-class>com.listener.SessionListener</listener-class> 
</listener>
```
#####　8、servlet

`<servlet></servlet>` 用来声明一个servlet的数据，主要有以下子元素：

`<servlet-name></servlet-name>` 指定servlet的名称
`<servlet-class></servlet-class>` 指定servlet的类名称
`<jsp-file></jsp-file> `指定web站台中的某个JSP网页的完整路径
`<init-param></init-param>` 用来定义参数，可有多个init-param。在servlet类中通过getInitParamenter(String name)方法访问初始化参数
`<load-on-startup></load-on-startup>`指定当Web应用启动时，装载Servlet的次序。当值为正数或零时：Servlet容器先加载数值小的servlet，再依次加载其他数值大的servlet。当值为负或未定义：Servlet容器将在Web客户首次访问这个servlet时加载它。
`<servlet-mapping></servlet-mapping> `用来定义servlet所对应的URL，包含两个子元素
`<servlet-name></servlet-name>` 指定servlet的名称
`<url-pattern></url-pattern>` 指定servlet所对应的URL
```xml
<!-- 基本配置 -->
<servlet>
    <servlet-name>snoop</servlet-name>
    <servlet-class>SnoopServlet</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>snoop</servlet-name>
    <url-pattern>/snoop</url-pattern>
</servlet-mapping>
<!-- 高级配置 -->
<servlet>
    <servlet-name>snoop</servlet-name>
    <servlet-class>SnoopServlet</servlet-class>
    <init-param>
        <param-name>foo</param-name>
        <param-value>bar</param-value>
    </init-param>
    <run-as>
        <description>Security role for anonymous access</description>
        <role-name>tomcat</role-name>
    </run-as>
</servlet>
<servlet-mapping>
    <servlet-name>snoop</servlet-name>
    <url-pattern>/snoop</url-pattern>
</servlet-mapping>
```
######9、<session-config>会话超时配置

　　单位为分钟。
```xml
<session-config>
    <session-timeout>120</session-timeout>
</session-config>
```
#####10、mime-mapping
```xml
<mime-mapping>
    <extension>htm</extension>
    <mime-type>text/html</mime-type>
</mime-mapping>
```
#####11、<welcome-file-list>欢迎文件页
```xml
<welcome-file-list>
    <welcome-file>index.jsp</welcome-file>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.htm</welcome-file>
</welcome-file-list>
```
#####12、<error-page>错误页面
```xml
<!-- 1、通过错误码来配置error-page。当系统发生×××错误时，跳转到错误处理页面。 -->
<error-page>
    <error-code>404</error-code>
    <location>/NotFound.jsp</location>
</error-page>
<!-- 2、通过异常的类型配置error-page。当系统发生java.lang.NullException（即空指针异常）时，跳转到错误处理页面。 -->
<error-page>
    <exception-type>java.lang.NullException</exception-type>
    <location>/error.jsp</location>
</error-page>
```
#####13、<jsp-config>设置jsp

　　`<jsp-config>` 包括 `<taglib>` 和 `<jsp-property-group>` 两个子元素。其中`<taglib>` 元素在JSP 1.2 时就已经存在；而`<jsp-property-group>` 是JSP 2.0 新增的元素。

　　`<jsp-property-group>` 元素主要有八个子元素，它们分别为：

`<description>`：设定的说明 
`<display-name>`：设定名称 
`<url-pattern>`：设定值所影响的范围，如： /CH2 或 /*.jsp
`<el-ignored>`：若为 true，表示不支持 EL 语法 
`<scripting-invalid>`：若为 true，表示不支持 <% scripting %>语法 
`<page-encoding>`：设定 JSP 网页的编码 
`<include-prelude>`：设置 JSP 网页的抬头，扩展名为 .jspf
`<include-coda>` ：设置 JSP 网页的结尾，扩展名为 .jspf
```xml
<jsp-config>
    <taglib>
        <taglib-uri>Taglib</taglib-uri>
        <taglib-location>/WEB-INF/tlds/MyTaglib.tld</taglib-location>
    </taglib>
    <jsp-property-group>
        <description>Special property group for JSP Configuration JSP example.</description>
        <display-name>JSPConfiguration</display-name>
        <url-pattern>/jsp/* </url-pattern>
        <el-ignored>true</el-ignored>
        <page-encoding>GB2312</page-encoding>
        <scripting-invalid>true</scripting-invalid>
        <include-prelude>/include/prelude.jspf</include-prelude>
        <include-coda>/include/coda.jspf</include-coda>
    </jsp-property-group>
</jsp-config>
```
　　对于Web 应用程式来说，Scriptlet 是个不乐意被见到的东西，因为它会使得HTML 与Java 程式码交相混杂，对于程式的维护来说相当的麻烦，必要的时候，可以在web.xml 中加上<script-invalid> 标签，设定所有的JSP 网页都不可以使用Scriptlet。

####三、Mapping规则

　　当一个请求发送到servlet容器的时候，容器先会将请求的url减去当前应用上下文的路径作为servlet的映射url，比如我访问的是`http://localhost/test/aaa.html` ，我的应用上下文是test，容器会将`http://localhost/test`去掉，剩下的/aaa.html部分拿来做servlet的映射匹配。这个映射匹配过程是有顺序的，而且当有一个servlet匹配成功以后，就不会去理会剩下的servlet了。

　　其匹配规则和顺序如下：

精确路径匹配。例子：比如servletA 的url-pattern为 /test，servletB的url-pattern为 /* ，这个时候，如果我访问的url为 `http://localhost/test`，这个时候容器就会先 进行精确路径匹配，发现/test正好被servletA精确匹配，那么就去调用servletA，也不会去理会其他的servlet了。
最长路径匹配。例子：servletA的url-pattern为/test/*，而servletB的url-pattern为/test/a/*，此时访问`http://localhost/test/a`时，容器会选择路径最长的servlet来匹配，也就是这里的servletB。
扩展匹配，如果url最后一段包含扩展，容器将会根据扩展选择合适的servlet。例子：servletA的url-pattern：*.action
　　以”/’开头和以”/*”结尾的是用来做路径映射的。以前缀”*.”开头的是用来做扩展映射的。所以，为什么定义”/*.action”这样一个看起来很正常的匹配会错？因为这个匹配即属于路径映射，也属于扩展映射，导致容器无法判断。

 