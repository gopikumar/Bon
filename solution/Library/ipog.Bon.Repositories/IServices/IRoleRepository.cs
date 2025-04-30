using ipog.Bon.Entity.Roles;

namespace ipog.Bon.Repositories.IServices
{
    public interface IRoleRepository : IGenericRepository<Role>
    {
        Task<string?> NameValidation(Guid? uid, string name);
    }
}
