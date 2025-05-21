namespace ipog.Bon.Workflow.Mapping
{
    public interface IMapping
    {
        Task<TSource> CreateMap<TSource, TDestination>(TDestination entity);
    }
}
