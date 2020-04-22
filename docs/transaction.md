# 数据库事务

v3.1版本支持数据库事务了
## 普通调用方法
调用方法如下 
须通过'DBTool.BeginTransaction()'开启事务调用'tran.Complete()'提交事务,不调用'tran.Complete()'当using结束会自动回滚
<br>
- **注意'DBTool.BeginTransaction()'必须使用using**

```csharp
using (var tran = DBTool.BeginTransaction())
{
	var repository = GetRepository();           
	var deleteCount = repository.Delete(m => m.DataSource == "测试来源批量修改");
	tran.Complete();
}
```
## 事务嵌套调用
事务支持嵌套,当嵌套时只有调用最外层的'tran.Complete()'才会提交事务.
```csharp
using (var tran = DBTool.BeginTransaction())
{
	using (var tran2 = DBTool.BeginTransaction())
	{
		var repository = GetRepository();           
		var deleteCount = repository.Delete(m => m.DataSource == "测试来源批量修改");
		//下面这句话并不会提交事务
		tran2.Complete();
	}
	//下面这句话会提交事务
	tran.Complete();
}
```