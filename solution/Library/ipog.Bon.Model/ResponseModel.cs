namespace ipog.Bon.Model
{
    public class ResponseModelCollection
    {
        public int Code { get; set; } = 200;
        public bool Success { get; set; } = true;
        public string Message { get; set; } = "Get success";
        public ResultModel? Record { get; set; }
    }
    public class ResponseByIdModel
    {
        public int Code { get; set; } = 200;
        public bool Success { get; set; } = true;
        public string Message { get; set; } = "Get success";
    }
    public class ResultModel
    {
        public int Count { get; set; } = 0;
        public dynamic? Data { get; set; }
    }
}
