using ipog.Bon.Model;
using ipog.Bon.Model.Roles;

namespace ipog.Bon.Workflow.IService
{
    public interface IRoleService : IGenericService<RoleModelCollection,  GetRoleModel, RoleModel>
    {
        Task<ResponseModel> NameValidation(string name);
    }
}
