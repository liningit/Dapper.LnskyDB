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
 
}
