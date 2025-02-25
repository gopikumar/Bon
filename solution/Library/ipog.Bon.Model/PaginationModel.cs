    using System.ComponentModel;

namespace ipog.Bon.Model
{
    public class PaginationModel
    {
        [DefaultValue(1)]
        public int PageNumber { get; set; }
        [DefaultValue(10)]
        public int PageSize { get; set; }
        [DefaultValue("id")]
        public string? SortBy { get; set; }
        [DefaultValue("asc")]
        public string? OrderBy { get; set; }
        public IDictionary<string, string>? FilterColumns { get; set; }
    }
}
