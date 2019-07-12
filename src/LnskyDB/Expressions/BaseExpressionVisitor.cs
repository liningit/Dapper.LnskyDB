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
    internal class BaseExpressionVisitor : ExpressionVisitor
    {
        public BaseExpressionVisitor(DynamicParameters param)
        {
            Param = param;
        }
        protected readonly StringBuilder _sqlCmd = new StringBuilder();


        public DynamicParameters Param { get; private set; }

        protected string _tempFieldName;

        protected string TempFieldName
        {
            get => _tempFieldName + Param.ParameterNames.Count();
        }

        private string ParamName => _parameterPrefix + TempFieldName;


        protected readonly char _parameterPrefix = ProviderOption.Option.ParameterPrefix;

        protected readonly char _closeQuote = ProviderOption.Option.CloseQuote;

        protected readonly char _openQuote = ProviderOption.Option.OpenQuote;

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
                    if ((exp as MethodCallExpression).Method.DeclaringType == typeof(DBFunction))
                    {
                        Visit(exp);
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
            if (node.Method.DeclaringType == typeof(DBFunction))
            {
                DBFunction(node);
                return node;
            }
            if (node.Method.DeclaringType.IsGenericType && node.Method.DeclaringType.GetGenericTypeDefinition() == typeof(ISelectResult<>))
            {
                SelectResultAnalysis(node);
                return node;
            }
            if (Array.Exists(node.Method.DeclaringType.GetInterfaces(), t => t.IsGenericType && t.GetGenericTypeDefinition() == typeof(ISelectResult<>)))
            {
                return node;
            }
            if (node.Method.Name == "Contains" && typeof(IEnumerable).IsAssignableFrom(node.Method.DeclaringType) && node.Method.DeclaringType != typeof(string))
            {
                In(node);
                return node;
            }
            if (node.Method.Name == "Contains" && typeof(Enumerable) == node.Method.DeclaringType && node.Method.DeclaringType != typeof(string))
            {
                InEnumerable(node);
                return node;
            }
            if (node.Method.Name == "Equals")
            {
                Equal(node);
                return node;
            }
            if (node.Method.Name == "IsNullOrEmpty")
            {
                IsNullOrEmpty(node);
                return node;
            }

            Like(node);
            return node;

        }

        private void SelectResultAnalysis(MethodCallExpression node)
        {
            if (node.Method.Name == "Contains")
            {
                Visit(node.Arguments[0]);
                _sqlCmd.AppendFormat(" IN (");
                var t = ((ConstantExpression)node.Object).Value as IBaseSelectResult;
                _sqlCmd.Append(t.SqlCmd);
                _sqlCmd.Append(")");

                Param.AddDynamicParams(t.Param);
            }
        }

        private void DBFunction(MethodCallExpression node)
        {
            _sqlCmd.Append(" " + node.Arguments[0].ToConvertAndGetValue() + "(");
            var p = node.Arguments[1] as NewArrayExpression;
            for (int i = 0; i < p.Expressions.Count; i++)
            {
                Visit(p.Expressions[i]);
                if (i != p.Expressions.Count - 1)
                {
                    _sqlCmd.Append(",");
                }
            }
            _sqlCmd.Append(")");
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
