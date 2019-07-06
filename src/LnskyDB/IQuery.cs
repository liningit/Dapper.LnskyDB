using LnskyDB.Expressions;
using LnskyDB.Model;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB
{
    public interface IQuery<T> where T : BaseDBModel
    {

        long StarSize { get; set; }
        int Rows { get; set; }
        List<OrderCriteria> OrderbyList { get; }
        LambdaExpression WhereExpression { get; }
        T DBModel { get; }
        IQuery<T> And(Expression<Func<T, bool>> predicate);
        IQuery<T> And(IQuery<T> query);

        IQuery<T> Or(Expression<Func<T, bool>> predicate);
        IQuery<T> Or(IQuery<T> query);

        IQuery<T> OrderBy<TProperty>(Expression<Func<T, TProperty>> field);

        IQuery<T> OrderByDescing<TProperty>(Expression<Func<T, TProperty>> field);
        IQuery<T> QueryiSearch<TProperty>(Expression<Func<T, TProperty>> field, string queryVal);

        IJoinQuery<TResult> OuterJoin<TR, TKey, TResult>(IQuery<TR> inner, Expression<Func<T, TKey>> outerKeySelector, Expression<Func<TR, TKey>> innerKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new();
        IJoinQuery<TResult> InnerJoin<TR, TKey, TResult>(IQuery<TR> inner, Expression<Func<T, TKey>> outerKeySelector, Expression<Func<TR, TKey>> innerKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new();

    }
}
