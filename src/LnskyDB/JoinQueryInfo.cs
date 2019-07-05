using Dapper;
using LnskyDB.Expressions;
using LnskyDB.Model;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB
{
    public class JoinQueryInfo<T> : IJoinQuery<T>
    {

        public DynamicParameters Param;

        public T Model { get; set; }
        public string JoinStr { get; set; }
        public string Where { get; set; }
        public Dictionary<string, string> Map { get; set; }


        public JoinQueryInfo(string joinStr, Dictionary<string, string> map, string where, DynamicParameters parameters)
        {
            JoinStr = joinStr;
            Map = map;
            Where = where;
            Param = parameters;
        }

        public IJoinQuery<TResult> InnerJoin<TR, TKey, TResult>(IQuery<TR> inner, Expression<Func<T, TKey>> outerKeySelector, Expression<Func<TR, TKey>> innerKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new()
        {
            return null;
        }
        public ISelectResult<TResult> Select<TResult>(Expression<Func<T, TResult>> select, bool firstTableSelectAll = false)
        {
            var selectResult = new JoinSelectExpression(select, Map);
            var selSql = string.Join(",", selectResult.QueryColumns);
            if (firstTableSelectAll)
            {
                if (!string.IsNullOrEmpty(selSql))
                {
                    selSql = "t1.*," + selSql;
                }
                else
                {
                    selSql = "t1.*";
                }
            }
            string sql = $"SELECT {selSql} FROM {JoinStr} WHERE 1=1 {Where}";

            return new SelectResult<TResult>(sql, Param);
        }

    }
}
