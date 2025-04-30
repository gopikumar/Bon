using ipog.Bon.Entity.Users;

namespace ipog.Bon.Repositories.IServices
{
    public interface IUserRepository : IGenericRepository<User>
    {
        Task<User?> Validation(Login request);
        Task<User?> UpdatePassword(UpdatePassword request);
        Task<string?> EmailValidation(Guid? uid, string email);
        Task<string?> MobileValidation(Guid? uid, string mobile);
    }
}
