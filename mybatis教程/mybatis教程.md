[TOC]
1.概念


#概念
mybatis是一个持久化框架，是apache的项目

```xml
<insert id="insertUser" parameterType="User">
	<!-- order 执行顺序 -->
	<selectKey keyProperty="id" order="AFTER" resultType="java.lang.Integer">
    select LAST_INSERT_ID()
    <!-- 将主键值放入User的id中 -->
    </selectKey>
	insert into User(name,password) values(#{name},#{password}) 
</insert>
```

全局配置文件的内容
<properties resource=""></properties>
<setting></setting>
<typeAliases>
	
</typeAliases>