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
    public class ExamAdminController : BaseAdminController
    {
        private readonly ICategoryService categoryService;
        private readonly IQuestionService questionService;

        public ExamAdminController(ICategoryService categoryService, IQuestionService questionService)
        {
            this.categoryService = categoryService;
            this.questionService = questionService;
        }

        [Route("/admin/bo-de")]
        public IActionResult Index()
        {
            ViewBag.ActivePage = "exam";
            return View();
        }

        [Route("/admin/bo-de/tao")]
        public IActionResult Create()
        {
            ViewBag.ActivePage = "exam";
            //Lấy ra tất cả thể loại để filter
            var categoryServiceResult = categoryService.GetPage(new FilterCategory
            {
                PageSize = int.MaxValue
            });
            //Gọi service bị lỗi
            if (categoryServiceResult.ResponseCode != ResponseCode.SUCCESS )
            {
                return Redirect("~/internal-server-error");
            }
            ViewBag.CategoryLst = categoryServiceResult.Result;
            return View();
        }

        [HttpPost]
        public IActionResult TableQuestion(FilterQuestion filter)
        {
            //Lấy toàn bộ câu hỏi
            filter.PageSize = int.MaxValue;
            //Lấy ra tất cả thể loại để filter
            var questionServiceResult = questionService.GetPage(filter);
            //Gọi service bị lỗi thì throw exception để ajax xử lý
            if (questionServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                throw new Exception();
            }
            return PartialView(questionServiceResult.Result);
        }
    }
}
