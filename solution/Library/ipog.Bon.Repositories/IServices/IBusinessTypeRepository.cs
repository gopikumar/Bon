using ipog.Bon.Entity.Tables;

namespace ipog.Bon.Repositories.IServices
{
    public interface IBusinessTypeRepository : IGenericRepository<BusinessType>
    {
        Task<string?> NameValidation(Guid? uid, string name);
    }
}
