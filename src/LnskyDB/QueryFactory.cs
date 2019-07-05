using LnskyDB.Model;
using LnskyDB.Tool;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB
{
    public class QueryFactory
    {
        public static IQuery<T> Create<T>(Expression<Func<T, bool>> where) where T : BaseDBModel, new()
        {
            T obj = new T();
            return Create(obj).And(where);
        }
        public static IQuery<T> Create<T>() where T : BaseDBModel, new()
        {
            T obj = new T();
            return Create(obj);
        }
        private static IQuery<T> Create<T>(T obj) where T : BaseDBModel, new()
        {
            return new QueryInfo<T>(obj);
        }
    }
}
