using ipog.Bon.Model;
using ipog.Bon.Model.Users;
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
        public async Task<IActionResult> GetFilter(FilterPaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request.");
            }
            ResponseModelCollection<UserModelCollection> response = await _userService.Get(pagination);
            if (response == null)
            {
                return NotFound("Not found");
            }
            return Ok(response);
        }

        [HttpPost("All")]
        public async Task<IActionResult> GetAll(PaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request.");
            }
            ResponseModelCollection<UserModelCollection> response = await _userService.Get(pagination);
            if (response == null)
            {
                return NotFound("Not found");
            }
            return Ok(response);
        }

        [HttpGet]
        public async Task<IActionResult> GetById(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid ID.");
            }
            ResponseByIdModel<UserModel> response = await _userService.Find(id);
            if (response == null)
            {
                return NotFound("User not found.");
            }
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(UserModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request.");
            }
            ResponseModel<UserModel> response = await _userService.Add(model);
            if (response == null)
            {
                return NotFound("Insert failed.");
            }
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(UserModel model)
        {
            if (model == null || model?.UId == Guid.Empty)
            {
                return BadRequest("Invalid request.");
            }
            ResponseModel<UserModel> response = await _userService.Update(model);
            if (response == null)
            {
                return NotFound("Update failed.");
            }
            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid ID.");
            }
            ResponseByIdModel<UserModel> response = await _userService.Delete(id);
            if (response == null)
            {
                return NotFound("Delete failed.");
            }
            return Ok(response);
        }

        [HttpPatch]
        public async Task<IActionResult> UpdateIsActive(Guid id, bool isActive)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid ID.");
            }
            ResponseByIdModel<UserModel> response = await _userService.IsActive(id, isActive);
            if (response == null)
            {
                return NotFound("Update failed.");
            }
            return Ok(response);
        }
    }
}
