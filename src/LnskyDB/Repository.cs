using LnskyDB;
using LnskyDB.Model;
using LnskyDB.Tool;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data.Common;
using LnskyDB.Internal;
using System.Linq.Expressions;
using System.Reflection;
using System.Linq;
using System.Data;

namespace LnskyDB
{
    public abstract class Repository<T> : AbstractRepository<T> where T : BaseDBModel, new()
    {
        public Repository() : base(new T()) { }
    }
    public abstract class AbstractRepository<T> : IRepository<T> where T : BaseDBModel, new()
    {
        protected T DBModel = null;
        internal AbstractRepository(T obj)
        {
            DBModel = obj ?? throw new LnskyDBException("对象不可为空");

        }
        public int? CommandTimeout { get; set; }

        private DbConnection GetConn(T obj)
        {
            if (obj == null)
            {
                obj = DBModel;
            }
            return DBTool.GetConnection(obj);

        }
        public List<T> GetList(IQuery<T> query)
        {
            return GetConn(query.DBModel).GetList(query: query, commandTimeout: CommandTimeout);
        }
        public List<R> GetList<R>(IQuery<T> query)
        {
            return GetList(GetConn(query.DBModel).GetList<R, T>(query: query, commandTimeout: CommandTimeout));
        }
        public long Count(IQuery<T> query)
        {
            return GetConn(query.DBModel).Count(query: query, commandTimeout: CommandTimeout);
        }
        public Paging<T> GetPaging(IQuery<T> query)
        {
            var conn = GetConn(query.DBModel);
            var count = conn.Count(query: query, commandTimeout: CommandTimeout);
            List<T> lst = count == 0 ? new List<T>() : conn.GetList(query: query, commandTimeout: CommandTimeout);
            return new Paging<T>(count, lst);

        }
        public Paging<R> GetPaging<R>(IQuery<T> query)
        {
            var conn = GetConn(query.DBModel);
            var count = conn.Count(query: query, commandTimeout: CommandTimeout);
            List<R> lst = count == 0 ? new List<R>() : GetList(conn.GetList<R, T>(query: query, commandTimeout: CommandTimeout));
            return new Paging<R>(count, lst);
        }
        public T Get(T obj)
        {

            return GetConn(obj).Get(obj: obj, commandTimeout: CommandTimeout);
        }
        public bool Update(T obj)
        {
            return GetConn(obj).Update(obj: obj, commandTimeout: CommandTimeout);
        }
        public int Update(T obj, IQuery<T> where)
        {
            return GetConn(obj).Update(obj: obj, where: where, commandTimeout: CommandTimeout);
        }
        public int Update(T obj, Expression<Func<T, bool>> predicate)
        {
            var where = QueryFactory.Create(predicate);
            return Update(obj, where);
        }
        public bool Delete(T obj)
        {
            return GetConn(obj).Delete(obj: obj, commandTimeout: CommandTimeout);
        }
        public int Delete(IQuery<T> where)
        {
            return GetConn(where.DBModel).Delete(where: where, commandTimeout: CommandTimeout);
        }
        public int Delete(Expression<Func<T, bool>> predicate)
        {
            var where = QueryFactory.Create(predicate);
            return Delete(where);
        }
        public void Add(T obj)
        {

            GetConn(obj).Add(obj: obj, commandTimeout: CommandTimeout);
        }

