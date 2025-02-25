namespace ipog.Bon.Entity.Users
{
    public class User
    {
        public Guid UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public Guid RoleId { get; set; }
    }
    public class GetUser : User
    {
        public string? RoleName { get; set; }
        public long ActionBy { get; set; }
        public DateTime ActionDate { get; set; }
        public bool IsActive { get; set; }
    }

    public class UserCollection : List<User>
    {
        public string RoleName { get; set; } = string.Empty;
        public bool IsActive { get; set; }
    }
}
