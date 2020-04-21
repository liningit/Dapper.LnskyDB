using System;
using System.Data.Common;
using LnskyDB.Expressions;

namespace LnskyDB.MsSql
{
    public class MsSqlProvider : ISqlProvider
    {
        public DbConnection GetConnection(string connStr)
        {
            return new System.Data.SqlClient.SqlConnection(connStr);
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
                return $" OFFSET {starSize} ROWS";
            }

            return $" OFFSET {starSize} ROWS FETCH NEXT {row} ROWS ONLY";
        }
        static ProviderOption Option { get; } = new ProviderOption('[', ']', '@');
        public ProviderOption GetProviderOption()
        {
            return Option;
        }

        public string GetSelectIncrement()
        {
            return "select SCOPE_IDENTITY() as Id";
        }
    }
}
