namespace ipog.Bon.Entity
{
    public class Pagination
    {
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public string SortBy { get; set; }
        public string OrderBy { get; set; }
        public IDictionary<string, string> FilterColumns { get; set; }
    }
}
