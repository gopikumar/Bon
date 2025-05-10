using ipog.Bon.Model;
using ipog.Bon.Model.Tables;

namespace ipog.Bon.Workflow.IService
{
    public interface IHSNCodeService : IGenericService<HSNCodeModelCollection, GetHSNCodeModel, HSNCodeModel>
    {
        Task<ResponseModel> NameValidation(Guid? uid, string name,long categoryId);
    }
}
