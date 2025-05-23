﻿using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Service;
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
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<RoleModelCollection> response = await _roleService.Get(pagination);
            return Ok(response);
        }

        [HttpPost("All")]
        public async Task<IActionResult> GetAll(PaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<RoleModelCollection> response = await _roleService.Get(pagination);
            return Ok(response);
        }

        [HttpGet]
        public async Task<IActionResult> GetById(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetRoleModel> response = await _roleService.Find(id);
            return Ok(response);
        }

        [HttpGet("Name")]
        public async Task<IActionResult> NameValidation(Guid? uid, string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                return BadRequest("Kindly pass the name");
            }
            ResponseModel response = await _roleService.NameValidation(uid, name);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(RoleModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModel<GetRoleModel> response = await _roleService.Add(model);
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(RoleModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            if (model.UId == null || model.UId == Guid.Empty)
            {
                return BadRequest("Invalid uid");
            }
            ResponseModel<GetRoleModel> response = await _roleService.Update(model!);
            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseModel response = await _roleService.Delete(id);
            return Ok(response);
        }

        [HttpPatch]
        public async Task<IActionResult> UpdateIsActive(Guid id, bool isActive)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetRoleModel> response = await _roleService.IsActive(id, isActive);
            return Ok(response);
        }
    }
}
