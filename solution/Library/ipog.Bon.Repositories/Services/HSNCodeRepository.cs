using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Repositories.IServices;
using Microsoft.Extensions.Configuration;

namespace ipog.Bon.Repositories.Services
{
    public class HSNCodeRepository : BaseRepository, IHSNCodeRepository
    {
        public HSNCodeRepository(IConfiguration configuration) : base(configuration)
        {
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
            return await base.QueryMultipleAsync<HSNCode>("sp_HSNCodeGet", parameters);
        }
      
        public async Task<(int, IEnumerable<HSNCode>)> Get(FilterPagination pagination)
        {
            return await base.QueryMultipleAsync<HSNCode>("sp_HSNCodeGet", PaginationFilter.GetFilterPagination(pagination));
        }
      
        public async Task<HSNCode?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await base.QueryFirstOrDefaultAsync<HSNCode>("sp_HSNCodeById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<HSNCode>("sp_HSNCode", parameters);
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
            return await base.QueryFirstOrDefaultAsync<HSNCode>("sp_HSNCode", parameters);
        }
     
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await base.ExecuteAsync("sp_HSNCodeById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<HSNCode>("sp_HSNCodeById", parameters);
        }

        public async Task<string?> NameValidation(Guid? uid, string name, long categoryId)
        {
            DynamicParameters parameters = new(
                new
                {
                    uid,
                    name,
                    categoryId
                });
            return await base.QueryFirstOrDefaultAsync<string>("sp_HSNCodeValidation", parameters);
        }

    }
}
