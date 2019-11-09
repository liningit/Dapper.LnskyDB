using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using LnskyDB;
using LnskyDB.Model;

namespace LnskyDB
{
    public interface IRepository<T> where T : BaseDBModel
    {
        int? CommandTimeout { get; set; }
        void Add(T obj);
        long Count(IQuery<T> query);
        bool Delete(T obj);
        int Delete(IQuery<T> where);
        int Delete(Expression<Func<T, bool>> predicate);
        T Get(T obj);
        List<T> GetList();
        List<T> GetList(Expression<Func<T, bool>> predicate);
        List<T> GetList(IQuery<T> query);
        List<T> GetList(IQuery<T> query, DateTime stTime, DateTime endime);
        List<R> GetList<R>(IQuery<T> query);
        List<R> GetList<R>(ISelectResult<R> query) where R : new();
        Paging<T> GetPaging(IQuery<T> query, DateTime stTime, DateTime endime);

        Paging<T> GetPaging(IQuery<T> query);
        Paging<R> GetPaging<R>(IQuery<T> query);
        Paging<R> GetPaging<R>(ISelectResult<R> query) where R : new();

        bool Update(T obj);
        List<T> GetList(string sql, object par);
        List<R> GetList<R>(string sql, object par);
        T Get(string sql, object par);
        R Get<R>(string sql, object par);
        int Execute(string sql, object par);

        int Update(T obj, IQuery<T> where);
        int Update(T obj, Expression<Func<T, bool>> predicate);

        List<T> GetList(T dBModel, string sql, object par);
        List<R> GetList<R>(T dBModel, string sql, object par);
        T Get(T dBModel, string sql, object par);
        R Get<R>(T dBModel, string sql, object par);
        int Execute(T dBModel, string sql, object par);

    }
}