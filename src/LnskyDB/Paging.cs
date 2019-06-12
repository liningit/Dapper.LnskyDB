using LnskyDB.Tool;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Linq;

namespace LnskyDB
{
    public class Paging<T>
    {


        public IEnumerable<T> Items { get; set; }




        public long TotalCount { get; set; }

        public Paging(long totalCount, IEnumerable<T> items)
        {
            TotalCount = totalCount;
            Items = items;

        }

        public List<T> ToList() { return Items?.ToList(); }
    }
}
