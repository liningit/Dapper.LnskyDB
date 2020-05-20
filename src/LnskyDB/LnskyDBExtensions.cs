using LnskyDB.Filter;
using LnskyDB.Internal;
using LnskyDB.Model;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Hosting.Server.Features;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace LnskyDB
{
    public static class LnskyDBExtensions
    {
        public delegate void LnskyDBEventHandler<TEventArgs>(TEventArgs e);
        public static IServiceCollection AddLnskyDB(this IServiceCollection services)
        {
            services.Configure<MvcOptions>(options =>
            {
                options.Filters.Add(typeof(SampleActionFilter));
                options.Filters.Add(typeof(ApiExceptionFilterAttribute));

            });
            services.AddScoped<LnskyDBConnLst>();
            services.AddScoped<ILnskyDBTransactionMain, LnskyDBTransactionMain>();
            services.AddHttpContextAccessor();
            services.AddHttpContextAccessor();
            return services;
        }

        public static IApplicationBuilder UseLnskyDB(this IApplicationBuilder app)
        {
            var httpContextAccessor = app.ApplicationServices.GetRequiredService<IHttpContextAccessor>();
            DBTool.HttpContext = httpContextAccessor;
            DBTool.Configuration = app.ApplicationServices.GetRequiredService<IConfiguration>();
            return app;
        }
    }
}
