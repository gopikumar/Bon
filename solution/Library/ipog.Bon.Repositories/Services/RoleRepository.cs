using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Roles;
using ipog.Bon.Entity.Users;
using ipog.Bon.Repositories.IServices;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static Dapper.SqlMapper;

namespace ipog.Bon.Repositories.Services
{
    public class RoleRepository : IRoleRepository
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;
        public RoleRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
        public async Task<(int, IEnumerable<Role>)> Get(Pagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "All",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                });
            using (GridReader response = await _connection.QueryMultipleAsync("sp_RoleGet", parameters, commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<Role>());
            }
        }
        public async Task<(int, IEnumerable<Role>)> Get(FilterPagination pagination)
        {
            using (GridReader response = await _connection.QueryMultipleAsync("sp_RoleGet",
                PaginationFilter.GetPaginationParameters(pagination), commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<Role>());
            }
        }
        public async Task<Role?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await _connection.QueryFirstOrDefaultAsync<Role>("sp_RoleById", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<Role?> Add(Role model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Add",
                    name = model.Name,
                    control = model.Control,
                    notes = model.Notes,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<Role>("sp_Role", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<Role?> Update(Role model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Update",
                    uId = model.UId,
                    name = model.Name,
                    control = model.Control,
                    notes = model.Notes,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<Role>("sp_Role", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await _connection.ExecuteAsync("sp_RoleById", parameters, commandType: CommandType.StoredProcedure);
        }
        public async Task<Role?> IsActive(Guid uid, bool isActive)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "IsActive",
                    uid,
                    isActive
                });
            return await _connection.QueryFirstOrDefaultAsync<Role>("sp_RoleById", parameters, commandType: CommandType.StoredProcedure);
        }
    }
}
