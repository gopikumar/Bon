using ipog.Bon.Model;
using ipog.Bon.Model.Tables;

namespace ipog.Bon.Workflow.IService
{
    public interface IBusinessTypeService : IGenericService<BusinessTypeModelCollection, GetBusinessTypeModel, BusinessTypeModel>
    {
        Task<ResponseModel> NameValidation(Guid? uid, string name);
    }
}
