using System;
using System.Collections.Generic;
using System.Text;
using Dapper;
using LnskyDB.Model;

namespace LnskyDB.Internal
{
    internal class SelectResult<T> : ISelectResult<T>
    {
        public string SqlCmd { get; set; }
        public string CountSqlCmd { get; set; }
        public DynamicParameters Param { get; set; }
        public BaseDBModel DBModel { get; set; }

        public SelectResult(string sqlCmd, string countSqlCmd, DynamicParameters param)
        {
            SqlCmd = sqlCmd;
            CountSqlCmd = countSqlCmd;
            Param = param;
        }
        public bool Contains(T v)
        {
            throw new NotSupportedException("该方法不可直接调用");
        }
    }
}
