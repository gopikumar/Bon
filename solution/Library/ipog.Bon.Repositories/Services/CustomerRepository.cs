using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Repositories.IServices;
using Microsoft.Extensions.Configuration;

namespace ipog.Bon.Repositories.Services
{
    public class CustomerRepository : BaseRepository, ICustomerRepository
    {
        public CustomerRepository(IConfiguration configuration) : base(configuration)
        {
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
            return await base.QueryMultipleAsync<Customer>("sp_CustomerGet", parameters);
        }
      
        public async Task<(int, IEnumerable<Customer>)> Get(FilterPagination pagination)
        {
            return await base.QueryMultipleAsync<Customer>("sp_CustomerGet", PaginationFilter.GetFilterPagination(pagination));
        }
      
        public async Task<Customer?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await base.QueryFirstOrDefaultAsync<Customer>("sp_CustomerById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Customer>("sp_Customer", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Customer>("sp_Customer", parameters);
        }
     
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await base.ExecuteAsync("sp_CustomerById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Customer>("sp_CustomerById", parameters);
        }

        public async Task<string?> EmailValidation(Guid? uid, string email)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Email",
                    uid,
                    email
                });
            return await base.QueryFirstOrDefaultAsync<string>("sp_CustomerValidation", parameters);
        }

        public async Task<string?> MobileValidation(Guid? uid, string mobile)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Mobile",
                    uid,
                    mobile
                });
            return await base.QueryFirstOrDefaultAsync<string>("sp_CustomerValidation", parameters);
        }
    }
}
