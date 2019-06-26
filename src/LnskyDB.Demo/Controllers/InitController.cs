using System;
using System.Collections.Generic;
using System.Linq;
using LnskyDB;
using LnskyDB.Demo.Entity.Purify;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace Lnsky.Test.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class InitController : ControllerBase
    {

        public static object lockObj = new object();
        static List<string> lstDataSource = new List<string> { "测试来源1", "测试来源2", "自动生成" };
        static Dictionary<Guid, string> dicShop = new Dictionary<Guid, string> {
            { Guid.Parse("2E3E3B71-94B5-4C16-BFAC-2FF136B78FF5"), "测试店铺1" },
            { Guid.Parse("4E37A7E1-8BAC-44C9-B128-58E4049E3CCF"), "测试店铺2" }
        };
        static Dictionary<Guid, string> dicProduct = new Dictionary<Guid, string>();
        static InitController()
        {
            
    InitDic(dicProduct, "测试商品", 10);
        }
        private static void InitDic(Dictionary<Guid, string> dic, string namePre, int count)
        {
            for (int i = 1; i < count + 1; i++)
            {
                dic.Add(Guid.NewGuid(), namePre + i);
            }
        }
        static bool isRuning = false;
        [HttpGet]
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
                    var importGroupId = Guid.NewGuid();
                    var random = new Random();
                    var repositoryFactory = RepositoryFactory.Create<ProductSaleByDayEntity>();
                    var repositoryNSFactory = RepositoryFactory.Create<ProductSaleByDayNSEntity>();
                    repositoryNSFactory.Delete(QueryFactory.Create<ProductSaleByDayNSEntity>());
                    var tempDate = new DateTime(2018, 1, 1);
                    while (tempDate <= DateTime.Now.Date)
                    {
                        if (tempDate.Day == 1)
                        {
                            var query = QueryFactory.Create<ProductSaleByDayEntity>();
                            query.DBModel.DBModel_ShuffledTempDate = tempDate;
                            repositoryFactory.Delete(query);
                        }
                        foreach (var p in dicProduct)
                        {
                            var temp = new ProductSaleByDayEntity();
                            var tempNS = new ProductSaleByDayNSEntity();
                            tempNS.SysNo = temp.SysNo = Guid.NewGuid();
                            tempNS.DataSource = temp.DataSource = lstDataSource[random.Next(lstDataSource.Count)];
                            tempNS.ShopID = temp.ShopID = dicShop.Keys.ToList()[random.Next(dicShop.Count)];
                            tempNS.ShopName = temp.ShopName = dicShop[temp.ShopID];
                            tempNS.ProductID = temp.ProductID = p.Key;
                            tempNS.OutProductID = temp.OutProductID = p.Value;
                            tempNS.ProductName = temp.ProductName = p.Value;
                            tempNS.Sales = temp.Sales = random.Next(100000);
                            tempNS.StatisticalDate = temp.StatisticalDate = tempDate;
                            tempNS.UpdateDate = temp.UpdateDate = temp.CreateDate = DateTime.Now;
                            tempNS.UpdateUserID = temp.UpdateUserID = temp.CreateUserID = Guid.NewGuid();
                            tempNS.ImportGroupId = temp.ImportGroupId = importGroupId;
                            repositoryFactory.Add(temp);
                            repositoryNSFactory.Add(tempNS);

                        }
                        tempDate = tempDate.AddDays(1);
                    }
                }
                finally
                {

                    isRuning = false;
                }
                return "初始化成功";
            }

        }
    }
}