1. 创建Maven的普通java项目： 
   mvn archetype:create 
   -DgroupId=packageName 
   -DartifactId=projectName  
2. 创建Maven的Web项目：   
    mvn archetype:create 
    -DgroupId=packageName    
    -DartifactId=webappName 
    -DarchetypeArtifactId=maven-archetype-webapp    
3. 编译源代码： mvn compile 
4. 编译测试代码：mvn test-compile    
5. 运行测试：mvn test   
6. 产生site：mvn site   
7. 打包：mvn package   
8. 在本地Repository中安装jar：mvn install 
9. 清除产生的项目：mvn clean   
10. 生成eclipse项目：mvn eclipse:eclipse  
11. 生成idea项目：mvn idea:idea  
12. 组合使用goal命令，如只打包不测试：mvn -Dtest package   
13. 编译测试的内容：mvn test-compile  
14. 只打jar包: mvn jar:jar  
15. 只测试而不编译，也不测试编译：mvn test -skipping compile -skipping test-compile 
      ( -skipping 的灵活运用，当然也可以用于其他组合命令)  
16. 清除eclipse的一些系统设置:mvn eclipse:clean  
17. 发布第三方Jar到本地库中： 

mvn install:install-file -DgroupId=com -DartifactId=client -Dversion=0.1.0 -Dpackaging=jar -Dfile=d:\client-0.1.0.jar 
