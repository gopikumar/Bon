using ipog.Bon.Model.Users;

namespace ipog.Bon.Workflow.IService
{
    public interface IUserService
    {
        Task<UserModelCollection> Get();
    }
}
