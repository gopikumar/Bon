using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Service;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class CustomerController : BaseController<CustomerController>
    {
        private readonly ICustomerService _customerService;
        public CustomerController(ICustomerService customerService, ILogger<CustomerController> logger) : base(logger)
        {
            _customerService = customerService;
        }

        [HttpPost("Filter")]
        public async Task<IActionResult> GetFilter(FilterPaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<CustomerModelCollection> response = await _customerService.Get(pagination);
            return Ok(response);
        }

        [HttpPost("All")]
        public async Task<IActionResult> GetAll(PaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<CustomerModelCollection> response = await _customerService.Get(pagination);
            return Ok(response);
        }

        [HttpGet]
        public async Task<IActionResult> GetById(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetCustomerModel> response = await _customerService.Find(id);
            return Ok(response);
        }

        [HttpGet("Email")]
        public async Task<IActionResult> EmailValidation(Guid? uid, string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                return BadRequest("Kindly pass the email");
            }
            ResponseModel response = await _customerService.EmailValidation(uid, email);
            return Ok(response);
        }

        [HttpGet("Mobile")]
        public async Task<IActionResult> MobileValidation(Guid? uid, string mobile)
        {
            if (string.IsNullOrEmpty(mobile))
            {
                return BadRequest("Kindly pass the mobile");
            }
            ResponseModel response = await _customerService.MobileValidation(uid, mobile);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(CustomerModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModel<GetCustomerModel> response = await _customerService.Add(model);
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(CustomerModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            if (model.UId == null || model.UId == Guid.Empty)
            {
                return BadRequest("Invalid uid");
            }
            ResponseModel<GetCustomerModel> response = await _customerService.Update(model!);
            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseModel response = await _customerService.Delete(id);
            return Ok(response);
        }

        [HttpPatch]
        public async Task<IActionResult> UpdateIsActive(Guid id, bool isActive)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetCustomerModel> response = await _customerService.IsActive(id, isActive);
            return Ok(response);
        }
   
    }
}
