using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace LnskyDB
{
    public interface ILnskyDBTransactionMain : IDisposable
    {
        bool IsBeginTransaction { get; }
        IsolationLevel? IsolationLevel { get; }
        Dictionary<IDbConnection, IDbTransaction> TransactionDic { get; }

        ILnskyDBTransaction BeginTransaction();
        ILnskyDBTransaction BeginTransaction(IsolationLevel isolationLevel);
        void Commit();
        void Rollback();
    }
}
