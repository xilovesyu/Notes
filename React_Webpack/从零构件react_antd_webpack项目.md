需要的基础有nodejs，yarn命令，react和babel，webpack的相关知识。

### **首先init**

第一步我们要有自己的项目目录，利用

```shell
mkdir your_app_name
cd your_app_name
yarn init
```

### **安装react，react-dom 依赖**

这里我们的依赖安装在dependencies里面
```shell
yarn add react react-dom -S
```

### **安装 webpack, webpack-dev-server以及webpack-cli**

webpack主要用来模块化打包，，webpack-dev-server用来启动一个调试的环境，webpack-cli命令行工具（暂时没有用处），这里我们加到devDependencies
```shell
yarn add -D webpack  webpack-dev-server webpack-cli
```

### **安装babel相关依赖**

babel相关的依赖主要有
1.@babel/core [-D]
2.@babel/cli [-D] (不用命令行babel用不到)
3.@babel/preset-env [-D] 预设置， 设置支持的环境等
4.@babel/polyfill [-D] (垫片，用来支持新的es6 API等)
5.@babel/runtime [-S] 5和6加起来的作用和第四点一样，但是实现方式不一样
6.@babel/plugin-transform-runtime [-D] 5和6加起来的作用和第四点一样，但是实现方式不一样
7.@babel/preset-react [-D] 预设置，预设react的
8.@babel/plugin-proposal-decorators [-D] 预设置， 装饰器
9.@babel/plugin-proposal-class-properties [-D] 支持类的属性（？）
10.babel-loader [-D] webpack中用到的loader，

### **安装htmlWebPack插件**

用来支持webpack打包html文件的，在这之后的配置会用到的。如果用不着打包html文件，那这个plugin也用不着。

```shell
yarn add -D html-webpack-plugin
```

### **babel，webpack 以及 package.json的配置**

#### **babel配置**
首先看babel配置，babel配置主要在`.babelrc`文件中，主要分为两大类的配置，一类是plugins配置，一类是presets配置。
所以我们的配置文件可以首先这么写

```json
{
	"plugins": [],
	"presets": []
}
```

那么我们上面安装了preset-react，preset-env，所以我们要添加这两个preset配置到配置文件中

```json
{
    "plugins":[],
    "presets":[
        "@babel/preset-env",
        "@babel/preset-react"
    ]
}
```

紧接着是我们的plugins，我们安装的plugin主要有plugin-transform-runtime，plugin-proposal-decorators 以及plugin-proposal-class-properties。
这里我们对装饰器语法以及类属性进行配置。

```json
{
	"plugins": [
		[
			"@babel/plugin-proposal-decorators",
			{
				"legacy": true
			}
		],
       ["@babel/plugin-proposal-class-properties", { "loose": true }]
	],
	"presets": [
		"@babel/preset-env",
		"@babel/preset-react"
	]
}
```

#### **webpack配置**
webpack用来模块化构建的，可以将相互依赖的js模块都打包到一个js文件中。webpack的配置较为复杂，可以参照官方的文档进行查看。主要定义有以下几个方面。

1. entry 入口文件
2. output 导出到哪，文件名是什么
3. plugins 插件
4. module 定义模块，比如js，css，less等属于不同类型的文件
5. mode production or development
6. devServer 用来指定开发调试的server是什么。


首先我们定义我们的入口文件。在这之前我们在根目录新建src目录，用来存放我们的源文件。新建index.js用来表示我们的入口文件。新建index.html文件。文件的内容如下：

```javascript
import React from 'react';
import ReactDOM from 'react-dom';
ReactDOM.render(<div>just a test!</div>, document.getElementById('index'));
```

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>React、Webpack4 and Babel 7</title>
    </head>
    <body>
        <div id="index"></div>
    </body>
</html>
```

接下来我们的webpack配置文件可以这么写。在根目录新建webpack.config.js（如果不是这个名字的话，打包或调试的时候要加上你的配置文件名）。

```javascript
// 导入我们要用的工具 1是我们的html打包器 2是nodejs提供的功能用来访问文件及路径
const HtmlWebPackPlugin = require('html-webpack-plugin');
const path = require('path');

