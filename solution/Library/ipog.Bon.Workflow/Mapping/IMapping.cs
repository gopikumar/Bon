namespace ipog.Bon.Workflow.Mapping
{
    public interface IMapping
    {
        Task<T> CreateMap<T, U>(U entity);
    }
}
