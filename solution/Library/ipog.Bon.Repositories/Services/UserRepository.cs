using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Users;
using ipog.Bon.Repositories.IServices;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static Dapper.SqlMapper;

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
        public async Task<(int, IEnumerable<User>)> Get(Pagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "All",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                });
            GridReader response = await _connection.QueryMultipleAsync("sp_UserGet", parameters, commandType: CommandType.StoredProcedure);
            return (response.ReadFirst<int>(), response.Read<User>());
        }
        public async Task<(int, IEnumerable<User>)> Get(FilterPagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Filter",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                    pageNumber = pagination.PageNumber,
                    pageSize = pagination.PageSize,
                    filterColumns = pagination.FilterColumns
                });
            GridReader response = await _connection.QueryMultipleAsync("sp_UserGet", parameters, commandType: CommandType.StoredProcedure);
            return (response.ReadFirst<int>(), response.Read<User>());
        }
        public async Task<User> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<User> Add(User model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Add",
                    uid = Guid.NewGuid()
                });
            await _connection.ExecuteAsync("AddUser", parameters, commandType: CommandType.StoredProcedure);
            return model;
        }
        public async Task<User> Update(User model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Update"
                });
            await _connection.ExecuteAsync("UpdateUser", parameters, commandType: CommandType.StoredProcedure);
            return model;
        }
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await _connection.ExecuteAsync("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<User> IsActive(Guid uid, bool isActive)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "IsActive",
                    uid,
                    isActive
                });
            await _connection.ExecuteAsync("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
            return await Find(uid);
        }
    }
}
