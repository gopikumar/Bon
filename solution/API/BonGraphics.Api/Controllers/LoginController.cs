using ipog.Bon.Model;
using ipog.Bon.Model.Users;
using ipog.Bon.Workflow.IService;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class LoginController : BaseController<LoginController>
    {
        private readonly IUserService _userService;
        public LoginController(IUserService userService, ILogger<LoginController> logger) : base(logger)
        {
            _userService = userService;
        }

        [HttpPost]
        public async Task<IActionResult> Validation(LoginModel request)
        {
            if (request == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseByModel<GetUserModel> response = await _userService.Validation(request!);
            return Ok(response);
        }

        [HttpPost("UpdatePassword")]
        public async Task<IActionResult> UpdatePassword(UpdatePasswordModel request)
        {
            if (request == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseByModel<GetUserModel> response = await _userService.UpdatePassword(request!);
            return Ok(response);
        }
    }
}