// 配置
module.exports={
    // 默认的entry为index.js，这里我们的entry为src/index.js
    entry: path.join(__dirname, 'src/index.js'),
    // output 的路径和文件名
    output: {
        // 保存到根目录的target目录下
        path: path.join(__dirname, 'target'),
        // 打包的文件名
        filename: 'bundle.js'
    },
    //插件,这里我们只是添加html的打包插件，其他插件还有优化插件，热更新插件等
    plugins:[
        new HtmlWebPackPlugin({
            template: './src/index.html',
            filename: './index.html'
        })
    ],
    // module 模块
    module:{
        // 一些匹配的规则,这里只给出js和jsx的规则
        rules:[
            {
                // 正则表达式
                test: /\.js[x]?$/,
                // 排除node_modules模块
                exclude: /node_modules/,
                // s使用babel loader
                use:{
                    loader: 'babel-loader'
                }
            },
            {
            }
        ]
    },
    // 配置开发的server
    devServer:{
        port: 3001
        // 其他有代理设置等server的一些设置
    },
    // 模式有developement和production两种
    mode: 'development'
}
```

#### **package.json文件的配置**

package.json 是yarn和npm主要存储的设置，主要有模块的一些定义信息，模块所用的依赖和一些脚本定义，这里我们主要添加的是一些可以用的脚本来方便操作。如下所示，我们在scripts里定义了两个操作，start和build，这里的命令具体内容可以是任何cli的命令。我这里的start就是开启调试并指定配置文件是webpack.config.js文件，build命令是打包文件并指定模式是production。

```json
{
	"name": "test2",
	"version": "1.0.0",
	"main": "index.js",
	"author": "jiaxiang.xi",
	"license": "MIT",
	"scripts": {
		"build": "webpack --mode production",
		"start": "webpack-dev-server --config webpack.config.js"
	},
	"dependencies": {
		"@babel/runtime": "^7.4.5",
		"mobx": "^5.10.1",
		"mobx-react": "^6.1.1",
		"react": "^16.8.6",
		"react-dom": "^16.8.6"
	},
	"devDependencies": {
		"@babel/cli": "^7.4.4",
		"@babel/core": "^7.4.5",
		"@babel/plugin-proposal-class-properties": "^7.4.4",
		"@babel/plugin-proposal-decorators": "^7.4.4",
		"@babel/plugin-transform-runtime": "^7.4.4",
		"@babel/preset-env": "^7.4.5",
		"@babel/preset-react": "^7.0.0",
		"babel-loader": "^8.0.6",
		"html-webpack-plugin": "^3.2.0",
		"webpack": "^4.35.0",
		"webpack-cli": "^3.3.5",
		"webpack-dev-server": "^3.7.2"
	}
}
```


### **增加typescript支持**
首先需在全局安装typescript，然后在你的目录下面运行tsc --init 之后一个tsconfig.json文件会被创建。

### **增加tslint**
首先安装tslint

```shell
yarn add -D tslint
```

然后在根目录下面新建tslint.json文件。
文件的一些规则可以找github上定义好的规则。

### **antd**

`yarn add antd`

解决样式问题

yarn add babel-plugin-import


添加antd的样式，这里我们添加了全局的样式。 首先在webpack中添加resovle

```javascript
// 引入node_modules中的antd
resolve: {
modules: ['node_modules', path.join(__dirname, './node_modules/antd')],
extensions: ['.ts', '.tsx', '.web.js', '.js', '.json', '.css', '.png', '.gif', '.svg'],
}
```

然后在index.less中引入antd 的样式

```css
@import "~antd/dist/antd.css";
```

最后在index.tsx中引入index.less样式

```javascript
import * as React from 'react'
import ReactDOM from 'react-dom'
import { App } from './component/App'
import './index.less'
ReactDOM.render(<App />, document.getElementById('index'))
```


之后还会遇到很多其他的配置以后在更新吧。
