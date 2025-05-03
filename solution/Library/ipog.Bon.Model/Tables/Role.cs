namespace ipog.Bon.Model.Tables
{
    public class RoleModel
    {
        public Guid? UId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Control { get; set; } = string.Empty;
        public string Notes { get; set; } = string.Empty;
        public long ActionBy { get; set; }
        public bool IsActive { get; set; }
    }
    public class GetRoleModel : RoleModel
    {
        public long Id { get; set; }
        public DateTime ActionDate { get; set; }
    }

    public class RoleModelCollection : List<GetRoleModel>
    {
    }
}
