using System;
using System.Collections.Generic;
using System.Data.Common;

namespace LnskyDB.Model
{
    internal class LnskyDBConnLst
    {
        public LnskyDBConnLst()
        {
        }
        internal Dictionary<string, DbConnection> ConnLst { get; } = new Dictionary<string, DbConnection>();
    }
}
