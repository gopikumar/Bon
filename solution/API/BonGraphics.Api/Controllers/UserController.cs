using ipog.Bon.Workflow.IService;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class UserController : BaseController<UserController>
    {
        private readonly IUserService _userService;
        public UserController(IUserService userService, ILogger<UserController> logger) : base(logger)
        {
            _userService = userService;
        }

        [HttpPost("Filter")]
        public async Task<IActionResult> GetFilter()
        {
            var result = await _userService.Get();
            return Ok(result);
        }

        [HttpGet("All")]
        public async Task<IActionResult> GetAll()
        {
            var result = await _userService.Get();
            return Ok(result);
        }

        [HttpGet("Id")]
        public async Task<IActionResult> GetById(Guid id)
        {
            //var result = await _userRepository.Find(id);
            return Ok();
        }
    }
}
