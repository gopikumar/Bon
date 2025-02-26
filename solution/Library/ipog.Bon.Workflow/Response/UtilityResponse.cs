using ipog.Bon.Model;

namespace ipog.Bon.Workflow.Response
{
    public static class UtilityResponse
    {
        public static ResponseModel SuccessResponse<T>(int code, string message, T data)
        {
            return new ResponseModel()
            {
                Code = code,
                Success = true,
                Message = message,
                Data = data
            };
        }
        public static ResponseModel ErrorResponse(int code, string message)
        {
            return new ResponseModel()
            {
                Code = code,
                Success = false,
                Message = message
            };
        }
        public static ResponseByIdModel SuccessResponseById<T>(int code, string message, T data)
        {
            return new ResponseByIdModel()
            {
                Code = code,
                Success = true,
                Message = message,
                Data = data
            };
        }
        public static ResponseByIdModel ErrorResponseById(int code, string message)
        {
            return new ResponseByIdModel()
            {
                Code = code,
                Success = false,
                Message = message
            };
        }
        public static ResponseModelCollection SuccessResponseCollection<T>(int code, string message, int count, T data)
        {
            return new ResponseModelCollection()
            {
                Code = code,
                Success = true,
                Message = message,
                Record = new ResultModel()
                {
                    Count = count,
                    Data = data
                }
            };
        }
        public static ResponseModelCollection ErrorResponseCollection(int code, string message)
        {
            return new ResponseModelCollection()
            {
                Code = code,
                Success = false,
                Message = message
            };
        }
    }
}
