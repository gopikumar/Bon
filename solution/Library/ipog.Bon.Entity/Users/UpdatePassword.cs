namespace ipog.Bon.Entity.Users
{
    public class UpdatePassword
    {
        public string UserName { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string NewPassword { get; set; } = string.Empty;
    }
}
