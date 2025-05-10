using ipog.Bon.Model;
using ipog.Bon.Model.Tables;

namespace ipog.Bon.Workflow.IService
{
    public interface ICustomerService : IGenericService<CustomerModelCollection, GetCustomerModel, CustomerModel>
    {
        Task<ResponseModel> EmailValidation(Guid? uid, string email);
        Task<ResponseModel> MobileValidation(Guid? uid, string mobile);
    }
}
