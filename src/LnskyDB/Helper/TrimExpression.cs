using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace LnskyDB.Helper
{
    internal class TrimExpression : ExpressionVisitor
    {
        private bool _isDeep;

        public static Expression Trim(Expression expression)
        {
            return new TrimExpression().Visit(expression);
        }

        private Expression Sub(Expression expression)
        {
            var type = expression.Type;
            switch (expression.NodeType)
            {
                case ExpressionType.Constant:
                    if (TypeHelper.GetNonNullableType(expression.Type) == TypeHelper.GetNonNullableType(type))
                        return Expression.Constant(((ConstantExpression)expression).Value, type);
                    break;

                case ExpressionType.MemberAccess:
                    var mExpression = expression as MemberExpression;
                    var root = mExpression.GetRootMember();
                    if (root != null)
                    {
                        var value = mExpression.MemberToValue(root);
                        return Expression.Constant(value, type);
                    }
                    else
                    {
                        if (_isDeep)
                            return expression;

                        _isDeep = true;
                        return Expression.Equal(expression, Expression.Constant(true));
                    }

                case ExpressionType.Convert:
                    var u = (UnaryExpression)expression;
                    if (TypeHelper.GetNonNullableType(u.Operand.Type) == TypeHelper.GetNonNullableType(type))
                    {
                        expression = u.Operand;
                        expression = Sub(expression);
                        if (expression.NodeType == ExpressionType.Constant)
                        {
                            return Expression.Constant(((ConstantExpression)expression).Value, type);
                        }
                        else
                        {
                            return u;
                        }
                    }

                    if (u.Operand.Type.IsEnum && u.Operand.NodeType == ExpressionType.MemberAccess)
                    {
                        var mem = u.Operand as MemberExpression;
                        if (mem.Expression.NodeType == ExpressionType.Parameter)
                        {
                            return expression;
                        }
                        else
                        {
                            var value = Convert.ChangeType(mem.MemberToValue(), type);
                            return Expression.Constant(value, type);
                        }
                    }
                    break;

                case ExpressionType.Not:
                    var n = (UnaryExpression)expression;
                    return Expression.Equal(n.Operand, Expression.Constant(false));
                case ExpressionType.AndAlso:
                case ExpressionType.OrElse:
                    var b = (BinaryExpression)expression;
                    _isDeep = true;
                    if (b.Left.NodeType != b.Right.NodeType)
                    {
                        if ((b.Left.NodeType == ExpressionType.MemberAccess || b.Left.NodeType == ExpressionType.Constant) && b.Left.Type.Name == "Boolean")
                        {
                            if (expression.NodeType == ExpressionType.AndAlso)
                                return Expression.AndAlso(Expression.Equal(b.Left, Expression.Constant(true)), b.Right);
                            if (expression.NodeType == ExpressionType.OrElse)
                                return Expression.OrElse(Expression.Equal(b.Left, Expression.Constant(true)), b.Right);
                        }
                        if ((b.Right.NodeType == ExpressionType.MemberAccess || b.Right.NodeType == ExpressionType.Constant) && b.Right.Type.Name == "Boolean")
                        {
                            if (expression.NodeType == ExpressionType.AndAlso)
                                return Expression.AndAlso(b.Left, Expression.Equal(b.Right, Expression.Constant(true)));
                            if (expression.NodeType == ExpressionType.OrElse)
                                return Expression.OrElse(b.Left, Expression.Equal(b.Right, Expression.Constant(true)));
                        }
                        return b;
                    }
                    break;
                default:
                    _isDeep = true;
                    return expression;
            }

            return expression;
        }

        public override Expression Visit(Expression exp)
        {
            if (exp == null)
                return null;

            var exp2 = Sub(exp);
            var temp = base.Visit(exp2);
            return temp;
        }

    }
}
