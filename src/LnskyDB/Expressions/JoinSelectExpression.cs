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
    internal class JoinSelectExpression : ExpressionVisitor
    {
        private readonly StringBuilder _sqlCmd = new StringBuilder();


        public List<string> QueryColumns = new List<string>();
        public DynamicParameters Param { get; }

        private string _tempFieldName;

        private string TempFieldName
        {
            get => _tempFieldName + Param.ParameterNames.Count();
        }

        private string ParamName => _parameterPrefix + TempFieldName;


        private readonly char _parameterPrefix;

        private readonly char _closeQuote;

        private readonly char _openQuote;

        Dictionary<string, string> _map = new Dictionary<string, string>();

        public JoinSelectExpression(LambdaExpression expression, Dictionary<string, string> map)
        {
            foreach (var v in map)
            {
                var key = string.IsNullOrEmpty(v.Key) ? expression.Parameters[0].Name : (expression.Parameters[0].Name + "." + v.Key);
                _map.Add(key, v.Value);
            }
            _tempFieldName = "PJS_" + GetHashCode() + "_";
            _sqlCmd = new StringBuilder(100);
            Param = new DynamicParameters();


            _parameterPrefix = ProviderOption.Option.ParameterPrefix;
            _openQuote = ProviderOption.Option.OpenQuote;
            _closeQuote = ProviderOption.Option.CloseQuote;

            var exp = TrimExpression.Trim(expression);

            Visit(exp);
            if(_sqlCmd.Length>0)
            {
                QueryColumns.Add(_sqlCmd.ToString());
                _sqlCmd.Clear();
            }
        }


        #region 访问成员表达式
        /*   protected override Expression VisitNew(NewExpression node)
           {
               for (int i = 0; i < node.Arguments.Count; i++)
               {
                   Visit(node.Arguments[i]);
                   QueryColumns.Add(_sqlCmd.ToString() + " " + node.Members[i].Name);
                   _sqlCmd.Clear();
                   _name.Clear();
               }
               return node;
           }*/

        protected override Expression VisitMemberInit(MemberInitExpression node)
        {
            for (int i = 0; i < node.Bindings.Count; i++)
            {
                var m = node.Bindings[i] as MemberAssignment;
                Visit(m.Expression);
                // Visit(node.Bindings[i].);
                QueryColumns.Add(_sqlCmd.ToString() + " " + node.Bindings[i].Member.Name);
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

        #region 访问二元表达式
        /// <inheritdoc />
        /// <summary>
        /// 访问二元表达式
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        protected override System.Linq.Expressions.Expression VisitBinary(BinaryExpression node)
        {
            _sqlCmd.Append("(");

            VisitNode(node.Left, node.NodeType);

            _sqlCmd.Append(node.GetExpressionType());

            VisitNode(node.Right, node.NodeType);
            _sqlCmd.Append(")");

            return node;
        }

        private void VisitNode(Expression exp, ExpressionType ptype)
        {
            switch (ptype)
            {
                case ExpressionType.And:
                case ExpressionType.AndAlso:
                case ExpressionType.Or:
                case ExpressionType.OrElse:
                    Visit(exp);
                    return;
            }
            if (TypeHelper.IsNameExpression(exp))
            {
                Visit(exp);
                return;
            }
            switch (exp.NodeType)
            {

                case ExpressionType.Add:
                case ExpressionType.AddChecked:
                case ExpressionType.Divide:
                case ExpressionType.Multiply:
                case ExpressionType.MultiplyChecked:
                case ExpressionType.Subtract:
                case ExpressionType.SubtractChecked:
                    Visit(exp);
                    return;
                case ExpressionType.Call:
                    var f = exp as MethodCallExpression;
                    if (f.Method.DeclaringType == typeof(DBFunction))
                    {
                        _sqlCmd.Append(" " + f.Arguments[0].ToConvertAndGetValue() + "(");
                        var p = f.Arguments[1] as NewArrayExpression;
                        for (int i = 0; i < p.Expressions.Count; i++)
                        {
                            Visit(p.Expressions[i]);
                            if (i != p.Expressions.Count - 1)
                            {
                                _sqlCmd.Append(",");
                            }
                        }
                        _sqlCmd.Append(")");
                        return;
                    }
                    break;

            }

            SetParam(GetExpressionValue(exp));
        }


        #endregion

        #region 访问常量表达式
        /// <inheritdoc />
        /// <summary>
        /// 访问常量表达式
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        protected override System.Linq.Expressions.Expression VisitConstant(ConstantExpression node)
        {
            SetParam(node.Value);

            return node;
        }
        #endregion

        #region 访问方法表达式
        /// <inheritdoc />
        /// <summary>
        /// 访问方法表达式
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        protected override System.Linq.Expressions.Expression VisitMethodCall(MethodCallExpression node)
        {
            if (node.Method.Name == "Contains" && typeof(IEnumerable).IsAssignableFrom(node.Method.DeclaringType) && node.Method.DeclaringType != typeof(string))
                In(node);
            else if (node.Method.Name == "Contains" && typeof(Enumerable) == node.Method.DeclaringType && node.Method.DeclaringType != typeof(string))
                InEnumerable(node);
            else if (node.Method.Name == "Equals")
                Equal(node);
            else if (node.Method.Name == "IsNullOrEmpty")
                IsNullOrEmpty(node);
            else
                Like(node);

            return node;
        }




        #endregion

        private void SetParam(object value)
        {
            if (value != null)
            {
                _sqlCmd.Append(ParamName);
                Param.Add(TempFieldName, value);
            }
            else
            {
                _sqlCmd.Append("NULL");
            }
        }
        private void IsNullOrEmpty(MethodCallExpression node)
        {
            _sqlCmd.Append("(");
            Visit(node.Arguments[0]);
            _sqlCmd.AppendFormat(" IS NULL OR ");
            Visit(node.Arguments[0]);
            _sqlCmd.AppendFormat("=''");
            _sqlCmd.Append(")");
        }
        private void Like(MethodCallExpression node)
        {
            Visit(node.Object);
            _sqlCmd.AppendFormat(" LIKE {0}", ParamName);
            switch (node.Method.Name)
            {
                case "StartsWith":
                    {
                        var argumentExpression = (ConstantExpression)node.Arguments[0];
                        Param.Add(TempFieldName, argumentExpression.Value + "%");
                    }
                    break;
                case "EndsWith":
                    {
                        var argumentExpression = (ConstantExpression)node.Arguments[0];
                        Param.Add(TempFieldName, "%" + argumentExpression.Value);
                    }
                    break;
                case "Contains":
                    {
                        var argumentExpression = (ConstantExpression)node.Arguments[0];
                        Param.Add(TempFieldName, "%" + argumentExpression.Value + "%");
                    }
                    break;
                default:
                    throw new DapperExtensionException("the expression is no support this function");
            }
        }

        private void Equal(MethodCallExpression node)
        {
            Visit(node.Object);
            _sqlCmd.AppendFormat(" ={0}", ParamName);
            var argumentExpression = node.Arguments[0].ToConvertAndGetValue();
            Param.Add(TempFieldName, argumentExpression);
        }
        private void InEnumerable(MethodCallExpression node)
        {

            var arrayValue = (IEnumerable)((ConstantExpression)node.Arguments[0]).Value;
            var lst = arrayValue.Cast<object>();
            if (lst.Count() == 0)
            {
                _sqlCmd.Append(" 1 = 2");
                return;
            }
            Visit(node.Arguments[1]);
            _sqlCmd.AppendFormat(" IN {0}", ParamName);
            Param.Add(TempFieldName, lst.ToList());
        }

        private void In(MethodCallExpression node)
        {
            var arrayValue = (IList)((ConstantExpression)node.Object).Value;
            if (arrayValue.Count == 0)
            {
                _sqlCmd.Append(" 1 = 2");
                return;
            }
            Visit(node.Arguments[0]);
            _sqlCmd.AppendFormat(" IN {0}", ParamName);
            Param.Add(TempFieldName, arrayValue);
        }


        private object GetExpressionValue(Expression valueExpression)
        {
            if (valueExpression == null)
            {
                return null;
            }
            object result = null;
            switch (valueExpression.NodeType)
            {
                case ExpressionType.Constant:
                    result = ((ConstantExpression)valueExpression).Value;
                    break;
                case ExpressionType.Add:
                case ExpressionType.AddChecked:
                case ExpressionType.And:
                case ExpressionType.ArrayLength:
                case ExpressionType.ArrayIndex:
                case ExpressionType.Call:
                case ExpressionType.Coalesce:
                case ExpressionType.Conditional:
                case ExpressionType.Convert:
                case ExpressionType.ConvertChecked:
                case ExpressionType.Divide:
                case ExpressionType.Equal:
                case ExpressionType.ExclusiveOr:
                case ExpressionType.GreaterThan:
                case ExpressionType.GreaterThanOrEqual:
                case ExpressionType.Invoke:
                case ExpressionType.LeftShift:
                case ExpressionType.LessThan:
                case ExpressionType.LessThanOrEqual:
                case ExpressionType.MemberAccess:
                case ExpressionType.Modulo:
                case ExpressionType.Multiply:
                case ExpressionType.MultiplyChecked:
                case ExpressionType.Negate:
                case ExpressionType.NegateChecked:
                case ExpressionType.New:
                case ExpressionType.Not:
                case ExpressionType.NotEqual:
                case ExpressionType.Or:
                case ExpressionType.RightShift:
                case ExpressionType.Subtract:
                case ExpressionType.SubtractChecked:
                case ExpressionType.Decrement:
                case ExpressionType.Increment:
                case ExpressionType.OnesComplement:
                    result = Expression.Lambda(valueExpression).Compile().DynamicInvoke();
                    break;
            }
            return result;
        }
    }
}
