using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Service;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class BusinessTypeController : BaseController<BusinessTypeController>
    {
        private readonly IBusinessTypeService _businessTypeService;
        public BusinessTypeController(IBusinessTypeService businessTypeService, ILogger<BusinessTypeController> logger) : base(logger)
        {
            _businessTypeService = businessTypeService;
        }

        [HttpPost("Filter")]
        public async Task<IActionResult> GetFilter(FilterPaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<BusinessTypeModelCollection> response = await _businessTypeService.Get(pagination);
            return Ok(response);
        }

        [HttpPost("All")]
        public async Task<IActionResult> GetAll(PaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<BusinessTypeModelCollection> response = await _businessTypeService.Get(pagination);
            return Ok(response);
        }

        [HttpGet]
        public async Task<IActionResult> GetById(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetBusinessTypeModel> response = await _businessTypeService.Find(id);
            return Ok(response);
        }

        [HttpGet("Name")]
        public async Task<IActionResult> NameValidation(Guid? uid, string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                return BadRequest("Kindly pass the name");
            }
            ResponseModel response = await _businessTypeService.NameValidation(uid, name);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(BusinessTypeModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModel<GetBusinessTypeModel> response = await _businessTypeService.Add(model);
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(BusinessTypeModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            if (model.UId == null || model.UId == Guid.Empty)
            {
                return BadRequest("Invalid uid");
            }
            ResponseModel<GetBusinessTypeModel> response = await _businessTypeService.Update(model!);
            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseModel response = await _businessTypeService.Delete(id);
            return Ok(response);
        }

        [HttpPatch]
        public async Task<IActionResult> UpdateIsActive(Guid id, bool isActive)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetBusinessTypeModel> response = await _businessTypeService.IsActive(id, isActive);
            return Ok(response);
        }
   
    }
}
