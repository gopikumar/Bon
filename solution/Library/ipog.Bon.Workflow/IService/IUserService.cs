using ipog.Bon.Model;
using ipog.Bon.Model.Users;

namespace ipog.Bon.Workflow.IService
{
    public interface IUserService
    {
        Task<ResponseModelCollection> Get(PaginationModel pagination);
        Task<ResponseModelCollection> Get(FilterPaginationModel pagination);
        Task<ResponseByIdModel> Find(Guid uid);
        Task<ResponseModel> Add(UserModel model);
        Task<ResponseModel> Update(UserModel model);
        Task<ResponseByIdModel> Delete(Guid uid);
        Task<ResponseByIdModel> IsActive(Guid uid, bool isActive);
    }
}
