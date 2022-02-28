using LnskyDB.Model;
using LnskyDB.MsSql; 
using System;
using System.Collections.Immutable;
namespace LnskyDB.Demo.Entity.Data
{
   public class ShopEntity : BaseDBModel
    {
		private static ImmutableList<string> _DBModel_PKCols = ImmutableList.Create("SysNo");
        public override ImmutableList<string> GetDBModel_PKCols() => _DBModel_PKCols;
 
		
		public static ISqlProvider _DBModel_SqlProvider = new MsSqlProvider();
		public override ISqlProvider GetDBModel_SqlProvider() => _DBModel_SqlProvider;
        public override string GetDBModel_TableName() => "Data_Shop{0}";
        public override string GetDBModel_DBName() => "LnskyNS{0}";
				
		#region Model
		
		Guid _SysNo;
		/// <summary>
		/// 系统编号
		/// </summary>		
		public Guid SysNo { get { return _SysNo; } set { Change("SysNo"); _SysNo = value; } }
		
		string _ShopCode;
		/// <summary>
		/// 店铺编码
		/// </summary>		
		public string ShopCode { get { return _ShopCode; } set { Change("ShopCode"); _ShopCode = value; } }
		
		string _ShopName;
		/// <summary>
		/// 店铺名称
		/// </summary>		
		public string ShopName { get { return _ShopName; } set { Change("ShopName"); _ShopName = value; } }
		
		int? _ShopType;
		/// <summary>
		/// 店铺类型
		/// </summary>		
		public int? ShopType { get { return _ShopType; } set { Change("ShopType"); _ShopType = value; } }
		
		bool _IsDelete;
		/// <summary>
		/// 
		/// </summary>		
		public bool IsDelete { get { return _IsDelete; } set { Change("IsDelete"); _IsDelete = value; } }
		
		#endregion Model
	}
}
