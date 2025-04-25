using ipog.Bon.Model;
using System.IdentityModel.Tokens.Jwt;

namespace ipog.Bon.Api.Middlewares
{
    public class AuthorizationMiddleware : IMiddleware
    {
        private readonly ILogger<AuthorizationMiddleware> _logger;
        public AuthorizationMiddleware(ILogger<AuthorizationMiddleware> logger)
        {
            _logger = logger;
        }
        public async Task InvokeAsync(HttpContext context, RequestDelegate next)
        {
            //if (context.Request.IsHttps)
            //{
            //    _logger.LogInformation(JsonConvert.SerializeObject(new StatusCodeResult(StatusCodes.Status403Forbidden)) + "Allow Only Http Url");
            //    Error error = new()
            //    {
            //        Success = false,
            //        Message = "Allow Only Http Url",
            //        Source = context.Request.Path
            //    };
            //    await context.Response.WriteAsJsonAsync(error);
            //}
            if (!context.Request.Headers.ContainsKey("Authorization"))
            {
                Error error = new()
                {
                    Success = false,
                    Message = "Kindly pass the token in request header",
                    Source = context.Request.Path
                };
                await context.Response.WriteAsJsonAsync(error);
                return;
            }

            string? authorizationHeader = context.Request.Headers["Authorization"].FirstOrDefault();
            if (string.IsNullOrWhiteSpace(authorizationHeader) || !authorizationHeader.Contains(" "))
            {
                Error error = new()
                {
                    Success = false,
                    Message = "Invalid Authorization header format",
                    Source = context.Request.Path
                };
                await context.Response.WriteAsJsonAsync(error);
                return;
            }

            string token = authorizationHeader.Split(" ")[1];
            JwtSecurityToken? jwtToken = new JwtSecurityTokenHandler().ReadToken(token) as JwtSecurityToken;
            if (jwtToken?.ValidTo < DateTime.UtcNow)
            {
                Error error = new()
                {
                    Success = false,
                    Message = "Token expired!",
                    Source = context.Request.Path
                };
                await context.Response.WriteAsJsonAsync(error);
                return;
            }

            await next(context);

        }
    }
}
