using Dapper;
using LnskyDB.Helper;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB.Expressions
{
    internal sealed class JoinExpression : BaseExpressionVisitor
    {


        Dictionary<string, string> _map = new Dictionary<string, string>();


        public Dictionary<string, string> JoinDic { get; set; } = new Dictionary<string, string>();

        public JoinExpression(LambdaExpression expression, Dictionary<string, string> m, DynamicParameters para) : base(para)
        {

            _tempFieldName = "PJ_" + GetHashCode() + "_";
            foreach (var v in m)
            {
                var key = string.IsNullOrEmpty(v.Key) ? expression.Parameters[0].Name : (expression.Parameters[0].Name + "." + v.Key);
                _map.Add(key, v.Value);
            }

            var exp = TrimExpression.Trim(expression, false);
            Visit(exp);
            if (_sqlCmd.Length > 0)
            {
                JoinDic.Add("", _sqlCmd.ToString());
            }
        }


        #region 访问成员表达式

        protected override Expression VisitNew(NewExpression node)
        {
            for (int i = 0; i < node.Arguments.Count; i++)
            {
                Visit(node.Arguments[i]);
                JoinDic.Add(node.Members[i].Name, _sqlCmd.ToString());
                _sqlCmd.Clear();
            }
            return node;
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
                _map.TryGetValue(name, out val);
                val += "." + _openQuote + node.Member.GetColumnAttributeName() + _closeQuote;
            }
            _sqlCmd.Append(val);
            return node;
        }
        #endregion
    }
}
