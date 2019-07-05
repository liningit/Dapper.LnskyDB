using System;
using System.Collections.Generic;
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
        T Get(T obj);
        List<T> GetList(IQuery<T> query);
        List<T> GetList(IQuery<T> query, DateTime stTime, DateTime endime);
        List<R> GetList<R>(IQuery<T> query);
        List<R> GetList<R>(ISelectResult<R> query);
        Paging<T> GetPaging(IQuery<T> query, DateTime stTime, DateTime endime);

        Paging<T> GetPaging(IQuery<T> query);
        bool Update(T obj);
        List<T> GetList(string sql, object par);
        List<R> GetList<R>(string sql, object par);
        T Get(string sql, object par);
        R Get<R>(string sql, object par);
        int Execute(string sql, object par);

        int Update(T obj, IQuery<T> where);

        List<T> GetList(T dBModel, string sql, object par);
        List<R> GetList<R>(T dBModel, string sql, object par);
        T Get(T dBModel, string sql, object par);
        R Get<R>(T dBModel, string sql, object par);
        int Execute(T dBModel, string sql, object par);

    }
}