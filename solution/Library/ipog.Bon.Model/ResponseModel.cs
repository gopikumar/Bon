namespace ipog.Bon.Model
{
    public class ResponseModel<T>
    {
        public int Code { get; set; } = 200;
        public bool Success { get; set; } = true;
        public string Message { get; set; } = "Get success";
        public T? Data { get; set; }
    }
    public class ResponseByIdModel<T>
    {
        public int Code { get; set; } = 200;
        public bool Success { get; set; } = true;
        public string Message { get; set; } = "Get success";
        public T? Data { get; set; }
    }
    public class ResponseModelCollection<T>
    {
        public int Code { get; set; } = 200;
        public bool Success { get; set; } = true;
        public string Message { get; set; } = "Get success";
        public ResultModel<T>? Record { get; set; }
    }
    public class ResultModel<T>
    {
        public int Count { get; set; } = 0;
        public T? Data { get; set; }
    }
}
