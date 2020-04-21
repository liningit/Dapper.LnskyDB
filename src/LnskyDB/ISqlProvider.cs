using LnskyDB.Expressions;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Text;

namespace LnskyDB
{
    /// <summary>
    /// 数据库提供程序
    /// </summary>
    public interface ISqlProvider
    {
        DbConnection GetConnection(string connStr);
        string GetLimit(long starSize, long row);
        ProviderOption GetProviderOption();
        string GetSelectIncrement();
    }
}
