using Dapper;
using LnskyDB.Expressions;
using LnskyDB.Helper;
using LnskyDB.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;

namespace LnskyDB
{
    internal class QueryInfo<T> : IQuery<T> where T : BaseDBModel, new()
    {
        public long StarSize { get; set; }
        public int Rows { get; set; }
        public T DBModel { get; private set; }
        internal QueryInfo(T model)
        {
            DBModel = model;
        }
        public List<OrderCriteria> OrderbyList { get; private set; } = new List<OrderCriteria>();
        public LambdaExpression WhereExpression { get; private set; }

        public IQuery<T> And(Expression<Func<T, bool>> predicate)
        {
            WhereExpression = WhereExpression == null ? predicate : ((Expression<Func<T, bool>>)WhereExpression).And(predicate);
            return this;
        }
        public IQuery<T> And(IQuery<T> query)
        {
            WhereExpression = WhereExpression == null ? query.WhereExpression : ((Expression<Func<T, bool>>)WhereExpression).And((Expression<Func<T, bool>>)query.WhereExpression);
            return this;
        }
        public IQuery<T> Or(Expression<Func<T, bool>> predicate)
        {
            WhereExpression = WhereExpression == null ? predicate : ((Expression<Func<T, bool>>)WhereExpression).Or(predicate);
            return this;
        }
        public IQuery<T> Or(IQuery<T> query)
        {
            WhereExpression = WhereExpression == null ? query.WhereExpression : ((Expression<Func<T, bool>>)WhereExpression).Or((Expression<Func<T, bool>>)query.WhereExpression);
            return this;
        }
        public IQuery<T> OrderBy<TProperty>(Expression<Func<T, TProperty>> field)
        {
            if (field != null)
                OrderbyList.Add(new OrderCriteria { OrderBy = EOrderBy.Asc, Field = field });
            return this;
        }

        public IQuery<T> OrderByDescing<TProperty>(Expression<Func<T, TProperty>> field)
        {
            if (field != null)
                OrderbyList.Add(new OrderCriteria { OrderBy = EOrderBy.Desc, Field = field });
            return this;
        }

        private IQuery<T> QueryiSearch(string propertyName, string queryVal)
        {
            string tempQueryFiled = string.Empty;
            while (tempQueryFiled != queryVal)
            {
                tempQueryFiled = queryVal;
                queryVal = queryVal.Replace("+ ", "+").Replace(" +", "+");
            }
            var query_Search = QueryFactory.Create<T>();

            string[] lst = queryVal.Split(new string[] { " ", "	", "　", "	" }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var f in lst)
            {
                if (string.IsNullOrWhiteSpace(f))
                {
                    continue;
                }
                var q = QueryFactory.Create<T>();
                string[] lstInfo;
                if (f.Contains("+") || f.Contains("＋"))
                {
                    lstInfo = f.Split(new string[] { "+", "＋" }, StringSplitOptions.RemoveEmptyEntries);

                }
                else
                {
                    lstInfo = new string[] { f };
                }
                foreach (var info in lstInfo)
                {
                    if (!string.IsNullOrWhiteSpace(info))
                    {
                        q.And(DBTool.GetContains<T>(propertyName, info));
                    }
                }
                query_Search.Or(q);
            }
            return And(query_Search);
        }


        public IQuery<T> QueryiSearch<TProperty>(Expression<Func<T, TProperty>> field, string queryVal)
        {
            return QueryiSearch(((MemberExpression)field.Body).Member.Name, queryVal);
        }

        public IJoinQuery<TResult> InnerJoin<TR, TKey, TResult>(IQuery<TR> rightQuery, Expression<Func<T, TKey>> leftKeySelector, Expression<Func<TR, TKey>> rightKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new()
        {

            var left = new JoinExpression(leftKeySelector, "t1");
            var right = new JoinExpression(rightKeySelector, "t2");
            StringBuilder sqlJoin = new StringBuilder();
            foreach (var v in left.JoinDic)
            {
                if (sqlJoin.Length > 0)
                {
                    sqlJoin.Append(" AND ");
                }
                sqlJoin.Append("(");
                sqlJoin.Append(v.Value);
                sqlJoin.Append("=");
                sqlJoin.Append(right.JoinDic[v.Key]);
                sqlJoin.Append(")");
            }
            var joinStr = $"{DBTool.GetTableName(DBModel)} t1 INNER JOIN {DBTool.GetTableName(rightQuery.DBModel)} t2 ON {sqlJoin}";

            var sel = new JoinResultMapExpression(resultSelector, new Dictionary<string, string> { { "", "t1" } }, "t2");
            StringBuilder sqlWhere = new StringBuilder();
            var dynamicParameters = new DynamicParameters();
            var where = new WhereExpression(this.WhereExpression, "", "t1");
            if (!string.IsNullOrEmpty(where.SqlCmd))
            {
                sqlWhere.Append(where.SqlCmd);
                dynamicParameters.AddDynamicParams(where.Param);
            }

            where = new WhereExpression(rightQuery.WhereExpression, "", "t2");
            if (!string.IsNullOrEmpty(where.SqlCmd))
            {
                sqlWhere.Append(where.SqlCmd);
                dynamicParameters.AddDynamicParams(where.Param);
            }

            return new JoinQueryInfo<TResult>(joinStr, sel.MapList, sqlWhere.ToString(), dynamicParameters);
        }


    }
}
