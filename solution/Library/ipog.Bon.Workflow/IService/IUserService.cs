using ipog.Bon.Entity;
using ipog.Bon.Model;
using ipog.Bon.Model.Users;

namespace ipog.Bon.Workflow.IService
{
    public interface IUserService
    {
        Task<ResponseModelCollection> Get();
        Task<ResponseModelCollection> Get(Pagination pagination);
    }
}
