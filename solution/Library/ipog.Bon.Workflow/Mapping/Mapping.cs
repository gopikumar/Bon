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
        private  Task<T> Map<T, U>(U entity)
        {
            return Task.FromResult(_mapper.Map<T>(entity));
        }
        public async Task<T> CreateMap<T, U>(U entity)
        {
            return await Map<T, U>(entity);
        }
        #endregion
    }
}
