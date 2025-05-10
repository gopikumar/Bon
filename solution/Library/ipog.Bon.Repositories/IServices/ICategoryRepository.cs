using ipog.Bon.Entity.Tables;

namespace ipog.Bon.Repositories.IServices
{
    public interface ICategoryRepository : IGenericRepository<Category>
    {
        Task<string?> NameValidation(Guid? uid, string name);
    }
}
