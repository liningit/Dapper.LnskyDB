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

namespace LnskyDB.Internal
{
    internal class QueryInfo<T> : IQuery<T> where T : BaseDBModel, new()
    {
        public long StarSize { get; set; }
        public int Rows { get; set; }
        public string TableWith { get { return DBModel.GetTableWith(); } set { DBModel.SetTableWith(value); } }
        public T DBModel { get; private set; }
        internal QueryInfo(T model)
        {
            DBModel = model;
            if (DBModel == null)
            {
                DBModel = new T();
            }
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

        public IJoinQuery<TResult> OuterJoin<TR, TKey, TResult>(IQuery<TR> rightQuery, Expression<Func<T, TKey>> leftKeySelector, Expression<Func<TR, TKey>> rightKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new()
        {
            return Join("LEFT OUTER", rightQuery, leftKeySelector, rightKeySelector, resultSelector);
        }
        public IJoinQuery<TResult> InnerJoin<TR, TKey, TResult>(IQuery<TR> rightQuery, Expression<Func<T, TKey>> leftKeySelector, Expression<Func<TR, TKey>> rightKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new()
        {
            return Join("INNER", rightQuery, leftKeySelector, rightKeySelector, resultSelector);
        }

        private IJoinQuery<TResult> Join<TR, TKey, TResult>(string type, IQuery<TR> rightQuery, Expression<Func<T, TKey>> leftKeySelector, Expression<Func<TR, TKey>> rightKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new()
        {
            var dynamicParameters = new DynamicParameters();
            var left = new JoinExpression(leftKeySelector, new Dictionary<string, string> { { "", "t1" } }, dynamicParameters);

            var right = new JoinExpression(rightKeySelector, new Dictionary<string, string> { { "", "t2" } }, dynamicParameters);
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
            var joinStr = $"{DBTool.GetTableName(DBModel)} t1 {DBTool.GetTableWith(this)} {type} JOIN {DBTool.GetTableName(rightQuery.DBModel)} t2  {DBTool.GetTableWith(rightQuery)} ON {sqlJoin}";

            var sel = new JoinResultMapExpression(resultSelector, new Dictionary<string, string> { { "", "t1" } }, "t2", dynamicParameters);
            StringBuilder sqlWhere = new StringBuilder();

            var where = new WhereExpression(this.WhereExpression, "t1", dynamicParameters);
            if (!string.IsNullOrEmpty(where.SqlCmd))
            {
                sqlWhere.Append(where.SqlCmd);

            }

            where = new WhereExpression(rightQuery.WhereExpression, "t2", dynamicParameters);
            if (!string.IsNullOrEmpty(where.SqlCmd))
            {
                sqlWhere.Append(where.SqlCmd);
            }

            return new JoinQueryInfo<TResult>(joinStr, 2, sel.MapList, sqlWhere.ToString(), dynamicParameters);
        }

        public ISelectResult<TResult> Select<TResult>(Expression<Func<T, TResult>> sel)
        {

            var dynamicParameters = new DynamicParameters();
            var selExp = new JoinSelectExpression(sel, new Dictionary<string, string> { { "", "[jtmp]" } }, dynamicParameters);
            var selSql = string.Join(",", selExp.QueryColumns).Replace("[jtmp].", "");
            var sql = new StringBuilder($"SELECT {selSql} FROM {DBTool.GetTableName(this.DBModel)} {DBTool.GetTableWith(this)} WHERE 1=1");
            var countSql = new StringBuilder($"SELECT COUNT(1) FROM {DBTool.GetTableName(this.DBModel)} {DBTool.GetTableWith(this)} WHERE 1=1");

            var whereExp = new WhereExpression(WhereExpression, "", dynamicParameters);
            sql.Append(whereExp.SqlCmd);
            countSql.Append(whereExp.SqlCmd);

            if (OrderbyList.Count > 0)
            {
                sql.Append($" ORDER BY ");
                var olst = OrderbyList.Select(m =>
                {
                    var order = new JoinOrderExpression(m.Field, new Dictionary<string, string> { { "", "" } }, dynamicParameters);
                    return order.SqlCmd + " " + m.OrderBy;
                });
                sql.Append(string.Join(",", olst) + " ");
            }

            if (StarSize != 0 || Rows != 0)
            {
                sql.Append($" OFFSET {StarSize } ROWS ");
                if (Rows != 0)
                {
                    sql.Append($"  FETCH NEXT {Rows} ROWS ONLY ");

                }
            }
            var sr = new SelectResult<TResult>(sql.ToString(), countSql.ToString(), dynamicParameters);
            sr.DBModel = DBModel;
            return sr;
        }
    }
}
