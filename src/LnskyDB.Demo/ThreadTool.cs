using LnskyDB;
using System;
using System.Threading;

namespace LnskyDB.Demo
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
