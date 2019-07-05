using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB
{
    public class DBFunction
    {
        public static T Function<T>(string funcName,params object[] par)
        {
            throw new NotSupportedException("该方法不可直接调用");
        }
    }
}
