# 不分库分表

## 查询
1. 根据主键查询
```csharp
var repository = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
var entity = repository.Get(new ProductSaleByDayNSEntity
{
    SysNo = sysNo
});
```
1. 根据where条件查询
```csharp
var stTime = new DateTime(2019, 1, 15);
var endTime = new DateTime(2019, 2, 11);
var repository = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => m.ShopName.Contains("测试"));
query.And(m => m.StatisticalDate >= stTime && m.StatisticalDate < endTime.Date.AddDays(1));
query.OrderByDescing(m => m.StatisticalDate);
query.StarSize = 20; //可以设置查询行数及开始行数
query.Rows = 10;
var lst = repository.GetList(query);
```
1. 分页查询
```csharp
var stTime = new DateTime(2019, 1, 15);
var endTime = new DateTime(2019, 2, 11);
var repository = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => m.ShopName.Contains("测试"));
query.And(m => m.StatisticalDate >= stTime);
query.And(m => m.StatisticalDate < endTime.Date.AddDays(1));
query.OrderByDescing(m => m.StatisticalDate);
query.StarSize = 20;
query.Rows = 10;
var paging = repository.GetPaging(query);
var count = paging.TotalCount;
var lst = paging.ToList();//或者paging.Items
```

## 添加
```csharp
var addEntity = new ProductSaleByDayNSEntity()
{
    SysNo = Guid.NewGuid(),
    DataSource = "测试来源",
    ProductID = Guid.NewGuid(),               
    ShopID = Guid.NewGuid(),
    ShopName = "测试店铺",
    ProductName = "测试商品",
    OutProductID = Guid.NewGuid().ToString(),
    ImportGroupId = Guid.NewGuid(),
    StatisticalDate = DateTime.Now
};
var repository = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
//如果新增主键是自增列会自动赋值自增列值到主键
repository.Add(addEntity);
```

## 更新
1. 根据主键更新
```csharp
var updateEntity = new ProductSaleByDayNSEntity()
{
    SysNo = Guid.Parse("650BC09C-2B9C-467B-A457-8B4853CC1F0F"),
    DataSource = "测试来源修改",
    ShopName = "店铺修改"
};
var repository = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
//根据主键更新其他字段
return repository.Update(updateEntity);
```
1. 根据where条件更新
```csharp
var updateEntity = new ProductSaleByDayNSEntity()
{
    DataSource = "测试来源修改",
    ShopName = "店铺修改Where",
    DBModel_ShuffledTempDate = new DateTime(2019, 01, 05),
};
var repository = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
var where = QueryFactory.Create<ProductSaleByDayNSEntity>(m => m.ShopName == "测试店铺1" && m.StatisticalDate > new DateTime(2019, 01, 03));//where是更新条件
return repository.Update(updateEntity, where);
```

## 删除
1. 根据主键删除
```csharp
var deleteEntity = new ProductSaleByDayNSEntity()
{
    SysNo = Guid.Parse("650BC09C-2B9C-467B-A457-8B4853CC1F0F")
};
var repository = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
return repository.Delete(deleteEntity);
```
1. 根据where条件删除
```csharp
var repository = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
var where = QueryFactory.Create<ProductSaleByDayNSEntity>();
//QueryiSearch方法表示搜索里面空格表示或+表示且
//如 导入+手工 自动+生成 表示字段必须同时拥有导入和手工或者自动和生成
//生成sql是 and ((DataSource like '%导入%' and DataSource like '%手工%') or DataSource like '%自动%' and DataSource like '%生成%')            
where.QueryiSearch(m => m.DataSource, "新+更");
where.QueryiSearch(m => m.ShopName, "批量修改");
//注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
return repository.Delete(where);
```