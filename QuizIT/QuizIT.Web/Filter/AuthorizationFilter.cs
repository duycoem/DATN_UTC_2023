using QuizIT.Common.Helpers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Linq;
using static QuizIT.Common.Constant;

namespace QuizIT.Web.Filter
{
    public class AuthorizationFilter : Attribute, IAuthorizationFilter
    {
        public int RoleID { get; set; } = Role.ALL;

        public void OnAuthorization(AuthorizationFilterContext filterContext)
        {
            var hasClaim = filterContext.HttpContext.User.Claims.Any();

            if (!hasClaim)
            {
                filterContext.Result = new RedirectResult("~/");
                return;
            }

            //Lấy thông tin người đang đăng nhập từ cookie của request
            HttpHelper.HttpContext.Items["CurrentUser"] = filterContext.HttpContext.User.Claims;

            //Todo check quyền
            if (RoleID != Role.ALL)
            {

            }
        }
    }
}