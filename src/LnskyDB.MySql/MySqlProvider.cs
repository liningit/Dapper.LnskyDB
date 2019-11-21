using LnskyDB.Expressions;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Text;

namespace LnskyDB.MySql
{
    public class MySqlProvider : ISqlProvider
    {
        public DbConnection GetConnection(string connStr)
        {
            return new MySqlConnection(connStr);
        }

        public string GetLimit(long starSize, long row)
        {
            if (starSize < 0 || row < 0)
            {
                return "";
            }
            if (starSize == 0 && row == 0)
            {
                return "";
            }
            if (row == 0)
            {
                row = -1;
            }
            return $" LIMIT {starSize},{row} ";
        }
        static ProviderOption Option { get; } = new ProviderOption('`', '`', '@');
        public ProviderOption GetProviderOption()
        {
            return Option;
        }
    }
}
