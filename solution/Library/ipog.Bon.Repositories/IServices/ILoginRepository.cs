using ipog.Bon.Entity.Users;

namespace ipog.Bon.Repositories.IServices
{
    public interface ILoginRepository 
    {
        Task<User> Validation(Login request);
    }
}
