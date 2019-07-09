using System;
using System.Collections.Generic;
using System.Text;
using Dapper;

namespace LnskyDB.Internal
{
    internal class SelectResult<T> : ISelectResult<T>
    {
        public string SqlCmd { get; set; }
        public string CountSqlCmd { get; set; }
        public DynamicParameters Param { get; set; } 
        public SelectResult(string sqlCmd, string countSqlCmd, DynamicParameters param )
        {
            SqlCmd = sqlCmd;
            CountSqlCmd = countSqlCmd;
            Param = param;
        }
    }
}
