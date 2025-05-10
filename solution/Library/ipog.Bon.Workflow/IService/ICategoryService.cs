using ipog.Bon.Model;
using ipog.Bon.Model.Tables;

namespace ipog.Bon.Workflow.IService
{
    public interface ICategoryService : IGenericService<CategoryModelCollection, GetCategoryModel, CategoryModel>
    {
        Task<ResponseModel> NameValidation(Guid? uid, string name);
    }
}
