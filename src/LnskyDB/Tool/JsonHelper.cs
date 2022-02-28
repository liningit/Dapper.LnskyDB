
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;

namespace LnskyDB.Tool
{
    internal class JsonHelper
    {

        static JsonHelper()
        {

        }

        /// <summary>
        ///     转换对象为json格式字符串
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="loadSetting">加载设置</param>
        /// <returns></returns>
        public static string ToJSON(object obj)
        {
            string jsonString = JsonSerializer.Serialize(obj);

            return jsonString;


        }

    }
}
