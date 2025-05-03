namespace ipog.Bon.Model.Tables
{
    public class CategoryModel
    {
        public Guid? UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Notes { get; set; } = string.Empty;
        public long ActionBy { get; set; }
        public bool IsActive { get; set; }
    }
    public class GetCategoryModel : CategoryModel
    {
        public long Id { get; set; }
        public DateTime ActionDate { get; set; }
    }

    public class CategoryModelCollection : List<GetCategoryModel>
    {
    }
}
