using ipog.Bon.Entity.Tables;

namespace ipog.Bon.Repositories.IServices
{
    public interface ICustomerRepository : IGenericRepository<Customer>
    {
        Task<string?> EmailValidation(Guid? uid, string email);
        Task<string?> MobileValidation(Guid? uid, string mobile);
    }
}
