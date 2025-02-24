namespace ipog.Bon.Entity
{
    public class User
    {
        public long Id { get; set; }
        public Guid UId { get; set; }
        public string Name { get; set; }    
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
