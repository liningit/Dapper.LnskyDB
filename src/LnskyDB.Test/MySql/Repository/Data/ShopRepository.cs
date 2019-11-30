using LnskyDB;
using LnskyDB.Test.MySql.Entity.Data;
using LnskyDB.Test.MySql.RepositoryInterface.Data;

namespace LnskyDB.Test.MySql.Repository.Data
{
    public class ShopRepository : Repository<ShopEntity>, IShopRepository
    {
    }
}

