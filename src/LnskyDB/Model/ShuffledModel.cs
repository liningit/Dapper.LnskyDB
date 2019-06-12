namespace LnskyDB.Model
{
    public class ShuffledModel
    {
        public static ShuffledModel Empty { get; } = new ShuffledModel("", "");
        public ShuffledModel(string dbId, string tableId)
        {
            DBId = dbId;
            TableId = tableId;
        }
        public string DBId { get; private set; }
        public string TableId { get; private set; }
        public bool IsEmpty()
        {
            return string.IsNullOrEmpty(DBId) && string.IsNullOrEmpty(TableId);
        }
    }
}