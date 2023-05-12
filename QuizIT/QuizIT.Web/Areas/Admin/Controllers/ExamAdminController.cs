using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace QuizIT.Web.Areas.Admin.Controllers
{
    public class ExamAdminController : BaseAdminController
    {
        [Route("/admin/bo-de")]
        public IActionResult Index()
        {
            ViewBag.ActivePage = "exam";
            return View();
        }
    }
}
