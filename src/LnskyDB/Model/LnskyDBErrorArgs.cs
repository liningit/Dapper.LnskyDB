using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB.Model
{
    public class LnskyDBErrorArgs
    {
        internal LnskyDBErrorArgs(){}
        public Exception Exception { get; set; }
        public string LogInfo { get; set; }
    }
}
