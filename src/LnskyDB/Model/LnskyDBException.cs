using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB.Model
{
    public class LnskyDBException : ApplicationException
    {
        public LnskyDBException(string message) : base(message)
        {

        }
    }
}
