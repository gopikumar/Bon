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
            var (count, items) = await _userRepository.Get(await _mapper.CreateMap<Pagination, PaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<UserModelCollection>(404, "Data not found");
            }
            UserModelCollection collection = await _mapper.CreateMap<UserModelCollection, List<User>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<UserModelCollection>(200, "Get successfully", count, collection);
        }
       
        public async Task<ResponseModelCollection<UserModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _userRepository.Get(await _mapper.CreateMap<FilterPagination, FilterPaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<UserModelCollection>(404, "Data not found");
            }
            UserModelCollection collection = await _mapper.CreateMap<UserModelCollection, List<User>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<UserModelCollection>(200, "Get successfully", count, collection);
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
            int isDelete = await _userRepository.Delete(uid);
            if (isDelete == 0)
            {
                return UtilityResponse.ErrorResponse(404, "Id not found");
            }
            return UtilityResponse.SuccessResponse(204, "Deleted successfully");
        }
       
        public async Task<ResponseByModel<GetUserModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _userRepository.IsActive(uid, isActive) is User item)
            {
                return UtilityResponse.SuccessResponseByModel<GetUserModel>(200, "Active status updated successfully", await _mapper.CreateMap<GetUserModel, User>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetUserModel>(404, "Data not found");
        }

        public async Task<ResponseModel> EmailValidation(Guid? uid, string email)
        {
            if (await _userRepository.EmailValidation(uid,email) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Email already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }

        public async Task<ResponseModel> MobileValidation(Guid? uid, string mobile)
        {
            if (await _userRepository.MobileValidation(uid, mobile) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Mobile already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }

        public async Task<ResponseByModel<GetUserModel>> Validation(LoginModel request)
        {
            if (await _userRepository.Validation(await _mapper.CreateMap<Login, LoginModel>(request)) is User item)
            {
                return UtilityResponse.SuccessResponseByModel<GetUserModel>(200, "Get successfully", await _mapper.CreateMap<GetUserModel, User>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetUserModel>(404, "Invalid credential");
        }

        public async Task<ResponseByModel<GetUserModel>> UpdatePassword(UpdatePasswordModel request)
        {
            if (await _userRepository.UpdatePassword(await _mapper.CreateMap<UpdatePassword, UpdatePasswordModel>(request)) is User item)
            {
                return UtilityResponse.SuccessResponseByModel<GetUserModel>(200, "Get successfully", await _mapper.CreateMap<GetUserModel, User>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetUserModel>(404, "Data not found");
        }
    }
}
