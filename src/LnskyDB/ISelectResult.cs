using Dapper;
using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB
{
    public interface ISelectResult<T>
    {
        string SqlCmd { get; set; }
        string CountSqlCmd { get; set; }
        DynamicParameters Param { get; set; }    }
}
