using ipog.Bon.Entity.Users;
using ipog.Bon.Model;
using ipog.Bon.Model.Users;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Response;

namespace ipog.Bon.Workflow.Service
{
    public class LoginService : ILoginService
    {
        private readonly ILoginRepository _loginRepository;
        private readonly IMapping _mapper;
        public LoginService(ILoginRepository loginRepository, IMapping mapper)
        {
            _loginRepository = loginRepository;
            _mapper = mapper;
        }

        public async Task<ResponseByModel<GetUserModel>> Validation(LoginModel request)
        {
            if (await _loginRepository.Validation(await _mapper.CreateMap<Login, LoginModel>(request)) is User item)
            {
                return UtilityResponse.SuccessResponseByModel<GetUserModel>(200, "Get successfully", await _mapper.CreateMap<GetUserModel, User>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetUserModel>(404, "Data not found");
        }
    }
}
