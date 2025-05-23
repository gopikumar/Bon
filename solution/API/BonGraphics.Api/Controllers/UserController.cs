﻿using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Workflow.IService;
using Microsoft.AspNetCore.Mvc;
using System.Reflection;

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
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<UserModelCollection> response = await _userService.Get(pagination);
            return Ok(response);
        }

        [HttpPost("All")]
        public async Task<IActionResult> GetAll(PaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<UserModelCollection> response = await _userService.Get(pagination);
            return Ok(response);
        }

        [HttpGet]
        public async Task<IActionResult> GetById(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetUserModel> response = await _userService.Find(id);
            return Ok(response);
        }

        [HttpGet("Email")]
        public async Task<IActionResult> EmailValidation(Guid? uid, string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                return BadRequest("Kindly pass the email");
            }
            ResponseModel response = await _userService.EmailValidation(uid, email);
            return Ok(response);
        }

        [HttpGet("Mobile")]
        public async Task<IActionResult> MobileValidation(Guid? uid, string mobile)
        {
            if (string.IsNullOrEmpty(mobile))
            {
                return BadRequest("Kindly pass the mobile");
            }
            ResponseModel response = await _userService.MobileValidation(uid, mobile);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(UserModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModel<GetUserModel> response = await _userService.Add(model);
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(UserModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            if (model.UId == null || model.UId == Guid.Empty)
            {
                return BadRequest("Invalid uid");
            }
            ResponseModel<GetUserModel> response = await _userService.Update(model!);
            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseModel response = await _userService.Delete(id);
            return Ok(response);
        }

        [HttpPatch]
        public async Task<IActionResult> UpdateIsActive(Guid id, bool isActive)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetUserModel> response = await _userService.IsActive(id, isActive);
            return Ok(response);
        }
   
    }
}
