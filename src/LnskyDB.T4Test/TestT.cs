using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace LnskyDB.T4Test
{
    #region 配置

    public class Config
    {
        public delegate void InitTableInfo(TableInfo tableInfo);
        public static List<DbConfig> DbConfigs = new List<DbConfig> {
        new DbConfig{
                    ConnectionString="Database=LnskyNS_Test;Data Source=localhost;User Id=root;Password=root;pooling=false;CharSet=utf8;port=3306",
                    Database="LnskyNS_Test",
                    DatabaseName="LnskyNS",
                    TableNames = new List<string>{"*"},
                    ExcludeTableName=new List<string>{ }
                },
            };
    };

    public class DbConfig
    {
        public string ConnectionString { get; set; }
        public string Database { get; set; }
        public string DatabaseName { get; set; }
        public List<string> TableNames { get; set; }
        public List<string> ExcludeTableName { get; set; }
        public Dictionary<string, ShuffledConfig> ShuffledConfigs { get; set; }


        public Config.InitTableInfo Init { get; set; }
    }
    public class TableInfo
    {
        public string DatabaseName { get; set; }
        public string TableName { get; set; }
        public string TablePre { get; set; }
        public bool IsShuffled { get; set; }
        public ShuffledConfig ShuffledConfig { get; internal set; }
        public List<DbColumn> Columns { get; internal set; }
        public List<string> PKCols { get; internal set; }
        public string IncrementCol { get; internal set; }
        public string DBModel_TableName { get; internal set; }
        public string TableComment { get; internal set; }
    }
    public class ShuffledConfig
    {
        public ShuffledConfig(string shuffledData, DateTime minShuffledTempDate)
        {
            ShuffledData = shuffledData;
            MinShuffledTempDate = minShuffledTempDate;
        }

        public string ShuffledData { get; set; }
        public string ShuffledDataRemark { get; set; }
        public DateTime MinShuffledTempDate { get; set; }
    }

    public class Tool
    {
        public static string GetL(string name)
        {
            return name[0].ToString().ToLower() + name.Substring(1);
        }
        public static TableInfo GetTableInfo(DbTable table, DbConfig dbconfig)
        {
            var tableName = table.TableName;
            TableInfo tableInfo = new TableInfo();
            tableInfo.DatabaseName = dbconfig.DatabaseName;
            tableInfo.TableComment = table.TableComment;
            var names = tableName.Split('_');
            if (names.Length == 1)
            {
                tableInfo.TablePre = dbconfig.DatabaseName;
                tableInfo.DBModel_TableName = names[0];
                tableInfo.TableName = names[0];
                tableInfo.IsShuffled = false;
            }
            else
            {

                if (names.Length == 2 && dbconfig.ShuffledConfigs.Any(m => m.Key == names[0]))
                {
                    tableInfo.TablePre = dbconfig.DatabaseName;
                    tableInfo.DBModel_TableName = names[0];
                    tableInfo.TableName = names[0];
                    tableInfo.IsShuffled = true;
                }
                else
                {
                    tableInfo.TablePre = names[0];
                    tableInfo.DBModel_TableName = names[0] + "_" + names[1];
                    tableInfo.TableName = names[1];
                    tableInfo.IsShuffled = names.Length == 3;
                }
            }
            var cn = GetName(names);
            if (!dbconfig.TableNames.Exists(m => cn.Contains(m)))
            {
                return null;
            }
            if (dbconfig.ExcludeTableName.Exists(m => cn.Contains(m)))
            {
                return null;
            }
            tableInfo.Columns = DbHelper.GetDbColumns(dbconfig.ConnectionString, dbconfig.Database, tableName);
            tableInfo.PKCols = tableInfo.Columns.Where(m => m.IsPrimaryKey).Select(m => m.ColumnName).ToList();

            if (dbconfig.ShuffledConfigs.ContainsKey(tableInfo.DBModel_TableName))
            {
                if (!tableInfo.IsShuffled)
                {
                    return null;
                }
                tableInfo.ShuffledConfig = dbconfig.ShuffledConfigs[tableInfo.DBModel_TableName];
                tableInfo.ShuffledConfig.ShuffledDataRemark = tableInfo.Columns.FirstOrDefault(m => m.ColumnName == tableInfo.ShuffledConfig.ShuffledData)?.Remark;
            }
            else
            {
                if (tableInfo.IsShuffled)
                {
                    return null;
                }
            }

            var temp = tableInfo.Columns.FirstOrDefault(m => m.IsIdentity);
            if (temp != null)
            {
                tableInfo.IncrementCol = temp.ColumnName;
            }
            if (dbconfig.Init != null)
            {
                dbconfig.Init(tableInfo);
            }
            return tableInfo;
        }
        public static List<string> GetName(string[] names)
        {
            var s = new List<string>();
            if (names.Length == 1)
            {
                s.Add("*");
                s.Add(names[0]);
            }
            else if (names.Length == 2)
            {
                s.Add("*");
                s.Add("*_*");
                s.Add(names[0] + "_*");
                s.Add(names[0] + "_" + names[1]);
            }
            else if (names.Length == 3)
            {
                s.Add("*");
                s.Add("*_*_*");
                s.Add(names[0] + "_*_*");
                s.Add(names[0] + "_" + names[1] + "_*");
            }
            return s;
        }
        public static List<TableInfo> GetTableInfos()
        {
            var tables = new List<TableInfo>();
            foreach (var dbconfig in Config.DbConfigs)
            {
                if (dbconfig.ExcludeTableName == null)
                {
                    dbconfig.ExcludeTableName = new List<string>();
                }
                if (dbconfig.ShuffledConfigs == null)
                {
                    dbconfig.ShuffledConfigs = new Dictionary<string, ShuffledConfig>();
                }

                var tempTables = DbHelper.GetDbTables(dbconfig.ConnectionString, dbconfig.Database);

                foreach (var tempTable in tempTables)
                {
                    var tableInfo = Tool.GetTableInfo(tempTable, dbconfig);
                    if (tableInfo != null)
                    {
                        if (!tables.Exists(m => m.TablePre == tableInfo.TablePre && m.TableName == tableInfo.TableName))
                        {
                            tables.Add(tableInfo);
                        }
                    }
                }

            }
            return tables.Where(m => m.PKCols.Count > 0).ToList();

        }
    }
    #endregion




    #region MyRegion

    public class DbHelper
    {
        #region GetDbTables

        public static List<DbTable> GetDbTables(string connectionString, string database, string tables = null)
        {

            if (!string.IsNullOrEmpty(tables))
            {
                tables = string.Format(" and  TABLE_NAME in ('{0}')", tables.Replace(",", "','"));
            }
            #region SQL
            string sql = $@"SELECT TABLE_NAME,TABLE_COMMENT FROM `information_schema`.`TABLES` where TABLE_SCHEMA='{database}' {tables} ";
            #endregion
            DataTable dt = GetDataTable(connectionString, sql);
            return dt.Rows.Cast<DataRow>().Select(row => new DbTable
            {
                TableName = row.Field<string>("TABLE_NAME"),
                TableComment = row.Field<string>("TABLE_COMMENT")
            }).ToList();
        }

        #endregion

        #region GetDbColumns

        public static List<DbColumn> GetDbColumns(string connectionString, string database, string tableName)
        {
            #region SQL
            string sql = string.Format($@"SELECT  *
                                                FROM `information_schema`.`COLUMNS`
                                                WHERE `information_schema`.`COLUMNS`.`TABLE_SCHEMA`='{database}'  and `TABLE_NAME`='{tableName}' order by ORDINAL_POSITION");
            #endregion
            DataTable dt = GetDataTable(connectionString, sql);
            return dt.Rows.Cast<DataRow>().Select(row => new DbColumn()
            {
                IsPrimaryKey = row.Field<string>("COLUMN_KEY") == "PRI",
                ColumnName = row.Field<string>("COLUMN_NAME"),
                ColumnType = row.Field<string>("DATA_TYPE"),
                IsIdentity = row.Field<string>("EXTRA")?.ToUpper() == "AUTO_INCREMENT",
                IsNullable = row.Field<string>("IS_NULLABLE") == "YES",
                ByteLength = ToInt(row["NUMERIC_PRECISION"]),
                CharLength = ToInt(row["CHARACTER_MAXIMUM_LENGTH"]),
                Scale = ToInt(row["NUMERIC_SCALE"]),
                Remark = row["COLUMN_COMMENT"]?.ToString()
            }).ToList();
        }

        #endregion

        private static int ToInt(object o)
        {
            if (o == null)
            {
                return 0;
            }
            var s = o.ToString();
            if (string.IsNullOrEmpty(s))
            {
                return 0;
            }
            return int.Parse(s);
        }
        #region GetDataTable

        public static DataTable GetDataTable(string connectionString, string commandText, params SqlParameter[] parms)
        {
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                MySqlCommand command = connection.CreateCommand();
                command.CommandText = commandText;
                command.Parameters.AddRange(parms);
                MySqlDataAdapter adapter = new MySqlDataAdapter(command);

                DataTable dt = new DataTable();
                adapter.Fill(dt);

                return dt;
            }
        }

        #endregion
    }

    #region DbTable
    /// <summary>
    /// 表结构
    /// </summary>
    public sealed class DbTable
    {
        /// <summary>
        /// 表名称
        /// </summary>
        public string TableName { get; set; }
        public string TableComment { get; set; }


    }
    #endregion

    #region DbColumn
    /// <summary>
    /// 表字段结构
    /// </summary>
    public sealed class DbColumn
    {


        /// <summary>
        /// 是否主键
        /// </summary>
        public bool IsPrimaryKey { get; set; }

        /// <summary>
        /// 字段名称
        /// </summary>
        public string ColumnName { get; set; }

        /// <summary>
        /// 字段类型
        /// </summary>
        public string ColumnType { get; set; }

        /// <summary>
        /// 数据库类型对应的C#类型
        /// </summary>
        public string CSharpType
        {
            get
            {
                var r = SqlServerDbTypeMap.MapCsharpType(ColumnType);
                if (IsNullable && CommonType.IsValueType)
                {
                    return r + "?";
                }
                return r;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public Type CommonType
        {
            get
            {
                return SqlServerDbTypeMap.MapCommonType(ColumnType);
            }
        }

        /// <summary>
        /// 字节长度
        /// </summary>
        public int ByteLength { get; set; }

        /// <summary>
        /// 字符长度
        /// </summary>
        public long CharLength { get; set; }

        /// <summary>
        /// 小数位
        /// </summary>
        public int Scale { get; set; }

        /// <summary>
        /// 是否自增列
        /// </summary>
        public bool IsIdentity { get; set; }

        /// <summary>
        /// 是否允许空
        /// </summary>
        public bool IsNullable { get; set; }



        /// <summary>
        /// 描述
        /// </summary>
        public string Remark { get; set; }
    }
    #endregion

    #region SqlServerDbTypeMap

    public class SqlServerDbTypeMap
    {
        public static string MapCsharpType(string dbtype)
        {
            if (string.IsNullOrEmpty(dbtype)) return dbtype;
            dbtype = dbtype.ToLower();
            switch (dbtype)
            {
                case "tinyint":
                case "smallint":
                case "mediumint":
                case "int":
                case "integer":
                    return "int";
                case "double":
                    return "double";
                case "float":
                    return "float";
                case "decimal":
                    return "decimal";
                case "numeric":
                case "real":
                    return "decimal";
                case "bit":
                    return "bool";
                case "date":
                case "time":
                case "year":
                case "datetime":
                case "timestamp":
                    return "DateTime";
                case "tinyblob":
                case "blob":
                case "mediumblob":
                case "longblog":
                case "binary":
                case "varbinary":
                    return "byte[]";
                case "char":
                case "varchar":
                case "tinytext":
                case "text":
                case "mediumtext":
                case "longtext":
                    return "string";
                case "point":
                case "linestring":
                case "polygon":
                case "geometry":
                case "multipoint":
                case "multilinestring":
                case "multipolygon":
                case "geometrycollection":
                case "enum":
                case "set":
                default:
                    return dbtype;

            }
        }

        public static Type MapCommonType(string dbtype)
        {
            if (string.IsNullOrEmpty(dbtype)) return Type.Missing.GetType();
            dbtype = dbtype.ToLower();
            Type commonType = typeof(object);
            dbtype = dbtype.ToLower();
            switch (dbtype)
            {
                case "tinyint":
                case "smallint":
                case "mediumint":
                case "int":
                case "integer":
                    return typeof(int);
                case "double":
                    return typeof(double);
                case "float":
                    return typeof(float);
                case "decimal":
                    return typeof(decimal);
                case "numeric":
                case "real":
                    return typeof(decimal);
                case "bit":
                    return typeof(bool);
                case "date":
                case "time":
                case "year":
                case "datetime":
                case "timestamp":
                    return typeof(DateTime);
                case "tinyblob":
                case "blob":
                case "mediumblob":
                case "longblog":
                case "binary":
                case "varbinary":
                    return typeof(byte[]);
                case "char":
                case "varchar":
                case "tinytext":
                case "text":
                case "mediumtext":
                case "longtext":
                    return typeof(string);
                case "point":
                case "linestring":
                case "polygon":
                case "geometry":
                case "multipoint":
                case "multilinestring":
                case "multipolygon":
                case "geometrycollection":
                case "enum":
                case "set":
                default:
                    return Type.Missing.GetType();

            }
        }
    }
    #endregion
    #endregion
}
