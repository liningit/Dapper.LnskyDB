# 高级操作

## 数据库函数
`DBFunction.Function`表示数据库函数如:
```csharp
var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => DBFunction.Function<DateTime>("ISNULL", m.UpdateDate, DateTime.Now) > new DateTime(2019, 6, 26));
```

## 自定义分库分表
只需修改实体类里面的'public override ShuffledModel GetShuffledModel()'方法返回'ShuffledModel'即可.
ShuffledModel包含两个属性分表表示分库分表
如下是不分库按年月分表:
```csharp
	public override ShuffledModel GetShuffledModel()
        {
            if (DBModel_ShuffledTempDate == DateTime.MinValue)
            {
                throw new NoShuffledException(GetDBModel_TableName(), "分库分表时间,ShuffledTempDate");
            }
            return new ShuffledModel("", "_" + DBModel_ShuffledTempDate.Year.ToString().Substring(2) + "_" + DBModel_ShuffledTempDate.Month.ToString("00"));

        }
```