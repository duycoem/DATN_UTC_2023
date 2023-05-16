using Microsoft.AspNetCore.Mvc;
using QuizIT.Common.Helpers;
using QuizIT.Common.Models;
using QuizIT.Service.Entities;
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
        private readonly IExamService examService;

        public ExamAdminController(ICategoryService categoryService, IQuestionService questionService, IExamService examService)
        {
            this.categoryService = categoryService;
            this.questionService = questionService;
            this.examService = examService;
        }

        [Route("/admin/bo-de")]
        public IActionResult Index(FilterExam filter)
        {
            ViewBag.ActivePage = "exam";
            //Lấy ra tất cả thể loại để filter
            var categoryServiceResult = categoryService.GetPage(new FilterCategory
            {
                PageSize = int.MaxValue
            });
            //Lấy danh sách bộ đề
            var examServiceResult = examService.GetPage(filter);
            //Gọi service bị lỗi
            if (categoryServiceResult.ResponseCode != ResponseCode.SUCCESS ||
                examServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            ViewBag.CategoryLst = categoryServiceResult.Result;
            ViewBag.PaginationModel = PaginationHelper.GetPaginationModel(filter.PageNumber, filter.PageSize, examServiceResult.TotalRecord);
            ViewBag.Filter = filter;
            return View(examServiceResult.Result);
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
            if (categoryServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            ViewBag.CategoryLst = categoryServiceResult.Result;
            return View();
        }

        [Route("/admin/bo-de/chi-tiet/{examId}")]
        public IActionResult Detail(int examId)
        {
            ViewBag.ActivePage = "exam";
            //Lấy ra tất cả thể loại để filter
            var categoryServiceResult = categoryService.GetPage(new FilterCategory
            {
                PageSize = int.MaxValue
            });
            //Lấy thông tin exam
            var examServiceResult = examService.GetById(examId);
            //Sai id
            if (examServiceResult.ResponseCode == ResponseCode.NOT_FOUND)
            {
                return Redirect("~/error");
            }
            //Gọi service bị lỗi
            if (categoryServiceResult.ResponseCode != ResponseCode.SUCCESS ||
                examServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            ViewBag.CategoryLst = categoryServiceResult.Result;
            return View(examServiceResult.Result.FirstOrDefault());
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

        [HttpPost]
        public async Task<IActionResult> EventCreate(Exam exam, List<int> questionIdLst)
        {
            var serviceResult = await examService.Create(exam, questionIdLst);
            return Json(serviceResult);
        }

        [HttpPost]
        public async Task<IActionResult> EventUpdate(Exam exam, List<int> questionIdLst)
        {
            var serviceResult = await examService.Update(exam, questionIdLst);
            return Json(serviceResult);
        }

        [HttpPost]
        public async Task<IActionResult> EventDelete(Exam exam)
        {
            var serviceResult = await examService.Delete(exam);
            return Json(serviceResult);
        }
    }
}
