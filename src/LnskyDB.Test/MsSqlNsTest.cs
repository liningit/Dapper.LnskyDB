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
using LnskyDB.Test.MsSql.Entity.LnskyNS;
using LnskyDB.Test.MsSql.Repository.LnskyNS;
using System.Threading;
using System.Threading.Tasks;

namespace LnskyDB.Test
{
    public class MsSqlNsTest
    {

        public static object lockObj = new object();
        static List<string> lstDataSource = new List<string> { "测试来源1", "测试来源2", "来源自动生成" };
        static List<ShopEntity> lstShop = new List<ShopEntity>();
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
            Console.WriteLine("开始执行测试");
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
                    var repositoryNSFactory = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
                    using (var tran = DBTool.BeginTransaction())
                    {
                        if (repositoryNSFactory.GetList(m => m.CreateDate > DateTime.Now.Date).Count > 100)
                        {
                            tran.Complete();
                            return "";
                        }
                    }
                    var shopRepository = RepositoryFactory.Create<ShopEntity>();
                    shopRepository.Delete(QueryFactory.Create<ShopEntity>());

                    using (var tran = DBTool.BeginTransaction())
                    {
                        for (int i = 0; i < 10; i++)
                        {


                            var shop = new ShopEntity
                            {
                                SysNo = Guid.NewGuid(),
                                ShopCode = "00" + i,
                                ShopName = "测试店铺" + i,
                                ShopType = i % 3,
                                IsDelete = false,
                            };
                            shopRepository.Add(shop);
                        }
                        lstShop = shopRepository.GetList(QueryFactory.Create<ShopEntity>());
                        tran.Complete();
                    }
                    var importGroupId = Guid.NewGuid();
                    var random = new Random();

                    repositoryNSFactory.Delete(QueryFactory.Create<ProductSaleByDayNSEntity>());
                    var tempDate = new DateTime(2018, 1, 1);
                    while (tempDate <= DateTime.Now)
                    {
                        using (var tran = DBTool.BeginTransaction())
                        {

                            foreach (var p in dicProduct)
                            {
                                var tempNS = new ProductSaleByDayNSEntity();
                                tempNS.SysNo = Guid.NewGuid();
                                tempNS.DataSource = lstDataSource[random.Next(lstDataSource.Count)];
                                var shop = lstShop[random.Next(lstShop.Count)];
                                tempNS.ShopID = shop.SysNo;

                                tempNS.ProductID = p.Key;
                                tempNS.OutProductID = p.Value;
                                tempNS.ProductName = p.Value;
                                tempNS.Sales = random.Next(100000);
                                tempNS.StatisticalDate = tempDate;
                                tempNS.CreateDate = DateTime.Now;
                                tempNS.CreateUserID = Guid.NewGuid();
                                tempNS.ImportGroupId = importGroupId;

                                repositoryNSFactory.Add(tempNS);

                            }
                            tempDate = tempDate.AddDays(1);
                            tran.Complete();
                        }
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
        [Test]
        public void TestProductSaleByDayNSGet()
        {

            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>();
            query.OrderBy(m => m.StatisticalDate);
            query.StarSize = 11;
            query.Rows = 1;

            var model = repository.GetPaging(query).ToList()[0];
            var entity = repository.Get(new ProductSaleByDayNSEntity
            {
                SysNo = model.SysNo
            });
            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.ShopID, entity.ShopID);
            Assert.AreEqual(model.ProductName, entity.ProductName);

            entity = repository.Get("select * from Purify_ProductSaleByDayNS where SysNo=@SysNo", model);

            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.ShopID, entity.ShopID);
            Assert.AreEqual(model.ProductName, entity.ProductName);

