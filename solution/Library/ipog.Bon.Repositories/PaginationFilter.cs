using Dapper;
using ipog.Bon.Entity;

namespace ipog.Bon.Repositories
{
    public static class PaginationFilter
    {
        public static DynamicParameters GetPaginationParameters(FilterPagination pagination)
        {
            string filters = string.Empty;
            if (pagination.FilterColumns != null && pagination.FilterColumns.Count > 0)
            {
                foreach (var item in pagination.FilterColumns)
                {
                    filters += $"{item.Key} = '{item.Value}' AND ";
                }
                if (filters.Length > 0)
                {
                    filters = filters.Substring(0, filters.Length - 4); // Remove last "AND "
                }
            }
            return new(
                new
                {
                    action = "Filter",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                    pageNumber = pagination.PageNumber,
                    pageSize = pagination.PageSize,
                    filterColumns = filters
                });
        }
    }
}
