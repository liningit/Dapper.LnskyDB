using LnskyDB.Helper;
using Dapper;
using System;
using System.Collections;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Collections.Generic;

namespace LnskyDB.Expressions
{
    internal sealed class JoinWhereExpression : BaseExpressionVisitor
    {
        #region sql指令

        /// <summary>
        /// sql指令
        /// </summary>
        public string SqlCmd => _sqlCmd.Length > 0 ? $" AND {_sqlCmd} " : "";

        Dictionary<string, string> _map = new Dictionary<string, string>();

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
        public JoinWhereExpression(LambdaExpression expression, Dictionary<string, string> map, DynamicParameters para) : base(para)
        {
            if (expression == null)
            {
                return;
            }
            foreach (var v in map)
            {
                var key = string.IsNullOrEmpty(v.Key) ? expression.Parameters[0].Name : (expression.Parameters[0].Name + "." + v.Key);
                _map.Add(key, v.Value);
            }
            _tempFieldName = "PJW_" + GetHashCode() + "_";

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
            var name = node.ToString();
            if (!_map.TryGetValue(name, out var val))
            {
                name = name.Remove(name.LastIndexOf("."));
                _map.TryGetValue(name, out val);
                val += "." + _openQuote + node.Member.GetColumnAttributeName() + _closeQuote;
            }
            _sqlCmd.Append(val);
            return node;
        }
        #endregion
    }

}