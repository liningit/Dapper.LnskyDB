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
        string _namePre = string.Empty;

        public JoinResultMapExpression(LambdaExpression expression, Dictionary<string, string> left, string right, DynamicParameters para, ISqlProvider sqlProvider) : base(para, sqlProvider)
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
                _sqlCmd.Clear();
            }
            if (!string.IsNullOrEmpty(_namePre))
            {
                _namePre = _namePre + ".";
                foreach (var d in _map)
                {
                    if (d.Key.StartsWith(_namePre))
                    {
                        MapList.Add(d.Key.Substring(_namePre.Length), d.Value);
                    }
                }
                _namePre = "";
            }
        }

        #region 访问成员表达式
        protected override Expression VisitNew(NewExpression node)
        {
            for (int i = 0; i < node.Arguments.Count; i++)
            {
                Visit(node.Arguments[i]);
                if (_sqlCmd.Length > 0)
                {
                    MapList.Add(node.Members[i].Name, _sqlCmd.ToString());
                }
                if (!string.IsNullOrEmpty(_namePre))
                {
                    _namePre = _namePre + ".";
                    foreach (var d in _map)
                    {
                        if (d.Key.StartsWith(_namePre))
                        {
                            MapList.Add(node.Members[i].Name + "." + d.Key.Substring(_namePre.Length), d.Value);
                        }
                    }
                }
                _sqlCmd.Clear();
                _namePre = string.Empty;
            }
            return node;
        }
        public override Expression Visit(Expression node)
        {
            return base.Visit(node);
        }
        protected override Expression VisitParameter(ParameterExpression node)
        {
            if (_map.ContainsKey(node.Name))
            {
                _sqlCmd.Append(_map[node.Name]);
            }
            else
            {
                _namePre = node.Name;
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
                if (_map.TryGetValue(name, out val))
                {
                    val += "." + _openQuote + node.Member.GetColumnAttributeName() + _closeQuote;
                }
                else
                {
                    _namePre = node.ToString();
                }
            }
            _sqlCmd.Append(val);
            return node;
        }

        #endregion




    }

}
