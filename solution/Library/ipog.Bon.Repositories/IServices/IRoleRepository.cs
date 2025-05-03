using ipog.Bon.Entity.Tables;

namespace ipog.Bon.Repositories.IServices
{
    public interface IRoleRepository : IGenericRepository<Role>
    {
        Task<string?> NameValidation(Guid? uid, string name);
    }
}
