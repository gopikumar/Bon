using ipog.Bon.Entity.Users;

namespace ipog.Bon.Repositories.IServices
{
    public interface IUserRepository : IGenericRepository<User>
    {
        Task<string> EmailValidation(string email);
        Task<string> MobileValidation(string mobile);
    }
}
