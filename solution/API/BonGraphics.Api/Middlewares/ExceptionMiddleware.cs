using ipog.Bon.Model;
using Newtonsoft.Json;

namespace ipog.Bon.Api.Middlewares
{
    public class ExceptionMiddleware : IMiddleware
    {
        private readonly ILogger<ExceptionMiddleware> _logger;
        public ExceptionMiddleware(ILogger<ExceptionMiddleware> logger)
        {
            _logger = logger;
        }
        public async Task InvokeAsync(HttpContext context, RequestDelegate next)
        {
            try
            {
                _logger.LogInformation(JsonConvert.SerializeObject(context.Request.Path));
                await next(context);
            }
            catch (Exception ex)
            {
                _logger.LogError(JsonConvert.SerializeObject(ex));
                Error error = new()
                {
                    Success = false,
                    Message = ex.Message,
                    Source = ex.Source ?? "Unknown"
                };
                await context.Response.WriteAsJsonAsync(error);
            }
        }
    }
}
