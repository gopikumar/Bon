using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Repositories.IServices;
using Microsoft.Extensions.Configuration;

namespace ipog.Bon.Repositories.Services
{
    public class CategoryRepository : BaseRepository, ICategoryRepository
    {
        public CategoryRepository(IConfiguration configuration) : base(configuration)
        {
        }

        public async Task<(int, IEnumerable<Category>)> Get(Pagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "All",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                });
            return await base.QueryMultipleAsync<Category>("sp_CategoryGet", parameters);
        }

        public async Task<(int, IEnumerable<Category>)> Get(FilterPagination pagination)
        {
            return await base.QueryMultipleAsync<Category>("sp_CategoryGet", PaginationFilter.GetFilterPagination(pagination));
        }

        public async Task<Category?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await base.QueryFirstOrDefaultAsync<Category>("sp_CategoryById", parameters);
        }

        public async Task<Category?> Add(Category model)
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
            return await base.QueryFirstOrDefaultAsync<Category>("sp_Category", parameters);
        }

        public async Task<Category?> Update(Category model)
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
            return await base.QueryFirstOrDefaultAsync<Category>("sp_Category", parameters);
        }

        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await base.ExecuteAsync("sp_CategoryById", parameters);
        }

        public async Task<Category?> IsActive(Guid uid, bool isActive)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "IsActive",
                    uid,
                    isActive
                });
            return await base.QueryFirstOrDefaultAsync<Category>("sp_CategoryById", parameters);
        }

        public async Task<string?> NameValidation(Guid? uid, string name)
        {
            DynamicParameters parameters = new(
                new
                {
                    uid,
                    name
                });
            return await base.QueryFirstOrDefaultAsync<string>("sp_CategoryValidation", parameters);
        }
    }
}
