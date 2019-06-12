using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;

namespace LnskyDB.Helper
{
    internal static class TypeHelper
    {

        public static bool IsNameExpression(Expression exp)
        {
            if (exp == null)
            {
                return false;
            }
            bool result = false;
            switch (exp.NodeType)
            {
                case ExpressionType.MemberAccess:
                    result = true;
                    break;
                case ExpressionType.Convert:
                case ExpressionType.ConvertChecked:
                    if ((exp as UnaryExpression).Operand.NodeType == ExpressionType.MemberAccess)
                    {
                        result = true;
                    }
                    if ((exp as UnaryExpression).Operand.NodeType == ExpressionType.Convert|| (exp as UnaryExpression).Operand.NodeType == ExpressionType.ConvertChecked)
                    {
                        result = IsNameExpression((exp as UnaryExpression).Operand);
                    }
                    break;
            }
            return result;
        }
        public static Type FindIEnumerable(Type seqType)
        {
            if (seqType == null || seqType == typeof(string))
                return null;
            if (seqType.IsArray)
                return typeof(IEnumerable<>).MakeGenericType(seqType.GetElementType());
            if (seqType.IsGenericType)
            {
                foreach (var arg in seqType.GetGenericArguments())
                {
                    var ienum = typeof(IEnumerable<>).MakeGenericType(arg);
                    if (ienum.IsAssignableFrom(seqType))
                    {
                        return ienum;
                    }
                }
            }
            Type[] ifaces = seqType.GetInterfaces();
            if (ifaces.Length > 0)
            {
                foreach (Type iface in ifaces)
                {
                    Type ienum = FindIEnumerable(iface);
                    if (ienum != null) return ienum;
                }
            }
            if (seqType.BaseType != null && seqType.BaseType != typeof(object))
            {
                return FindIEnumerable(seqType.BaseType);
            }
            return null;
        }

        public static bool IsNullableType(Type type)
        {
            return type != null && type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>);
        }

        public static bool IsNullAssignable(Type type)
        {
            return !type.IsValueType || IsNullableType(type);
        }

        public static Type GetNonNullableType(Type type)
        {
            if (IsNullableType(type))
            {
                return type.GetGenericArguments()[0];
            }
            return type;
        }

        public static string GetColumnAttributeName(this PropertyInfo propertyInfo)
        {
            return propertyInfo.GetCustomAttribute<ColumnAttribute>()?.Name ?? propertyInfo.Name;
        }

        public static string GetTableAttributeName(this Type type)
        {
            return type.GetCustomAttribute<TableAttribute>()?.Name ?? type.Name;
        }
    }

}
