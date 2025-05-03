namespace ipog.Bon.Entity.Tables
{
    public class User
    {
        public long Id { get; set; }
        public Guid? UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public long RoleId { get; set; }
        public string? RoleName { get; set; }
        public bool IsLogin { get; set; }
        public long ActionBy { get; set; }
        public DateTime ActionDate { get; set; }
        public bool IsActive { get; set; }
    }
}
