namespace ipog.Bon.Entity
{
    public class ResponseCollection<T>
    {
        public int Code { get; set; }
        public bool Success { get; set; }
        public string Message { get; set; } = "Get success";
        public Result<T>? Record { get; set; }
    }
    public class ResponseById
    {
        public int Code { get; set; }
        public bool Success { get; set; }
        public string Message { get; set; } = "Get success";
    }
    public class Result<T>
    {
        public int Count { get; set; }
        public T? Data { get; set; }
    }
}
