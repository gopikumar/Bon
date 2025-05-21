using ipog.Bon.Workflow.Mapping;

namespace ipog.Bon.Workflow.Service
{
    public abstract class BaseService : IDisposable
    {
        protected readonly IMapping _mapper;

        protected BaseService(IMapping mapper)
        {
            _mapper = mapper;
        }
        protected async Task<TSource> Map<TSource, TDestination>(TDestination entity)
        {
            return await _mapper.CreateMap<TSource, TDestination>(entity);
        }
        #region Dispose
        public void Dispose()
        {
        }
        #endregion
    }
}
