using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Suppliers;
using ipog.Bon.Repositories.IServices;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static Dapper.SqlMapper;

namespace ipog.Bon.Repositories.Services
{
    public class SupplierRepository : ISupplierRepository
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;
        public SupplierRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
       
        public async Task<(int, IEnumerable<Supplier>)> Get(Pagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "All",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                });
            using (GridReader response = await _connection.QueryMultipleAsync("sp_SupplierGet", parameters, commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<Supplier>());
            }
        }
      
        public async Task<(int, IEnumerable<Supplier>)> Get(FilterPagination pagination)
        {
            using (GridReader response = await _connection.QueryMultipleAsync("sp_SupplierGet",
                PaginationFilter.GetPaginationParameters(pagination), commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<Supplier>());
            }
        }
      
        public async Task<Supplier?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await _connection.QueryFirstOrDefaultAsync<Supplier>("sp_SupplierById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<Supplier?> Add(Supplier model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Add",
                    typeId = model.TypeId,
                    name = model.Name,
                    gst = model.GST,
                    landline = model.Landline,
                    email = model.Email,
                    contact = model.Contact,
                    mobile = model.Mobile,
                    address = model.Address,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<Supplier>("sp_Supplier", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<Supplier?> Update(Supplier model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Update",
                    uId = model.UId,
                    typeId = model.TypeId,
                    name = model.Name,
                    gst = model.GST,
                    landline = model.Landline,
                    email = model.Email,
                    contact = model.Contact,
                    mobile = model.Mobile,
                    address = model.Address,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<Supplier>("sp_Supplier", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await _connection.ExecuteAsync("sp_SupplierById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<Supplier?> IsActive(Guid uid, bool isActive)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "IsActive",
                    uid,
                    isActive
                });
            return await _connection.QueryFirstOrDefaultAsync<Supplier>("sp_SupplierById", parameters, commandType: CommandType.StoredProcedure);
        }

    }
}
