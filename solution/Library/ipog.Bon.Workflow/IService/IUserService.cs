using ipog.Bon.Model;
using ipog.Bon.Model.Users;

namespace ipog.Bon.Workflow.IService
{
    public interface IUserService : IGenericService<UserModelCollection, GetUserModel, UserModel>
    {
        Task<ResponseByModel<GetUserModel>> Validation(LoginModel request);
        Task<ResponseByModel<GetUserModel>> UpdatePassword(UpdatePasswordModel request);
        Task<ResponseModel> EmailValidation(string email);
        Task<ResponseModel> MobileValidation(string mobile);
    }
}
