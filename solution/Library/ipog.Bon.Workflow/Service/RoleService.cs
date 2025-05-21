using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Response;

namespace ipog.Bon.Workflow.Service
{
    public class RoleService : BaseService, IRoleService
    {
        private readonly IRoleRepository _roleRepository;
        public RoleService(IRoleRepository roleRepository, IMapping mapper) : base(mapper)
        {
            _roleRepository = roleRepository;
        }

        public async Task<ResponseModelCollection<RoleModelCollection>> Get(PaginationModel pagination)
        {
            var (count, items) = await _roleRepository.Get(await base.Map<Pagination, PaginationModel>(pagination));
            if (count.Equals(0) || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<RoleModelCollection>(404, "Data not found");
            }
            RoleModelCollection collection = await base.Map<RoleModelCollection, List<Role>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<RoleModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseModelCollection<RoleModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _roleRepository.Get(await base.Map<FilterPagination, FilterPaginationModel>(pagination));
            if (count.Equals(0) || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<RoleModelCollection>(404, "Data not found");
            }
            RoleModelCollection collection = await base.Map<RoleModelCollection, List<Role>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<RoleModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseByModel<GetRoleModel>> Find(Guid uid)
        {
            if (await _roleRepository.Find(uid) is Role item)
            {
                return UtilityResponse.SuccessResponseByModel<GetRoleModel>(200, "Get successfully", await base.Map<GetRoleModel, Role>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetRoleModel>(404, "Data not found");
        }

        public async Task<ResponseModel<GetRoleModel>> Add(RoleModel model)
        {
            if (await _roleRepository.Add(await base.Map<Role, RoleModel>(model)) is Role item)
            {
                return UtilityResponse.SuccessResponse<GetRoleModel>(200, "Insert successfully", await base.Map<GetRoleModel, Role>(item));
            }
            return UtilityResponse.ErrorResponse<GetRoleModel>(404, "Insert failed");
        }

        public async Task<ResponseModel<GetRoleModel>> Update(RoleModel model)
        {
            if (await _roleRepository.Update(await base.Map<Role, RoleModel>(model)) is Role item)
            {
                return UtilityResponse.SuccessResponse<GetRoleModel>(200, "Update successfully", await base.Map<GetRoleModel, Role>(item));
            }
            return UtilityResponse.ErrorResponse<GetRoleModel>(404, "Update failed");
        }

        public async Task<ResponseModel> Delete(Guid uid)
        {
            int isDelete = await _roleRepository.Delete(uid);
            if (isDelete == 0)
            {
                return UtilityResponse.ErrorResponse(404, "Id not found");
            }
            return UtilityResponse.SuccessResponse(204, "Deleted successfully");
        }

        public async Task<ResponseByModel<GetRoleModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _roleRepository.IsActive(uid, isActive) is Role item)
            {
                return UtilityResponse.SuccessResponseByModel<GetRoleModel>(200, "Active status updated successfully", await base.Map<GetRoleModel, Role>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetRoleModel>(404, "Data not found");
        }

        public async Task<ResponseModel> NameValidation(Guid? uid, string name)
        {
            if (await _roleRepository.NameValidation(uid, name) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Name already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }
    }
}
