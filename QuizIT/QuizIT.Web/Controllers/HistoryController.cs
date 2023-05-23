using Microsoft.AspNetCore.Mvc;
using QuizIT.Common.Helpers;
using QuizIT.Common.Models;
using QuizIT.Service.IServices;
using QuizIT.Service.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace QuizIT.Web.Controllers
{
    public class HistoryController : BaseController
    {
        private readonly IExamService examService;
        private readonly IUserService userService;

        public HistoryController(IExamService examService, IUserService userService)
        {
            this.examService = examService;
            this.userService = userService;
        }

        //Danh sách lịch sử
        [Route("/lich-su")]
        public IActionResult Index(FilterHistory filter)
        {
            ViewBag.ActivePage = "history";
            //Lấy danh sách lịch sử
            var historyServiceResult = examService.GetHistoryPage(filter);
            //Lấy danh sách bộ đề và người dùng
            var examServiceResult = examService.GetPage(new FilterExam
            {
                PageSize = int.MaxValue
            });
            var userServiceResult = userService.GetPage(new FilterUser
            {
                PageSize = int.MaxValue
            });
            //Gọi service bị lỗi
            if (historyServiceResult.ResponseCode != ResponseCode.SUCCESS ||
                examServiceResult.ResponseCode != ResponseCode.SUCCESS ||
                userServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            ViewBag.PaginationModel = PaginationHelper.GetPaginationModel(filter.PageNumber, filter.PageSize, historyServiceResult.TotalRecord);
            ViewBag.Filter = filter;
            ViewBag.ExamLst = examServiceResult.Result;
            ViewBag.UserLst = userServiceResult.Result;
            return View(historyServiceResult.Result.OrderByDescending(c => c.CreatedAt).ToList());
        }

        //Chi tiet lich su
        [Route("/lich-su/chi-tiet/{historyId}")]
        public IActionResult Detail(int historyId)
        {
            ViewBag.ActivePage = "history";
            //Lấy thông tin lịch sử
            var historyServiceResult = examService.GetHistoryById(historyId);
            //Sai id
            if (historyServiceResult.ResponseCode == ResponseCode.NOT_FOUND)
            {
                return Redirect("~/error");
            }
            //Gọi service bị lỗi
            if (historyServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            return View(historyServiceResult.Result.FirstOrDefault());
        }

        //Sự kiện chấm lại điểm
        [HttpPost]
        public async Task<IActionResult> EventMarkPointAgain(int historyId, double timeDoExam)
        {
            var serviceResult = await examService.MarkPointAgain(historyId, timeDoExam);
            return Json(serviceResult);
        }
    }
}
