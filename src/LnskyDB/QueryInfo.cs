using LnskyDB.Expressions;
using LnskyDB.Model;
using System;
using System.Collections.Generic;
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
    }
}
