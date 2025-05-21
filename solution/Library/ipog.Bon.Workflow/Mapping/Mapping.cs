using AutoMapper;

namespace ipog.Bon.Workflow.Mapping
{
    public class Mapping : IMapping
    {
        #region Declaration
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public Mapping(IMapper mapper)
        {
            _mapper = mapper;
        }
        #endregion

        #region Events
        private  Task<TSource> Map<TSource, TDestination>(TDestination entity)
        {
            return Task.FromResult(_mapper.Map<TSource>(entity));
        }
        public async Task<TSource> CreateMap<TSource, TDestination>(TDestination entity)
        {
            return await Map<TSource, TDestination>(entity);
        }
        #endregion
    }
}
