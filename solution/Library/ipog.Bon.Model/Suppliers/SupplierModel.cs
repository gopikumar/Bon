namespace ipog.Bon.Model.Suppliers
{
    public class SupplierModel
    {
        public Guid? UId { get; set; }
        public Int64 TypeId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string GST { get; set; } = string.Empty;
        public string Landline { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Contact { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public Int64 ActionBy { get; set; }
        public bool IsActive { get; set; }
    }
    public class GetSupplierModel : SupplierModel
    {
        public Int64 Id { get; set; }
        public string? TypeName { get; set; }
        public DateTime ActionDate { get; set; }
    }

    public class SupplierModelCollection : List<GetSupplierModel>
    {
    }
}
