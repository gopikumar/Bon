using ipog.Bon.Model;
using ipog.Bon.Model.Tables;

namespace ipog.Bon.Workflow.IService
{
    public interface IUserService : IGenericService<UserModelCollection, GetUserModel, UserModel>
    {
        Task<ResponseByModel<GetUserModel>> Validation(LoginModel request);
        Task<ResponseByModel<GetUserModel>> UpdatePassword(UpdatePasswordModel request);
        Task<ResponseModel> EmailValidation(Guid? uid, string email);
        Task<ResponseModel> MobileValidation(Guid? uid, string mobile);
    }
}
