using Dapper;
using LnskyDB.Expressions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB.Helper
{
    internal class JoinResultMapExpression : ExpressionVisitor
    {
        private readonly char _parameterPrefix;

        private readonly char _closeQuote;

        private readonly char _openQuote;



        string TableName { get; set; }
        private readonly StringBuilder _sqlCmd = new StringBuilder();
        private readonly StringBuilder _name = new StringBuilder();


        public Dictionary<string, string> MapList = new Dictionary<string, string>();
        Dictionary<string, string> _oldMap = new Dictionary<string, string>();


        public JoinResultMapExpression(LambdaExpression expression, Dictionary<string, string> left, string right)
        {
            _parameterPrefix = ProviderOption.Option.ParameterPrefix;
            _openQuote = ProviderOption.Option.OpenQuote;
            _closeQuote = ProviderOption.Option.CloseQuote;
            foreach (var v in left)
            {
                var key = string.IsNullOrEmpty(v.Key) ? expression.Parameters[0].Name : (expression.Parameters[0].Name + "." + v.Key);
                _oldMap.Add(key, v.Value);
            }
            _oldMap.Add(expression.Parameters[1].Name, right);

            Visit(expression);
            var trimLength = expression.Parameters[0].Name.Length + expression.Parameters[1].Name.Length + 1;
            _name.Remove(_name.Length - trimLength, trimLength);
            if (_sqlCmd.Length > 0 || _name.Length > 0)
            {
                _name.Remove(_name.Length - 1, 1);
                if (_sqlCmd.Length > 0)
                {
                    _sqlCmd.Insert(0, ".");
                }
                _sqlCmd.Insert(0, _oldMap[_name.ToString()]);
                MapList.Add("", _sqlCmd.ToString());
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
                    _sqlCmd.Insert(0, ".");
                }
                _sqlCmd.Insert(0, _oldMap[_name.ToString()]);
                MapList.Add(node.Members[i].Name, _sqlCmd.ToString());
                _sqlCmd.Clear();
                _name.Clear();
            }
            return node;
        }
        public override Expression Visit(Expression node)
        {
            return base.Visit(node);
        }
        protected override Expression VisitParameter(ParameterExpression node)
        {
            if (_name.Length > 0)
            {
                _name.Append(".");
            }
            _name.Append(node.Name);
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
            Visit(node.Expression);

            _sqlCmd.Append(_openQuote + node.Member.GetColumnAttributeName() + _closeQuote);
            return node;
        }

        #endregion




    }

}
