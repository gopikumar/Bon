namespace ipog.Bon.Entity.Tables
{
    public class Category
    {
        public long Id { get; set; }
        public Guid? UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Notes { get; set; } = string.Empty;
        public long ActionBy { get; set; }
        public DateTime ActionDate { get; set; }
        public bool IsActive { get; set; }
    }
}
