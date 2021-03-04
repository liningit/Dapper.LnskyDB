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
using LnskyDB.Internal;

namespace LnskyDB
{
    public class DBConn : IDisposable
    {
        public int Index = 0;


        public void Dispose()
        {
            if (Index <= 1)
            {
                DBTool.CloseConnections();
                Index--;
            }
            else
            {
                Index--;
            }
        }
    }
    public class DBTool
    {
        public static event LnskyDBEventHandler<LnskyDBErrorArgs> Error;
        /// <summary>
        /// ThreadStatic表示每个线程都是独立对象
        /// </summary>
        [ThreadStatic] private static LnskyDBConnLst ThreadLnskyDBConnLst;
        [ThreadStatic] private static ILnskyDBTransactionMain ThreadLnskyDBTransaction;
        [ThreadStatic] private static DBConn DBConnObj;

        /// <summary>
        /// 获取当前请求的数据库连接列表
        /// </summary>
        internal static LnskyDBConnLst GetRequestConnLst()
        {
            if (ThreadLnskyDBConnLst != null)
            {
                return ThreadLnskyDBConnLst;
            }
            if (HttpContext?.HttpContext != null && HttpContext.HttpContext.RequestServices != null)
            {
                var url = HttpContext.HttpContext.Request;
                return HttpContext.HttpContext.RequestServices.GetService<LnskyDBConnLst>();
            }
            throw new LnskyDBException("没有取到ConnLst");

        }
        /// <summary>
        /// 获取数据库事务主要控制类
        /// </summary> 
        public static ILnskyDBTransactionMain GetLnskyDBTransactionMain()
        {
            if (ThreadLnskyDBTransaction != null)
            {
                return ThreadLnskyDBTransaction;
            }
            if (HttpContext?.HttpContext != null && HttpContext.HttpContext.RequestServices != null)
            {
                var url = HttpContext.HttpContext.Request;
                return HttpContext.HttpContext.RequestServices.GetService<ILnskyDBTransactionMain>();
            }
            throw new LnskyDBException("没有取到LnskyDBTransactionMain");
        }
        /// <summary>
        /// 当在线程中使用时要在开始调用
        /// </summary>
        public static DBConn BeginThread()
        {
            if (DBConnObj == null)
            {
                DBConnObj = new DBConn();
            }
            DBConnObj.Index++;
            if (DBConnObj.Index <= 1)
            {
                ThreadLnskyDBConnLst = new LnskyDBConnLst();
                ThreadLnskyDBTransaction = new LnskyDBTransactionMain();
            }
            return DBConnObj;
        }
        /// <summary>
        /// 开启事务
        /// </summary> 
        public static ILnskyDBTransaction BeginTransaction()
        {
            var tran = GetLnskyDBTransactionMain();
            return tran.BeginTransaction();
        }
        /// <summary>
        /// 开启事务
        /// </summary> 
        public static ILnskyDBTransaction BeginTransaction(IsolationLevel isolationLevel)
        {
            var tran = GetLnskyDBTransactionMain();
            return tran.BeginTransaction(isolationLevel);

        }
        /// <summary>
        /// 返回数据库事务
        /// </summary>
        /// <param name="conn"></param>
        /// <returns></returns>
        internal static IDbTransaction GetTransaction(DbConnection conn)
        {
            var tran = GetLnskyDBTransactionMain();
            if (!tran.IsBeginTransaction)
            {
                return null;
            }
            tran.TransactionDic.TryGetValue(conn, out var dbtran);
            if (dbtran == null)
            {
                dbtran = tran.IsolationLevel.HasValue ? conn.BeginTransaction(tran.IsolationLevel.Value) : conn.BeginTransaction();
                tran.TransactionDic.Add(conn, dbtran);

            }
            return dbtran;

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
            DBConnObj = null;
            ThreadLnskyDBTransaction = null;

        }
        public static IConfiguration Configuration { get; set; }
        internal static IHttpContextAccessor HttpContext { get; set; }

        internal static Expression<Func<T, bool>> GetContains<T>(string propertyName, string propertyValue)
        {
            ParameterExpression parameter = Expression.Parameter(typeof(T), "p");
            MemberExpression member = Expression.PropertyOrField(parameter, propertyName);
            MethodInfo method = typeof(string).GetMethod("Contains", new[] { typeof(string) });
            ConstantExpression constant = Expression.Constant(propertyValue, typeof(string));
            return Expression.Lambda<Func<T, bool>>(Expression.Call(member, method, constant), parameter);
        }
        public static DbConnection GetConnectionT<T>(T obj) where T : BaseDBModel
        {
            if (obj == null)
            {
                throw new LnskyDBException("对象不可为空");
            }
            return GetConnection(obj.GetDBModel_SqlProvider(), obj.GetDBModel_DBName(), obj.GetShuffledModel());
        }
        public static DbConnection GetConnection<T>(T obj) where T : BaseDBModel, new()
        {
            if (obj == null)
            {
                obj = new T();
            }
            return GetConnection(obj.GetDBModel_SqlProvider(), obj.GetDBModel_DBName(), obj.GetShuffledModel());
        }
        public static DbConnection GetConnection(ISqlProvider sqlProvider, string key, ShuffledModel shuffle)
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
                conn = sqlProvider.GetConnection(connStr);
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

        public static string GetTableWith(BaseDBModel dBModel)
        {
            if (string.IsNullOrEmpty(dBModel.GetTableWith()))
            {
                return string.Empty;
            }
            return $" with({dBModel.GetTableWith()}) ";
        }
        public static string GetTableWith<T>(IQuery<T> query) where T : BaseDBModel
        {
            return GetTableWith(query.DBModel);
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
