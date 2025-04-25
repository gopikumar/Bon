using ipog.Bon.Entity;
using ipog.Bon.Model;

namespace ipog.Bon.Workflow.IService
{
    public interface IGenericService<T,U,V> where T : class
    {
        Task<ResponseModelCollection<T>> Get(PaginationModel pagination);
        Task<ResponseModelCollection<T>> Get(FilterPaginationModel pagination);
        Task<ResponseByModel<U>> Find(Guid uid);
        Task<ResponseModel<U>> Add(V model);
        Task<ResponseModel<U>> Update(V model);
        Task<ResponseModel> Delete(Guid uid);
        Task<ResponseByModel<U>> IsActive(Guid uid, bool isActive);
    }
}
