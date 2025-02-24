using Microsoft.AspNetCore.Mvc;

namespace ipog.Bon.Api.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class BaseController<T> : ControllerBase
    {
        protected readonly ILogger<T> _logger;

        public BaseController(ILogger<T> logger)
        {
            _logger = logger;
        }
    }
}
