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
        public UserService(IUserRepository iUserRepository, IMapping mapper)
        {
            _userRepository = iUserRepository;
            _mapper = mapper;
        }
        public async Task<ResponseModelCollection> Get(PaginationModel pagination)
        {
            if (await _userRepository.Get(await _mapper.CreateMap<Pagination, PaginationModel>(pagination)) is var (count, items))
            {
                if (count.Equals(0) || items == null || !items.Any())
                {
                    return UtilityResponse.ErrorResponseCollection(404, "Data not found");
                }
                if (await _mapper.CreateMap<UserModelCollection, List<User>>(items.ToList()) is UserModelCollection userModel)
                {
                    return UtilityResponse.SuccessResponseCollection<UserModelCollection>(200, "Get successfully", count, userModel);
                }
            }
            return new();
        }
        public async Task<ResponseModelCollection> Get(FilterPaginationModel pagination)
        {
            if (await _userRepository.Get(await _mapper.CreateMap<FilterPagination, FilterPaginationModel>(pagination)) is var (count, items))
            {
                if (count.Equals(0) || items == null || !items.Any())
                {
                    return UtilityResponse.ErrorResponseCollection(404, "Data not found");
                }
                if (await _mapper.CreateMap<UserModelCollection, List<User>>(items.ToList()) is UserModelCollection userModel)
                {
                    return UtilityResponse.SuccessResponseCollection<UserModelCollection>(200, "Get successfully", count, userModel);
                }
            }
            return new();
        }
        public async Task<ResponseByIdModel> Find(Guid uid)
        {
            if (await _userRepository.Find(uid) is IEnumerable<User> item)
            {
                if (item == null || !item.Any())
                {
                    return UtilityResponse.ErrorResponseById(404, "Data not found");
                }
                return UtilityResponse.SuccessResponseById<User>(200, "Get successfully", item.FirstOrDefault());
            }
            return new();
        }
        public async Task<ResponseModel> Add(UserModel model)
        {
            if (await _userRepository.Add(await _mapper.CreateMap<User, UserModel>(model)) is IEnumerable<User> item)
            {
                if (item == null || !item.Any())
                {
                    return UtilityResponse.ErrorResponse(404, "Data not found");
                }
                return UtilityResponse.SuccessResponse<User>(200, "Insert successfully", item.FirstOrDefault());
            }
            return new();
        }
        public async Task<ResponseModel> Update(UserModel model)
        {
            if (await _userRepository.Update(await _mapper.CreateMap<User, UserModel>(model)) is IEnumerable<User> item)
            {
                if (item == null || !item.Any())
                {
                    return UtilityResponse.ErrorResponse(404, "Data not found");
                }
                return UtilityResponse.SuccessResponse<User>(200, "Insert successfully", item.FirstOrDefault());
            }
            return new();
        }
        public async Task<ResponseByIdModel> Delete(Guid uid)
        {
            if (await _userRepository.Delete(uid) is int isDelete)
            {
                if (isDelete == 0)
                {
                    return UtilityResponse.ErrorResponseById(404, "Data not found");
                }
                return UtilityResponse.SuccessResponseById<User>(204, "Deleted successfully", new());
            }
            return new();
        }
        public async Task<ResponseByIdModel> IsActive(Guid uid, bool isActive)
        {
            if (await _userRepository.IsActive(uid, isActive) is IEnumerable<User> item)
            {
                if (item == null || !item.Any())
                {
                    return UtilityResponse.ErrorResponseById(404, "Data not found");
                }
                return UtilityResponse.SuccessResponseById<User>(200, "Active status updated successfully", item.FirstOrDefault());
            }
            return new();
        }
    }
}
