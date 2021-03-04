using LnskyDB;
using LnskyDB.Test.MySql.Entity.Data;
using LnskyDB.Test.MySql.Entity.Purify;
using LnskyDB.Test.MySql.Repository.Purify;
using Microsoft.Extensions.Configuration;
using NUnit.Framework;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Collections.Generic;
using System.IO;

namespace LnskyDB.Test
{
    public class MySqlNsTest
    {

        public static object lockObj = new object();
        static List<string> lstDataSource = new List<string> { "������Դ1", "������Դ2", "��Դ�Զ�����" };
        static List<ShopEntity> lstShop = new List<ShopEntity>();
        static Dictionary<Guid, string> dicProduct = new Dictionary<Guid, string>();

        [SetUp]
        public void Setup()
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();
            DBTool.Configuration = configuration;
            DBTool.Error += DBTool_Error;
            InitDic(dicProduct, "������Ʒ", 10);
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
                return "����������";
            }
            lock (lockObj)
            {

                isRuning = true;
                try
                {
                    var repositoryNSFactory = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
                    if (repositoryNSFactory.GetList(m => m.CreateDate > DateTime.Now.Date).Count > 100)
                    {
                        return "";
                    }
                    var shopRepository = RepositoryFactory.Create<ShopEntity>();
                    shopRepository.Delete(QueryFactory.Create<ShopEntity>());
                    for (int i = 0; i < 10; i++)
                    {
                        using (var tran = DBTool.BeginTransaction())
                        {

                            var shop = new ShopEntity
                            {
                                SysNo = Guid.NewGuid().ToString(),
                                ShopCode = "00" + i,
                                ShopName = "���Ե���" + i,
                                ShopType = i % 3,
                                IsDelete = false,
                            };
                            shopRepository.Add(shop);
                            tran.Complete();
                        }
                    }
                    lstShop = shopRepository.GetList(QueryFactory.Create<ShopEntity>());
                    var importGroupId = Guid.NewGuid();
                    var random = new Random();

                    repositoryNSFactory.Delete(QueryFactory.Create<ProductSaleByDayNSEntity>());
                    var tempDate = new DateTime(2018, 1, 1);
                    using (var tran = DBTool.BeginTransaction())
                    {
                        while (tempDate <= DateTime.Now)
                        {

                            foreach (var p in dicProduct)
                            {
                                var tempNS = new ProductSaleByDayNSEntity();

                                tempNS.DataSource = lstDataSource[random.Next(lstDataSource.Count)];
                                var shop = lstShop[random.Next(lstShop.Count)];
                                tempNS.ShopID = shop.SysNo;

                                tempNS.ProductID = p.Key.ToString();
                                tempNS.OutProductID = p.Value;
                                tempNS.ProductName = p.Value;
                                tempNS.Sales = random.Next(100000);
                                tempNS.StatisticalDate = tempDate;
                                tempNS.CreateDate = DateTime.Now;
                                tempNS.CreateUserID = Guid.NewGuid().ToString();
                                tempNS.ImportGroupId = importGroupId.ToString();

                                repositoryNSFactory.Add(tempNS);


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
                return "��ʼ���ɹ�";
            }

        }
        static bool isRuning = false;
        static int i = 0;
        private static IRepository<ProductSaleByDayNSEntity> GetRepository()
        {

            i++;
            if (i % 2 == 0)
            {
                //����ͨ����������
                return RepositoryFactory.Create<ProductSaleByDayNSEntity>();
            }
            else
            {
                //Ҳ���Լ̳�ʵ����
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


            entity = repository.Get(m => m.SysNo == model.SysNo);

            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.ShopID, entity.ShopID);
            Assert.AreEqual(model.ProductName, entity.ProductName);

            entity = repository.Get(m => m.SysNo == model.SysNo && m.ShopID == model.ShopID);

            Assert.NotNull(entity);
            Assert.AreEqual(model.SysNo, entity.SysNo);
            Assert.AreEqual(model.ShopID, entity.ShopID);
            Assert.AreEqual(model.ProductName, entity.ProductName);

        }
        [Test]
        public void TestProductSaleByDayNSGetList()
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m =>
            m.ProductName.Contains("����")
            && m.StatisticalDate >= new DateTime(2019, 2, 10) && m.StatisticalDate < new DateTime(2019, 2, 27)
            );

            var q2 = query.Select(m => new ProductSaleByDayNSEntity { SysNo = m.SysNo, BrandID = m.BrandID, ProductName = m.ProductName, StatisticalDate = m.StatisticalDate });

            var lst = repository.GetList(q2);
            Assert.True(lst.Count > 30);
            Assert.False(lst.Any(m => !(m.ProductName?.Contains("����")).GetValueOrDefault() || m.StatisticalDate.Year != 2019 || m.StatisticalDate.Month != 2));
            query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => m.IsExclude && !m.IsExclude && m.ProductName.Contains("���")
            && !m.ProductName.Contains("û��") && m.IsExclude == false && m.AveragePrice > 0 && m.AveragePrice == 0 && string.IsNullOrEmpty(m.CategoryID) && true == true);

            var c = repository.Count(query);
            Assert.True(c == 0);

            lst = repository.GetList();
            lst[0].ProductName = "";
            repository.Update(lst[0]);
            var all = lst.AsQueryable();

            Expression<Func<ProductSaleByDayNSEntity, bool>> where =
                m => m.ProductName.Contains("����") && !m.ProductName.Contains("������") && m.ProductName.Contains("����") == true
                && m.ProductName.Contains("������") == false;

            var allCount = all.Count(where);
            query = QueryFactory.Create(where);
            c = repository.Count(query);
            Assert.AreEqual(allCount, c);
            Assert.AreNotEqual(allCount, 0);


            where =
             m => m.Sales + m.NumberOfSales > m.OrderQuantity + m.NumberOfSales && m.Sales > 0;

            allCount = all.Count(where);
            query = QueryFactory.Create(where);
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
            query = QueryFactory.Create(where);
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
            var sysNos = new List<int>();

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

            where = m => !string.IsNullOrEmpty(m.ShopID) && sysNos.Contains(m.SysNo) && m.SysNo > 0;
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
            Expression<Func<ProductSaleByDayNSEntity, bool>> where = m => !string.IsNullOrEmpty(m.ShopID) && m.SysNo > 0;
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
            Expression<Func<ProductSaleByDayNSEntity, bool>> where = m => !string.IsNullOrEmpty(m.ShopID) && m.SysNo > 0;
            var query = QueryFactory.Create(where);
            var jq = query.InnerJoin(QueryFactory.Create<ShopEntity>(), m => m.ShopID, m => m.SysNo, (x, y) => new { Sale = x, Shop = y });
            var r = jq.Select(m => new
            {
                TName = DBFunction.Function<string>("CONCAT", m.Sale.DataSource, ",", m.Sale.ProductName),
                m.Sale.ShopID,
                ShopID2 = m.Shop.SysNo
            });
            var rlst = repository.GetList(r);
            Assert.True(rlst.Count > 10);
            Assert.AreEqual(rlst[0].ShopID, rlst[0].ShopID2);
            Assert.False(string.IsNullOrEmpty(rlst[0].TName));
            Assert.True(rlst.Any(m => m.TName.Contains("��Ʒ")));
            Assert.True(rlst.Any(m => m.TName.Contains("��Դ")));
            jq.OrderBy(m => m.Sale.StatisticalDate);
            jq.StarSize = 10;
            jq.Rows = 5;
            r = jq.Select(m => new
            {
                TName = DBFunction.Function<string>("CONCAT", m.Sale.DataSource, ",", m.Sale.ProductName),
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
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>(m => m.ProductName.Contains("����"));
            query.And(m => m.StatisticalDate >= stTime);
            query.And(m => m.StatisticalDate < endTime.Date.AddDays(1));
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = 20;
            query.Rows = 10;
            //�ֿ�Ĵ���stTime,endTime���Զ�����ʱ���ѯ���������Ŀ�ͱ�
            var paging = repository.GetPaging(query);
            var count = paging.TotalCount;
            var lst = paging.ToList();//����paging.Items
            Assert.True(count > 10);
            Assert.True(lst.Count == 10);
            Assert.True(lst.Any(m => m.StatisticalDate > new DateTime(2019, 2, 1)));
        }




        private void TestProductSaleByDayNSAdd()
        {
            var addEntity = new ProductSaleByDayNSEntity()
            {
                DataSource = "������Դ",
                ProductID = Guid.NewGuid().ToString(),
                ShopID = Guid.NewGuid().ToString(),
                ProductName = "������Ʒ���",
                OutProductID = Guid.NewGuid().ToString(),
                ImportGroupId = Guid.NewGuid().ToString(),
                StatisticalDate = DateTime.Now//�ֿ�ֱ��ֶ��Ǳ����
            };
            var repository = GetRepository();
            //������������������л��Զ���ֵ������ֵ������
            repository.Add(addEntity);
            var entity = repository.Get(new ProductSaleByDayNSEntity { SysNo = addEntity.SysNo });
            Assert.True(addEntity.SysNo > 0);
            Assert.NotNull(entity);
            Assert.AreEqual(addEntity.SysNo, entity.SysNo);
            Assert.AreEqual(addEntity.ProductName, entity.ProductName);
        }

        private void TestProductSaleByDayNSUpdate()
        {

            var repository = GetRepository();
            var queryCount = QueryFactory.Create<ProductSaleByDayNSEntity>();
            queryCount.And(m => m.DataSource == "������Դ�޸�");
            var preCount = repository.Count(queryCount);

            var query = QueryFactory.Create<ProductSaleByDayNSEntity>();
            query.And(m => m.DataSource != "������Դ�޸�");
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = new Random().Next(5);
            query.Rows = 1;
            var model = repository.GetPaging(query).ToList()[0];

            model.DataSource = "������Դ�޸�";
            model.ProductName = "������Ʒ�޸�";

            //�����������������ֶ�
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
            var queryCount = QueryFactory.Create<ProductSaleByDayNSEntity>(m => !m.ProductName.Contains("û��") && m.ProductName.Contains("�޸�"));


            var count = repository.Count(queryCount);
            var updateEntity = new ProductSaleByDayNSEntity()
            {
                DataSource = "������Դ�����޸�",
                ProductName = "��Ʒ�޸�Where"
            };

            var where = QueryFactory.Create<ProductSaleByDayNSEntity>(m => !m.ProductName.Contains("û��") && m.ProductName.Contains("�޸�"));//where�Ǹ�������
            //ע������Ǹ����õ���ʵ�����DBModel_ShuffledTempDate Query�е���Ч
            int updateCount = repository.Update(updateEntity, where);
            Assert.AreEqual(updateCount, count);
            Assert.AreNotEqual(updateCount, 0);
        }
        public void TestProductSaleByDayNSDelete()
        {
            var repository = GetRepository();
            var query = QueryFactory.Create<ProductSaleByDayNSEntity>();
            query.And(m => !m.DataSource.Contains("�޸�"));
            query.OrderByDescing(m => m.StatisticalDate);
            query.StarSize = new Random().Next(5);
            query.Rows = 1;
            var model = repository.GetPaging(query).ToList()[0];
            repository.Delete(model);
            var deleteCount = repository.Delete(m => m.DataSource == "������Դ�����޸�");
            Assert.True(deleteCount > 0);

        }
        [Test]
        public void TestProductSaleByDayNSAddUpdateDelete()
        {
            TestProductSaleByDayNSAdd();
            TestProductSaleByDayNSUpdate();
            TestProductSaleByDayNSUpdateWhere();
            TestProductSaleByDayNSDelete();
        }



        [TearDown]
        public void TestTearDown()
        {
            DBTool.CloseConnections();
        }
    }
}