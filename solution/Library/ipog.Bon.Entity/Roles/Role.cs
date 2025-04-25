namespace ipog.Bon.Entity.Roles
{
    public class Role
    {
        public Int64 Id { get; set; }
        public Guid UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Control { get; set; } = string.Empty;
        public string Notes { get; set; } = string.Empty;
        public Int64 ActionBy { get; set; }
        public DateTime ActionDate { get; set; }
        public bool IsActive { get; set; }
    }
}
