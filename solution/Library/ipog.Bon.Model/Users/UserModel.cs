namespace ipog.Bon.Model.Users
{
    public class UserModel
    {
        public Guid UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public Guid RoleId { get; set; }
        public long ActionBy { get; set; }
        public bool IsActive { get; set; }
    }
    public class GetUserModel : UserModel
    {
        public string? RoleName { get; set; }
        public DateTime ActionDate { get; set; }
    }

    public class UserModelCollection : List<GetUserModel>
    {
    }
}
