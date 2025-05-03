
using AutoMapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Model;
using ipog.Bon.Model.Tables;

namespace ipog.Bon.Workflow.Mapping
{
    public class MapperProfile : Profile
    {
        public MapperProfile()
        {
            CreateMap<PaginationModel, Pagination>();
            CreateMap<FilterPaginationModel, FilterPagination>();

            CreateMap<User, UserModel>().ReverseMap();
            CreateMap<User, GetUserModel>();
            CreateMap<User, UserModelCollection>();
            CreateMap<LoginModel, Login>();
            CreateMap<UpdatePasswordModel, UpdatePassword>();

            CreateMap<Role, RoleModel>().ReverseMap();
            CreateMap<Role, GetRoleModel>();
            CreateMap<Role, RoleModelCollection>();

            CreateMap<Customer, CustomerModel>().ReverseMap();
            CreateMap<Customer, GetCustomerModel>();
            CreateMap<Customer, CustomerModelCollection>();

            CreateMap<Supplier, SupplierModel>().ReverseMap();
            CreateMap<Supplier, GetSupplierModel>();
            CreateMap<Supplier, SupplierModelCollection>();

            CreateMap<HSNCode, HSNCodeModel>().ReverseMap();
            CreateMap<HSNCode, GetHSNCodeModel>();
            CreateMap<HSNCode, HSNCodeModelCollection>();

            CreateMap<Category, CategoryModel>().ReverseMap();
            CreateMap<Category, GetCategoryModel>();
            CreateMap<Category, CategoryModelCollection>();

            CreateMap<BusinessType, BusinessTypeModel>().ReverseMap();
            CreateMap<BusinessType, GetBusinessTypeModel>();
            CreateMap<BusinessType, BusinessTypeModelCollection>();
        }
    }
}
