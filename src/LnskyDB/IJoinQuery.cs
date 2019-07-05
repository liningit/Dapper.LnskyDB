using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB
{
    public interface IJoinQuery<T>
    {
        T Model { get; set; }
        ISelectResult<TResult> Select<TResult>(Expression<Func<T, TResult>> outerKeySelector, bool firstTableSelectAll = false);
    }
}
