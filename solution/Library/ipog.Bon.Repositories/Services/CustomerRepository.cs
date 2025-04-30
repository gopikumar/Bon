using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Customers;
using ipog.Bon.Repositories.IServices;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static Dapper.SqlMapper;

namespace ipog.Bon.Repositories.Services
{
    public class CustomerRepository : ICustomerRepository
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;
        public CustomerRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
       
        public async Task<(int, IEnumerable<Customer>)> Get(Pagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "All",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                });
            using (GridReader response = await _connection.QueryMultipleAsync("sp_CustomerGet", parameters, commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<Customer>());
            }
        }
      
        public async Task<(int, IEnumerable<Customer>)> Get(FilterPagination pagination)
        {
            using (GridReader response = await _connection.QueryMultipleAsync("sp_CustomerGet",
                PaginationFilter.GetPaginationParameters(pagination), commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<Customer>());
            }
        }
      
        public async Task<Customer?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await _connection.QueryFirstOrDefaultAsync<Customer>("sp_CustomerById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<Customer?> Add(Customer model)
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
            return await _connection.QueryFirstOrDefaultAsync<Customer>("sp_Customer", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<Customer?> Update(Customer model)
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
            return await _connection.QueryFirstOrDefaultAsync<Customer>("sp_Customer", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await _connection.ExecuteAsync("sp_CustomerById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<Customer?> IsActive(Guid uid, bool isActive)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "IsActive",
                    uid,
                    isActive
                });
            return await _connection.QueryFirstOrDefaultAsync<Customer>("sp_CustomerById", parameters, commandType: CommandType.StoredProcedure);
        }

    }
}
