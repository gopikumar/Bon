using ipog.Bon.Model;
using ipog.Bon.Model.Users;
using ipog.Bon.Workflow.IService;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class LoginController : BaseController<LoginController>
    {
        private readonly ILoginService _loginService;
        public LoginController(ILoginService loginService, ILogger<LoginController> logger) : base(logger)
        {
            _loginService = loginService;
        }

        [HttpPost]
        public async Task<IActionResult> Validation(LoginModel request)
        {
            if (request == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseByModel<GetUserModel> response = await _loginService.Validation(request!);
            //if (response == null)
            //{
            //    return NotFound("credentials not found.");
            //}
            return Ok(response);
        }

        [HttpPost("UpdatePassword")]
        public async Task<IActionResult> UpdatePassword(UpdatePasswordModel request)
        {
            if (request == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseByModel<GetUserModel> response = await _loginService.UpdatePassword(request!);
            return Ok(response);
        }
    }
}
