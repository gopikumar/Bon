namespace ipog.Bon.Model
{
    public class RequestModel<T> 
    {
        public T? Data { get; set; }
    }
    public class RequestByIdModel
    {
        public Guid Id { get; set; }
    }
    public class RequestModelCollection : PaginationModel
    {
    }
}
