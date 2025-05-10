using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Service;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class HSNCodeController : BaseController<HSNCodeController>
    {
        private readonly IHSNCodeService _hsnCodeService;
        public HSNCodeController(IHSNCodeService hsnCodeService, ILogger<HSNCodeController> logger) : base(logger)
        {
            _hsnCodeService = hsnCodeService;
        }

        [HttpPost("Filter")]
        public async Task<IActionResult> GetFilter(FilterPaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<HSNCodeModelCollection> response = await _hsnCodeService.Get(pagination);
            return Ok(response);
        }

        [HttpPost("All")]
        public async Task<IActionResult> GetAll(PaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<HSNCodeModelCollection> response = await _hsnCodeService.Get(pagination);
            return Ok(response);
        }

        [HttpGet]
        public async Task<IActionResult> GetById(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetHSNCodeModel> response = await _hsnCodeService.Find(id);
            return Ok(response);
        }

        [HttpGet("Name")]
        public async Task<IActionResult> NameValidation(Guid? uid, string name,long categoryId)
        {
            if (string.IsNullOrEmpty(name))
            {
                return BadRequest("Kindly pass the name");
            }
            ResponseModel response = await _hsnCodeService.NameValidation(uid, name,categoryId);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(HSNCodeModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModel<GetHSNCodeModel> response = await _hsnCodeService.Add(model);
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(HSNCodeModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            if (model.UId == null || model.UId == Guid.Empty)
            {
                return BadRequest("Invalid uid");
            }
            ResponseModel<GetHSNCodeModel> response = await _hsnCodeService.Update(model!);
            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseModel response = await _hsnCodeService.Delete(id);
            return Ok(response);
        }

        [HttpPatch]
        public async Task<IActionResult> UpdateIsActive(Guid id, bool isActive)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetHSNCodeModel> response = await _hsnCodeService.IsActive(id, isActive);
            return Ok(response);
        }
   
    }
}
