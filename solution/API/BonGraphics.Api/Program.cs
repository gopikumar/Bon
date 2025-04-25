using ipog.Bon.Api;
using ipog.Bon.Api.Middlewares;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);
ConfigureServices(builder.Services);
Configure(builder.Build());
void ConfigureServices(IServiceCollection services)
{
    services.AddControllers();
    services.ConfigureSwagger();
    services.ConfigureMVC();
    services.ConfigureCors();
    services.ConfigureAutoMapper();
    services.ConfigureMiddleware();
    services.ConfigureWorkflow();
    services.ConfigureRepository();
}
void Configure(WebApplication app)
{
    //if (app.Environment.IsDevelopment())
    //{
    app.UseSwagger();
    app.UseSwaggerUI();
    //}  
    app.UseCors("AllowAnyCorsPolicy");
#if !DEBUG
    app.UseMiddleware<AuthorizationMiddleware>();
#endif
    app.UseMiddleware<ExceptionMiddleware>();
    app.UseAuthorization();
    app.MapControllers();
    app.Run();
}
