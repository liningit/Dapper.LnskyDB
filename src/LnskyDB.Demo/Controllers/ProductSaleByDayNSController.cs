
using LnskyDB.Demo.Entity.Data;
using LnskyDB.Demo.Entity.Purify;
using LnskyDB.Demo.Repository.Data;
using LnskyDB.Demo.Repository.Purify;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;

namespace LnskyDB.Demo.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ProductSaleByDayNSController : ControllerBase
    {
        static int i = 0;
        private static IRepository<ProductSaleByDayNSEntity> GetRepository()
        {
            i++;
            if (i % 2 == 0)
            {
                //可以通过工厂创建
                return RepositoryFactory.Create<ProductSaleByDayNSEntity>();
            }
            else
            {
                //也可以继承实例化
                return new ProductSaleByDayNSRepository();
            }
        }
        // GET http://localhost:53277/ProductSaleByDayNS/Get

        [HttpGet]
        public ActionResult<ProductSaleByDayNSEntity> Get(Guid sysNo)
        {

            var repository = GetRepository();
            var entity = repository.Get(new ProductSaleByDayNSEntity
            {
                SysNo = sysNo
            });
            if (entity == null)
            {
                return new ProductSaleByDayNSEntity();
            }
            return entity;
        }
        [HttpGet]
        public ActionResult<List<ShopEntity>> GetShopList()
        {

            var lst = new ShopRepository().GetList(m => m.ShopName == null && m.IsDelete == true);
            return lst;
        }
        // GET http://localhost:53277/ProductSaleByDayNS/GetList
        [HttpGet]
        public ActionResult<List<ProductSaleByDayNSEntity>> GetList()
        {

            var repository = GetRepository();

            var lst = repository.GetList(m => true && m.Sales >= 0 && m.DataSource != "");

            return lst;
        }
        //GET http://localhost:53277/ProductSaleByDayNS/GetPaging
        [HttpGet]
        public ActionResult<Paging<ProductSaleByDayNSEntity>> GetPaging()
        {

            var stTime = new DateTime(2019, 1, 15);
            var endTime = new DateTime(2019, 2, 11);
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => DBFunction.Function<DateTime>("ISNULL", m.UpdateDate, DateTime.Now) > new DateTime(2019, 6, 26));

            query.OrderByDescing(m => m.StatisticalDate);
            query.OrderByDescing(m => m.Sales + 1);
            query.StarSize = 0;
            query.Rows = 10;
            var paging = repository.GetPaging(query);
            var count = paging.TotalCount;
            var lst = paging.ToList();//或者paging.Items
            return paging;
        }

        // Get http://localhost:53277/ProductSaleByDayNS/Add
        [HttpGet]
        public void Add()
        {
            var addEntity = new ProductSaleByDayNSEntity()
            {
                SysNo = Guid.NewGuid(),
                DataSource = "新增测试来源",
                ProductID = Guid.NewGuid(),
                ShopID = Guid.NewGuid(),
                ProductName = "测试商品",
                OutProductID = Guid.NewGuid().ToString(),
                ImportGroupId = Guid.NewGuid(),
                StatisticalDate = DateTime.Now
            };
            var repository = GetRepository();
            //如果新增主键是自增列会自动赋值自增列值到主键
            repository.Add(addEntity);
        }
        //http://localhost:53277/ProductSaleByDayNS/Update
        [HttpGet]
        public bool Update()
        {
            var updateEntity = new ProductSaleByDayNSEntity()
            {
                SysNo = Guid.Parse("650BC09C-2B9C-467B-A457-8B4853CC1F0F"),
                DataSource = "测试来源修改",
                StatisticalDate = new DateTime(2019, 01, 05),
            };
            var repository = GetRepository();
            //根据主键更新其他字段
            return repository.Update(updateEntity);
        }
        //http://localhost:53277/ProductSaleByDayNS/UpdateWhere
        [HttpGet]
        public int UpdateWhere()
        {
            var updateEntity = new ProductSaleByDayNSEntity()
            {
                DataSource = "测试来源修改",

            };
            var repository = GetRepository();
            var where = QueryFactory.Create<ProductSaleByDayNSEntity>(m => m.DataSource == "新增测试来源" && m.StatisticalDate > new DateTime(2019, 01, 03));//where是更新条件

            return repository.Update(updateEntity, where);
        }
        // http://localhost:53277/ProductSaleByDayNS/Delete
        [HttpGet]
        public bool Delete()
        {

            var deleteEntity = new ProductSaleByDayNSEntity()
            {
                SysNo = Guid.Parse("650BC09C-2B9C-467B-A457-8B4853CC1F0F")
            };
            var repository = GetRepository();
            return repository.Delete(deleteEntity);
        }

        //http://localhost:53277/ProductSaleByDayNS/DleteWhere
        [HttpGet]
        public int DleteWhere(string shopName, DateTime shuffledTempDate, string dataSource)
        {

            var repository = GetRepository();
            var where = QueryFactory.Create<ProductSaleByDayNSEntity>();
            //QueryiSearch方法表示搜索里面空格表示或+表示且
            //如 导入+手工 自动+生成 表示字段必须同时拥有导入和手工或者自动和生成
            //生成sql是 and ((DataSource like '%导入%' and DataSource like '%手工%') or DataSource like '%自动%' and DataSource like '%生成%')            
            where.QueryiSearch(m => m.DataSource, "新 修改");
            //注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
            return repository.Delete(where);
        }
        //GET http://localhost:53277/ProductSaleByDayNS/Select
        [HttpGet]
        public ActionResult<Paging<ProductSaleByDayNSEntity>> Select()
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => DBFunction.Function<DateTime>("ISNULL", m.UpdateDate, DateTime.Now) > new DateTime(2019, 6, 26));
            query.OrderBy(m => m.Sales + 1 + m.NumberOfSales);
            query.OrderByDescing(m => m.ShopID);
            query.StarSize = 10;
            query.Rows = 4;
            //var res1 = query.Select(m => m);
            //var lst1 = repository.GetPaging(res1);
            var res2 = query.Select(m => m.SysNo);
            //var lst2 = repository.GetPaging(res2);
            //var res3 = query.Select(m => m.Sales + m.AveragePrice + 2);
            //var lst3 = repository.GetPaging(res3);

            var q = QueryFactory.Create<ProductSaleByDayNSEntity>();
            q.And(m => m.Sales > 0);
            q.And(m => res2.Contains(m.SysNo));

            var lst4 = repository.GetPaging(q);
            return lst4;

        }
        //GET http://localhost:53277/ProductSaleByDayNS/GetJoinPaging
        [HttpGet]
        public ActionResult<object> GetJoinPaging()
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => DBFunction.Function<DateTime>("ISNULL", m.UpdateDate, DateTime.Now) > new DateTime(2019, 6, 26));
            var jq = query.InnerJoin(QueryFactory.Create<ShopEntity>(), m => m.ShopID, m => m.SysNo, (x, y) => new { Sale = x, Shop = y });
            jq.And(m => m.Shop.ShopName.Contains("店铺"));
        
            jq.StarSize = 10;
            jq.Rows = 5; 
            //也可以下面这样返回dto.第二个参数表示第一个表是否要查询所有列.
            var res2 = jq.Select(m => new  { SysNo = m.Sale.SysNo, BrandID = m.Sale.BrandID }, false);
            var paging2 = repository.GetPaging(res2);
    
            return paging2;
        }
        //GET http://localhost:53277/ProductSaleByDayNS/GetJoinPaging2
        [HttpGet]
        public ActionResult<Paging<ProductSaleByDayNSEntity>> GetJoinPaging2()
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => DBFunction.Function<DateTime>("ISNULL", m.UpdateDate, DateTime.Now) > new DateTime(2019, 6, 26));
            var jq = query.InnerJoin(QueryFactory.Create<ShopEntity>(), m => m.ShopID, m => m.SysNo, (x, y) => x);
            jq.And(m => m.DataSource.Contains(""));
            jq.OrderByDescing(m => m.Sales + 1);
            jq.OrderBy(m => m.ProductName + m.OutProductID);
            jq.StarSize = 10;
            jq.Rows = 5;
            var res = jq.Select(m => m);
            var paging = repository.GetPaging(res);
            //也可以下面这样返回dto.第二个参数表示第一个表是否要查询所有列.
            var res2 = jq.Select(m => new PSDto { ShopName = m.ProductName }, true);
            var paging2 = repository.GetPaging(res2);
            var res3 = jq.Select(m => m.AveragePrice);
            var paging3 = repository.GetPaging(res3);
            var count = paging.TotalCount;
            var lst = paging.ToList();//或者paging.Items
            return paging;
        }
        [HttpGet]
        public void TestThread(string shopName, DateTime shuffledTempDate, string dataSource)
        {
            ThreadTool.QueueUserWorkItem(ThreadDo);
            ThreadTool.QueueUserWorkItem(ThreadDo);
            ThreadTool.QueueUserWorkItem(ThreadDo);
            ThreadTool.QueueUserWorkItem(ThreadDo);
            ThreadTool.QueueUserWorkItem(ThreadDo);
        }
        private static void ThreadDo()
        {
            var repository = GetRepository();
            for (int i = 0; i < 10; i++)
            {
                var stTime = DateTime.Now.Date.AddMonths(0 - i).AddDays(-3);

                var query = QueryFactory.Create<ProductSaleByDayNSEntity>();
                query.And(m => m.StatisticalDate >= stTime);
                query.And(m => m.StatisticalDate < stTime.AddDays(3));
                //分页查询必须有排序字段
                query.OrderByDescing(m => m.StatisticalDate);
                //分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
                var res = repository.GetList(query, stTime, stTime.AddDays(3));

            }
        }
    }
}
