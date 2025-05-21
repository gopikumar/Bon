using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Repositories.IServices;
using Microsoft.Extensions.Configuration;

namespace ipog.Bon.Repositories.Services
{
    public class BusinessTypeRepository : BaseRepository, IBusinessTypeRepository
    {
        public BusinessTypeRepository(IConfiguration configuration) : base(configuration)
        {
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
            return await base.QueryMultipleAsync<BusinessType>("sp_BusinessTypeGet", parameters);
        }

        public async Task<(int, IEnumerable<BusinessType>)> Get(FilterPagination pagination)
        {
            return await base.QueryMultipleAsync<BusinessType>("sp_BusinessTypeGet", PaginationFilter.GetFilterPagination(pagination));
        }

        public async Task<BusinessType?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await base.QueryFirstOrDefaultAsync<BusinessType>("sp_BusinessTypeById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<BusinessType>("sp_BusinessType", parameters);
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
            return await base.QueryFirstOrDefaultAsync<BusinessType>("sp_BusinessType", parameters);
        }

        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await base.ExecuteAsync("sp_BusinessTypeById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<BusinessType>("sp_BusinessTypeById", parameters);
        }

        public async Task<string?> NameValidation(Guid? uid, string name)
        {
            DynamicParameters parameters = new(
                new
                {
                    uid,
                    name
                });
            return await base.QueryFirstOrDefaultAsync<string>("sp_BusinessTypeValidation", parameters);
        }
    }
}
