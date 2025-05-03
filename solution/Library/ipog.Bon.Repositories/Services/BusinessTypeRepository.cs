using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Repositories.IServices;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static Dapper.SqlMapper;

namespace ipog.Bon.Repositories.Services
{
    public class BusinessTypeRepository : IBusinessTypeRepository
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;
        public BusinessTypeRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
       
        public async Task<(int, IEnumerable<BusinessType>)> Get(Pagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "All",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                });
            using (GridReader response = await _connection.QueryMultipleAsync("sp_BusinessTypeGet", parameters, commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<BusinessType>());
            }
        }
      
        public async Task<(int, IEnumerable<BusinessType>)> Get(FilterPagination pagination)
        {
            using (GridReader response = await _connection.QueryMultipleAsync("sp_BusinessTypeGet",
                PaginationFilter.GetPaginationParameters(pagination), commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<BusinessType>());
            }
        }
      
        public async Task<BusinessType?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await _connection.QueryFirstOrDefaultAsync<BusinessType>("sp_BusinessTypeById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<BusinessType?> Add(BusinessType model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Add",
                    name = model.Name,
                    notes = model.Notes,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<BusinessType>("sp_BusinessType", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<BusinessType?> Update(BusinessType model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Update",
                    uId = model.UId,
                    name = model.Name,
                    notes = model.Notes,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<BusinessType>("sp_BusinessType", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await _connection.ExecuteAsync("sp_BusinessTypeById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<BusinessType?> IsActive(Guid uid, bool isActive)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "IsActive",
                    uid,
                    isActive
                });
            return await _connection.QueryFirstOrDefaultAsync<BusinessType>("sp_BusinessTypeById", parameters, commandType: CommandType.StoredProcedure);
        }

    }
}
