using Dapper;
using LnskyDB.Helper;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB.Expressions
{
    internal class JoinOrderExpression : BaseExpressionVisitor
    {
        Dictionary<string, string> _map = new Dictionary<string, string>();


        public string SqlCmd => _sqlCmd.Length > 0 ? $" {_sqlCmd} " : "";
        public JoinOrderExpression(LambdaExpression expression, Dictionary<string, string> m, DynamicParameters para) : base(para)
        {

            _tempFieldName = "PJO_" + GetHashCode() + "_";
            foreach (var v in m)
            {
                var key = string.IsNullOrEmpty(v.Key) ? expression.Parameters[0].Name : (expression.Parameters[0].Name + "." + v.Key);
                _map.Add(key, v.Value);
            }

            var exp = TrimExpression.Trim(expression, false);
            Visit(exp);
        }
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
                if (_map.TryGetValue(name, out val))
                {
                    if (!string.IsNullOrEmpty(val))
                    {
                        val += ".";
                    }
                    val += _openQuote + node.Member.GetColumnAttributeName() + _closeQuote;
                }
                else
                {
                    throw new DapperExtensionException($"无法解析{node}");
                }
            }
            _sqlCmd.Append(val);
            return node;
        }
    }
}
