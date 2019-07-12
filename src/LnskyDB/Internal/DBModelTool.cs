using LnskyDB.Expressions;
using LnskyDB.Helper;
using LnskyDB;
using LnskyDB.Model;
using LnskyDB.Tool;
using Dapper;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using Microsoft.AspNetCore.Http;
using System.Threading;
using Microsoft.Extensions.DependencyInjection;
using static LnskyDB.LnskyDBExtensions;

namespace LnskyDB.Internal
{
    internal static class DBModelTool
    {
        internal static List<T> GetAll<T>(this DbConnection conn, int? commandTimeout = null) where T : BaseDBModel, new()
        {
            T obj = new T();
            var sql = $"SELECT * FROM [{DBTool.GetTableName(obj)}] ";
            try
            {
                var lst = conn.Query<T>(sql: sql, param: obj, commandTimeout: commandTimeout).AsList();
                lst.ForEach(m => { m.GetDBModel_ChangeList().Clear(); m.BeginChange(); });
                return lst;
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + JsonHelper.ToJSON(obj) + ExceptionTool.ToString(e));
                throw;
            }
        }

        private static string ToIQueryJSON<T>(DynamicParameters dynamicParameters, IQuery<T> query) where T : BaseDBModel
        {
            string str = "【";
            if (query.DBModel != null && query.DBModel.GetDBModel_ChangeList().Count > 0)
            {
                str += JsonHelper.ToJSON(query.DBModel) + "\n\t";
            }
            if (dynamicParameters != null)
            {
                foreach (var p in dynamicParameters.ParameterNames)
                {
                    str += p + ":" + dynamicParameters.Get<object>(p) + ",";
                }
                str += "\n\t";
            }
            str += "】";
            return str;
        }

