using System.ComponentModel;

namespace ipog.Bon.Model.Users
{
    public class UserModel
    {
        public Guid? UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public Int64 RoleId { get; set; }
        public bool IsActive { get; set; }
    }
    public class GetUserModel : UserModel
    {
        public Int64 ActionBy { get; set; }
        public string? RoleName { get; set; }
        public DateTime ActionDate { get; set; }
    }

    public class UserModelCollection : List<GetUserModel>
    {
    }
}
