using LnskyDB;
using LnskyDB.Test.MsSql.Entity.Data;
using LnskyDB.Test.MsSql.Entity.Purify;
using LnskyDB.Test.MsSql.Repository.Purify;
using Microsoft.Extensions.Configuration;
using NUnit.Framework;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Collections.Generic;
using System.IO;
using LnskyDB.Model;

namespace LnskyDB.Test
{
    public class MsSqlTest
    {

        public static object lockObj = new object();
        static List<string> lstDataSource = new List<string> { "测试来源1", "测试来源2", "来源自动生成" };

        static Dictionary<Guid, string> dicProduct = new Dictionary<Guid, string>();

        [SetUp]
        public void Setup()
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();
            DBTool.Configuration = configuration;
            DBTool.Error += DBTool_Error;
            InitDic(dicProduct, "测试商品", 10);
            DBTool.BeginThread();
            Index();
        }

        private void DBTool_Error(LnskyDB.Model.LnskyDBErrorArgs e)
        {
            Console.WriteLine(e.LogInfo);
        }

        private static void InitDic(Dictionary<Guid, string> dic, string namePre, int count)
        {
            for (int i = 1; i < count + 1; i++)
            {
                dic.Add(Guid.NewGuid(), namePre + i);
            }
        }
        public string Index()
        {
            if (isRuning == true)
            {
                return "正在运行中";
            }
            lock (lockObj)
            {

                isRuning = true;
                try
                {
                    using (var tran = DBTool.BeginTransaction())
                    {
                        var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
                        var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.CreateDate > DateTime.Now.Date);
                        query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 09, 01);
                        if (repositoryFactory.GetList(query).Count > 10)
                        {
                            return "";
                        }
                        var importGroupId = Guid.NewGuid();
                        var random = new Random();

                        var tempDate = new DateTime(2018, 1, 1);
                        while (tempDate <= new DateTime(2019, 12, 31))
                        {
                            if (tempDate.Day == 1)
                            {
                                query = QueryFactory.Create<ProductSaleByDayEntity>();
                                query.DBModel.DBModel_ShuffledTempDate = tempDate;
                                repositoryFactory.Delete(query);
                            }
                            foreach (var p in dicProduct)
                            {
                                var temp = new ProductSaleByDayEntity();

                                temp.SysNo = Guid.NewGuid();
                                temp.DataSource = lstDataSource[random.Next(lstDataSource.Count)];
                                temp.ShopName = "测试店铺";
                                temp.ProductID = p.Key;
                                temp.OutProductID = p.Value;
                                temp.ProductName = p.Value;
                                temp.Sales = random.Next(100000);
                                temp.StatisticalDate = tempDate;
                                temp.UpdateDate = temp.CreateDate = DateTime.Now;
                                temp.UpdateUserID = temp.CreateUserID = Guid.NewGuid();
                                temp.ImportGroupId = importGroupId;
                                repositoryFactory.Add(temp);

                            }
                            tempDate = tempDate.AddDays(1);
                        }
                        tran.Complete();
                    }
                }
                finally
                {

                    isRuning = false;
                }
                return "初始化成功";
            }

        }
        static bool isRuning = false;
        static int i = 0;
        private static IRepository<ProductSaleByDayEntity> GetRepository()
        {

            i++;
            if (i % 2 == 0)
            {
                //可以通过工厂创建
                return RepositoryFactory.Create<ProductSaleByDayEntity>();
            }
            else
            {
                //也可以继承实例化
                return new ProductSaleByDayRepository();
            }
        }
        [Test]
        public void TestProductSaleByDayGet()
        {
            TestProductSaleByDayGet(new DateTime(2019, 01, 01));
            TestProductSaleByDayGet(new DateTime(2018, 02, 01));
        }

        private static void TestProductSaleByDayGet(DateTime dt)
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayEntity>();
            query.OrderBy(m => m.StatisticalDate);
            query.StarSize = 11;
            query.Rows = 1;
            query.DBModel.DBModel_ShuffledTempDate = dt;
            var model = repository.GetPaging(query).ToList()[0];
            var entity = repository.Get(new ProductSaleByDayEntity
            {
                DBModel_ShuffledTempDate = dt,//这儿表示差19年1月的库和表
                SysNo = model.SysNo
            });
            Assert.AreEqual(model.StatisticalDate.Year,dt.Year);
            Assert.AreEqual(model.StatisticalDate.Month,dt.Month);
            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.ShopName, entity.ShopName);
            Assert.AreEqual(model.StatisticalDate, entity.StatisticalDate);

            entity = repository.Get<ProductSaleByDayEntity>(model, $"select * from Purify_ProductSaleByDay_{dt.Month.ToString("00")} where SysNo=@SysNo", new { model.SysNo });
            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.ShopName, entity.ShopName);
            entity = repository.Get(model, $"select * from Purify_ProductSaleByDay_{dt.Month.ToString("00")} where SysNo=@SysNo", new { model.SysNo });
            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.ShopName, entity.ShopName);
        }

        [Test]
        public void TestProductSaleByDayGetList()
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName.Contains("测试"));

            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);//这儿表示查19年1月的库和表
            var q2 = query.Select(m => new ProductSaleByDayEntity { SysNo = m.SysNo, BrandID = m.BrandID, ShopName = m.ShopName, StatisticalDate = m.StatisticalDate });
            //分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
            var lst = repository.GetList(q2);
            Assert.True(lst.Count > 30);
            Assert.False(lst.Any(m => !(m.ShopName?.Contains("测试")).GetValueOrDefault() || m.StatisticalDate.Year != 2019 || m.StatisticalDate.Month != 2));
            query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.IsExclude && !m.IsExclude && m.ProductName.Contains("你好")
            && !m.ProductName.Contains("没有") && m.IsExclude == false && m.AveragePrice > 0 && m.AveragePrice == 0 && m.CategoryID == Guid.Empty && true == true);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            var c = repository.Count(query);
            Assert.True(c == 0);

            query = QueryFactory.Create<ProductSaleByDayEntity>();
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            lst = repository.GetList(query);
            lst[0].ShopName = "";
            repository.Update(lst[0]);
            var all = lst.AsQueryable();

            Expression<Func<ProductSaleByDayEntity, bool>> where =
                m => m.ShopName.Contains("测试") && !m.ShopName.Contains("不存在") && m.ShopName.Contains("测试") == true
                && m.ShopName.Contains("不存在") == false;

            var allCount = all.Count(where);
            query = QueryFactory.Create(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);


            where =
             m => m.Sales + m.NumberOfSales > m.OrderQuantity + m.NumberOfSales && m.Sales > 0;

            allCount = all.Count(where);
            query = QueryFactory.Create<ProductSaleByDayEntity>(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);


            where =
             m => m.StatisticalDate > new DateTime(2019, 2, 10) && m.StatisticalDate <= new DateTime(2019, 2, 12);

            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);


            where =
           m => !string.IsNullOrEmpty(m.ShopName) && !string.IsNullOrEmpty(m.DataSource);
            allCount = all.Count(where);
            query = QueryFactory.Create<ProductSaleByDayEntity>(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);

            where =
         m => string.IsNullOrEmpty(m.ShopName) && !string.IsNullOrEmpty(m.DataSource);
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);


            where =
         m => !(string.IsNullOrEmpty(m.ShopName) && !string.IsNullOrEmpty(m.DataSource));
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);
            var sysNos = new List<Guid>();

            where = m => sysNos.Contains(m.SysNo);
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreEqual(allCount, 0);

            sysNos = all.OrderBy(m => Guid.NewGuid()).Take(10).Select(m => m.SysNo).ToList();

            where = m => sysNos.Contains(m.SysNo);
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreEqual(allCount, 10);

            where = m => m.ProductID != Guid.Empty && sysNos.Contains(m.SysNo) && m.SysNo != Guid.NewGuid();
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreEqual(allCount, 10);

            var tempRes = query.Select(m => m.SysNo);
            where = m => tempRes.Contains(m.SysNo);
            query = QueryFactory.Create(where);
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 02, 01);
            c = repository.Count(query);
            Assert.AreEqual(c, 10);

            bool hasError = false;
            try
            {

                where = m => sysNos.Contains(m.SysNo);
                query = QueryFactory.Create(where);
                c = repository.Count(query);
            }
            catch (NoShuffledException)
            {
                hasError = true;
            }
            Assert.True(hasError);
        }
        [Test]
        public void TestProductSaleByDayGetPaging()
        {
            var stTime = new DateTime(2019, 1, 15);
            var endTime = new DateTime(2019, 2, 11);
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayEntity>(m => m.ShopName.Contains("测试"));
            query.And(m => m.StatisticalDate >= stTime);
            query.And(m => m.StatisticalDate < endTime.Date.AddDays(1));
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = 20;
            query.Rows = 10;
            //分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
            var paging = repository.GetPaging(query, stTime, endTime);
            var count = paging.TotalCount;
            var lst = paging.ToList();//或者paging.Items
            Assert.True(count > 10);
            Assert.True(lst.Count == 10);
            Assert.True(lst.Any(m => m.StatisticalDate > new DateTime(2019, 2, 1)));
        }




        private void TestProductSaleByDayAdd()
        {
            var addEntity = new ProductSaleByDayEntity()
            {
                SysNo = Guid.NewGuid(),
                DataSource = "测试来源",
                ProductID = Guid.NewGuid(),
                ShopID = Guid.NewGuid(),
                ShopName = "测试店铺添加",
                ProductName = "测试商品",
                OutProductID = Guid.NewGuid().ToString(),
                ImportGroupId = Guid.NewGuid(),
                StatisticalDate = DateTime.Now.AddYears(2019 - DateTime.Now.Year)//分库分表字段是必须的
            };
            var repository = GetRepository();
            //如果新增主键是自增列会自动赋值自增列值到主键
            repository.Add(addEntity);
            var entity = repository.Get(new ProductSaleByDayEntity { DBModel_ShuffledTempDate = addEntity.StatisticalDate, SysNo = addEntity.SysNo });
            Assert.NotNull(entity);
            Assert.AreEqual(addEntity.SysNo, entity.SysNo);
            Assert.AreEqual(addEntity.ShopName, entity.ShopName);
        }

        private void TestProductSaleByDayUpdate()
        {

            var repository = GetRepository();
            var queryCount = QueryFactory.Create<ProductSaleByDayEntity>();
            queryCount.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 01);
            queryCount.And(m => m.DataSource == "测试来源修改");
            var preCount = repository.Count(queryCount);

            var query = QueryFactory.Create<ProductSaleByDayEntity>();
            query.And(m => m.DataSource != "测试来源修改");
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = new Random().Next(5);
            query.Rows = 1;
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 01);
            var model = repository.GetPaging(query).ToList()[0];

            model.DataSource = "测试来源修改";
            model.ProductName = "测试商品修改";

            //根据主键更新其他字段
            var r = repository.Update(model);
            Assert.True(r);
            var nextCount = repository.Count(queryCount);
            Assert.AreEqual(preCount + 1, nextCount);
            var entity = repository.Get(new ProductSaleByDayEntity { DBModel_ShuffledTempDate = model.StatisticalDate, SysNo = model.SysNo });
            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.DataSource, entity.DataSource);
            Assert.AreEqual(model.ProductName, entity.ProductName);
        }
        [Test]
        public void TestProductSaleByDayAddUpdate()
        {
            TestProductSaleByDayAdd();
            TestProductSaleByDayUpdate();
            TestProductSaleByDayUpdateWhere();
            TestProductSaleByDayDelete();
        }
        public void TestProductSaleByDayDelete()
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayEntity>();
            query.And(m => !m.DataSource.Contains("修改"));
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = new Random().Next(5);
            query.Rows = 1;
            query.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 05);
            var model = repository.GetPaging(query).ToList()[0];
            var qm = repository.Get(new ProductSaleByDayEntity
            {
                SysNo = model.SysNo,
                DBModel_ShuffledTempDate = new DateTime(2019, 01, 05)
            });
            Assert.NotNull(qm);
            var res = repository.Delete(model);
            Assert.True(res);
            qm = repository.Get(new ProductSaleByDayEntity
            {
                SysNo = model.SysNo,
                DBModel_ShuffledTempDate = new DateTime(2019, 01, 05)
            });
            Assert.Null(qm);
            model = repository.GetPaging(query).ToList()[0];
            qm = repository.Get(new ProductSaleByDayEntity
            {
                SysNo = model.SysNo,
                DBModel_ShuffledTempDate = new DateTime(2019, 01, 05)
            });
            Assert.NotNull(qm);
            res = repository.Delete(new ProductSaleByDayEntity
            {
                SysNo = model.SysNo,
                DBModel_ShuffledTempDate = new DateTime(2019, 01, 05)
            });
            Assert.True(res);
            qm = repository.Get(new ProductSaleByDayEntity
            {
                SysNo = model.SysNo,
                DBModel_ShuffledTempDate = new DateTime(2019, 01, 05)
            });
            Assert.Null(qm);
            var delQuery = QueryFactory.Create<ProductSaleByDayEntity>(m => m.DataSource == "测试来源批量修改");
            delQuery.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 05);
            var deleteCount = repository.Delete(delQuery);
            Assert.True(deleteCount > 0);

        }
        public void TestProductSaleByDayUpdateWhere()
        {

            var repository = GetRepository();
            var queryCount = QueryFactory.Create<ProductSaleByDayEntity>(m => !m.ProductName.Contains("没有") && m.ProductName.Contains("修改"));

            queryCount.DBModel.DBModel_ShuffledTempDate = new DateTime(2019, 01, 05);
            var count = repository.Count(queryCount);
            var updateEntity = new ProductSaleByDayEntity()
            {
                DataSource = "测试来源批量修改",
                ShopName = "店铺修改Where",
                DBModel_ShuffledTempDate = new DateTime(2019, 01, 05),//如果用这句话来确定是那个库及表
                // StatisticalDate = statisticalDate,//如果要更新StatisticalDate则可以用这句话替代上面那句话
            };

            var where = QueryFactory.Create<ProductSaleByDayEntity>(m => !m.ProductName.Contains("没有") && m.ProductName.Contains("修改"));//where是更新条件
            //注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
            int updateCount = repository.Update(updateEntity, where);
            Assert.AreEqual(updateCount, count);
            Assert.AreNotEqual(updateCount, 0);

        }


        [Test]
        public void TestProductSaleByDayNSTransaction()
        {
            using (var tran = DBTool.BeginTransaction())
            {
                TestProductSaleByDayGet();
                TestProductSaleByDayGetList();
                TestProductSaleByDayGetPaging();
                TestProductSaleByDayAddUpdate();
                tran.Complete();
            }

        }
        [TearDown]
        public void TestTearDown()
        {
            DBTool.CloseConnections();
        }
    }
}