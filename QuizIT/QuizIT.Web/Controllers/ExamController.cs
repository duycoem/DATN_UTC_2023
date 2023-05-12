using QuizIT.Web.Filter;
using Microsoft.AspNetCore.Mvc;

namespace QuizIT.Web.Controllers
{

    public class ExamController : Controller
    {
        [Route("/bo-de")]
        [AuthorizationFilter]
        public IActionResult Index()
        {
            return View();
        }
    }
}