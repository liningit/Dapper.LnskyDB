# 不分库分表

## 数据库函数
`DBFunction.Function`表示数据库函数如:
```csharp
var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => DBFunction.Function<DateTime>("ISNULL", m.UpdateDate, DateTime.Now) > new DateTime(2019, 6, 26));
```