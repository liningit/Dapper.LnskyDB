# LnskyDB

LnskyDB是基于Dapper的Lambda扩展,支持按时间分库分表,也可以自定义分库分表方法

在此非常感谢SkyChenSky其中lambda表达式的解析参考了他的开源项目

下面是用ProductSaleByDayEntity作为示例,其中StatisticalDate为分库分表字段,如果是对分库分表对象进行数据库操作则必须传入StatisticalDate或者设置DBModel_ShuffledTempDate指定是那个库和表

------------
#### 1. 查询
1.1 根据主键查询
```csharp
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
var entity = repositoryFactory.Get(new ProductSaleByDayEntity
{
    DBModel_ShuffledTempDate = new DateTime(2019, 01, 01),//这儿表示差19年1月的库和表
    SysNo = sysNo
});
```
1.2 根据where条件查询
```csharp
var stTime = new DateTime(2019, 1, 15);
var endTime = new DateTime(2019, 2, 11);
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName.Contains("测试"));
query.And(m => m.StatisticalDate >= stTime);
query.And(m => m.StatisticalDate < endTime.Date.AddDays(1));
query.OrderByDescing(m => m.StatisticalDate);//如果是查多个库表必须按分库分表的字段降序排列
query.StarSize = 20; //可以设置查询行数及开始行数
query.Rows = 10;
//分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
var lst = repositoryFactory.GetList(query, stTime, endTime);
```
如果可以确定统计时间也可以查指定的库表进行单表查询
```csharp
var stTime = new DateTime(2019, 1, 15);
var endTime = new DateTime(2019, 1, 18);
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName.Contains("测试"));
query.And(m => m.StatisticalDate >= stTime);
query.And(m => m.StatisticalDate < endTime.Date.AddDays(1));
query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 01);//这儿表示查19年1月的库和表
query.OrderByDescing(m => m.StatisticalDate);//单表查询可以随意排序
query.StarSize = 20;
query.Rows = 10;
var lst= repositoryFactory.GetList(query);
```
1.3 分页查询
```csharp
var stTime = new DateTime(2019, 1, 15);
var endTime = new DateTime(2019, 2, 11);
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName.Contains("测试"));
query.And(m => m.StatisticalDate >= stTime);
query.And(m => m.StatisticalDate < endTime.Date.AddDays(1));
query.OrderByDescing(m => m.StatisticalDate);//如果是查多个库表必须按分库分表的字段降序排列
query.StarSize = 20;
query.Rows = 10;
//分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
var paging = repositoryFactory.GetPaging(query, stTime, endTime);
var count = paging.TotalCount;
var lst = paging.ToList();//或者paging.Items
```
如果可以确定统计时间也可以查指定的库表
```csharp
var stTime = new DateTime(2019, 1, 15);
var endTime = new DateTime(2019, 1, 18);
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName.Contains("测试"));
query.And(m => m.StatisticalDate >= stTime);
query.And(m => m.StatisticalDate < endTime.Date.AddDays(1));
query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 01);//这儿表示查19年1月的库和表
query.OrderByDescing(m => m.StatisticalDate);//单表查询可以随意排序
query.StarSize = 20;
query.Rows = 10;
var paging= repositoryFactory.GetPaging(query);
var count = paging.TotalCount;
var lst = paging.ToList();//或者paging.Items
```
#### 2. 添加
```csharp
var addEntity = new ProductSaleByDayEntity()
{
    SysNo = Guid.NewGuid(),
    DataSource = "测试来源",
    ProductID = Guid.NewGuid(),               
    ShopID = Guid.NewGuid(),
    ShopName = "测试店铺",
    ProductName = "测试商品",
    OutProductID = Guid.NewGuid().ToString(),
    ImportGroupId = Guid.NewGuid(),
    StatisticalDate = DateTime.Now//分库分表字段是必须的
};
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
//如果新增主键是自增列会自动赋值自增列值到主键
repositoryFactory.Add(addEntity);
```
#### 3. 更新
3.1 根据主键更新
```csharp
var updateEntity = new ProductSaleByDayEntity()
{
    SysNo = Guid.Parse("650BC09C-2B9C-467B-A457-8B4853CC1F0F"),
    DataSource = "测试来源修改",
    ShopName = "店铺修改",
    StatisticalDate = new DateTime(2019,01,05),//如果StatisticalDate赋值了则根据StatisticalDate找库表,然后根据主键更新,StatisticalDate也会被更新成所赋的值
    //如果不想更新StatisticalDate可以用下面这句话
    // DBModel_ShuffledTempDate=new DateTime(2019,01,05),//如果不想更新StatisticalDate字段则用这句话来确定是那个库及表
};
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
//根据主键更新其他字段
return repositoryFactory.Update(updateEntity);
```
3.2 根据where条件更新
```csharp
var updateEntity = new ProductSaleByDayEntity()
{
    DataSource = "测试来源修改",
    ShopName = "店铺修改Where",
    DBModel_ShuffledTempDate = new DateTime(2019, 01, 05),//如果用这句话来确定是那个库表
    // StatisticalDate = statisticalDate,//如果要更新StatisticalDate则可以用这句话替代上面那句话
};
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
var where = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName == "测试店铺1" && m.StatisticalDate > new DateTime(2019, 01, 03));//where是更新条件
//注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
return repositoryFactory.Update(updateEntity, where);
```
#### 4. 删除
3.1 根据主键删除
```csharp
var deleteEntity = new ProductSaleByDayEntity()
{
    SysNo = Guid.Parse("650BC09C-2B9C-467B-A457-8B4853CC1F0F"),
    DBModel_ShuffledTempDate = new DateTime(2019, 01, 05),//对于分库分表来说DBModel_ShuffledTempDate是必须的用来确认是那个库表
};
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
return repositoryFactory.Delete(deleteEntity);
```
3.1 根据where条件删除
```csharp
var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
var where = QueryFactory.Create<ProductSaleByDayEntity>();
where.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 01);
//QueryiSearch方法表示搜索里面空格表示或+表示且
//如 导入+手工 自动+生成 表示字段必须同时拥有导入和手工或者自动和生成
//生成sql是 and ((DataSource like '%导入%' and DataSource like '%手工%') or DataSource like '%自动%' and DataSource like '%生成%')            
where.QueryiSearch(m => m.DataSource, "新+更");
where.QueryiSearch(m => m.ShopName, "批量修改");
//注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
return repositoryFactory.Delete(where);
```
#### 5. 多线程处理
对于mvc每次请求都会在请求结束时将数据库连接关闭,如果是新建线程则需要在线程开始调用`DBTool.BeginThread();`
并且在线程结束为止调用`DBTool.CloseConnections();`关闭连接
```csharp
public class ThreadTool
{
    public static void QueueUserWorkItem(Action action)
    {
        ThreadPool.QueueUserWorkItem(delegate
        {
            DBTool.BeginThread();
            try
            {
                action();
            }
            finally
            {
                DBTool.CloseConnections();
            }
        });
    }
}
ThreadTool.QueueUserWorkItem(ThreadDo);//调用
```
#### 6. 实体类T4自动生成
在[LnskyDB.Demo\T4](https://github.com/liningit/LnskyDB/tree/master/src/LnskyDB.Demo/T4 "LnskyDB.Demo\T4")中有可以自动生成实体类的T4模版.
其中DbHelper.ttinclude中的Config是配置数据库的
Entity.tt是生成实体的T4模版.大家可以根据自己的情况修改
