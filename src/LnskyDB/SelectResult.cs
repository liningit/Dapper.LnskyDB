using System;
using System.Collections.Generic;
using System.Text;
using Dapper;

namespace LnskyDB
{
    public class SelectResult<T> : ISelectResult<T>
    {
        public string SqlCmd { get; set; }
        public DynamicParameters Param { get; set; }
        public SelectResult(string sqlCmd, DynamicParameters param)
        {
            SqlCmd = sqlCmd;
            Param = param;
        }
    }
}
