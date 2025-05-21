using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Response;

namespace ipog.Bon.Workflow.Service
{
    public class CustomerService : BaseService, ICustomerService
    {
        private readonly ICustomerRepository _customerRepository;
        public CustomerService(ICustomerRepository customerRepository, IMapping mapper) : base(mapper)
        {
            _customerRepository = customerRepository;
        }

        public async Task<ResponseModelCollection<CustomerModelCollection>> Get(PaginationModel pagination)
        {
            var (count, items) = await _customerRepository.Get(await base.Map<Pagination, PaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<CustomerModelCollection>(404, "Data not found");
            }
            CustomerModelCollection collection = await base.Map<CustomerModelCollection, List<Customer>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<CustomerModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseModelCollection<CustomerModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _customerRepository.Get(await base.Map<FilterPagination, FilterPaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<CustomerModelCollection>(404, "Data not found");
            }
            CustomerModelCollection collection = await base.Map<CustomerModelCollection, List<Customer>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<CustomerModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseByModel<GetCustomerModel>> Find(Guid uid)
        {
            if (await _customerRepository.Find(uid) is Customer item)
            {
                return UtilityResponse.SuccessResponseByModel<GetCustomerModel>(200, "Get successfully", await base.Map<GetCustomerModel, Customer>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetCustomerModel>(404, "Data not found");
        }

        public async Task<ResponseModel<GetCustomerModel>> Add(CustomerModel model)
        {
            if (await _customerRepository.Add(await base.Map<Customer, CustomerModel>(model)) is Customer item)
            {
                return UtilityResponse.SuccessResponse<GetCustomerModel>(200, "Insert successfully", await base.Map<GetCustomerModel, Customer>(item));
            }
            return UtilityResponse.ErrorResponse<GetCustomerModel>(404, "Insert failed");
        }

        public async Task<ResponseModel<GetCustomerModel>> Update(CustomerModel model)
        {
            if (await _customerRepository.Update(await base.Map<Customer, CustomerModel>(model)) is Customer item)
            {
                return UtilityResponse.SuccessResponse<GetCustomerModel>(200, "Update successfully", await base.Map<GetCustomerModel, Customer>(item));
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
                return UtilityResponse.SuccessResponseByModel<GetCustomerModel>(200, "Active status updated successfully", await base.Map<GetCustomerModel, Customer>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetCustomerModel>(404, "Data not found");
        }
        public async Task<ResponseModel> EmailValidation(Guid? uid, string email)
        {
            if (await _customerRepository.EmailValidation(uid, email) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Email already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }

        public async Task<ResponseModel> MobileValidation(Guid? uid, string mobile)
        {
            if (await _customerRepository.MobileValidation(uid, mobile) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Mobile already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }

    }
}
