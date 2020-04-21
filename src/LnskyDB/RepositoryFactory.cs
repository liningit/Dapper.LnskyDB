using LnskyDB.Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB
{
    public class RepositoryFactory
    {
        public static IRepository<T> Create<T>() where T : BaseDBModel, new()
        {
            return new RepositoryA<T>(new T());
        }
        public static IRepository<T> Create<T>(T obj) where T : BaseDBModel, new()
        {
            return new RepositoryA<T>(obj);
        }

        private class RepositoryA<T> : AbstractRepository<T> where T : BaseDBModel, new()
        {
            public RepositoryA(T obj) : base(obj) { }
        }
    }
}
