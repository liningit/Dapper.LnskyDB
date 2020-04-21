using LnskyDB.Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB.Internal
{
    public class LnskyDBTransaction : ILnskyDBTransaction
    {
        public int TransactionIndex { get; set; }
        internal ILnskyDBTransactionMain TransactionMain { get; set; }
        private bool IsRun { get; set; } = false;
        public void Complete()
        {
            if (IsRun)
            {
                throw new LnskyDBException("该事务已提交或者回滚过不可再提交");
            }
            IsRun = true;
            if (TransactionIndex == 1)
            {
                TransactionMain.Commit();
            }
        }

        public void Dispose()
        {
            if (!IsRun)
            {
                Rollback();
            }
            if (TransactionIndex == 1)
            {
                TransactionMain.Dispose();
            }
        }

        public void Rollback()
        {
            if (IsRun)
            {
                throw new LnskyDBException("该事务已提交或者回滚过不可再提交");
            }
            IsRun = true;
            if (TransactionIndex == 1)
            {
                TransactionMain.Rollback();
            }
        }
    }
}
