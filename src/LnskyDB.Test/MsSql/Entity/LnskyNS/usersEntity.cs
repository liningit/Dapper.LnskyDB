using LnskyDB.Model;
using LnskyDB.MsSql;
using Newtonsoft.Json;
using System;
using System.Collections.Immutable;
namespace LnskyDB.Test.MsSql.Entity.LnskyNS
{
    public class usersEntity : BaseDBModel
    {
		private static ImmutableList<string> _DBModel_PKCols = ImmutableList.Create("id");
        public override ImmutableList<string> GetDBModel_PKCols() => _DBModel_PKCols;
 
		public override string GetDBModel_IncrementCol() =>  "id";
		public override void SetIncrementValue(int value)
		{
			id=value;
		}
		
		public static ISqlProvider _DBModel_SqlProvider = new MsSqlProvider();
		public override ISqlProvider GetDBModel_SqlProvider() => _DBModel_SqlProvider;
        public override string GetDBModel_TableName() => "users{0}";
        public override string GetDBModel_DBName() => "LnskyNS{0}";
				
		#region Model
		
		int _id;
		/// <summary>
		/// 
		/// </summary>		
		public int id { get { return _id; } set { Change("id"); _id = value; } }
		
		string _code;
		/// <summary>
		/// 
		/// </summary>		
		public string code { get { return _code; } set { Change("code"); _code = value; } }
		
		string _name;
		/// <summary>
		/// 
		/// </summary>		
		public string name { get { return _name; } set { Change("name"); _name = value; } }
		
		int _createWay;
		/// <summary>
		/// 
		/// </summary>		
		public int createWay { get { return _createWay; } set { Change("createWay"); _createWay = value; } }
		
		DateTime? _createDate;
		/// <summary>
		/// 
		/// </summary>		
		public DateTime? createDate { get { return _createDate; } set { Change("createDate"); _createDate = value; } }
		
		string _createUsers;
		/// <summary>
		/// 
		/// </summary>		
		public string createUsers { get { return _createUsers; } set { Change("createUsers"); _createUsers = value; } }
		
		int? _roleId;
		/// <summary>
		/// 
		/// </summary>		
		public int? roleId { get { return _roleId; } set { Change("roleId"); _roleId = value; } }
		
		#endregion Model
	}
}
