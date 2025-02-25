namespace ipog.Bon.Entity
{
    public class ResponseCollection
    {
        public int Code { get; set; }
        public bool Success { get; set; }
        public string Message { get; set; } = "Get success";
        public Result? Record { get; set; }
    }
    public class ResponseById
    {
        public int Code { get; set; }
        public bool Success { get; set; }
        public string Message { get; set; } = "Get success";
    }
    public class Result
    {
        public int Count { get; set; }
        public dynamic? Data { get; set; }
    }
}
