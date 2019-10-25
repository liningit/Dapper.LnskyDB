using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Text;

namespace LnskyDB.Model
{
    public class BaseDBModel
    {
        public BaseDBModel()
        {

        }
        /// <summary>
        /// 主键
        /// </summary>
        public virtual ImmutableList<string> GetDBModel_PKCols() => null;
        private static ImmutableList<string> _DBModel_ExcludeColsForUpdate = ImmutableList.Create<string>();
        /// <summary>
        /// 更新时忽略的列
        /// </summary>
        public virtual ImmutableList<string> GetDBModel_ExcludeColsForUpdate() => _DBModel_ExcludeColsForUpdate;
        /// <summary>
        /// 自增列
        /// </summary>
        public virtual string GetDBModel_IncrementCol() => string.Empty;
        public virtual bool GetDBModel_IsShuffled() => false;

        public virtual void SetIncrementValue(int value)
        {
            throw new Exception("该表没有自增列");
        }
        private string _tableWith = string.Empty;
        public string GetTableWith()
        {
            return _tableWith;
        }
        public void SetTableWith(string tableWith)
        {
            this._tableWith = tableWith;
        }
        /// <summary>
        /// 表名
        /// </summary>
        public virtual string GetDBModel_TableName() => null;
        /// <summary>
        /// 数据库名称
        /// </summary>
        /// <returns></returns>
        public virtual string GetDBModel_DBName() => null;
        /// <summary>
        /// 获取分库分表信息,如果没有分库分表则可以不重写
        /// </summary>
        /// <returns></returns>
        public virtual ShuffledModel GetShuffledModel() { return ShuffledModel.Empty; }
        public virtual void SetShuffledData(object obj) { throw new NoShuffledException(GetDBModel_TableName(), "没有实现分库分表"); }
        /// <summary>
        /// 是否开始修改
        /// </summary>
        private bool _IsBeginChange = true;

        private List<string> changeList { get; set; } = new List<string>();
        public List<string> GetDBModel_ChangeList()
        {
            return changeList;
        }
        public void BeginChange()
        {
            _IsBeginChange = true;
        }
        public bool IsBeginChange()
        {
            return _IsBeginChange;
        }
        protected void Change(string col)
        {
            if (_IsBeginChange)
            {
                if (!changeList.Contains(col))
                {
                    changeList.Add(col);
                }
            }
        }
        protected static ShuffledModel ShuffledByDbTable(DateTime createDate)
        {
            return new ShuffledModel("_" + createDate.Year.ToString().Substring(2), "_" + createDate.Month.ToString("00"));
        }
    }

}
