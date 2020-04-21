using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

namespace LnskyDB.Test
{
    public class ThreadTool
    {
        public static void QueueUserWorkItem(Action action)
        {
            ThreadPool.QueueUserWorkItem(delegate
            {
                DBTool.BeginThread();
                try
                {
                    action();
                }
                finally
                {
                    DBTool.CloseConnections();
                }
            });
        }
    }
}
