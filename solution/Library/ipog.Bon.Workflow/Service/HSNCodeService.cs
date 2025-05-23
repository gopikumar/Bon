﻿using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Model;
using ipog.Bon.Model.Tables;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;
using ipog.Bon.Workflow.Response;

namespace ipog.Bon.Workflow.Service
{
    public class HSNCodeService : BaseService, IHSNCodeService
    {
        private readonly IHSNCodeRepository _hsnCodeRepository;
        public HSNCodeService(IHSNCodeRepository hsnCodeRepository, IMapping mapper) : base(mapper)
        {
            _hsnCodeRepository = hsnCodeRepository;
        }

        public async Task<ResponseModelCollection<HSNCodeModelCollection>> Get(PaginationModel pagination)
        {
            var (count, items) = await _hsnCodeRepository.Get(await base.Map<Pagination, PaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<HSNCodeModelCollection>(404, "Data not found");
            }
            HSNCodeModelCollection collection = await base.Map<HSNCodeModelCollection, List<HSNCode>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<HSNCodeModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseModelCollection<HSNCodeModelCollection>> Get(FilterPaginationModel pagination)
        {
            var (count, items) = await _hsnCodeRepository.Get(await base.Map<FilterPagination, FilterPaginationModel>(pagination));
            if (count == 0 || items == null || !items.Any())
            {
                return UtilityResponse.ErrorResponseCollection<HSNCodeModelCollection>(404, "Data not found");
            }
            HSNCodeModelCollection collection = await base.Map<HSNCodeModelCollection, List<HSNCode>>(items.ToList());
            return UtilityResponse.SuccessResponseCollection<HSNCodeModelCollection>(200, "Get successfully", count, collection);
        }

        public async Task<ResponseByModel<GetHSNCodeModel>> Find(Guid uid)
        {
            if (await _hsnCodeRepository.Find(uid) is HSNCode item)
            {
                return UtilityResponse.SuccessResponseByModel<GetHSNCodeModel>(200, "Get successfully", await base.Map<GetHSNCodeModel, HSNCode>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetHSNCodeModel>(404, "Data not found");
        }

        public async Task<ResponseModel<GetHSNCodeModel>> Add(HSNCodeModel model)
        {
            if (await _hsnCodeRepository.Add(await base.Map<HSNCode, HSNCodeModel>(model)) is HSNCode item)
            {
                return UtilityResponse.SuccessResponse<GetHSNCodeModel>(200, "Insert successfully", await base.Map<GetHSNCodeModel, HSNCode>(item));
            }
            return UtilityResponse.ErrorResponse<GetHSNCodeModel>(404, "Insert failed");
        }

        public async Task<ResponseModel<GetHSNCodeModel>> Update(HSNCodeModel model)
        {
            if (await _hsnCodeRepository.Update(await base.Map<HSNCode, HSNCodeModel>(model)) is HSNCode item)
            {
                return UtilityResponse.SuccessResponse<GetHSNCodeModel>(200, "Update successfully", await base.Map<GetHSNCodeModel, HSNCode>(item));
            }
            return UtilityResponse.ErrorResponse<GetHSNCodeModel>(404, "Update failed");
        }

        public async Task<ResponseModel> Delete(Guid uid)
        {
            int isDelete = await _hsnCodeRepository.Delete(uid);
            if (isDelete == 0)
            {
                return UtilityResponse.ErrorResponse(404, "Id not found");
            }
            return UtilityResponse.SuccessResponse(204, "Deleted successfully");
        }

        public async Task<ResponseByModel<GetHSNCodeModel>> IsActive(Guid uid, bool isActive)
        {
            if (await _hsnCodeRepository.IsActive(uid, isActive) is HSNCode item)
            {
                return UtilityResponse.SuccessResponseByModel<GetHSNCodeModel>(200, "Active status updated successfully", await base.Map<GetHSNCodeModel, HSNCode>(item));
            }
            return UtilityResponse.ErrorResponseByModel<GetHSNCodeModel>(404, "Data not found");
        }

        public async Task<ResponseModel> NameValidation(Guid? uid, string name, long categoryId)
        {
            if (await _hsnCodeRepository.NameValidation(uid, name, categoryId) is string response)
            {
                return UtilityResponse.SuccessResponse(204, "Name already exists");
            }
            return UtilityResponse.SuccessResponse(204, "");
        }

    }
}
