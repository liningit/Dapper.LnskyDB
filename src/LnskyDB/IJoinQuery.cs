using LnskyDB.Model;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB
{
    public interface IJoinQuery<T>
    {
        long StarSize { get; set; }
        int Rows { get; set; }
        List<OrderCriteria> OrderbyList { get; }
        LambdaExpression WhereExpression { get; }
        IJoinQuery<T> And(Expression<Func<T, bool>> predicate);


        IJoinQuery<T> Or(Expression<Func<T, bool>> predicate);


        IJoinQuery<T> OrderBy<TProperty>(Expression<Func<T, TProperty>> field);

        IJoinQuery<T> OrderByDescing<TProperty>(Expression<Func<T, TProperty>> field);
    
        ISelectResult<TResult> Select<TResult>(Expression<Func<T, TResult>> outerKeySelector, bool firstTableSelectAll = false);

        IJoinQuery<TResult> OuterJoin<TR, TKey, TResult>(IQuery<TR> inner, Expression<Func<T, TKey>> outerKeySelector, Expression<Func<TR, TKey>> innerKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new();
        IJoinQuery<TResult> InnerJoin<TR, TKey, TResult>(IQuery<TR> inner, Expression<Func<T, TKey>> outerKeySelector, Expression<Func<TR, TKey>> innerKeySelector, Expression<Func<T, TR, TResult>> resultSelector) where TR : BaseDBModel, new();

    }
}
