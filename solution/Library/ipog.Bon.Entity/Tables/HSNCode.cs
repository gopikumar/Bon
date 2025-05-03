namespace ipog.Bon.Entity.Tables
{
    public class HSNCode
    {
        public long Id { get; set; }
        public Guid? UId { get; set; }
        public long CategoryId { get; set; }
        public string? CategoryName { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Notes { get; set; } = string.Empty;
        public decimal GST { get; set; } = 0;
        public decimal SGST { get; set; } = 0;
        public decimal CGST { get; set; } = 0;
        public long ActionBy { get; set; }
        public DateTime ActionDate { get; set; }
        public bool IsActive { get; set; }
    }
}
