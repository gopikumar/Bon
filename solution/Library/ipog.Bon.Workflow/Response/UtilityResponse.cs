using ipog.Bon.Model;
using static System.Runtime.InteropServices.JavaScript.JSType;

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
                Record = data
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
        public static ResponseByModel<T> SuccessResponseByModel<T>(int code, string message, T data)
        {
            return new ResponseByModel<T>()
            {
                Code = code,
                Success = true,
                Message = message,
                Record = data
            };
        }
        public static ResponseByModel<T> ErrorResponseByModel<T>(int code, string message)
        {
            return new ResponseByModel<T>()
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
                Message = message,
                Record = new ResultModel<T>()
                {
                    Count = 0
                }
            };
        }
        public static ResponseModel SuccessResponse(int code, string message)
        {
            return new ResponseModel()
            {
                Code = code,
                Success = true,
                Message = message
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
    }
}