            entity = repository.Get<ProductSaleByDayNSEntity>("select * from Purify_ProductSaleByDayNS where SysNo=@SysNo", model);

            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.ShopID, entity.ShopID);
            Assert.AreEqual(model.ProductName, entity.ProductName);

        }
        [Test]
        public void TestProductSaleByDayNSGetList()
        {
            var repository = GetRepository();



            IQuery<ProductSaleByDayNSEntity> query;
            long c;
            query = QueryFactory.Create<ProductSaleByDayNSEntity>(m =>
           m.ProductName.Contains("测试") && !m.ProductName.Contains("不存在")
           && m.StatisticalDate >= new DateTime(2019, 2, 10) && m.StatisticalDate < new DateTime(2019, 2, 27)
           );

            var q2 = query.Select(m => new ProductSaleByDayNSEntity { SysNo = m.SysNo, BrandID = m.BrandID, ProductName = m.ProductName, StatisticalDate = m.StatisticalDate });

            var lst = repository.GetList(q2);

            Assert.True(lst.Count > 30);
            Assert.False(lst.Any(m => !(m.ProductName?.Contains("测试")).GetValueOrDefault() || m.StatisticalDate.Year != 2019 || m.StatisticalDate.Month != 2));

            lst = repository.GetList();
            lst[0].ProductName = "";
            repository.Update(lst[0]);

            var all = lst.AsQueryable();

            Expression<Func<ProductSaleByDayNSEntity, bool>> where =
             m => !m.ProductName.Contains("不存在");

            var allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);

            where =
             m => m.ProductName.Contains("不存在") || m.ProductName.Contains("测试商品1");

            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);

            query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => m.IsExclude && !m.IsExclude && m.ProductName.Contains("你好")
            && !m.ProductName.Contains("没有") && m.IsExclude == false && m.AveragePrice > 0 && m.AveragePrice == 0 && m.CategoryID == Guid.Empty && true == true);

            c = repository.Count(query);
            Assert.True(c == 0);




            where =
                 m => !m.ProductName.Contains("不存在") && m.ProductName.Contains("测试商品1") == true
                 && m.ProductName.Contains("不存在") == false && m.ProductName.Contains("测试");

            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);

            where = m => m.IsExclude == false && m.ProductName.Contains("测试商品1");
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);

            where =
             m => m.Sales + m.NumberOfSales > m.OrderQuantity + m.NumberOfSales && m.Sales > 0;

            allCount = all.Count(where);
            query = QueryFactory.Create<ProductSaleByDayNSEntity>(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);


            where =
             m => m.StatisticalDate > new DateTime(2019, 2, 10) && m.StatisticalDate <= new DateTime(2019, 2, 12);

            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);


            where =
           m => !string.IsNullOrEmpty(m.ProductName) && !string.IsNullOrEmpty(m.DataSource);
            allCount = all.Count(where);
            query = QueryFactory.Create<ProductSaleByDayNSEntity>(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);

            where =
         m => string.IsNullOrEmpty(m.ProductName) && !string.IsNullOrEmpty(m.DataSource);
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);


            where =
         m => !(string.IsNullOrEmpty(m.ProductName) && !string.IsNullOrEmpty(m.DataSource));
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);
            var sysNos = new List<Guid>();

            where = m => sysNos.Contains(m.SysNo);
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreEqual(allCount, 0);

            sysNos = all.OrderBy(m => Guid.NewGuid()).Take(10).Select(m => m.SysNo).ToList();

            where = m => sysNos.Contains(m.SysNo);
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreEqual(allCount, 10);

            where = m => m.ShopID != Guid.Empty && sysNos.Contains(m.SysNo) && m.SysNo != Guid.NewGuid();
            allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreEqual(allCount, 10);

            var tempRes = query.Select(m => m.SysNo);
            where = m => tempRes.Contains(m.SysNo);
            query = QueryFactory.Create(where);
            var r = query.Select(m => DBFunction.Function<string>("substring", m.ProductName, 1, 3));
            var l = repository.GetList(r);
            var l2 = repository.GetList(where);
            Assert.AreEqual(l.Count, 10);
            Assert.AreEqual(l2.Count, 10);
            TestJq1();
            TestJq2();


        }
        private void TestJq1()
        {
            var repository = GetRepository();
            Expression<Func<ProductSaleByDayNSEntity, bool>> where = m => m.ShopID != Guid.Empty && m.SysNo != Guid.NewGuid();
            var query = QueryFactory.Create(where);
            var jq = query.InnerJoin(QueryFactory.Create<ShopEntity>(), m => m.ShopID, m => m.SysNo, (x, y) => new { Sale = x, Shop = y });
            var r = jq.Select(m => new { ShopID = m.Sale.ShopID, ShopID2 = m.Shop.SysNo, m.Sale.SysNo });
            var rlst = repository.GetList(r);
            Assert.True(rlst.Count > 10);
            Assert.AreEqual(rlst[0].ShopID, rlst[0].ShopID2);
        }
        private void TestJq2()
        {
            var repository = GetRepository();
            Expression<Func<ProductSaleByDayNSEntity, bool>> where = m => m.ShopID != Guid.Empty && m.SysNo != Guid.NewGuid();
            var query = QueryFactory.Create(where);
            var jq = query.InnerJoin(QueryFactory.Create<ShopEntity>(), m => m.ShopID, m => m.SysNo, (x, y) => new { Sale = x, Shop = y });
            var r = jq.Select(m => new
            {
                TName = m.Sale.ProductName + m.Sale.DataSource,
                m.Sale.ShopID,
                ShopID2 = m.Shop.SysNo
            });
            var rlst = repository.GetList(r);
            Assert.True(rlst.Count > 10);
            Assert.AreEqual(rlst[0].ShopID, rlst[0].ShopID2);
            Assert.False(string.IsNullOrEmpty(rlst[0].TName));
            Assert.True(rlst.Any(m => m.TName.Contains("商品")));
            Assert.True(rlst.Any(m => m.TName.Contains("来源")));
            jq.OrderBy(m => m.Sale.StatisticalDate);
            jq.StarSize = 10;
            jq.Rows = 5;
            r = jq.Select(m => new
            {
                TName = m.Sale.ProductName + m.Sale.DataSource,
                m.Sale.ShopID,
                ShopID2 = m.Shop.SysNo
            });
            var plst = repository.GetPaging(r);
            Assert.True(plst.Items.Count() == 5);
            Assert.True(plst.TotalCount > 20);

        }
        [Test]
        public void TestProductSaleByDayNSGetPaging()
        {
            var stTime = new DateTime(2019, 1, 15);
            var endTime = new DateTime(2019, 2, 11);
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => m.ProductName.Contains("测试"));
            query.And(m => m.StatisticalDate >= stTime);
            query.And(m => m.StatisticalDate < endTime.Date.AddDays(1));
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = 20;
            query.Rows = 10;
            //分库的传入stTime,endTime会自动根据时间查询符合条件的库和表
            var paging = repository.GetPaging(query);
            var count = paging.TotalCount;
            var lst = paging.ToList();//或者paging.Items
            Assert.True(count > 10);
            Assert.True(lst.Count == 10);
            Assert.True(lst.Any(m => m.StatisticalDate > new DateTime(2019, 2, 1)));
        }




        private void TestProductSaleByDayNSAdd()
        {
            var usersEntity = new UsersEntity
            {
                createDate = DateTime.Now,
                name = "名称",
                code = "c01"
            };
            new UsersRepository().Add(usersEntity);
            Assert.True(usersEntity.id > 0);
            var addEntity = new ProductSaleByDayNSEntity()
            {
                SysNo = Guid.NewGuid(),
                DataSource = "测试来源",
                ProductID = Guid.NewGuid(),
                ShopID = Guid.NewGuid(),
                ProductName = "测试商品添加",
                OutProductID = Guid.NewGuid().ToString(),
                ImportGroupId = Guid.NewGuid(),
                StatisticalDate = DateTime.Now//分库分表字段是必须的
            };
            var repository = GetRepository();
            //如果新增主键是自增列会自动赋值自增列值到主键
            repository.Add(addEntity);
            var entity = repository.Get(new ProductSaleByDayNSEntity { SysNo = addEntity.SysNo });
            Assert.NotNull(entity);
            Assert.AreEqual(addEntity.SysNo, entity.SysNo);
            Assert.AreEqual(addEntity.ProductName, entity.ProductName);
        }

        private void TestProductSaleByDayNSUpdate()
        {

            var repository = GetRepository();
            var queryCount = QueryFactory.Create<ProductSaleByDayNSEntity>();
            queryCount.And(m => m.DataSource == "测试来源修改");
            var preCount = repository.Count(queryCount);

            var query = QueryFactory.Create<ProductSaleByDayNSEntity>();
            query.And(m => m.DataSource != "测试来源修改");
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = new Random().Next(5);
            query.Rows = 1;
            var model = repository.GetPaging(query).ToList()[0];

            model.DataSource = "测试来源修改";
            model.ProductName = "测试商品修改";

            //根据主键更新其他字段
            var r = repository.Update(model);
            Assert.True(r);
            var nextCount = repository.Count(queryCount);
            Assert.AreEqual(preCount + 1, nextCount);
            var entity = repository.Get(new ProductSaleByDayNSEntity { SysNo = model.SysNo });
            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.DataSource, entity.DataSource);
            Assert.AreEqual(model.ProductName, entity.ProductName);
        }
        public void TestProductSaleByDayNSUpdateWhere()
        {
            var repository = GetRepository();
            var queryCount = QueryFactory.Create<ProductSaleByDayNSEntity>(m => !m.ProductName.Contains("没有") && m.ProductName.Contains("修改"));


            var count = repository.Count(queryCount);
            var updateEntity = new ProductSaleByDayNSEntity()
            {
                DataSource = "测试来源批量修改",
                ProductName = "商品修改Where"
            };

            var where = QueryFactory.Create<ProductSaleByDayNSEntity>(m => !m.ProductName.Contains("没有") && m.ProductName.Contains("修改"));//where是更新条件
            //注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
            int updateCount = repository.Update(updateEntity, where);
            Assert.AreEqual(updateCount, count);
            Assert.AreNotEqual(updateCount, 0);
        }
        public void TestProductSaleByDayNSDelete()
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>();
            query.And(m => !m.DataSource.Contains("修改"));
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = new Random().Next(5);
            query.Rows = 1;
            var model = repository.GetPaging(query).ToList()[0];
            repository.Delete(model);
            var deleteCount = repository.Delete(m => m.DataSource == "测试来源批量修改");
            Assert.True(deleteCount > 0);

        }
        [Test]
        public void TestProductSaleByDayNSAddUpdateDelete()
        {
            using (var tran = DBTool.BeginTransaction())
            {
                TestProductSaleByDayNSAdd();
                TestProductSaleByDayNSUpdate();
                TestProductSaleByDayNSUpdateWhere();
                TestProductSaleByDayNSDelete();
                tran.Complete();

            }
        }
        #region TestProductSaleByDayNSTransaction

        [Test]
        public void TestProductSaleByDayNSTransaction()
        {
            TestTranAdd(true);
            TestTranAdd(false);
            TestTranUpdate(true);
            TestTranUpdate(false);
            TestTranUpdateWhere(false);
            TestTranUpdateWhere(true);
            TestTranDelete(false);
            TestTranDelete(true);

        }
        private void TestTranDelete(bool isCommit)
        {
            using (var tran = DBTool.BeginTransaction())
            {
                var repository = GetRepository();
                var query = QueryFactory.Create<ProductSaleByDayNSEntity>();
                query.And(m => !m.DataSource.Contains("修改"));
                query.OrderByDescing(m => m.StatisticalDate);
                query.StarSize = new Random().Next(5);
                query.Rows = 1;
                var model = repository.GetPaging(query).ToList()[0];
                repository.Delete(model);
                var deleteCount = repository.Delete(m => m.DataSource == "测试来源批量修改");
                Assert.True(deleteCount > 0);
            }
        }
        private void TestTranUpdateWhere(bool isCommit)
        {
            var repository = GetRepository();
            var where = QueryFactory.Create<ProductSaleByDayNSEntity>(m => !m.ProductName.Contains("批量修改Where") && m.ProductName.Contains("修改"));//where是更新条件

            var count = repository.Count(where);
            var updateEntity = new ProductSaleByDayNSEntity()
            {
                DataSource = "测试来源批量修改",
                ProductName = "商品批量修改Where"
            };
            using (var tran = DBTool.BeginTransaction())
            {
                Assert.AreEqual(tran.TransactionIndex, 1);
                using (var tran2 = DBTool.BeginTransaction())
                {
                    Assert.AreEqual(tran2.TransactionIndex, 2);
                    //注意如果是更新用的是实体类的DBModel_ShuffledTempDate Query中的无效
                    int updateCount = repository.Update(updateEntity, where);

                    Assert.AreEqual(updateCount, count);
                    Assert.AreNotEqual(updateCount, 0);
                    if (isCommit)
                    {
                        tran.Complete();
                    }
                }
            }
            using (var tran = DBTool.BeginTransaction())
            {
                Assert.AreEqual(tran.TransactionIndex, 1);
            }
            if (isCommit)
            {

                var newcount = repository.Count(where);
                Assert.AreNotEqual(count, newcount);
            }
            else
            {
                var newcount = repository.Count(where);
                Assert.AreEqual(count, newcount);
            }
            using (var tran = DBTool.BeginTransaction())
            {
                Assert.AreEqual(tran.TransactionIndex, 1);
            }

        }
        private void TestTranUpdate(bool isCommit)
        {
            var repository = GetRepository();
            var queryCount = QueryFactory.Create<ProductSaleByDayNSEntity>();
            queryCount.And(m => m.DataSource == "测试来源修改");
            var preCount = repository.Count(queryCount);
            ProductSaleByDayNSEntity model;
            using (var tran = DBTool.BeginTransaction())
            {


                var query = QueryFactory.Create<ProductSaleByDayNSEntity>();
                query.And(m => m.DataSource != "测试来源修改");
                query.OrderByDescing(m => m.StatisticalDate);
                query.StarSize = new Random().Next(5);
                query.Rows = 1;
                model = repository.GetPaging(query).ToList()[0];

                model.DataSource = "测试来源修改";
                model.ProductName = "测试商品修改";

                //根据主键更新其他字段
                var r = repository.Update(model);
                Assert.True(r);
                var nextCount = repository.Count(queryCount);
                Assert.AreEqual(preCount + 1, nextCount);
                var entity = repository.Get(new ProductSaleByDayNSEntity { SysNo = model.SysNo });
                Assert.NotNull(entity);
                Assert.AreEqual(model.SysNo, entity.SysNo);
                Assert.AreEqual(model.DataSource, entity.DataSource);
                Assert.AreEqual(model.ProductName, entity.ProductName);
                if (isCommit)
                {
                    tran.Complete();

                }
            }
            if (isCommit)
            {
                var nextCount = repository.Count(queryCount);
                Assert.AreEqual(preCount + 1, nextCount);
                var entity = repository.Get(new ProductSaleByDayNSEntity { SysNo = model.SysNo });
                Assert.NotNull(entity);
                Assert.AreEqual(model.SysNo, entity.SysNo);
                Assert.AreEqual(model.DataSource, entity.DataSource);
                Assert.AreEqual(model.ProductName, entity.ProductName);

            }
            else
            {
                var nextCount = repository.Count(queryCount);
                Assert.AreEqual(preCount, nextCount);
                var entity = repository.Get(new ProductSaleByDayNSEntity { SysNo = model.SysNo });
                Assert.NotNull(entity);
                Assert.AreEqual(model.SysNo, entity.SysNo);
                Assert.AreNotEqual(model.DataSource, entity.DataSource);
                Assert.AreNotEqual(model.ProductName, entity.ProductName);
            }
        }
        private void TestTranAdd(bool isCommit)
        {
            var repository = GetRepository();
            var lst = repository.GetList();
            List<ProductSaleByDayNSEntity> newLst;
            using (var tran = DBTool.BeginTransaction())
            {
                TestProductSaleByDayNSAdd();
                newLst = repository.GetList();
                Assert.True(lst.Count < newLst.Count);
                if (isCommit)
                {
                    tran.Complete();
                }
            }
            if (isCommit)
            {

                newLst = repository.GetList();
                Assert.True(lst.Count + 1 == newLst.Count);
            }
            else
            {

                newLst = repository.GetList();
                Assert.True(lst.Count == newLst.Count);
            }
        }
        #endregion
        [Test]
        public void TestThread()
        {
            List<Task> lst = new List<Task>();
            for (var i = 0; i < 100; i++)
            {
                var task = Task.Run(() => TestQueueUserWorkItem());
                lst.Add(task);
            }
            Task.WaitAll(lst.ToArray());
        }
        static ILnskyDBTransactionMain LnskyDBTransactionMain = null;
        static Random random = new Random();
        public void TestQueueUserWorkItem()
        {
            DBTool.BeginThread();
            try
            {

                Thread.Sleep(random.Next(5000));
                ILnskyDBTransactionMain temp;
                using (var tran = DBTool.BeginTransaction())
                {
                    temp = DBTool.GetLnskyDBTransactionMain();
                    if (LnskyDBTransactionMain != null)
                    {
                        Assert.AreNotEqual(temp, LnskyDBTransactionMain);
                    }
                    LnskyDBTransactionMain = temp;
                    TestProductSaleByDayNSGet();
                }
                using (var tran = DBTool.BeginTransaction())
                {
                    var temp2 = DBTool.GetLnskyDBTransactionMain();
                    Assert.AreEqual(temp, temp2);
                }
            }
            finally
            {
                DBTool.CloseConnections();
            }
        }
        [TearDown]
        public void TestTearDown()
        {
            DBTool.CloseConnections();
        }
    }
}