using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace QuizIT.Web.Controllers
{
    public class AuthenticateController : Controller
    {
        [Route("/")]
        public IActionResult Login()
        {
            return View();
        }
    }
}
