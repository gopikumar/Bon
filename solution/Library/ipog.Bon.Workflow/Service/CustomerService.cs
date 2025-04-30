using ipog.Bon.Entity;
using ipog.Bon.Entity.Customers;
using ipog.Bon.Model;
using ipog.Bon.Model.Customers;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Response;

namespace ipog.Bon.Workflow.Service
{
    public class CustomerService : ICustomerService
    {
        private readonly ICustomerRepository _customerRepository;
        private readonly IMapping _mapper;
        public CustomerService(ICustomerRepository customerRepository, IMapping mapper)
        {
            _customerRepository = customerRepository;
            _mapper = mapper;
        }
      
        public async Task<ResponseModelCollection<CustomerModelCollection>> Get(PaginationModel pagination)
        {
            var (count, items) = await _customerRepository.Get(await _mapper.CreateMap<Pagination, PaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<CustomerModelCollection>(404, "Data not found");
            }
            CustomerModelCollection collection = await _mapper.CreateMap<CustomerModelCollection, List<Customer>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<CustomerModelCollection>(200, "Get successfully", count, collection);
        }
       
        public async Task<ResponseModelCollection<CustomerModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _customerRepository.Get(await _mapper.CreateMap<FilterPagination, FilterPaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<CustomerModelCollection>(404, "Data not found");
            }
            CustomerModelCollection collection = await _mapper.CreateMap<CustomerModelCollection, List<Customer>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<CustomerModelCollection>(200, "Get successfully", count, collection);
        }
     
        public async Task<ResponseByModel<GetCustomerModel>> Find(Guid uid)
        {
            if (await _customerRepository.Find(uid) is Customer item)
            {
                return UtilityResponse.SuccessResponseByModel<GetCustomerModel>(200, "Get successfully", await _mapper.CreateMap<GetCustomerModel, Customer>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetCustomerModel>(404, "Data not found");
        }
      
        public async Task<ResponseModel<GetCustomerModel>> Add(CustomerModel model)
        {
            if (await _customerRepository.Add(await _mapper.CreateMap<Customer, CustomerModel>(model)) is Customer item)
            {
                return UtilityResponse.SuccessResponse<GetCustomerModel>(200, "Insert successfully", await _mapper.CreateMap<GetCustomerModel, Customer>(item));
            }
            return UtilityResponse.ErrorResponse<GetCustomerModel>(404, "Insert failed");
        }
       
        public async Task<ResponseModel<GetCustomerModel>> Update(CustomerModel model)
        {
            if (await _customerRepository.Update(await _mapper.CreateMap<Customer, CustomerModel>(model)) is Customer item)
            {
                return UtilityResponse.SuccessResponse<GetCustomerModel>(200, "Update successfully", await _mapper.CreateMap<GetCustomerModel, Customer>(item));
            }
            return UtilityResponse.ErrorResponse<GetCustomerModel>(404, "Update failed");
        }
       
        public async Task<ResponseModel> Delete(Guid uid)
        {
            int isDelete = await _customerRepository.Delete(uid);
            if (isDelete == 0)
            {
                return UtilityResponse.ErrorResponse(404, "Id not found");
            }
            return UtilityResponse.SuccessResponse(204, "Deleted successfully");
        }
       
        public async Task<ResponseByModel<GetCustomerModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _customerRepository.IsActive(uid, isActive) is Customer item)
            {
                return UtilityResponse.SuccessResponseByModel<GetCustomerModel>(200, "Active status updated successfully", await _mapper.CreateMap<GetCustomerModel, Customer>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetCustomerModel>(404, "Data not found");
        }

    }
}
