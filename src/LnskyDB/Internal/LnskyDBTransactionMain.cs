using LnskyDB.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace LnskyDB.Internal
{
    internal class LnskyDBTransactionMain : ILnskyDBTransactionMain
    {


        public Dictionary<IDbConnection, IDbTransaction> TransactionDic { get; set; } = new Dictionary<IDbConnection, IDbTransaction>();
        public bool IsBeginTransaction { get; private set; } = false;

        public IsolationLevel? IsolationLevel { get; private set; }
        private int TransactionIndex { get; set; }
        public void Dispose()
        {
            if (IsBeginTransaction)
            {
                Rollback();
            }
            TransactionDic.Clear();
            IsBeginTransaction = false;
            TransactionIndex = 0;
            IsolationLevel = null;
        }

        public void Commit()
        {
            if (IsBeginTransaction)
            {
                foreach (var tran in TransactionDic.Values)
                {
                    tran.Commit();
                }
            }
            else
            {
                throw new LnskyDBException("该事务不可重复提交");
            }
            IsBeginTransaction = false;

        }

        public void Rollback()
        {
            if (IsBeginTransaction)
            {
                foreach (var tran in TransactionDic.Values)
                {
                    tran.Rollback();
                }
            }
            else
            {
                throw new LnskyDBException("该事务不可重复提交或撤销");
            }
            IsBeginTransaction = false;
        }

        public ILnskyDBTransaction BeginTransaction()
        {
            TransactionIndex++;
            IsBeginTransaction = true;
            var tran = new LnskyDBTransaction();
            tran.TransactionMain = this;
            tran.TransactionIndex = TransactionIndex;
            return tran;
        }

        public ILnskyDBTransaction BeginTransaction(IsolationLevel isolationLevel)
        {
            IsolationLevel = isolationLevel;
            return BeginTransaction();
        }
    }
}
