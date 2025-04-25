using ipog.Bon.Entity;
using ipog.Bon.Model;

namespace ipog.Bon.Workflow.IService
{
    public interface IGenericService<T,U,V> where T : class
    {
        Task<ResponseModelCollection<T>> Get(PaginationModel pagination);
        Task<ResponseModelCollection<T>> Get(FilterPaginationModel pagination);
        Task<ResponseByModel<V>> Find(Guid uid);
        Task<ResponseModel<V>> Add(U model);
        Task<ResponseModel<V>> Update(U model);
        Task<ResponseModel> Delete(Guid uid);
        Task<ResponseByModel<V>> IsActive(Guid uid, bool isActive);
    }
}
