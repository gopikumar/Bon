using ipog.Bon.Model;
using ipog.Bon.Model.Tables;

namespace ipog.Bon.Workflow.IService
{
    public interface IRoleService : IGenericService<RoleModelCollection,  GetRoleModel, RoleModel>
    {
        Task<ResponseModel> NameValidation(Guid? uid, string name);
    }
}
