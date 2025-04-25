namespace ipog.Bon.Model.Users
{
    public class UpdatePasswordModel
    {
        public string UserName { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string NewPassword { get; set; } = string.Empty;
    }
}
