using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Workflow.IService;
using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    public class CategoryController : BaseController<CategoryController>
    {
        private readonly ICategoryService _categoryService;
        public CategoryController(ICategoryService categoryService, ILogger<CategoryController> logger) : base(logger)
        {
            _categoryService = categoryService;
        }

        [HttpPost("Filter")]
        public async Task<IActionResult> GetFilter(FilterPaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<CategoryModelCollection> response = await _categoryService.Get(pagination);
            return Ok(response);
        }

        [HttpPost("All")]
        public async Task<IActionResult> GetAll(PaginationModel pagination)
        {
            if (pagination == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModelCollection<CategoryModelCollection> response = await _categoryService.Get(pagination);
            return Ok(response);
        }

        [HttpGet]
        public async Task<IActionResult> GetById(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetCategoryModel> response = await _categoryService.Find(id);
            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Insert(CategoryModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            ResponseModel<GetCategoryModel> response = await _categoryService.Add(model);
            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> Update(CategoryModel model)
        {
            if (model == null)
            {
                return BadRequest("Invalid request");
            }
            if (model.UId == null || model.UId == Guid.Empty)
            {
                return BadRequest("Invalid uid");
            }
            ResponseModel<GetCategoryModel> response = await _categoryService.Update(model!);
            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(Guid id)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseModel response = await _categoryService.Delete(id);
            return Ok(response);
        }

        [HttpPatch]
        public async Task<IActionResult> UpdateIsActive(Guid id, bool isActive)
        {
            if (id == Guid.Empty)
            {
                return BadRequest("Invalid id");
            }
            ResponseByModel<GetCategoryModel> response = await _categoryService.IsActive(id, isActive);
            return Ok(response);
        }
   
    }
}
