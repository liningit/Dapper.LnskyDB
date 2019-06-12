using LnskyDB;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB.Model
{
    public class OrderCriteria
    {
        public EOrderBy OrderBy { get; set; }
        public LambdaExpression Field { get; set; }
    }
}
