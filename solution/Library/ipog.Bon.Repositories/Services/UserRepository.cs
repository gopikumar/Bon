using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Users;
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
        public async Task<IEnumerable<User>> Get()
        {
            var parameters = new DynamicParameters();
            parameters.Add("@action", "Filter");
            return await _connection.QueryAsync<User>("sp_UserGet", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<IEnumerable<User>> Get(Pagination pagination)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@action", "Filter");
            parameters.Add("@orderBy", pagination.OrderBy);
            parameters.Add("@sortBy", pagination.SortBy);
            parameters.Add("@pageNumber", pagination.PageNumber);
            parameters.Add("@pageSize", pagination.PageSize);
            return await _connection.QueryAsync<User>("sp_UserGet", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<User> Find(Guid uid)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@action", "Get");
            parameters.Add("@uid", uid);
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
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
        public async Task<int> Delete(Guid uid)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@action", "Delete");
            parameters.Add("@uid", uid);
            return await _connection.ExecuteAsync("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<int> IsActive(Guid uid, bool isActive)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@action", "IsActive");
            parameters.Add("@uid", uid);
            parameters.Add("@isActive", isActive);
            return await _connection.ExecuteAsync("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
        }
    }
}