        internal static long Count<T>(this DbConnection conn, IQuery<T> query, int? commandTimeout = null) where T : BaseDBModel
        {
            var sql = new StringBuilder($"SELECT COUNT(1) FROM [{DBTool.GetTableName(query.DBModel)}] WHERE 1=1 ");
            DynamicParameters dynamicParameters = SetWhereSql(query, sql, true);
            try
            {
                return conn.QuerySingleOrDefault<long>(sql: sql.ToString(), param: dynamicParameters, commandTimeout: commandTimeout);
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + ToIQueryJSON(dynamicParameters, query) + ExceptionTool.ToString(e));
                throw;
            }
        }
        internal static List<T> GetList<T>(this DbConnection conn, IQuery<T> query, int? commandTimeout = null) where T : BaseDBModel
        {
            var sql = new StringBuilder($"SELECT * FROM [{DBTool.GetTableName(query.DBModel)}] WHERE 1=1 ");
            DynamicParameters dynamicParameters = SetWhereSql(query, sql);
            try
            {
                var lst = conn.Query<T>(sql: sql.ToString(), param: dynamicParameters, commandTimeout: commandTimeout).AsList();
                lst.ForEach(m => { m.GetDBModel_ChangeList().Clear(); m.BeginChange(); });
                return lst;
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + ToIQueryJSON(dynamicParameters, query) + ExceptionTool.ToString(e));
                throw;
            }
        }

        internal static List<R> GetList<R, T>(this DbConnection conn, IQuery<T> query, int? commandTimeout = null) where T : BaseDBModel
        {
            var sql = new StringBuilder($"SELECT * FROM [{DBTool.GetTableName(query.DBModel)}] WHERE 1=1 ");
            DynamicParameters dynamicParameters = SetWhereSql(query, sql);
            try
            {
                var lst = conn.Query<R>(sql: sql.ToString(), param: dynamicParameters, commandTimeout: commandTimeout).AsList();
                return lst;
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + ToIQueryJSON(dynamicParameters, query) + ExceptionTool.ToString(e));
                throw;
            }
        }
        internal static T Get<T>(this DbConnection conn, T obj, int? commandTimeout = null) where T : BaseDBModel
        {
            if (obj.GetDBModel_ChangeList().Count == 0)
            {
                throw new Exception("没有筛选条件");
            }
            var sql = $"SELECT * FROM [{DBTool.GetTableName(obj)}] WHERE " + GetSql(obj.GetDBModel_ChangeList(), "AND");
            try
            {
                var res = conn.QueryFirstOrDefault<T>(sql: sql, param: obj, commandTimeout: commandTimeout);
                res?.GetDBModel_ChangeList().Clear();
                return res;
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + JsonHelper.ToJSON(obj) + ExceptionTool.ToString(e));
                throw;
            }
        }
        internal static int Update<T>(this DbConnection conn, T obj, IQuery<T> where, int? commandTimeout = null) where T : BaseDBModel
        {
            if (obj.GetDBModel_ChangeList().Count == 0)
            {
                throw new Exception("没有修改列");
            }

            var elst = obj.GetDBModel_PKCols().AddRange(obj.GetDBModel_ExcludeColsForUpdate());
            var updateList = obj.GetDBModel_ChangeList().Where(m => m != obj.GetDBModel_IncrementCol() && !elst.Contains(m)).ToList();

            var sql = new StringBuilder($"UPDATE [{DBTool.GetTableName(obj)}] SET {GetSql(updateList, ",")} WHERE 1=1");
            DynamicParameters dynamicParameters = SetWhereSql(where, sql);
            dynamicParameters.AddDynamicParams(obj);
            try
            {
                return conn.Execute(sql: sql.ToString(), param: dynamicParameters, commandTimeout: commandTimeout);
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + JsonHelper.ToJSON(obj) + ToIQueryJSON(dynamicParameters, where) + ExceptionTool.ToString(e));
                throw;
            }
        }

        internal static bool Update<T>(this DbConnection conn, T obj, int? commandTimeout = null) where T : BaseDBModel
        {
            if (obj.GetDBModel_ChangeList().Count == 0)
            {
                throw new Exception("没有修改列");
            }
            if (obj.GetDBModel_PKCols().Count == 0)
            {
                throw new Exception("没有主键");
            }
            var elst = obj.GetDBModel_PKCols().AddRange(obj.GetDBModel_ExcludeColsForUpdate());
            var updateList = obj.GetDBModel_ChangeList().Where(m => m != obj.GetDBModel_IncrementCol() && !elst.Contains(m)).ToList();
            var sql = $"UPDATE [{DBTool.GetTableName(obj)}] SET {GetSql(updateList, ",")} WHERE {GetSql(obj.GetDBModel_PKCols(), "AND")}";
            try
            {
                return conn.Execute(sql: sql, param: obj, commandTimeout: commandTimeout) > 0;
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + JsonHelper.ToJSON(obj) + ExceptionTool.ToString(e));
                throw;
            }
        }

        internal static bool Delete<T>(this DbConnection conn, T obj, int? commandTimeout = null) where T : BaseDBModel
        {
            if (obj.GetDBModel_PKCols().Count == 0)
            {
                throw new Exception("没有主键");
            }
            var sql = $"DELETE FROM [{DBTool.GetTableName(obj)}] WHERE {GetSql(obj.GetDBModel_PKCols(), "AND")}";
            try
            {
                return conn.Execute(sql: sql, param: obj, commandTimeout: commandTimeout) == 1;
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + JsonHelper.ToJSON(obj) + ExceptionTool.ToString(e));
                throw;
            }
        }
        internal static int Delete<T>(this DbConnection conn, IQuery<T> where, int? commandTimeout = null) where T : BaseDBModel
        {
            var sql = new StringBuilder($"DELETE FROM [{DBTool.GetTableName(where.DBModel)}] WHERE 1=1 ");
            DynamicParameters dynamicParameters = SetWhereSql(where, sql);

            try
            {
                return conn.Execute(sql: sql.ToString(), param: dynamicParameters, commandTimeout: commandTimeout);
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + ToIQueryJSON(dynamicParameters, where) + ExceptionTool.ToString(e));
                throw;
            }
        }
        internal static void Add<T>(this DbConnection conn, T obj, int? commandTimeout = null) where T : BaseDBModel
        {
            if (obj.GetDBModel_ChangeList().Count == 0)
            {
                throw new Exception("没有修改列");
            }
            var sql = $"INSERT INTO [{DBTool.GetTableName(obj)}]({string.Join(',', obj.GetDBModel_ChangeList())}) VALUES(@{string.Join(",@", obj.GetDBModel_ChangeList())});";
            try
            {
                if (!string.IsNullOrEmpty(obj.GetDBModel_IncrementCol()))
                {
                    sql += "select LAST_INSERT_ID() as Id";
                    var v = conn.ExecuteScalar<int>(sql: sql, param: obj, commandTimeout: commandTimeout);
                    obj.SetIncrementValue(v);
                }
                else
                {
                    conn.Execute(sql: sql, param: obj, commandTimeout: commandTimeout);
                }
                obj.GetDBModel_ChangeList().Clear();
            }
            catch (Exception e)
            {
                DBTool.DbError(e, sql.ToString() + JsonHelper.ToJSON(obj) + ExceptionTool.ToString(e));
                throw;
            }

        }


        internal static DynamicParameters SetWhereSql<T>(IQuery<T> query, StringBuilder sql, bool isOnlyWhere = false) where T : BaseDBModel
        {
            var dynamicParameters = new DynamicParameters();
            if (query.DBModel.GetDBModel_ChangeList().Count > 0)
            {
                throw new DapperExtensionException("查询实体不可以赋值!");
            }

            var whereSql = GetSql(query.DBModel.GetDBModel_ChangeList(), "AND", "");
            if (!string.IsNullOrEmpty(whereSql))
            {
                throw new DapperExtensionException("查询实体不可以赋值!");
                sql.Append(" AND ");
                sql.Append(whereSql);
                dynamicParameters.AddDynamicParams(query.DBModel);

            }

            var where = new WhereExpression(query.WhereExpression, "", dynamicParameters);
            sql.Append(where.SqlCmd);
            if (!isOnlyWhere)
            {
                sql.Append(GetOrderBy(query.OrderbyList, dynamicParameters));
                sql.Append(GetLimit(query));
            }
            return dynamicParameters;
        }

        private static string GetLimit<T>(IQuery<T> query) where T : BaseDBModel
        {
            if (query.StarSize < 0 || query.Rows < 0)
            {
                return "";
            }
            if (query.StarSize == 0 && query.Rows == 0)
            {
                return "";
            }
            if (query.Rows == 0)
            {
                return $" OFFSET {query.StarSize } ROWS";
            }

            return $" OFFSET {query.StarSize } ROWS FETCH NEXT {query.Rows} ROWS ONLY";
        }
        private static string GetOrderBy(List<OrderCriteria> orderByLst, DynamicParameters dynamicParameters)
        {
            var orderByList = orderByLst.Select(a =>
            {

                var o = new JoinOrderExpression(a.Field, new Dictionary<string, string> { { "", "" } }, dynamicParameters);
                return o.SqlCmd + (a.OrderBy == EOrderBy.Asc ? " ASC " : " DESC ");
            }).ToList();

            if (!orderByList.Any())
                return "";
            return "ORDER BY " + string.Join(",", orderByList);
        }

        private static string GetSql(ICollection<string> keys, string addPre, string tableAlias = "")
        {
            if (!string.IsNullOrEmpty(tableAlias))
            {
                tableAlias += ".";
            }
            StringBuilder sql = new StringBuilder();
            foreach (var k in keys)
            {
                if (sql.Length > 0)
                {
                    sql.Append($" {addPre} ");
                }
                sql.Append($"{tableAlias}[{k}]=@{k}");
            }
            return sql.ToString();
        }

    }
}
