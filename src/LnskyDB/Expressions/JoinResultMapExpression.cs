using Dapper;
using LnskyDB.Expressions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB.Helper
{
    internal class JoinResultMapExpression : BaseExpressionVisitor
    {
        public Dictionary<string, string> MapList = new Dictionary<string, string>();
        Dictionary<string, string> _map = new Dictionary<string, string>();


        public JoinResultMapExpression(LambdaExpression expression, Dictionary<string, string> left, string right, DynamicParameters para) : base(para)
        {
            _tempFieldName = "PJR_" + GetHashCode() + "_";
            foreach (var v in left)
            {
                var key = string.IsNullOrEmpty(v.Key) ? expression.Parameters[0].Name : (expression.Parameters[0].Name + "." + v.Key);
                _map.Add(key, v.Value);
            }
            _map.Add(expression.Parameters[1].Name, right);

            Visit(expression.Body);

            if (_sqlCmd.Length > 0)
            {
                MapList.Add("", _sqlCmd.ToString());
            }
        }

        #region 访问成员表达式
        protected override Expression VisitNew(NewExpression node)
        {
            for (int i = 0; i < node.Arguments.Count; i++)
            {
                Visit(node.Arguments[i]);
                MapList.Add(node.Members[i].Name, _sqlCmd.ToString());
                _sqlCmd.Clear();

            }
            return node;
        }
        public override Expression Visit(Expression node)
        {
            return base.Visit(node);
        }
        protected override Expression VisitParameter(ParameterExpression node)
        {
            _sqlCmd.Append(_map[node.Name]);
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
