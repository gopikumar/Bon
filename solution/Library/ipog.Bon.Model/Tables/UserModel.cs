namespace ipog.Bon.Model.Tables
{
    public class UserModel
    {
        public Guid? UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public long RoleId { get; set; }
        public bool IsLogin { get; set; }
        public long ActionBy { get; set; }
        public bool IsActive { get; set; }
    }
    public class GetUserModel : UserModel
    {
        public long Id { get; set; }
        public string? RoleName { get; set; }
        public DateTime ActionDate { get; set; }
    }

    public class UserModelCollection : List<GetUserModel>
    {
    }
}
