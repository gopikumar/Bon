using ipog.Bon.Model;

namespace ipog.Bon.Workflow.Response
{
    public static class UtilityResponse
    {
        public static ResponseModel<T> SuccessResponse<T>(int code, string message, T data)
        {
            return new ResponseModel<T>()
            {
                Code = code,
                Success = true,
                Message = message,
                Data = data
            };
        }
        public static ResponseModel<T> ErrorResponse<T>(int code, string message)
        {
            return new ResponseModel<T>()
            {
                Code = code,
                Success = false,
                Message = message
            };
        }
        public static ResponseByIdModel<T> SuccessResponseById<T>(int code, string message, T data)
        {
            return new ResponseByIdModel<T>()
            {
                Code = code,
                Success = true,
                Message = message,
                Data = data
            };
        }
        public static ResponseByIdModel<T> ErrorResponseById<T>(int code, string message)
        {
            return new ResponseByIdModel<T>()
            {
                Code = code,
                Success = false,
                Message = message
            };
        }
        public static ResponseModelCollection<T> SuccessResponseCollection<T>(int code, string message, int count, T data)
        {
            return new ResponseModelCollection<T>()
            {
                Code = code,
                Success = true,
                Message = message,
                Record = new ResultModel<T>()
                {
                    Count = count,
                    Data = data
                }
            };
        }
        public static ResponseModelCollection<T> ErrorResponseCollection<T>(int code, string message)
        {
            return new ResponseModelCollection<T>()
            {
                Code = code,
                Success = false,
                Message = message
            };
        }
    }
}
