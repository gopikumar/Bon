using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Repositories.IServices;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace ipog.Bon.Repositories.Services
{
    public class UserRepository : IUserRepository
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;
        public UserRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
        public async Task<User> Add(User model)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@uid", Guid.NewGuid());
            await _connection.ExecuteAsync("AddUser", parameters, commandType: CommandType.StoredProcedure);
            return model;
        }

        public async Task<User> Update(User model)
        {
            var parameters = new DynamicParameters();
            await _connection.ExecuteAsync("UpdateUser", parameters, commandType: CommandType.StoredProcedure);
            return model;
        }

        public async Task<int> Remove(User model)
        {
            var parameters = new DynamicParameters();
            return await _connection.ExecuteAsync("DeleteUser", parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<User>> Get()
        {
            return await _connection.QueryAsync<User>("GetAllUser", commandType: CommandType.StoredProcedure);
        }

        public async Task<User> Find(Guid uid)
        {
            var parmeters = new DynamicParameters();
            parmeters.Add("@uid", uid);
            return await _connection.QueryFirstOrDefaultAsync<User>("GetUserById", parmeters, commandType: CommandType.StoredProcedure);
        }

    }
}
