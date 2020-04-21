using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB
{
    public interface ILnskyDBTransaction : IDisposable
    {
        int TransactionIndex { get; set; } 
        void Complete(); 
    }
}
