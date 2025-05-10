using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Repositories.Services;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Response;

namespace ipog.Bon.Workflow.Service
{
    public class CategoryService : ICategoryService
    {
        private readonly ICategoryRepository _categoryRepository;
        private readonly IMapping _mapper;
        public CategoryService(ICategoryRepository categoryRepository, IMapping mapper)
        {
            _categoryRepository = categoryRepository;
            _mapper = mapper;
        }

        public async Task<ResponseModelCollection<CategoryModelCollection>> Get(PaginationModel pagination)
        {
            var (count, items) = await _categoryRepository.Get(await _mapper.CreateMap<Pagination, PaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<CategoryModelCollection>(404, "Data not found");
            }
            CategoryModelCollection collection = await _mapper.CreateMap<CategoryModelCollection, List<Category>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<CategoryModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseModelCollection<CategoryModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _categoryRepository.Get(await _mapper.CreateMap<FilterPagination, FilterPaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<CategoryModelCollection>(404, "Data not found");
            }
            CategoryModelCollection collection = await _mapper.CreateMap<CategoryModelCollection, List<Category>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<CategoryModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseByModel<GetCategoryModel>> Find(Guid uid)
        {
            if (await _categoryRepository.Find(uid) is Category item)
            {
                return UtilityResponse.SuccessResponseByModel<GetCategoryModel>(200, "Get successfully", await _mapper.CreateMap<GetCategoryModel, Category>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetCategoryModel>(404, "Data not found");
        }

        public async Task<ResponseModel<GetCategoryModel>> Add(CategoryModel model)
        {
            if (await _categoryRepository.Add(await _mapper.CreateMap<Category, CategoryModel>(model)) is Category item)
            {
                return UtilityResponse.SuccessResponse<GetCategoryModel>(200, "Insert successfully", await _mapper.CreateMap<GetCategoryModel, Category>(item));
            }
            return UtilityResponse.ErrorResponse<GetCategoryModel>(404, "Insert failed");
        }

        public async Task<ResponseModel<GetCategoryModel>> Update(CategoryModel model)
        {
            if (await _categoryRepository.Update(await _mapper.CreateMap<Category, CategoryModel>(model)) is Category item)
            {
                return UtilityResponse.SuccessResponse<GetCategoryModel>(200, "Update successfully", await _mapper.CreateMap<GetCategoryModel, Category>(item));
            }
            return UtilityResponse.ErrorResponse<GetCategoryModel>(404, "Update failed");
        }

        public async Task<ResponseModel> Delete(Guid uid)
        {
            int isDelete = await _categoryRepository.Delete(uid);
            if (isDelete == 0)
            {
                return UtilityResponse.ErrorResponse(404, "Id not found");
            }
            return UtilityResponse.SuccessResponse(204, "Deleted successfully");
        }

        public async Task<ResponseByModel<GetCategoryModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _categoryRepository.IsActive(uid, isActive) is Category item)
            {
                return UtilityResponse.SuccessResponseByModel<GetCategoryModel>(200, "Active status updated successfully", await _mapper.CreateMap<GetCategoryModel, Category>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetCategoryModel>(404, "Data not found");
        }

        public async Task<ResponseModel> NameValidation(Guid? uid, string name)
        {
            if (await _categoryRepository.NameValidation(uid, name) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Name already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }

    }
}
