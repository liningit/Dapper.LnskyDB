using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Common.Tool;
using LnskyDB.Demo.Entity.Purify;
using Microsoft.AspNetCore.Mvc;

namespace LnskyDB.Demo.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class ProductSaleByDayController : ControllerBase
    {
        // GET http://localhost:53277/ProductSaleByDay/Get?sysNo=2d0c6662-9670-4c52-a4e1-02c37681e7e9
        [HttpGet]
        public ActionResult<ProductSaleByDayEntity> Get(Guid sysNo)
        {

            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            var entity = repositoryFactory.Get(new ProductSaleByDayEntity
            {
                DBModel_ShuffledTempDate = new DateTime(2019, 01, 01),//这儿表示差19年1月的库和表
                SysNo = sysNo
            });
            if (entity == null)
            {
                return new ProductSaleByDayEntity();
            }
            return entity;
        }

        // GET http://localhost:53277/ProductSaleByDay/GetList?shopName=1&stTime=2019-01-01&endTime=2019-09-05
        [HttpGet]
        public ActionResult<List<ProductSaleByDayEntity>> GetList(string shopName, DateTime? stTime, DateTime? endTime)
        {
            if (stTime == null)
            {
                stTime = ProductSaleByDayEntity.MinShuffledTempDate;//最小时间
            }
            if (endTime == null)
            {
                endTime = DateTime.Now.Date.AddDays(1 - DateTime.Now.Day).AddMonths(1).AddDays(-1);
            }
            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName.Contains(shopName));

            query.And(m => m.StatisticalDate >= stTime);
            query.And(m => m.StatisticalDate < endTime.Value.Date.AddDays(1));
            // query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 01);//这儿表示查19年1月的库和表
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = 20;
            query.Rows = 10;
            //分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
            return repositoryFactory.GetList(query, stTime.Value, endTime.Value);
        }
        //GET http://localhost:53277/ProductSaleByDay/GetPaging?shopName=1&stTime=2019-01-01&endTime=2019-03-11&page=2&pageSize=3
        [HttpGet]
        public ActionResult<object> GetPaging(string shopName, DateTime? stTime, DateTime? endTime, int page = 1, int pageSize = 10)
        {

            if (stTime == null)
            {
                stTime = ProductSaleByDayEntity.MinShuffledTempDate;//最小时间
            }
            if (endTime == null)
            {
                endTime = DateTime.Now.Date.AddDays(1 - DateTime.Now.Day).AddMonths(1).AddDays(-1);
            }
            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName.Contains(shopName));
            query.StarSize = (page - 1) * pageSize;
            query.Rows = pageSize;
            query.And(m => m.StatisticalDate >= stTime);
            query.And(m => m.StatisticalDate < endTime.Value.Date.AddDays(1));
            // query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 01);//这儿表示差19年1月的库和表
            //分页查询必须有排序字段
            query.OrderByDescing(m => m.StatisticalDate);
            //分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
            var res = repositoryFactory.GetPaging(query, stTime.Value, endTime.Value);
            return new { res.TotalCount, List = res.ToList() };
        }

        // Get http://localhost:53277/ProductSaleByDay/Add?shopName=增加2&StatisticalDate=2019-01-01&dataSource=测试用
        [HttpGet]
        public void Add(string shopName, DateTime statisticalDate, string dataSource)
        {
            var addEntity = new ProductSaleByDayEntity()
            {
                SysNo = Guid.NewGuid(),
                DataSource = dataSource,
                ProductID = Guid.NewGuid(),
                ShopID = Guid.NewGuid(),
                ShopName = shopName,
                ProductName = "",
                OutProductID = Guid.NewGuid().ToString(),
                ImportGroupId = Guid.NewGuid(),
                StatisticalDate = statisticalDate
            };
            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            //如果新增主键是自增列会自动赋值自增列值到主键
            repositoryFactory.Add(addEntity);
        }
        //http://localhost:53277/ProductSaleByDay/Update?sysNo=650BC09C-2B9C-467B-A457-8B4853CC1F0F&shopName=修改&statisticalDate=2019-01-01&dataSource=修改测试用
        [HttpGet]
        public bool Update(Guid sysNo, string shopName, DateTime statisticalDate, string dataSource)
        {
            var updateEntity = new ProductSaleByDayEntity()
            {
                SysNo = sysNo,
                DataSource = dataSource,
                ShopName = shopName,
                StatisticalDate = statisticalDate,//对于分库分表来说StatisticalDate是必须的
                // DBModel_ShuffledTempDate=statisticalDate,//如果不想更新StatisticalDate字段则用这句话来确定是那个库及表
            };
            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            //根据主键更新其他字段
            return repositoryFactory.Update(updateEntity);
        }

        // http://localhost:53277/ProductSaleByDay/Delete?sysNo=5119AC4F-FA2F-470F-8144-0069B45E15CF&statisticalDate=2019-01-01
        [HttpGet]
        public bool Delete(Guid sysNo, DateTime statisticalDate)
        {

            var deleteEntity = new ProductSaleByDayEntity()
            {
                SysNo = sysNo,
                DBModel_ShuffledTempDate = statisticalDate,//对于分库分表来说DBModel_ShuffledTempDate是必须的用来确认是那个库表
            };
            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            return repositoryFactory.Delete(deleteEntity);
        }
        //http://localhost:53277/ProductSaleByDay/UpdateWhere?shopName=批量修改&shuffledTempDate=2019-02-02&dataSource=更新
        [HttpGet]
        public int UpdateWhere(string shopName, DateTime shuffledTempDate, string dataSource)
        {
            var updateEntity = new ProductSaleByDayEntity()
            {
                DataSource = dataSource,
                ShopName = shopName,
                DBModel_ShuffledTempDate = shuffledTempDate,//如果用这句话来确定是那个库及表
                // StatisticalDate = statisticalDate,//如果要更新StatisticalDate则可以用这句话替代上面那句话
            };
            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            var where = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName == "测试店铺1");//where是更新条件
            //注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
            return repositoryFactory.Update(updateEntity, where);
        }
        //http://localhost:53277/ProductSaleByDay/DleteWhere?shopName=批量修改&shuffledTempDate=2019-02-02&dataSource=新+更
        [HttpGet]
        public int DleteWhere(string shopName, DateTime shuffledTempDate, string dataSource)
        {

            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            var where = QueryFactory.Create<ProductSaleByDayEntity>();
            where.DBModel.DBModel_ShuffledTempDate = shuffledTempDate;
            //QueryiSearch方法表示搜索里面空格表示或+表示且
            //如 导入+手工 自动+生成 表示字段必须同时拥有导入和手工或者自动和生成
            //生成sql是 and ((DataSource like '%导入%' and DataSource like '%手工%') or DataSource like '%自动%' and DataSource like '%生成%')            
            where.QueryiSearch(m => m.DataSource, dataSource);
            where.QueryiSearch(m => m.ShopName, shopName);
            //注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
            return repositoryFactory.Delete(where);
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
            var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
            for (int i = 0; i < 10; i++)
            {
                var stTime = DateTime.Now.Date.AddMonths(0 - i).AddDays(-3);

                var query = QueryFactory.Create<ProductSaleByDayEntity>();
                query.And(m => m.StatisticalDate >= stTime);
                query.And(m => m.StatisticalDate < stTime.AddDays(3));
                // query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 01);//这儿表示差19年1月的库和表
                //分页查询必须有排序字段
                query.OrderByDescing(m => m.StatisticalDate);
                //分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
                var res = repositoryFactory.GetList(query, stTime, stTime.AddDays(3));

            }
        }
    }
}
