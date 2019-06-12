
using LnskyDB.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Immutable;
namespace LnskyDB.Demo.Entity.Purify
{
    public class ProductSaleByDayEntity : BaseDBModel
    {
		private static ImmutableList<string> _DBModel_PKCols = ImmutableList.Create("SysNo");
        public override ImmutableList<string> GetDBModel_PKCols() => _DBModel_PKCols;

        private static ImmutableList<string> _DBModel_ExcludeColsForUpdate = ImmutableList.Create("CreateDate", "CreateUserID");
        public override ImmutableList<string> GetDBModel_ExcludeColsForUpdate() => _DBModel_ExcludeColsForUpdate;
        public override string GetDBModel_IncrementCol() =>  string.Empty;


        public override string GetDBModel_TableName() => "Purify_ProductSaleByDay{0}";
        public override string GetDBModel_DBName() => "LAWPurify{0}";
		
		/// <summary>
        /// 最小分库分表时间
        /// </summary>
        public static DateTime MinShuffledTempDate { get; } = new DateTime(2018, 1, 1);
        /// <summary>
        /// 获取分库分表信息,如果没有分库分表则可以不重写
        /// </summary>
        /// <returns></returns>
        public override ShuffledModel GetShuffledModel()
        {
            if (DBModel_ShuffledTempDate == DateTime.MinValue)
            {
                throw new NoShuffledException(GetDBModel_TableName(), "分库分表时间,ShuffledTempDate");
            }
            return ShuffledByDbTable(DBModel_ShuffledTempDate);
        }

        DateTime _DBModel_ShuffledTempDate;

        [JsonIgnore]
        public DateTime DBModel_ShuffledTempDate { get { return StatisticalDate != DateTime.MinValue ? StatisticalDate : _DBModel_ShuffledTempDate; } set { _DBModel_ShuffledTempDate = value; } }

        public override void SetShuffledData(object obj) { DBModel_ShuffledTempDate = (DateTime)obj; }
		
		#region Model
		
		Guid _SysNo;
		/// <summary>
		/// 
		/// </summary>		
		public Guid SysNo { get { return _SysNo; } set { Change("SysNo"); _SysNo = value; } }
		
		string _DataSource;
		/// <summary>
		/// 数据来源
		/// </summary>		
		public string DataSource { get { return _DataSource; } set { Change("DataSource"); _DataSource = value; } }
		
		string _OutProductID;
		/// <summary>
		/// 外部商品ID
		/// </summary>		
		public string OutProductID { get { return _OutProductID; } set { Change("OutProductID"); _OutProductID = value; } }
		
		Guid _BrandID;
		/// <summary>
		/// 
		/// </summary>		
		public Guid BrandID { get { return _BrandID; } set { Change("BrandID"); _BrandID = value; } }
		
		Guid _CategoryID;
		/// <summary>
		/// 分类id
		/// </summary>		
		public Guid CategoryID { get { return _CategoryID; } set { Change("CategoryID"); _CategoryID = value; } }
		
		Guid _ProductID;
		/// <summary>
		/// 商品id
		/// </summary>		
		public Guid ProductID { get { return _ProductID; } set { Change("ProductID"); _ProductID = value; } }
		
		string _ProductName;
		/// <summary>
		/// 商品名称
		/// </summary>		
		public string ProductName { get { return _ProductName; } set { Change("ProductName"); _ProductName = value; } }
		
		Guid _ShopID;
		/// <summary>
		/// 店铺ID
		/// </summary>		
		public Guid ShopID { get { return _ShopID; } set { Change("ShopID"); _ShopID = value; } }
		
		string _ShopName;
		/// <summary>
		/// 店铺名称
		/// </summary>		
		public string ShopName { get { return _ShopName; } set { Change("ShopName"); _ShopName = value; } }
		
		DateTime _StatisticalDate;
		/// <summary>
		/// 统计日期
		/// </summary>		
		public DateTime StatisticalDate { get { return _StatisticalDate; } set { Change("StatisticalDate"); _StatisticalDate = value; } }
		
		decimal _Sales;
		/// <summary>
		/// 销售额
		/// </summary>		
		public decimal Sales { get { return _Sales; } set { Change("Sales"); _Sales = value; } }
		
		int _NumberOfSales;
		/// <summary>
		/// 销量
		/// </summary>		
		public int NumberOfSales { get { return _NumberOfSales; } set { Change("NumberOfSales"); _NumberOfSales = value; } }
		
		decimal _AveragePrice;
		/// <summary>
		/// 商品均价
		/// </summary>		
		public decimal AveragePrice { get { return _AveragePrice; } set { Change("AveragePrice"); _AveragePrice = value; } }
		
		int _OrderQuantity;
		/// <summary>
		/// 订单量
		/// </summary>		
		public int OrderQuantity { get { return _OrderQuantity; } set { Change("OrderQuantity"); _OrderQuantity = value; } }
		
		DateTime _CreateDate;
		/// <summary>
		/// 创建时间
		/// </summary>		
		public DateTime CreateDate { get { return _CreateDate; } set { Change("CreateDate"); _CreateDate = value; } }
		
		Guid _CreateUserID;
		/// <summary>
		/// 创建人
		/// </summary>		
		public Guid CreateUserID { get { return _CreateUserID; } set { Change("CreateUserID"); _CreateUserID = value; } }
		
		DateTime? _UpdateDate;
		/// <summary>
		/// 更新时间
		/// </summary>		
		public DateTime? UpdateDate { get { return _UpdateDate; } set { Change("UpdateDate"); _UpdateDate = value; } }
		
		Guid? _UpdateUserID;
		/// <summary>
		/// 更新人
		/// </summary>		
		public Guid? UpdateUserID { get { return _UpdateUserID; } set { Change("UpdateUserID"); _UpdateUserID = value; } }
		
		Guid _ImportGroupId;
		/// <summary>
		/// 导入组
		/// </summary>		
		public Guid ImportGroupId { get { return _ImportGroupId; } set { Change("ImportGroupId"); _ImportGroupId = value; } }
		
		bool _IsExclude;
		/// <summary>
		/// 黑名单
		/// </summary>		
		public bool IsExclude { get { return _IsExclude; } set { Change("IsExclude"); _IsExclude = value; } }
		
		#endregion Model
	}
}
