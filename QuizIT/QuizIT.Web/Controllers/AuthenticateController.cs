using Microsoft.AspNetCore.Mvc;

namespace QuizIT.Web.Controllers
{
    public class AuthenticateController : Controller
    {
        [Route("/")]
        public IActionResult Login()
        {
            return View();
        }

        [Route("/registry")]
        public IActionResult Registry()
        {
            return View();
        }
    }
}