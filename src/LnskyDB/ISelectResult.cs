using Dapper;
using LnskyDB.Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB
{
    public interface IBaseSelectResult
    {
        string SqlCmd { get; set; }
        string CountSqlCmd { get; set; }
        BaseDBModel DBModel { get; set; }
        DynamicParameters Param { get; set; }
    }
    public interface ISelectResult<T> : IBaseSelectResult
    {

        bool Contains(T v);
    }
}
