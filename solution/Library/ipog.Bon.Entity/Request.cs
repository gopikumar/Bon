namespace ipog.Bon.Entity
{
    public class Request
    {
        public dynamic? Data { get; set; }
    }
    public class RequestById
    {
        public Guid Id { get; set; }
    }
    public class GetRequest
    {
    }
    public class FilterRequest : Pagination
    {
    }
}
