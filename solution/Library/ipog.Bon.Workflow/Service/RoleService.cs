using ipog.Bon.Entity;
using ipog.Bon.Entity.Roles;
using ipog.Bon.Model;
using ipog.Bon.Model.Roles;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Response;

namespace ipog.Bon.Workflow.Service
{
    public class RoleService : IRoleService
    {
        private readonly IRoleRepository _roleRepository;
        private readonly IMapping _mapper;
        public RoleService(IRoleRepository roleRepository, IMapping mapper)
        {
            _roleRepository = roleRepository;
            _mapper = mapper;
        }
        public async Task<ResponseModelCollection<RoleModelCollection>> Get(PaginationModel pagination)
        {
            if (await _roleRepository.Get(await _mapper.CreateMap<Pagination, PaginationModel>(pagination)) is var (count, items))
            {
                if (count.Equals(0) || items == null || !items.Any())
                {
                    return UtilityResponse.ErrorResponseCollection<RoleModelCollection>(404, "Data not found");
                }
                if (await _mapper.CreateMap<RoleModelCollection, List<Role>>(items.ToList()) is RoleModelCollection roleModel)
                {
                    return UtilityResponse.SuccessResponseCollection<RoleModelCollection>(200, "Get successfully", count, roleModel);
                }
            }
            return new();
        }
        public async Task<ResponseModelCollection<RoleModelCollection>> Get(FilterPaginationModel pagination)
        {
            if (await _roleRepository.Get(await _mapper.CreateMap<FilterPagination, FilterPaginationModel>(pagination)) is var (count, items))
            {
                if (count.Equals(0) || items == null || !items.Any())
                {
                    return UtilityResponse.ErrorResponseCollection<RoleModelCollection>(404, "Data not found");
                }
                if (await _mapper.CreateMap<RoleModelCollection, List<Role>>(items.ToList()) is RoleModelCollection roleModel)
                {
                    return UtilityResponse.SuccessResponseCollection<RoleModelCollection>(200, "Get successfully", count, roleModel);
                }
            }
            return new();
        }
        public async Task<ResponseByModel<GetRoleModel>> Find(Guid uid)
        {
            if (await _roleRepository.Find(uid) is Role item)
            {
                return UtilityResponse.SuccessResponseByModel<GetRoleModel>(200, "Get successfully", await _mapper.CreateMap<GetRoleModel, Role>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetRoleModel>(404, "Data not found");
        }
        public async Task<ResponseModel<GetRoleModel>> Add(RoleModel model)
        {
            if (await _roleRepository.Add(await _mapper.CreateMap<Role, RoleModel>(model)) is Role item)
            {
                return UtilityResponse.SuccessResponse<GetRoleModel>(200, "Insert successfully", await _mapper.CreateMap<GetRoleModel, Role>(item));
            }
            return UtilityResponse.ErrorResponse<GetRoleModel>(404, "Insert failed");
        }
        public async Task<ResponseModel<GetRoleModel>> Update(RoleModel model)
        {
            if (await _roleRepository.Update(await _mapper.CreateMap<Role, RoleModel>(model)) is Role item)
            {
                return UtilityResponse.SuccessResponse<GetRoleModel>(200, "Update successfully", await _mapper.CreateMap<GetRoleModel, Role>(item));
            }
            return UtilityResponse.ErrorResponse<GetRoleModel>(404, "Update failed");
        }
        public async Task<ResponseModel> Delete(Guid uid)
        {
            if (await _roleRepository.Delete(uid) is int isDelete)
            {
                if (isDelete == 0)
                {
                    return UtilityResponse.ErrorResponse(404, "Data not found");
                }
                return UtilityResponse.SuccessResponse(204, "Deleted successfully");
            }
            return new();
        }
        public async Task<ResponseByModel<GetRoleModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _roleRepository.IsActive(uid, isActive) is Role item)
            {
                return UtilityResponse.SuccessResponseByModel<GetRoleModel>(200, "Active status updated successfully", await _mapper.CreateMap<GetRoleModel, Role>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetRoleModel>(404, "Data not found");
        }
    }
}
