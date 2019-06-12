using LnskyDB;
using System;
using System.Threading;

namespace Common.Tool
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
                catch (System.Exception ex)
                {
                    Console.Error.WriteLine(ex.Message);
                    Console.Error.WriteLine(ex.StackTrace);
                }
                finally
                {
                    DBTool.CloseConnections();
                }
            });
        }
    }
}
