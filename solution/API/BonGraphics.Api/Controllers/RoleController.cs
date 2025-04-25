using ipog.Bon.Model;
using ipog.Bon.Model.Roles;
using ipog.Bon.Workflow.IService;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class RoleController : BaseController<RoleController>
    {
        private readonly IRoleService _roleService;
        public RoleController(IRoleService roleService, ILogger<RoleController> logger) : base(logger)
        {
            _roleService = roleService;
        }

        [HttpPost("Filter")]
        public async Task<IActionResult> GetFilter(FilterPaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request.");
            }
            ResponseModelCollection<RoleModelCollection> response = await _roleService.Get(pagination);
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
            ResponseModelCollection<RoleModelCollection> response = await _roleService.Get(pagination);
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
            ResponseByModel<GetRoleModel> response = await _roleService.Find(id);
            if (response == null)
            {
                return NotFound("Role not found.");
            }
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(RoleModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request.");
            }
            ResponseModel<GetRoleModel> response = await _roleService.Add(model);
            if (response == null)
            {
                return NotFound("Insert failed.");
            }
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(RoleModel model)
        {
            if (model == null || model.UId == Guid.Empty)
            {
                return BadRequest("Invalid request.");
            }
            ResponseModel<GetRoleModel> response = await _roleService.Update(model!);
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
            ResponseModel response = await _roleService.Delete(id);
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
            ResponseByModel<GetRoleModel> response = await _roleService.IsActive(id, isActive);
            if (response == null)
            {
                return NotFound("Update failed.");
            }
            return Ok(response);
        }
    }
}
