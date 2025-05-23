﻿using ipog.Bon.Entity;

namespace ipog.Bon.Repositories.IServices
{
    public interface IGenericRepository<T> where T : class
    {
        Task<(int, IEnumerable<T>)> Get(Pagination pagination);
        Task<(int, IEnumerable<T>)> Get(FilterPagination pagination);
        Task<T?> Find(Guid uid);
        Task<T?> Add(T model);
        Task<T?> Update(T model);
        Task<int> Delete(Guid uid);
        Task<T?> IsActive(Guid uid, bool isActive);
    }
}
