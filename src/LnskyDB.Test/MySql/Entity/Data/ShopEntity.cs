using LnskyDB.Model;
using LnskyDB.MySql;
using Newtonsoft.Json;
using System;
using System.Collections.Immutable;
namespace LnskyDB.Test.MySql.Entity.Data
{
    public class ShopEntity : BaseDBModel
    {
		private static ImmutableList<string> _DBModel_PKCols = ImmutableList.Create("SysNo");
        public override ImmutableList<string> GetDBModel_PKCols() => _DBModel_PKCols;
 
		
		public static ISqlProvider _DBModel_SqlProvider = new MySqlProvider();
		public override ISqlProvider GetDBModel_SqlProvider() => _DBModel_SqlProvider;
        public override string GetDBModel_TableName() => "Data_Shop{0}";
        public override string GetDBModel_DBName() => "MySqlLnskyNS{0}";
				
		#region Model
		
		string _SysNo;
		/// <summary>
		/// 
		/// </summary>		
		public string SysNo { get { return _SysNo; } set { Change("SysNo"); _SysNo = value; } }
		
		string _ShopCode;
		/// <summary>
		/// 
		/// </summary>		
		public string ShopCode { get { return _ShopCode; } set { Change("ShopCode"); _ShopCode = value; } }
		
		string _ShopName;
		/// <summary>
		/// 
		/// </summary>		
		public string ShopName { get { return _ShopName; } set { Change("ShopName"); _ShopName = value; } }
		
		int? _ShopType;
		/// <summary>
		/// 
		/// </summary>		
		public int? ShopType { get { return _ShopType; } set { Change("ShopType"); _ShopType = value; } }
		
		bool? _IsDelete;
		/// <summary>
		/// 
		/// </summary>		
		public bool? IsDelete { get { return _IsDelete; } set { Change("IsDelete"); _IsDelete = value; } }
		
		#endregion Model
	}
}
