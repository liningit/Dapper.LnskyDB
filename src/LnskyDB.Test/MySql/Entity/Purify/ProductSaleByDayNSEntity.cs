using LnskyDB.Model;
using LnskyDB.MySql;
using Newtonsoft.Json;
using System;
using System.Collections.Immutable;
namespace LnskyDB.Test.MySql.Entity.Purify
{
    public class ProductSaleByDayNSEntity : BaseDBModel
    {
		private static ImmutableList<string> _DBModel_PKCols = ImmutableList.Create("SysNo");
        public override ImmutableList<string> GetDBModel_PKCols() => _DBModel_PKCols;
 
		public override string GetDBModel_IncrementCol() =>  "SysNo";
		public override void SetIncrementValue(int value)
		{
			SysNo=value;
		}
		
		public static ISqlProvider _DBModel_SqlProvider = new MySqlProvider();
		public override ISqlProvider GetDBModel_SqlProvider() => _DBModel_SqlProvider;
        public override string GetDBModel_TableName() => "Purify_ProductSaleByDayNS{0}";
        public override string GetDBModel_DBName() => "MySqlLnskyNS{0}";
				
		#region Model
		
		int _SysNo;
		/// <summary>
		/// 
		/// </summary>		
		public int SysNo { get { return _SysNo; } set { Change("SysNo"); _SysNo = value; } }
		
		string _DataSource;
		/// <summary>
		/// 
		/// </summary>		
		public string DataSource { get { return _DataSource; } set { Change("DataSource"); _DataSource = value; } }
		
		string _OutProductID;
		/// <summary>
		/// 
		/// </summary>		
		public string OutProductID { get { return _OutProductID; } set { Change("OutProductID"); _OutProductID = value; } }
		
		int? _BrandID;
		/// <summary>
		/// 
		/// </summary>		
		public int? BrandID { get { return _BrandID; } set { Change("BrandID"); _BrandID = value; } }
		
		string _CategoryID;
		/// <summary>
		/// 
		/// </summary>		
		public string CategoryID { get { return _CategoryID; } set { Change("CategoryID"); _CategoryID = value; } }
		
		string _ProductID;
		/// <summary>
		/// 
		/// </summary>		
		public string ProductID { get { return _ProductID; } set { Change("ProductID"); _ProductID = value; } }
		
		string _ProductName;
		/// <summary>
		/// 
		/// </summary>		
		public string ProductName { get { return _ProductName; } set { Change("ProductName"); _ProductName = value; } }
		
		string _ShopID;
		/// <summary>
		/// 
		/// </summary>		
		public string ShopID { get { return _ShopID; } set { Change("ShopID"); _ShopID = value; } }
		
		DateTime _StatisticalDate;
		/// <summary>
		/// 
		/// </summary>		
		public DateTime StatisticalDate { get { return _StatisticalDate; } set { Change("StatisticalDate"); _StatisticalDate = value; } }
		
		double _Sales;
		/// <summary>
		/// 
		/// </summary>		
		public double Sales { get { return _Sales; } set { Change("Sales"); _Sales = value; } }
		
		int _NumberOfSales;
		/// <summary>
		/// 
		/// </summary>		
		public int NumberOfSales { get { return _NumberOfSales; } set { Change("NumberOfSales"); _NumberOfSales = value; } }
		
		double _AveragePrice;
		/// <summary>
		/// 
		/// </summary>		
		public double AveragePrice { get { return _AveragePrice; } set { Change("AveragePrice"); _AveragePrice = value; } }
		
		int _OrderQuantity;
		/// <summary>
		/// 
		/// </summary>		
		public int OrderQuantity { get { return _OrderQuantity; } set { Change("OrderQuantity"); _OrderQuantity = value; } }
		
		DateTime? _CreateDate;
		/// <summary>
		/// 
		/// </summary>		
		public DateTime? CreateDate { get { return _CreateDate; } set { Change("CreateDate"); _CreateDate = value; } }
		
		string _CreateUserID;
		/// <summary>
		/// 
		/// </summary>		
		public string CreateUserID { get { return _CreateUserID; } set { Change("CreateUserID"); _CreateUserID = value; } }
		
		DateTime? _UpdateDate;
		/// <summary>
		/// 
		/// </summary>		
		public DateTime? UpdateDate { get { return _UpdateDate; } set { Change("UpdateDate"); _UpdateDate = value; } }
		
		string _UpdateUserID;
		/// <summary>
		/// 
		/// </summary>		
		public string UpdateUserID { get { return _UpdateUserID; } set { Change("UpdateUserID"); _UpdateUserID = value; } }
		
		string _ImportGroupId;
		/// <summary>
		/// 
		/// </summary>		
		public string ImportGroupId { get { return _ImportGroupId; } set { Change("ImportGroupId"); _ImportGroupId = value; } }
		
		bool _IsExclude;
		/// <summary>
		/// 
		/// </summary>		
		public bool IsExclude { get { return _IsExclude; } set { Change("IsExclude"); _IsExclude = value; } }
		
		#endregion Model
	}
}
