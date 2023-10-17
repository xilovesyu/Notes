### **前言**

javascript 中的Date可谓是奇葩。所以为了避免在不经意间错误使用，把一些常见的坑以及比较好的实践方式记录下来。

---
### **时间格式**
<br/>

#### UTC,Z和GMT
<br/>

其实这三者都表示0时区的时间。一般我们JS中使用的是ISO 8601标准格式。它的格式如下：

```
// ISO 8601 Extended format
`YYYY-MM-DDTHH:mm:ss:sssZ`
```
---
### **Date使用**
<br/>

JS中Date构造函数有四种类型。

1. 不传参数

如果是不传任何参数的话，那么就是返回当前的**本地**时间。例子中是北京时间的13：16分

```javascript
new Date()
//Wed Mar 09 2022 13:16:10 GMT+0800 (中国标准时间)
```

2.传时间戳 

传时间戳的话也是返回当前时间戳的**本地**时间

```javascript
const timeStamp = new Date().getTime()
new Date(timeStamp)
//Wed Mar 09 2022 13:21:21 GMT+0800 (中国标准时间)
```

3.传字符串

传字符串的话需要特别注意时区问题。同时我们这里也只是讨论传的是符合ISO 8601格式的字符串。

如果是只传年月日的话，那么有两种区别，看以下例子：

```javascript
//UTC时间的0点 -> 北京时间的8点
const constructor3_1 = new Date("2022-03-10");
//北京时间的0点
const constructor3_2 = new Date("2022-3-10");
// constructor3_1
// Thu Mar 10 2022 08:00:00 GMT+0800 (中国标准时间)
// constructor3_2
// Thu Mar 10 2022 00:00:00 GMT+0800 (中国标准时间)
```

如果带时间，有带时区或者不带时区的区别。

```javascript
//北京时间的0点
const constructor3_3 = new Date("2022-03-10T00:00");
//UTC时间的0点 -> 北京时间的8点
const constructor3_4 = new Date("2022-03-10T00:00:00.000Z");
// constructor3_3
// Thu Mar 10 2022 00:00:00 GMT+0800 (中国标准时间)
// constructor3_4
// Thu Mar 10 2022 08:00:00 GMT+0800 (中国标准时间)
```

4.分别传年 ，月Index，日，时分秒毫秒

需要注意的是月是下标从0开始的。并且所有时间都是**本地**时间。

```javascript
//4. 分别 传年，月Index，日，时，分，秒，毫秒
const constructor4_1 = new Date(2022, 2, 10);

const constructor4_2 = new Date(2022, 2, 10, 0, 0, 0, 0);

//constructor4_1
// Thu Mar 10 2022 00:00:00 GMT+0800 (中国标准时间)
// constructor4_2
// Thu Mar 10 2022 00:00:00 GMT+0800 (中国标准时间)
```