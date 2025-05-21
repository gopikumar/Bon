using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Repositories.IServices;
using Microsoft.Extensions.Configuration;

namespace ipog.Bon.Repositories.Services
{
    public class RoleRepository : BaseRepository, IRoleRepository
    {
        public RoleRepository(IConfiguration configuration) : base(configuration)
        {
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
            return await base.QueryMultipleAsync<Role>("sp_RoleGet", parameters);
        }
      
        public async Task<(int, IEnumerable<Role>)> Get(FilterPagination pagination)
        {
            return await base.QueryMultipleAsync<Role>("sp_RoleGet", PaginationFilter.GetFilterPagination(pagination));
        }
      
        public async Task<Role?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await base.QueryFirstOrDefaultAsync<Role>("sp_RoleById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Role>("sp_Role", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Role>("sp_Role", parameters);
        }
      
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await base.ExecuteAsync("sp_RoleById", parameters);
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
            return await base.QueryFirstOrDefaultAsync<Role>("sp_RoleById", parameters);
        }

        public async Task<string?> NameValidation(Guid? uid, string name)
        {
            DynamicParameters parameters = new(
                new
                {
                    uid,
                    name
                });
            return await base.QueryFirstOrDefaultAsync<string>("sp_RoleValidation", parameters);
        }
    }
}
