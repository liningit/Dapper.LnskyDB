# LnskyDB  [![GitHub stars](https://img.shields.io/github/stars/liningit/LnskyDB.svg?style=social&label=Star&)](https://github.com/liningit/LnskyDB/stargazers) [![GitHub forks](https://img.shields.io/github/forks/liningit/LnskyDB.svg?style=social&label=Fork&)](https://github.com/liningit/LnskyDB/fork)

LnskyDB是基于Dapper的Lambda扩展,支持按时间分库分表,也可以自定义分库分表方法.而且可以T4生成实体类免去手写实体类的烦恼.

文档地址: https://liningit.github.io/LnskyDB/

开源地址: https://github.com/liningit/LnskyDB

nuget地址: https://www.nuget.org/packages/LnskyDB/

在此非常感谢SkyChenSky其中lambda表达式的解析参考了他的开源项目

## 功能特点
- **Lambda表达式查询方便**<br>
  基于Dapper的Lambda表达式扩展可以方便的进行查询筛选操作

- **支持分库分表**<br>
  默认支持按年分库按月分表,也支持自定义分库分表.从此大数据不用愁

- **T4自动生成实体**<br>
  有T4模板自动生成实体类,再也不用手写那些烦人的实体类了.仓储类及接口也支持自动生成

- **使用门槛低,快速上手**<br>
  使用非常简单,可以快速上手

## 注意问题
本框架只支持单表的Lambda表达式查询,如果多表需要手写sql,框架支持根据sql查询修改等.
另外不太建议连表查询,推荐在逻辑层处理

## 开源协议
[MIT license.](https://github.com/liningit/LnskyDB/blob/master/LICENSE)

## 联系我们

我们需要知道你对LnskyDB的一些看法以及建议：

- Mail: lining_it@163.com，
- [**Issues**](https://github.com/liningit/LnskyDB/issues)
