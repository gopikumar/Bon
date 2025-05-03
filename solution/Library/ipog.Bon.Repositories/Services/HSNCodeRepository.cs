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
    public class HSNCodeRepository : IHSNCodeRepository
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;
        public HSNCodeRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
       
        public async Task<(int, IEnumerable<HSNCode>)> Get(Pagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "All",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                });
            using (GridReader response = await _connection.QueryMultipleAsync("sp_HSNCodeGet", parameters, commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<HSNCode>());
            }
        }
      
        public async Task<(int, IEnumerable<HSNCode>)> Get(FilterPagination pagination)
        {
            using (GridReader response = await _connection.QueryMultipleAsync("sp_HSNCodeGet",
                PaginationFilter.GetPaginationParameters(pagination), commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<HSNCode>());
            }
        }
      
        public async Task<HSNCode?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await _connection.QueryFirstOrDefaultAsync<HSNCode>("sp_HSNCodeById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<HSNCode?> Add(HSNCode model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Add",
                    categoryId = model.CategoryId,
                    name = model.Name,
                    notes = model.Notes,
                    gst = model.GST,
                    SGST = model.SGST,
                    CGST = model.CGST,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<HSNCode>("sp_HSNCode", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<HSNCode?> Update(HSNCode model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Update",
                    uId = model.UId,
                    categoryId = model.CategoryId,
                    name = model.Name,
                    notes = model.Notes,
                    gst = model.GST,
                    SGST = model.SGST,
                    CGST = model.CGST,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<HSNCode>("sp_HSNCode", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await _connection.ExecuteAsync("sp_HSNCodeById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<HSNCode?> IsActive(Guid uid, bool isActive)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "IsActive",
                    uid,
                    isActive
                });
            return await _connection.QueryFirstOrDefaultAsync<HSNCode>("sp_HSNCodeById", parameters, commandType: CommandType.StoredProcedure);
        }

    }
}
