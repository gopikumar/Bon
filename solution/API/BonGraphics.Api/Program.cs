using ipog.Bon.Api;

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
    app.UseAuthorization();
    app.MapControllers();
    app.Run();
}
