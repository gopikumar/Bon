using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Service;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class SupplierController : BaseController<SupplierController>
    {
        private readonly ISupplierService _supplierService;
        public SupplierController(ISupplierService supplierService, ILogger<SupplierController> logger) : base(logger)
        {
            _supplierService = supplierService;
        }

        [HttpPost("Filter")]
        public async Task<IActionResult> GetFilter(FilterPaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<SupplierModelCollection> response = await _supplierService.Get(pagination);
            return Ok(response);
        }

        [HttpPost("All")]
        public async Task<IActionResult> GetAll(PaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<SupplierModelCollection> response = await _supplierService.Get(pagination);
            return Ok(response);
        }

        [HttpGet]
        public async Task<IActionResult> GetById(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetSupplierModel> response = await _supplierService.Find(id);
            return Ok(response);
        }

        [HttpGet("Email")]
        public async Task<IActionResult> EmailValidation(Guid? uid, string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                return BadRequest("Kindly pass the email");
            }
            ResponseModel response = await _supplierService.EmailValidation(uid, email);
            return Ok(response);
        }

        [HttpGet("Mobile")]
        public async Task<IActionResult> MobileValidation(Guid? uid, string mobile)
        {
            if (string.IsNullOrEmpty(mobile))
            {
                return BadRequest("Kindly pass the mobile");
            }
            ResponseModel response = await _supplierService.MobileValidation(uid, mobile);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(SupplierModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModel<GetSupplierModel> response = await _supplierService.Add(model);
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(SupplierModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            if (model.UId == null || model.UId == Guid.Empty)
            {
                return BadRequest("Invalid uid");
            }
            ResponseModel<GetSupplierModel> response = await _supplierService.Update(model!);
            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseModel response = await _supplierService.Delete(id);
            return Ok(response);
        }

        [HttpPatch]
        public async Task<IActionResult> UpdateIsActive(Guid id, bool isActive)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetSupplierModel> response = await _supplierService.IsActive(id, isActive);
            return Ok(response);
        }
   
    }
}
