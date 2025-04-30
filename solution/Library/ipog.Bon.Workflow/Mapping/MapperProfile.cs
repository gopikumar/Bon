
using AutoMapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Customers;
using ipog.Bon.Entity.Roles;
using ipog.Bon.Entity.Suppliers;
using ipog.Bon.Entity.Users;
using ipog.Bon.Model;
using ipog.Bon.Model.Customers;
using ipog.Bon.Model.Roles;
using ipog.Bon.Model.Suppliers;
using ipog.Bon.Model.Users;

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
        }
    }
}
