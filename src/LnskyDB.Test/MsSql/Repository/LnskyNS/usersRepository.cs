using LnskyDB;
using LnskyDB.Test.MsSql.Entity.LnskyNS;
using LnskyDB.Test.MsSql.RepositoryInterface.LnskyNS;

namespace LnskyDB.Test.MsSql.Repository.LnskyNS
{
    public class usersRepository : Repository<usersEntity>, IusersRepository
    {
    }
}

