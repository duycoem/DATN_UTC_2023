using Microsoft.AspNetCore.Mvc;
using QuizIT.Common.Models;
using QuizIT.Service.IServices;
using QuizIT.Service.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace QuizIT.Web.Areas.Admin.Controllers
{
    public class UserAdminController : BaseAdminController
    {
        private const int MODAL_ACTION_CREATE = 1;
        private const int MODAL_ACTION_UPDATE = 2;
        private readonly IRoleService roleService;
        private readonly IUserService userService;

        public UserAdminController(IRoleService roleService, IUserService userService)
        {
            this.roleService = roleService;
            this.userService = userService;
        }

        [Route("/admin/nguoi-dung")]
        public IActionResult Index(FilterUser filterUser)
        {
            ViewBag.ActivePage = "user";
            //Lấy danh sách role
            var roleServiceResult = roleService.GetAll();
            //Gọi service bị lỗi
            if (roleServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            ViewBag.RoleLst = roleServiceResult.Result;
            ViewBag.Filter = filterUser;
            return View();
        }
    }
}
