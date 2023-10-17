##目录
* [Spring JDBC](#SpringJDBC)
* [Spring JDBC存储过程](#Spring JDBC存储过程)
* [Spring 事务管理](#Spring 事务管理)
#### SpringJDBC
首先明白一点，做数据库的操作，第一步首先要的就是数据源，有了数据源才可以进行下一步的工作。所以我们首先配置数据源。
在beans的xml文件中我们定义数据源的bean（这里的数据源采用的是springjdbc提供的，我们还可以采用其他的例如dhcp，c3po，hikarp）
```xml
<bean id="dataSource"
		class="org.springframework.jdbc.datasource.DriverManagerDataSource">
		<property name="driverClassName" value="com.mysql.jdbc.Driver" />
		<property name="url" value="jdbc:mysql://localhost:3306/mydatabase" />
		<property name="username" value="root" />
		<property name="password" value="xyxx1231" />
	</bean>
```
然后通过jdbcTemplate进行一系列的操作。
为了方便示例，我们先建立一个实体类Student。并且建了studentDao的接口用来对student进行操作。
studentDao的内容如下：

```java
public interface studentDao {
	 public void setDataSource(DataSource ds);
	   /** 
	    * This is the method to be used to create
	    * a record in the Student table.
	    */
	   public void create(String name, Integer age);
	   /** 
	    * This is the method to be used to list down
	    * a record from the Student table corresponding
	    * to a passed student id.
	    */
	   public Student getStudent(Integer id);
	   /** 
	    * This is the method to be used to list down
	    * all the records from the Student table.
	    */
	   public List<Student> listStudents();
	   /** 
	    * This is the method to be used to delete
	    * a record from the Student table corresponding
	    * to a passed student id.
	    */
	   public void delete(Integer id);
	   /** 
	    * This is the method to be used to update
	    * a record into the Student table.
	    */
	   public void update(Integer id, Integer age);
}

```

那么我们写一个实现了studentDao接口的类，在这里进行具体的操作

```java
public class StudentJdbcTemplate implements studentDao {
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplateObject;

	@Override
	public void setDataSource(DataSource ds) {
		// TODO Auto-generated method stub
		this.dataSource = ds;
		this.jdbcTemplateObject = new JdbcTemplate(dataSource);
	}

	@Override
	public void create(String name, Integer age) {
		// TODO Auto-generated method stub
		String SQL = "insert into student (name, age) values (?, ?)";
		jdbcTemplateObject.update(SQL, name, age);
		System.out.println("Created Record Name = " + name + " Age = " + age);
		return;
	}

	@Override
	public Student getStudent(Integer id) {
		String SQL = "select * from student where id = ?";
		Student student = jdbcTemplateObject.queryForObject(SQL, new Object[] { id }, new StudentMapper());
		return student;
	}

	@Override
	public List<Student> listStudents() {
		String SQL = "select * from student";
		List<Student> students = jdbcTemplateObject.query(SQL, new StudentMapper());
		return students;
	}

	@Override
	public void delete(Integer id) {
		String SQL = "delete from student where id = ?";
		jdbcTemplateObject.update(SQL, id);
		System.out.println("Deleted Record with ID = " + id);
		return;
	}

	@Override
	public void update(Integer id, Integer age) {
		String SQL = "update student set age = ? where id = ?";
		jdbcTemplateObject.update(SQL, age, id);
		System.out.println("Updated Record with ID = " + id);
		return;
	}

}
```
这里的实现类就是具体的利用jdbcTemplate进行数据库的操作。这里的StudentMapper是另外一个类
```java
public class StudentMapper implements RowMapper<Student> {

	@Override
	public Student mapRow(ResultSet rs, int arg1) throws SQLException {
		Student student = new Student();
		student.setId(rs.getInt("id"));
		student.setName(rs.getString("name"));
		student.setAge(rs.getInt("age"));
		return student;
	}

}
```
用来返回一个Student类的。
那么最后的话，我们将StudentJDBCTemplate作为bean写到xml文件之中就完成了。
```xml
<!-- Definition for studentJDBCTemplate bean -->
	<bean id="studentJDBCTemplate" class="com.xixi.dao.StudentJdbcTemplate">
		<property name="dataSource" ref="dataSource" />
	</bean>
```

#### Spring JDBC存储过程

存储过程的话和jdbc类似，这里只展示他们的不同的地方
```java
	private SimpleJdbcCall jdbcCall;
	public void setDataSource(DataSource dataSource) {
      	this.dataSource = dataSource;
      	this.jdbcCall =  new SimpleJdbcCall(dataSource).
                       withProcedureName("getRecord");
 	}
 	public Student getStudent(Integer id) {
      	SqlParameterSource in = new MapSqlParameterSource().
                              addValue("in_id", id);
      	Map<String, Object> out = jdbcCall.execute(in);
      	Student student = new Student();
      	student.setId(id);
      	student.setName((String) out.get("out_name"));
      	student.setAge((Integer) out.get("out_age"));
      	return student;
   	}
```
在StudentJDBCTemplate中，利用jdbcCall来调用存储过程。

#### Spring 事务管理
在Spring中，分为编程式事务管理和声明式事务管理。
##### 事物定义
Spring中定义事务是通过TransactionDefinition接口来定义的。接口中主要包含以下方法。
```java
public interface TransactionDefinition{
	int getIsolationLevel();
	int getPropagationBehavior();
	int getTimeout();
	boolean isReadOnly();
}
```
#####事务隔离级别
隔离级别是指若干个并发的事务之间的隔离程度。TransactionDefinition 接口中定义了五个表示隔离级别的常量：
* TransactionDefinition.ISOLATION_DEFAULT：这是默认值，表示使用底层数据库的默认隔离级别。对大部分数据库而言，通常这值就是TransactionDefinition.ISOLATION_READ_COMMITTED。
* TransactionDefinition.ISOLATION_READ_UNCOMMITTED：该隔离级别表示一个事务可以读取另一个事务修改但还没有提交的数据。该级别不能防止脏读和不可重复读，因此很少使用该隔离级别。
* TransactionDefinition.ISOLATION_READ_COMMITTED：该隔离级别表示一个事务只能读取另一个事务已经提交的数据。该级别可以防止脏读，这也是大多数情况下的推荐值。
* TransactionDefinition.ISOLATION_REPEATABLE_READ：该隔离级别表示一个事务在整个过程中可以多次重复执行某个查询，并且每次返回的记录都相同。即使在多次查询之间有新增的数据满足该查询，这些新增的记录也会被忽略。该级别可以防止脏读和不可重复读。
* TransactionDefinition.ISOLATION_SERIALIZABLE：所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，该级别可以防止脏读、不可重复读以及幻读。但是这将严重影响程序的性能。通常情况下也不会用到该级别。

##### Spring 中的事务管理
&emsp;&emsp;spring框架中涉及到事务管理的主要有三个，`TransactionDefinition`、`PlatformTransactionManager`、`TransactionStatus`。
所谓事务管理，其实就是“按照给定的事务规则来执行提交或者回滚操作”。“给定的事务规则”就是用 TransactionDefinition 表示的，“按照……来执行提交或者回滚操作”便是用 PlatformTransactionManager 来表示，而 TransactionStatus 用于表示一个运行着的事务的状态。打一个不恰当的比喻，TransactionDefinition 与 TransactionStatus 的关系就像程序和进程的关系。
&emsp;&emsp;在Spring中，有个默认实现的TransactionDefinition。如果不满足需求，可以自己实现接口。
&emsp;&emsp;spring中的PlatformTransactionManager主要定义了事务操作。该接口的定义的主要方法有：
```java
Public interface PlatformTransactionManager{
  TransactionStatus getTransaction(TransactionDefinition definition)
   throws TransactionException;
   void commit(TransactionStatus status)throws TransactionException;
   void rollback(TransactionStatus status)throws TransactionException;
}
```
&emsp;&emsp;根据底层所使用的不同的持久化 API 或框架，PlatformTransactionManager 的主要实现类大致如下：
* DataSourceTransactionManager：适用于使用JDBC和iBatis进行数据持久化操作的情况。
* HibernateTransactionManager：适用于使用Hibernate进行数据持久化操作的情况。
* JpaTransactionManager：适用于使用JPA进行数据持久化操作的情况。
另外还有JtaTransactionManager 、JdoTransactionManager、JmsTransactionManager等等。

##### 编程式事务管理
首先需要spring的事务管理的jar包spring-tx.jar
其次，我们需要transactionManager和transactionDefinition。通过将transactionDefinition交给transactionManager管理，并由transactionManager得到transactionStatus。然后执行sql的操作。最后调用transactionManager的commit(transactionStatus status)方法提交。如果出现错误要回滚，那么就调用transactionManager的rollback(transactionStatus status)方法。

```java
public class StudentJdbcTemplate implements studentDao {
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplateObject;
	private PlatformTransactionManager txManager;

	@Override
	public void setDataSource(DataSource ds) {
		// TODO Auto-generated method stub
		this.dataSource = ds;
		this.jdbcTemplateObject = new JdbcTemplate(dataSource);

	}

	public void setTxManager(PlatformTransactionManager txManager) {
		this.txManager = txManager;
	}

	@Override
	public void create(String name, Integer age) {
		// 加入事务管理
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = txManager.getTransaction(def);
		try {
			String SQL = "insert into student (name, age) values (?, ?)";
			jdbcTemplateObject.update(SQL, name, age);
			System.out.println("Created Record Name = " + name + " Age = " + age);
			txManager.commit(status);
		} catch (Exception e) {
			System.out.println("Error in creating record, rolling back");
			txManager.rollback(status);
		}
		return;
	}
}
```

```xml
<!-- 配置beans文件 -->
<bean id="studentJDBCTemplate" class="com.xixi.dao.StudentJdbcTemplate">
		<property name="dataSource" ref="dataSource" />
		<property name="txManager" ref="transactionManager"></property>
	</bean>
	<bean id="transactionManager" 
      class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
      <property name="dataSource"  ref="dataSource" />    
   </bean>
```

##### 编程式事务管理2
如上所说的编程式事务管理的代码散落在业务逻辑代码中，破坏了原有代码的条理性，并且每一个业务方法都包含了类似的启动事务、提交/回滚事务的样板代码。幸好，Spring 也意识到了这些，并提供了简化的方法，这就是 Spring 在数据访问层非常常见的模板回调模式。示例代码如下：

```java
@Override
	public void update(Integer id, Integer age) {
		/*
		 * String SQL = "update student set age = ? where id = ?";
		 * jdbcTemplateObject.update(SQL, age, id);
		 * System.out.println("Updated Record with ID = " + id); return;
		 */
		TransactionTemplate template = new TransactionTemplate();
		template.setTransactionManager(txManager);
		Boolean flag = template.execute(new TransactionCallback<Boolean>() {

			@Override
			public Boolean doInTransaction(TransactionStatus status) {
				boolean tempflag = false;
				try {
					String SQL = "update student set age = ? where id = ?";
					jdbcTemplateObject.update(SQL, age, id);
					System.out.println("Updated Record with ID = " + id);
					tempflag = true;
				} catch (Exception e) {
					status.setRollbackOnly();
					System.out.println("Error!");
				}
				return tempflag;
			}
		});
	}
```

##### 声明式事务管理
**Spring 的声明式事务管理在底层是建立在 `AOP` 的基础之上的。其本质是对方法前后进行拦截，然后在目标方法开始之前创建或者加入一个事务，在执行完目标方法之后根据执行情况提交或者回滚事务。**
首先介绍的是基于<tx>命名空间的声明式事务管理
```xml
<!-- 声明式事务管理 1.首先添加校验xmlns:tx和xmlns:aop -->
	<tx:advice id="txAdvice" transaction-manager="transactionManager">
		<tx:attributes>
			<tx:method name="delete" propagation="REQUIRED" />
		</tx:attributes>
	</tx:advice>
	<aop:config>
		<aop:pointcut
			expression="execution(* com.xixi.dao.StudentJdbcTemplate.delete(..))"
			id="deleteOperation" />
		<aop:advisor advice-ref="txAdvice" pointcut-ref="deleteOperation" />
	</aop:config>
```

其次介绍一样通过注解的声明式事务管理
```java
@Transactional(propagation = Propagation.REQUIRED)
```
别忘了启用注解
```xml
<tx:annotation-driven transaction-manager="transactionManager"/>
```