using ipog.Bon.Model.Users;
using System.ComponentModel;

namespace ipog.Bon.Model.Roles
{
    public class RoleModel
    {
        [DefaultValue("00000000-0000-0000-0000-000000000000")]
        public Guid UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Control { get; set; } = string.Empty;
        public string Notes { get; set; } = string.Empty;
        public Int64 ActionBy { get; set; }
        public DateTime ActionDate { get; set; }
        public bool IsActive { get; set; }
    }
    public class GetRoleModel : RoleModel
    {
        public Int64 Id { get; set; }
        public new DateTime ActionDate { get; set; }
    }

    public class RoleModelCollection : List<GetRoleModel>
    {
    }
}
