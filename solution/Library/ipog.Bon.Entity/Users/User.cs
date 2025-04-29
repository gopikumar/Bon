namespace ipog.Bon.Entity.Users
{
    public class User
    {
        public Int64 Id { get; set; }
        public Guid? UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public Int64 RoleId { get; set; }
        public string? RoleName { get; set; }
        public Int64 ActionBy { get; set; }
        public DateTime ActionDate { get; set; }
        public bool IsActive { get; set; }
    }
}
