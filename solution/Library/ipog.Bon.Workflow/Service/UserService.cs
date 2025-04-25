using ipog.Bon.Entity;
using ipog.Bon.Entity.Users;
using ipog.Bon.Model;
using ipog.Bon.Model.Users;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Response;

namespace ipog.Bon.Workflow.Service
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IMapping _mapper;
        public UserService(IUserRepository userRepository, IMapping mapper)
        {
            _userRepository = userRepository;
            _mapper = mapper;
        }
        public async Task<ResponseModelCollection<UserModelCollection>> Get(PaginationModel pagination)
        {
            if (await _userRepository.Get(await _mapper.CreateMap<Pagination, PaginationModel>(pagination)) is var (count, items))
            {
                if (count.Equals(0) || items == null || !items.Any())
                {
                    return UtilityResponse.ErrorResponseCollection<UserModelCollection>(404, "Data not found");
                }
                if (await _mapper.CreateMap<UserModelCollection, List<User>>(items.ToList()) is UserModelCollection userModel)
                {
                    return UtilityResponse.SuccessResponseCollection<UserModelCollection>(200, "Get successfully", count, userModel);
                }
            }
            return new();
        }
        public async Task<ResponseModelCollection<UserModelCollection>> Get(FilterPaginationModel pagination)
        {
            if (await _userRepository.Get(await _mapper.CreateMap<FilterPagination, FilterPaginationModel>(pagination)) is var (count, items))
            {
                if (count.Equals(0) || items == null || !items.Any())
                {
                    return UtilityResponse.ErrorResponseCollection<UserModelCollection>(404, "Data not found");
                }
                if (await _mapper.CreateMap<UserModelCollection, List<User>>(items.ToList()) is UserModelCollection userModel)
                {
                    return UtilityResponse.SuccessResponseCollection<UserModelCollection>(200, "Get successfully", count, userModel);
                }
            }
            return new();
        }
        public async Task<ResponseByModel<GetUserModel>> Find(Guid uid)
        {
            if (await _userRepository.Find(uid) is User item)
            {
                return UtilityResponse.SuccessResponseByModel<GetUserModel>(200, "Get successfully", await _mapper.CreateMap<GetUserModel, User>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetUserModel>(404, "Data not found");
        }
        public async Task<ResponseModel<GetUserModel>> Add(UserModel model)
        {
            if (await _userRepository.Add(await _mapper.CreateMap<User, UserModel>(model)) is User item)
            {
                return UtilityResponse.SuccessResponse<GetUserModel>(200, "Insert successfully", await _mapper.CreateMap<GetUserModel, User>(item));
            }
            return UtilityResponse.ErrorResponse<GetUserModel>(404, "Insert failed");
        }
        public async Task<ResponseModel<GetUserModel>> Update(UserModel model)
        {
            if (await _userRepository.Update(await _mapper.CreateMap<User, UserModel>(model)) is User item)
            {
                return UtilityResponse.SuccessResponse<GetUserModel>(200, "Update successfully", await _mapper.CreateMap<GetUserModel, User>(item));
            }
            return UtilityResponse.ErrorResponse<GetUserModel>(404, "Update failed");
        }
        public async Task<ResponseModel> Delete(Guid uid)
        {
            if (await _userRepository.Delete(uid) is int isDelete)
            {
                if (isDelete == 0)
                {
                    return UtilityResponse.ErrorResponse(404, "Data not found");
                }
                return UtilityResponse.SuccessResponse(204, "Deleted successfully");
            }
            return new();
        }
        public async Task<ResponseByModel<GetUserModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _userRepository.IsActive(uid, isActive) is User item)
            {
                return UtilityResponse.SuccessResponseByModel<GetUserModel>(200, "Active status updated successfully", await _mapper.CreateMap<GetUserModel, User>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetUserModel>(404, "Data not found");
        }
        
    }
}
