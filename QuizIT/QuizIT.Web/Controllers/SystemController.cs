using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace QuizIT.Web.Controllers
{
    public class SystemController : Controller
    {
        [Route("/page-error-404")]
        public IActionResult Error()
        {
            return View();
        }
    }
}
