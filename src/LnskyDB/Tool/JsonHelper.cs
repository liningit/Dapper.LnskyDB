using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Text;

namespace LnskyDB.Tool
{
    internal class JsonHelper
    {
        private static readonly JsonSerializerSettings JsonSerializerSettings = new JsonSerializerSettings
        {
            NullValueHandling = NullValueHandling.Include,
            ContractResolver = new DefaultContractResolver()
        };

        static JsonHelper()
        {
            var timeConverter = new IsoDateTimeConverter();
            //timeConverter.DateTimeFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss";
            JsonSerializerSettings.Converters.Add(timeConverter);
        }

        /// <summary>
        ///     转换对象为json格式字符串
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="loadSetting">加载设置</param>
        /// <returns></returns>
        public static string ToJSON(object obj, bool loadSetting = true)
        {
            return loadSetting
                // 设置参数为Formatting.Indented可输出格式化后的json
                ? JsonConvert.SerializeObject(obj, Formatting.None, JsonSerializerSettings)
                : JsonConvert.SerializeObject(obj, Formatting.None);


        }

    }
}
