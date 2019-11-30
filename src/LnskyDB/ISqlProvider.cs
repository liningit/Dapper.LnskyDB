using LnskyDB.Expressions;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Text;

namespace LnskyDB
{
    public interface ISqlProvider
    {
        DbConnection GetConnection(string connStr);
        string GetLimit(long starSize, long row);
        ProviderOption GetProviderOption();
        string GetSelectIncrement();
    }
}
