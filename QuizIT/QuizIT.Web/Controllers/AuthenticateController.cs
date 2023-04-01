using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using QuizIT.Common.Models;
using QuizIT.Service.IServices;
using QuizIT.Service.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace QuizIT.Web.Controllers
{
    public class AuthenticateController : Controller
    {
        private readonly IAuthenticateService authenticateService;

        public AuthenticateController(IAuthenticateService authenticateService)
        {
            this.authenticateService = authenticateService;
        }

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

        #region CÁC SỰ KIỆN
        [HttpPost]
        public async Task<IActionResult> EventLogin(User user)
        {
            var resService = authenticateService.Login(user.UserName, user.Password);
            if (resService.ResponseCode == ResponseCode.SUCCESS)
            {
                user = resService.Result.FirstOrDefault();
                await SetCookieAuthenticate(user);
            }
            return Json(resService);
        }

        [HttpPost]
        public async Task<IActionResult> EventRegistry(User user)
        {
            var res = await authenticateService.Registry(user);
            return Json(res);
        }

        private async Task SetCookieAuthenticate(User user)
        {
            var claims = new List<Claim>
            {
                new Claim (ClaimTypes.Sid, Guid.NewGuid().ToString()),
                new Claim (ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim (ClaimTypes.Name, user.FullName),
                new Claim (ClaimTypes.Role, user.RoleId.ToString()),
                new Claim ("Avatar", user.Avatar)
            };

            var claimsIdentity = new ClaimsIdentity(claims, "Login");
            await HttpContext.SignInAsync(
                CookieAuthenticationDefaults.AuthenticationScheme,
                new ClaimsPrincipal(claimsIdentity),
                new AuthenticationProperties
                {
                    ExpiresUtc = DateTime.UtcNow.AddDays(2),
                    IsPersistent = true
                }
             );
        }
        #endregion
    }
}