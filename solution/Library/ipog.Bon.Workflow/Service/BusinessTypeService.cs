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
    public class BusinessTypeService : BaseService, IBusinessTypeService
    {
        private readonly IBusinessTypeRepository _businessTypeRepository;
        public BusinessTypeService(IBusinessTypeRepository businessTypeRepository, IMapping mapper) : base(mapper)
        {
            _businessTypeRepository = businessTypeRepository;
        }

        public async Task<ResponseModelCollection<BusinessTypeModelCollection>> Get(PaginationModel pagination)
        {
            var (count, items) = await _businessTypeRepository.Get(await base.Map<Pagination, PaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<BusinessTypeModelCollection>(404, "Data not found");
            }
            BusinessTypeModelCollection collection = await base.Map<BusinessTypeModelCollection, List<BusinessType>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<BusinessTypeModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseModelCollection<BusinessTypeModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _businessTypeRepository.Get(await base.Map<FilterPagination, FilterPaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<BusinessTypeModelCollection>(404, "Data not found");
            }
            BusinessTypeModelCollection collection = await base.Map<BusinessTypeModelCollection, List<BusinessType>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<BusinessTypeModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseByModel<GetBusinessTypeModel>> Find(Guid uid)
        {
            if (await _businessTypeRepository.Find(uid) is BusinessType item)
            {
                return UtilityResponse.SuccessResponseByModel<GetBusinessTypeModel>(200, "Get successfully", await base.Map<GetBusinessTypeModel, BusinessType>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetBusinessTypeModel>(404, "Data not found");
        }

        public async Task<ResponseModel<GetBusinessTypeModel>> Add(BusinessTypeModel model)
        {
            if (await _businessTypeRepository.Add(await base.Map<BusinessType, BusinessTypeModel>(model)) is BusinessType item)
            {
                return UtilityResponse.SuccessResponse<GetBusinessTypeModel>(200, "Insert successfully", await base.Map<GetBusinessTypeModel, BusinessType>(item));
            }
            return UtilityResponse.ErrorResponse<GetBusinessTypeModel>(404, "Insert failed");
        }

        public async Task<ResponseModel<GetBusinessTypeModel>> Update(BusinessTypeModel model)
        {
            if (await _businessTypeRepository.Update(await base.Map<BusinessType, BusinessTypeModel>(model)) is BusinessType item)
            {
                return UtilityResponse.SuccessResponse<GetBusinessTypeModel>(200, "Update successfully", await base.Map<GetBusinessTypeModel, BusinessType>(item));
            }
            return UtilityResponse.ErrorResponse<GetBusinessTypeModel>(404, "Update failed");
        }

        public async Task<ResponseModel> Delete(Guid uid)
        {
            int isDelete = await _businessTypeRepository.Delete(uid);
            if (isDelete == 0)
            {
                return UtilityResponse.ErrorResponse(404, "Id not found");
            }
            return UtilityResponse.SuccessResponse(204, "Deleted successfully");
        }

        public async Task<ResponseByModel<GetBusinessTypeModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _businessTypeRepository.IsActive(uid, isActive) is BusinessType item)
            {
                return UtilityResponse.SuccessResponseByModel<GetBusinessTypeModel>(200, "Active status updated successfully", await base.Map<GetBusinessTypeModel, BusinessType>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetBusinessTypeModel>(404, "Data not found");
        }

        public async Task<ResponseModel> NameValidation(Guid? uid, string name)
        {
            if (await _businessTypeRepository.NameValidation(uid, name) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Name already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }
    }
}
