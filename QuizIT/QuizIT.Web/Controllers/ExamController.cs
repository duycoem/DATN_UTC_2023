using QuizIT.Web.Filter;
using Microsoft.AspNetCore.Mvc;

namespace QuizIT.Web.Controllers
{

    public class ExamController : BaseController
    {
        [Route("/bo-de")]
        [AuthorizationFilter]
        public IActionResult Index()
        {
            ViewBag.ActivePage = "exam";
            return View();
        }
    }
}