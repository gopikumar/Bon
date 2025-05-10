using ipog.Bon.Entity.Tables;

namespace ipog.Bon.Repositories.IServices
{
    public interface IHSNCodeRepository : IGenericRepository<HSNCode>
    {
        Task<string?> NameValidation(Guid? uid, string name,long categoryId);
    }
}
