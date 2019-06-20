# 基础介绍
## 仓储
仓储的获取有两种方式一种是调用`RepositoryFactory.Create<T>()`方法创建,还有一种是创建仓储类继承`Repository<T>`.如果需要接口也可以创建接口继承`IRepository<T>`.
仓储中的`CommandTimeout`可以设置查询超时时间

## 实体类
创建实体类需继承`BaseDBModel`,并且实现里面的抽象方法

### 1.主键配置
`GetDBModel_PKCols()`返回表的主键名称,必须. 示例:
```csharp
private static ImmutableList<string> _DBModel_PKCols = ImmutableList.Create("SysNo");
public override ImmutableList<string> GetDBModel_PKCols() => _DBModel_PKCols; 
```
### 2.自增列配置
`GetDBModel_IncrementCol();` `SetIncrementValue(int value)`返回表的自增列,以及设置自增列值,如有自增列则必须. 示例:
```csharp
public override string GetDBModel_IncrementCol() => "Id";
public override void SetIncrementValue(int value)
{
    Id = value;
}
```
### 3.库名表名配置
`GetDBModel_TableName()` `GetDBModel_DBName()`返回表名及库名,必须.如果是分库分表则后面待{0}.示例:
```csharp
public override string GetDBModel_TableName() => "Purify_ProductSaleByDay{0}";
public override string GetDBModel_DBName() => "Lnsky{0}";
```
### 4.分库分表配置
GetShuffledModel()` SetShuffledData(object obj)`返回分库分表对象,及实现设置分库分表值.示例:
```csharp
public override ShuffledModel GetShuffledModel()
{
    if (DBModel_ShuffledTempDate == DateTime.MinValue)
    {
        throw new NoShuffledException(GetDBModel_TableName(), "分库分表时间,ShuffledTempDate");
    }
    return ShuffledByDbTable(DBModel_ShuffledTempDate);
}
DateTime _DBModel_ShuffledTempDate;
[JsonIgnore]
public DateTime DBModel_ShuffledTempDate { get { return StatisticalDate != DateTime.MinValue ? StatisticalDate : _DBModel_ShuffledTempDate; } set { _DBModel_ShuffledTempDate = value; } }

public override void SetShuffledData(object obj) { DBModel_ShuffledTempDate = (DateTime)obj; }
```
## T4模版生成
项目'LnskyDB.Demo'中的T4目录下有T4自动生成实体类的代码.大家可以根据自己的实际情况进行修改配置
'DbHelper.ttinclude'中的'Config.DbConfigs'是用来编写生成配置的
1. ConnectionString表示连接字符串
1. Database是表示数据库实际名称
1. DatabaseName是表示存储在'appsettings.json'中的名称
1. TableNames表示要生成那些表*表示全部Name_*表示前缀是Name_的
1. ExcludeTableName表示要排除那些表
1. ShuffledConfigs表示分库分表配置存储表名,ShuffledConfig的键值对形式
1. ShuffledConfig分库分表具体配置ShuffledData根据那一列分库分表,MinShuffledTempDate表示最小值

'Entity.tt'是生成实体,仓储及仓储接口的实际代码.大家可以根据自己项目的实际情况修改