using Microsoft.AspNetCore.Mvc.Filters;
using System;

namespace LnskyDB.Filter
{
    internal class ApiExceptionFilterAttribute : IExceptionFilter
    {
        public void OnException(ExceptionContext context)
        {
            DBTool.CloseConnections();
        }
    }
}
