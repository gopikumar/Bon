﻿using System.ComponentModel;

namespace ipog.Bon.Model.Users
{
    public class UserModel
    {
        [DefaultValue("00000000-0000-0000-0000-000000000000")]
        public Guid UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public Int64 RoleId { get; set; }
        public Int64 ActionBy { get; set; }
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
