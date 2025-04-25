using Dapper;
using ipog.Bon.Entity.Users;
using ipog.Bon.Repositories.IServices;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static Dapper.SqlMapper;

namespace ipog.Bon.Repositories.Services
{
    public class LoginRepository : ILoginRepository
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;
        public LoginRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }

        public async Task<User?> Validation(Login request)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "employee",
                    username= request.UserName,
                    password = request.Password
                });
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_Login", parameters, commandType: CommandType.StoredProcedure);
        }
    }
}
