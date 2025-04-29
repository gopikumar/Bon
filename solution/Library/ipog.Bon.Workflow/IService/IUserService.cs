using ipog.Bon.Model;
using ipog.Bon.Model.Users;

namespace ipog.Bon.Workflow.IService
{
    public interface IUserService : IGenericService<UserModelCollection, GetUserModel, UserModel>
    {
        Task<ResponseModel> EmailValidation(string email);
        Task<ResponseModel> MobileValidation(string mobile);
    }
}
