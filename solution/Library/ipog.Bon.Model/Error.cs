namespace ipog.Bon.Model
{
    public class Error
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public string Source { get; set; } = string.Empty;
    }
}
