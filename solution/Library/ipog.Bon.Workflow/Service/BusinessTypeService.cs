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
    public class BusinessTypeService : IBusinessTypeService
    {
        private readonly IBusinessTypeRepository _businessTypeRepository;
        private readonly IMapping _mapper;
        public BusinessTypeService(IBusinessTypeRepository businessTypeRepository, IMapping mapper)
        {
            _businessTypeRepository = businessTypeRepository;
            _mapper = mapper;
        }
      
        public async Task<ResponseModelCollection<BusinessTypeModelCollection>> Get(PaginationModel pagination)
        {
            var (count, items) = await _businessTypeRepository.Get(await _mapper.CreateMap<Pagination, PaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<BusinessTypeModelCollection>(404, "Data not found");
            }
            BusinessTypeModelCollection collection = await _mapper.CreateMap<BusinessTypeModelCollection, List<BusinessType>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<BusinessTypeModelCollection>(200, "Get successfully", count, collection);
        }
       
        public async Task<ResponseModelCollection<BusinessTypeModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _businessTypeRepository.Get(await _mapper.CreateMap<FilterPagination, FilterPaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<BusinessTypeModelCollection>(404, "Data not found");
            }
            BusinessTypeModelCollection collection = await _mapper.CreateMap<BusinessTypeModelCollection, List<BusinessType>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<BusinessTypeModelCollection>(200, "Get successfully", count, collection);
        }
     
        public async Task<ResponseByModel<GetBusinessTypeModel>> Find(Guid uid)
        {
            if (await _businessTypeRepository.Find(uid) is BusinessType item)
            {
                return UtilityResponse.SuccessResponseByModel<GetBusinessTypeModel>(200, "Get successfully", await _mapper.CreateMap<GetBusinessTypeModel, BusinessType>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetBusinessTypeModel>(404, "Data not found");
        }
      
        public async Task<ResponseModel<GetBusinessTypeModel>> Add(BusinessTypeModel model)
        {
            if (await _businessTypeRepository.Add(await _mapper.CreateMap<BusinessType, BusinessTypeModel>(model)) is BusinessType item)
            {
                return UtilityResponse.SuccessResponse<GetBusinessTypeModel>(200, "Insert successfully", await _mapper.CreateMap<GetBusinessTypeModel, BusinessType>(item));
            }
            return UtilityResponse.ErrorResponse<GetBusinessTypeModel>(404, "Insert failed");
        }
       
        public async Task<ResponseModel<GetBusinessTypeModel>> Update(BusinessTypeModel model)
        {
            if (await _businessTypeRepository.Update(await _mapper.CreateMap<BusinessType, BusinessTypeModel>(model)) is BusinessType item)
            {
                return UtilityResponse.SuccessResponse<GetBusinessTypeModel>(200, "Update successfully", await _mapper.CreateMap<GetBusinessTypeModel, BusinessType>(item));
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
                return UtilityResponse.SuccessResponseByModel<GetBusinessTypeModel>(200, "Active status updated successfully", await _mapper.CreateMap<GetBusinessTypeModel, BusinessType>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetBusinessTypeModel>(404, "Data not found");
        }

    }
}
