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
        public async Task<IActionResult> GetCatigories()
        {
            var result = await _userRepository.Get();
            return Ok(result);
        }

        [HttpGet("Id")]
        public async Task<IActionResult> GetCatigories(Guid id)
        {
            var result = await _userRepository.Find(id);
            return Ok(result);
        }
    }
}
