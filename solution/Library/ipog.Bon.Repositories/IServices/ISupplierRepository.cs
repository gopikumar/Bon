using ipog.Bon.Entity.Tables;

namespace ipog.Bon.Repositories.IServices
{
    public interface ISupplierRepository : IGenericRepository<Supplier>
    {
        Task<string?> EmailValidation(Guid? uid, string email);
        Task<string?> MobileValidation(Guid? uid, string mobile);
    }
}
