using ipog.Bon.Api.Middlewares;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Repositories.Services;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Service;
using Microsoft.OpenApi.Models;
using System.Text.Json.Serialization;

namespace ipog.Bon.Api
{
    public static class ServiceExtension
    {
        public static void ConfigureCors(this IServiceCollection services)
        {
            services.AddCors(options =>
            {
                options.AddPolicy("AllowAnyCorsPolicy", policy =>
                    policy.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin()
                );
            });
        }
        public static void ConfigureSwagger(this IServiceCollection services)
        {
            services.AddEndpointsApiExplorer();
#if DEBUG
            services.AddSwaggerGen();
#else
            services.AddSwaggerGen(m =>
            {
                m.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
                {
                    Title = "Utilizer",
                    Version = "v1"
                });
                m.AddSecurityDefinition("Bearer", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
                {
                    Name = "Authorization",
                    Type = SecuritySchemeType.ApiKey,
                    Scheme = "Bearer",
                    BearerFormat = "JWT",
                    In = ParameterLocation.Header,
                    Description = "JWT Authorization header using the bearer scheme. Enter 'Bearer' [space] and then your token in the text input"
                });
                m.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {
                    new OpenApiSecurityScheme
                    {
                        Reference=new OpenApiReference
                        {
                            Type=ReferenceType.SecurityScheme,
                            Id="Bearer"
                        }
                    },
                    new string[] { }
                    }
                });
            });
#endif
        }
        public static void ConfigureMVC(this IServiceCollection services)
        {
            services.AddControllers().AddJsonOptions(x =>
                            x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);
        }
        public static void ConfigureAutoMapper(this IServiceCollection services)
        {
            services.AddAutoMapper(typeof(MapperProfile));
            services.AddTransient<IMapping, Mapping>();
        }
        public static void ConfigureWorkflow(this IServiceCollection services)
        {
            services.AddTransient<IUserService, UserService>();
            services.AddTransient<ILoginService, LoginService>();
            services.AddTransient<IRoleService, RoleService>();
        }
        public static void ConfigureRepository(this IServiceCollection services)
        {
            services.AddTransient<IUserRepository, UserRepository>();
            services.AddTransient<ILoginRepository, LoginRepository>();
            services.AddTransient<IRoleRepository, RoleRepository>();
        }

        public static void ConfigureMiddleware(this IServiceCollection services)
        {
            services.AddTransient<AuthorizationMiddleware>();
            services.AddTransient<ExceptionMiddleware>();
        }
    }
}
