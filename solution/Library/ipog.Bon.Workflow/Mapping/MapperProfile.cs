using AutoMapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Users;
using ipog.Bon.Model;
using ipog.Bon.Model.Users;

namespace ipog.Bon.Workflow.Mapping
{
    public class MapperProfile : Profile
    {
        public MapperProfile()
        {
            //CreateMap<RequestModel, Request>();
            //CreateMap<RequestByIdModel, RequestById>();
            //CreateMap<GetRequestModel, GetRequest>();
            //CreateMap<FilterRequestModel, FilterRequest>();
            CreateMap<PaginationModel, Pagination>();
            CreateMap<FilterPaginationModel, FilterPagination>();

            //CreateMap<ResponseCollection, ResponseModelCollection>();
            //CreateMap<Result, ResultModel>();
            //CreateMap<ResponseById, ResponseByIdModel>();

            CreateMap<User, UserModel>().ReverseMap();
            CreateMap<User, GetUserModel>();
            CreateMap<User, UserModelCollection>();
        }
    }
}
