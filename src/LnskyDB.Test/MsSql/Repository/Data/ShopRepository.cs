using LnskyDB;
using LnskyDB.Test.MsSql.Entity.Data;
using LnskyDB.Test.MsSql.RepositoryInterface.Data;

namespace LnskyDB.Test.MsSql.Repository.Data
{
    public class ShopRepository : Repository<ShopEntity>, IShopRepository
    {
    }
}

