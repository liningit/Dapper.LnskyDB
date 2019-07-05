using LnskyDB.Helper;
using Dapper;
using System;
using System.Collections;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB.Expressions
{
    internal sealed class WhereExpression : BaseExpressionVisitor
    {
        #region sql指令

        /// <summary>
        /// sql指令
        /// </summary>
        public  string SqlCmd => _sqlCmd.Length > 0 ? $" AND {_sqlCmd} " : "";    
        private readonly string _prefix;
        private readonly string _tableAlias;
        #endregion
        #region 执行解析

        /// <inheritdoc />
        /// <summary>
        /// 执行解析
        /// </summary>
        /// <param name="expression"></param>
        /// <param name="prefix">字段前缀</param>
        /// <param name="providerOption"></param>
        /// <returns></returns>
        public WhereExpression(LambdaExpression expression, string prefix, string tableAlias, DynamicParameters para) : base(para)
        {
            _tempFieldName = "P_" + tableAlias + GetHashCode() + "_";     
            _prefix = prefix;       
            if (!string.IsNullOrEmpty(tableAlias))
            {
                _tableAlias = tableAlias + ".";
            }
            var exp = TrimExpression.Trim(expression);
            Visit(exp);
        }
        #endregion
        #region 访问成员表达式

        /// <inheritdoc />
        /// <summary>
        /// 访问成员表达式
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        protected override System.Linq.Expressions.Expression VisitMember(MemberExpression node)
        {
            _sqlCmd.Append(_tableAlias + _openQuote + node.Member.GetColumnAttributeName() + _closeQuote);
            return node;
        }
        #endregion
    }

}