        public List<T> GetList(string sql, object par)
        {
            var conn = GetConn(null);
            var lst = conn.Query<T>(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
            return GetList(lst);
        }

        public List<R> GetList<R>(string sql, object par)
        {
            var conn = GetConn(null);
            var lst = conn.Query<R>(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
            return GetList(lst);
        }

        public T Get(string sql, object par)
        {
            var conn = GetConn(null);
            return conn.QueryFirstOrDefault<T>(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
        }

        public R Get<R>(string sql, object par)
        {
            var conn = GetConn(null);
            return conn.QueryFirstOrDefault<R>(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
        }

        public int Execute(string sql, object par)
        {
            var conn = GetConn(null);
            return conn.Execute(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
        }

        public List<T> GetList(T obj, string sql, object par)
        {
            var conn = GetConn(obj);
            return GetList(conn.Query<T>(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn)));
        }

        public List<R> GetList<R>(T obj, string sql, object par)
        {
            var conn = GetConn(obj);
            return GetList(conn.Query<R>(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn)));
        }

        public List<R> GetList<R>(ISelectResult<R> query)
        {
            Type typeFromHandle = typeof(R);
            ConstructorInfo right = typeFromHandle.GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).FirstOrDefault((ConstructorInfo x) => x.GetParameters().Length == 0);
            var conn = GetConn(query.DBModel as T);
            if (null == right && typeFromHandle.FullName.Contains("AnonymousType"))
            {
                using (IDataReader reader = conn.ExecuteReader(sql: query.SqlCmd, param: query.Param, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn)))
                {
                    return GetList(reader.Parse<R>().ToList());
                }
            }

            return GetList(conn.Query<R>(sql: query.SqlCmd, param: query.Param, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn)));
        }
        public Paging<R> GetPaging<R>(ISelectResult<R> query)
        {

            var lst = GetList(query);
            var conn = GetConn(null);
            var count = conn.QuerySingleOrDefault<long>(sql: query.CountSqlCmd, param: query.Param, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
            return new Paging<R>(count, lst);
        }

        private List<R> GetList<R>(IEnumerable<R> lst)
        {
            if (typeof(BaseDBModel).IsAssignableFrom(typeof(R)))
            {
                foreach (var t in lst)
                {
                    var b = t as BaseDBModel;
                    b.GetDBModel_ChangeList().Clear();
                    b.BeginChange();
                }
            }
            return lst.AsList();
        }

        public T Get(T obj, string sql, object par)
        {
            var conn = GetConn(obj);
            return conn.QueryFirstOrDefault<T>(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
        }

        public R Get<R>(T obj, string sql, object par)
        {
            var conn = GetConn(obj);
            return conn.QueryFirstOrDefault<R>(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
        }

        public int Execute(T obj, string sql, object par)
        {
            var conn = GetConn(obj);
            return conn.Execute(sql: sql, param: par, commandTimeout: CommandTimeout, transaction: DBTool.GetTransaction(conn));
        }

        public virtual Paging<T> GetPaging(IQuery<T> query, DateTime stTime, DateTime endime)
        {
            var res = GetList(query, stTime, endime, true);
            return new Paging<T>(res.TotalCount, res.List);
        }

        private (List<T> List, long TotalCount) GetList(IQuery<T> query, DateTime stTime, DateTime endime, bool isQueryCount)
        {
            stTime = stTime.Date.AddDays(1 - stTime.Day);
            var res = new List<T>();
            long totalCount = 0;
            var isNoPage = query.StarSize == 0 && query.Rows == 0;
            var StarSize = query.StarSize;
            var PageSize = query.Rows;

            query.StarSize = 0;
            query.Rows = 0;
            while (stTime <= endime)
            {
                query.DBModel.SetShuffledData(endime);
                if (isNoPage)
                {
                    var lst = GetList<T>(query);
                    res.AddRange(lst);
                    totalCount = res.Count;
                }
                else
                {
                    var thisCount = Count(query);
                    if (totalCount < StarSize + PageSize && thisCount + totalCount > StarSize & thisCount != 0)
                    {
                        query.StarSize = StarSize - totalCount;
                        query.Rows = PageSize - res.Count;
                        if (query.StarSize < 0)
                        {
                            query.StarSize = 0;
                        }
                        var lst = GetList(query);
                        res.AddRange(lst);
                    }
                    if (!isQueryCount && res.Count >= PageSize)
                    {
                        break;
                    }
                    totalCount += thisCount;
                }
                endime = endime.AddMonths(-1);
            }
            return (res, totalCount);
        }

        public virtual List<T> GetList(IQuery<T> query, DateTime stTime, DateTime endime)
        {
            var res = GetList(query, stTime, endime, false);
            return res.List;

        }
        public List<T> GetList(Expression<Func<T, bool>> predicate)
        {
            var query = QueryFactory.Create(predicate);
            return GetList(query);
        }
        public List<T> GetList()
        {
            var query = QueryFactory.Create<T>();
            return GetList(query);
        }

        public long Count(Expression<Func<T, bool>> predicate)
        {
            var query = QueryFactory.Create(predicate);
            return Count(query);
        }

        public T Get(Expression<Func<T, bool>> predicate)
        {
            var query = QueryFactory.Create(predicate);
            return Get(query);
        }

        public T Get(IQuery<T> query)
        {
            return GetConn(query.DBModel).Get(query: query, commandTimeout: CommandTimeout);
        }
    }
}
