using Microsoft.AspNetCore.Mvc;
using QuizIT.Common.Helpers;
using QuizIT.Common.Models;
using QuizIT.Service.IServices;
using QuizIT.Service.Models;
using QuizIT.Web.Filter;
using System.Linq;

namespace QuizIT.Web.Controllers
{
    public class ExamController : BaseController
    {
        private readonly ICategoryService categoryService;
        private readonly IQuestionService questionService;
        private readonly IExamService examService;

        public ExamController(ICategoryService categoryService, IQuestionService questionService, IExamService examService)
        {
            this.categoryService = categoryService;
            this.questionService = questionService;
            this.examService = examService;
        }

        [Route("/bo-de")]
        [AuthorizationFilter]
        public IActionResult Index(FilterExam filter)
        {
            ViewBag.ActivePage = "exam";
            //Chỉ hiện những bộ đề đang hoạt động
            filter.IsActive = 1;
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

        [Route("/bo-de/chi-tiet/{examId}")]
        public IActionResult Detail(int examId)
        {
            ViewBag.ActivePage = "exam";
            //Lấy thông tin exam
            var examServiceResult = examService.GetById(examId);
            //Sai id
            if (examServiceResult.ResponseCode == ResponseCode.NOT_FOUND)
            {
                return Redirect("~/error");
            }
            //Gọi service bị lỗi
            if (examServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            return View(examServiceResult.Result.FirstOrDefault());
        }

        [Route("/bo-de/lam-de/{examId}")]
        public IActionResult DoExam(int examId)
        {
            ViewBag.ActivePage = "exam";
            //Lấy thông tin exam
            var examServiceResult = examService.GetById(examId);
            //Sai id
            if (examServiceResult.ResponseCode == ResponseCode.NOT_FOUND)
            {
                return Redirect("~/error");
            }
            //Gọi service bị lỗi
            if (examServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            return View(examServiceResult.Result.FirstOrDefault());
        }
    }
}