using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB.Tool
{
    internal class ExceptionTool
    {
        internal static string ToString(Exception ex)
        {
            string errMsg = ex.Message;
            if (ex.InnerException != null)
            {
                errMsg += ToString(ex.InnerException);
            }
            return "【" + errMsg + "------------" + ex.StackTrace + "】";
        }
    }
}
