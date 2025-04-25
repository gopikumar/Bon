using ipog.Bon.Model;
using ipog.Bon.Model.Users;

namespace ipog.Bon.Workflow.IService
{
    public interface ILoginService
    {
        Task<ResponseByModel<GetUserModel>> Validation(LoginModel request);
        Task<ResponseByModel<GetUserModel>> UpdatePassword(UpdatePasswordModel request);
    }
}
