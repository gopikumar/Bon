using ipog.Bon.Entity;
using ipog.Bon.Model;

namespace ipog.Bon.Workflow.IService
{
    public interface IGenericService<T,U> where T : class
    {
        Task<ResponseModelCollection<T>> Get(PaginationModel pagination);
        Task<ResponseModelCollection<T>> Get(FilterPaginationModel pagination);
        Task<ResponseByIdModel<U>> Find(Guid uid);
        Task<ResponseModel<U>> Add(U model);
        Task<ResponseModel<U>> Update(U model);
        Task<ResponseByIdModel<U>> Delete(Guid uid);
        Task<ResponseByIdModel<U>> IsActive(Guid uid, bool isActive);
    }
}
