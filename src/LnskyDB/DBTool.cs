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

namespace LnskyDB
{
    public class DBTool
    {
        public static string LnskyDBConnLstThreadId { get; } = "LnskyDBConnLst";

        public static event LnskyDBEventHandler<LnskyDBErrorArgs> Error;
        /// <summary>
        /// ThreadStatic表示每个线程都是独立对象
        /// </summary>
        [ThreadStatic] private static LnskyDBConnLst ThreadLnskyDBConnLst;

        /// <summary>
        /// 获取当前请求的数据库连接列表
        /// </summary>
        internal static LnskyDBConnLst GetRequestConnLst()
        {
            if (ThreadLnskyDBConnLst != null)
            {
                return ThreadLnskyDBConnLst;
            }
            if (HttpContext.HttpContext != null && HttpContext.HttpContext.RequestServices != null)
            {
                var url = HttpContext.HttpContext.Request;
                return HttpContext.HttpContext.RequestServices.GetService<LnskyDBConnLst>();
            }
            throw new Exception("没有取到ConnLst");

        }
        /// <summary>
        /// 当在线程中使用时要在开始调用
        /// </summary>
        public static void BeginThread()
        {
            ThreadLnskyDBConnLst = new LnskyDBConnLst();
        }
        /// <summary>
        /// 关闭当前请求的连接
        /// </summary>
        public static void CloseConnections()
        {
            var reqModel = GetRequestConnLst();
            if (reqModel.ConnLst.Count > 0)
            {
                foreach (var conn in reqModel.ConnLst)
                {
                    try
                    {
                        conn.Value.Close();
                    }
                    catch (Exception e)
                    {

                        DbError(e, ExceptionTool.ToString(e));
                    }
                }
                reqModel.ConnLst.Clear();
            }
            ThreadLnskyDBConnLst = null;
        }
        internal static IConfiguration Configuration { get; set; }
        internal static IHttpContextAccessor HttpContext { get; set; }

        internal static Expression<Func<T, bool>> GetContains<T>(string propertyName, string propertyValue)
        {
            ParameterExpression parameter = Expression.Parameter(typeof(T), "p");
            MemberExpression member = Expression.PropertyOrField(parameter, propertyName);
            MethodInfo method = typeof(string).GetMethod("Contains", new[] { typeof(string) });
            ConstantExpression constant = Expression.Constant(propertyValue, typeof(string));
            return Expression.Lambda<Func<T, bool>>(Expression.Call(member, method, constant), parameter);
        }
        public static DbConnection GetConnection<T>(T obj) where T : BaseDBModel, new()
        {
            if (obj == null)
            {
                obj = new T();
            }
            return GetConnection(obj.GetDBModel_DBName(), obj.GetShuffledModel());
        }
        public static DbConnection GetConnection(string key, ShuffledModel shuffle)
        {
            var connStr = Configuration.GetConnectionString(string.Format(key, shuffle.DBId));
            if (string.IsNullOrEmpty(connStr))
            {
                connStr = Configuration.GetConnectionString(string.Format(key, ""));
            }
            connStr = string.Format(connStr, shuffle.DBId);
            var connLst = GetRequestConnLst().ConnLst;
            DbConnection conn;
            connLst.TryGetValue(connStr, out conn);
            if (conn == null)
            {
                conn = new SqlConnection(connStr);
                connLst.Add(connStr, conn);
            }
            try
            {
                if (conn.State != ConnectionState.Open)
                {
                    conn.Open();
                }
            }
            catch
            {
                conn.Close();
                throw;
            }

            return conn;
        }



        public static string GetTableName(BaseDBModel model)
        {
            return string.Format(model.GetDBModel_TableName(), model.GetShuffledModel().TableId);
        }
        internal static void DbError(Exception e, string v)
        {
            if (Error != null)
            {
                Error(new LnskyDBErrorArgs { Exception = e, LogInfo = v });
            }
        }
        /// <summary>
        /// 将中文加号等转换成英文
        /// </summary>
        public static string ReplaceSearch(string search)
        {
            search = search.Replace(" ", " ").Replace("	", " ").Replace("　", " ").Replace("	", " ");
            search = search.Replace("+", "+").Replace("＋", "+");
            return search;
        }
        /// <summary>
        /// 检查name是否符合搜索条件
        /// </summary>
        public static bool CheckNameSearch(string name, string search)
        {
            if (string.IsNullOrEmpty(name))
            {
                return false;
            }
            if (string.IsNullOrEmpty(search))
            {
                return true;
            }
            var lstSet = search.Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var sinfo in lstSet)
            {
                if (string.IsNullOrEmpty(sinfo))
                {
                    continue;
                }
                bool isOk = true;
                foreach (var info in sinfo.Split(new string[] { "+" }, StringSplitOptions.RemoveEmptyEntries))
                {
                    if (!name.Contains(info))
                    {
                        isOk = false;
                    }
                }
                if (isOk)
                {
                    return true;
                }

            }
            return false;
        }
    }
    internal static class DBModelTool
    {
        internal static List<T> GetAll<T>(this DbConnection conn, int? commandTimeout = null) where T : BaseDBModel, new()
        {
            T obj = new T();
            var sql = $"SELECT * FROM [{DBTool.GetTableName(obj)}] ";
            try
            {
                var lst = conn.Query<T>(sql: sql, param: obj, commandTimeout: commandTimeout).AsList();
                lst.ForEach(m => m.GetDBModel_ChangeList().Clear());
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
            var sql = new StringBuilder($"SELECT 0 as DBModel_IsBeginChange, * FROM [{DBTool.GetTableName(query.DBModel)}] WHERE 1=1 ");
            DynamicParameters dynamicParameters = SetWhereSql(query, sql);

            try
            {
                var lst = conn.Query<T>(sql: sql.ToString(), param: dynamicParameters, commandTimeout: commandTimeout).AsList();
                lst.ForEach(m => m.BeginChange());
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
