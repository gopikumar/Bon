using ipog.Bon.Model.Customers;

namespace ipog.Bon.Workflow.IService
{
    public interface ICustomerService : IGenericService<CustomerModelCollection, GetCustomerModel, CustomerModel>
    {
    }
}
