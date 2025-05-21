using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Repositories.IServices;
using Microsoft.Extensions.Configuration;

namespace ipog.Bon.Repositories.Services
{
    public class SupplierRepository : BaseRepository, ISupplierRepository
    {
        public SupplierRepository(IConfiguration configuration) : base(configuration)
        {
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
            return await base.QueryMultipleAsync<Supplier>("sp_SupplierGet", parameters);
        }
      
        public async Task<(int, IEnumerable<Supplier>)> Get(FilterPagination pagination)
        {
            return await base.QueryMultipleAsync<Supplier>("sp_SupplierGet", PaginationFilter.GetFilterPagination(pagination));
        }
      
        public async Task<Supplier?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await base.QueryFirstOrDefaultAsync<Supplier>("sp_SupplierById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Supplier>("sp_Supplier", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Supplier>("sp_Supplier", parameters);
        }
     
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await base.ExecuteAsync("sp_SupplierById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Supplier>("sp_SupplierById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<string>("sp_SupplierValidation", parameters);
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
            return await base.QueryFirstOrDefaultAsync<string>("sp_SupplierValidation", parameters);
        }

    }
}
