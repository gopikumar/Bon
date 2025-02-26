using ipog.Bon.Model;

namespace ipog.Bon.Workflow.IService
{
    public interface IUserService
    {
        Task<ResponseModelCollection> Get(PaginationModel pagination);
        Task<ResponseModelCollection> Get(FilterPaginationModel pagination);
    }
}
