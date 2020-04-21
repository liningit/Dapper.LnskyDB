using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LnskyDB.Demo
{
    public class PSDto
    {
        public Guid SysNo { get; set; }
        public string DataSource { get; set; }
        public string OutProductID { get; set; }
        public Guid ShopID { get; set; }
        public DateTime StatisticalDate { get; set; }
        public decimal Sales { get; set; }
        public string ShopName { get; set; }
    }
}
