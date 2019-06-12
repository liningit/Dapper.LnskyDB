using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB.Model
{
    public class NoShuffledException : ApplicationException
    {
        public NoShuffledException(string table, string col) : base($"{table}表没有传入{col},分库分表进行数据库操作必须传入.")
        {

        }
    }
}
