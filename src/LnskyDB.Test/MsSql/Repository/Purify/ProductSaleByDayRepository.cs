﻿using LnskyDB;
using LnskyDB.Test.MsSql.Entity.Purify;
using LnskyDB.Test.MsSql.RepositoryInterface.Purify;

namespace LnskyDB.Test.MsSql.Repository.Purify
{
    public class ProductSaleByDayRepository : Repository<ProductSaleByDayEntity>, IProductSaleByDayRepository
    {
    }
}

