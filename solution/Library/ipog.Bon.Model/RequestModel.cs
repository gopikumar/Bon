namespace ipog.Bon.Model
{
    public class RequestModel
    {
        public dynamic? Data { get; set; }
    }
    public class RequestByIdModel
    {
        public Guid Id { get; set; }
    }
    public class RequestModelCollection : PaginationModel
    {
    }
}
