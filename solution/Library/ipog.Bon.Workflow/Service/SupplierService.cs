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
    public class SupplierService : BaseService, ISupplierService
    {
        private readonly ISupplierRepository _supplierRepository;
        public SupplierService(ISupplierRepository supplierRepository, IMapping mapper) : base(mapper)
        {
            _supplierRepository = supplierRepository;
        }

        public async Task<ResponseModelCollection<SupplierModelCollection>> Get(PaginationModel pagination)
        {
            var (count, items) = await _supplierRepository.Get(await base.Map<Pagination, PaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<SupplierModelCollection>(404, "Data not found");
            }
            SupplierModelCollection collection = await base.Map<SupplierModelCollection, List<Supplier>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<SupplierModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseModelCollection<SupplierModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _supplierRepository.Get(await base.Map<FilterPagination, FilterPaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<SupplierModelCollection>(404, "Data not found");
            }
            SupplierModelCollection collection = await base.Map<SupplierModelCollection, List<Supplier>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<SupplierModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseByModel<GetSupplierModel>> Find(Guid uid)
        {
            if (await _supplierRepository.Find(uid) is Supplier item)
            {
                return UtilityResponse.SuccessResponseByModel<GetSupplierModel>(200, "Get successfully", await base.Map<GetSupplierModel, Supplier>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetSupplierModel>(404, "Data not found");
        }

        public async Task<ResponseModel<GetSupplierModel>> Add(SupplierModel model)
        {
            if (await _supplierRepository.Add(await base.Map<Supplier, SupplierModel>(model)) is Supplier item)
            {
                return UtilityResponse.SuccessResponse<GetSupplierModel>(200, "Insert successfully", await base.Map<GetSupplierModel, Supplier>(item));
            }
            return UtilityResponse.ErrorResponse<GetSupplierModel>(404, "Insert failed");
        }

        public async Task<ResponseModel<GetSupplierModel>> Update(SupplierModel model)
        {
            if (await _supplierRepository.Update(await base.Map<Supplier, SupplierModel>(model)) is Supplier item)
            {
                return UtilityResponse.SuccessResponse<GetSupplierModel>(200, "Update successfully", await base.Map<GetSupplierModel, Supplier>(item));
            }
            return UtilityResponse.ErrorResponse<GetSupplierModel>(404, "Update failed");
        }

        public async Task<ResponseModel> Delete(Guid uid)
        {
            int isDelete = await _supplierRepository.Delete(uid);
            if (isDelete == 0)
            {
                return UtilityResponse.ErrorResponse(404, "Id not found");
            }
            return UtilityResponse.SuccessResponse(204, "Deleted successfully");
        }

        public async Task<ResponseByModel<GetSupplierModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _supplierRepository.IsActive(uid, isActive) is Supplier item)
            {
                return UtilityResponse.SuccessResponseByModel<GetSupplierModel>(200, "Active status updated successfully", await base.Map<GetSupplierModel, Supplier>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetSupplierModel>(404, "Data not found");
        }
        public async Task<ResponseModel> EmailValidation(Guid? uid, string email)
        {
            if (await _supplierRepository.EmailValidation(uid, email) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Email already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }

        public async Task<ResponseModel> MobileValidation(Guid? uid, string mobile)
        {
            if (await _supplierRepository.MobileValidation(uid, mobile) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Mobile already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }

    }
}
