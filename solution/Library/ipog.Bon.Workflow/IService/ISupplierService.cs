using ipog.Bon.Model;
using ipog.Bon.Model.Tables;

namespace ipog.Bon.Workflow.IService
{
    public interface ISupplierService : IGenericService<SupplierModelCollection, GetSupplierModel, SupplierModel>
    {
        Task<ResponseModel> EmailValidation(Guid? uid, string email);
        Task<ResponseModel> MobileValidation(Guid? uid, string mobile);
    }
}
