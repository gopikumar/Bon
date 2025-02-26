namespace ipog.Bon.Entity
{
    public class Pagination
    {
        public string SortBy { get; set; } = string.Empty;
        public string OrderBy { get; set; } = string.Empty;
    }
    public class FilterPagination : Pagination
    {
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public IDictionary<string, string>? FilterColumns { get; set; }
    }
}
