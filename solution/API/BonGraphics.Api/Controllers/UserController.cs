using ipog.Bon.Model;
using ipog.Bon.Repositories.IServices;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class UserController : BaseController<UserController>
    {
        private readonly IUserRepository _userRepository;
        public UserController(IUserRepository iUserRepository, ILogger<UserController> logger) : base(logger)
        {
            _userRepository=iUserRepository;
        }

        [HttpGet]
        public async Task<IEnumerable<UserModel>> GetCatigories()
        {
            var catigories = await _userRepository.Get();
            return default;
        }
    }
}
