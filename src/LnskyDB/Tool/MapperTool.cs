using AutoMapper;
using AutoMapper.Configuration;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Text;

namespace LnskyDB.Tool
{
    public class MapperTool
    {
        static MapperTool()
        {
            var cfg = new MapperConfigurationExpression();
            cfg.ForAllMaps((m, y) => { y.ValidateMemberList(MemberList.None); });
            AutoMapper.Mapper.Initialize(cfg);
        }
        public static T Map<T>(object obj)
        {
            return Mapper.Map<T>(obj);
        }
        public static dynamic GetNull(IDictionary<String, Object> d)
        {
            var r = new ExpandoObject();
            foreach (var pio in d.Keys)
            {
                r.TryAdd(pio, null);
            }
            return r;
        }
    }
}
