# 连表查询

v2.0版本支持多表查询了
步骤如下
1. 调用方法是通过`IQuery.OuterJoin`或者`IQuery.InnerJoin`进行连表查询,返回IJoinQuery对象. 
1. 可以调用`IJoinQuery.And,Or`进行条件过滤.调用`Select`返回`ISelectResult`. 
1. 通过仓储的`GetList`或`GetPaging`进行返回结果. 
```csharp
 var repository = GetRepository();
var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => DBFunction.Function<DateTime>("ISNULL", m.UpdateDate, DateTime.Now) > new DateTime(2019, 6, 26));
var jq = query.InnerJoin(QueryFactory.Create<ShopEntity>(), m => m.ShopID, m => m.SysNo, (x, y) => new { Sale = x, Shop = y });
jq.And(m => m.Shop.ShopName.Contains("店铺"));
jq.OrderByDescing(m => m.Sale.Sales + 1);
jq.OrderBy(m => m.Sale.ProductName + m.Sale.OutProductID);
jq.StarSize = 10;
jq.Rows = 5;
var res = jq.Select(m => m.Sale);
var paging = repository.GetPaging(res);
//也可以下面这样返回dto.第二个参数表示第一个表是否要查询所有列.
var res2 = jq.Select(m => new PSDto { ShopName = m.Shop.ShopName }, true);
var paging2 = repository.GetPaging(res2);
var count = paging.TotalCount;
var lst = paging.ToList();//或者paging.Items
```