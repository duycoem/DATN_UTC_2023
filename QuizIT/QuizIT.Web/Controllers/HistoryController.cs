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

        public HistoryController(IExamService examService)
        {
            this.examService = examService;
        }

        //Danh sách lịch sử
        [Route("/lich-su")]
        public IActionResult Index(FilterHistory filter)
        {
            ViewBag.ActivePage = "history";
            //Lấy danh sách lịch sử
            var historyServiceResult = examService.GetHistoryPage(filter);
            //Gọi service bị lỗi
            if (historyServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            ViewBag.PaginationModel = PaginationHelper.GetPaginationModel(filter.PageNumber, filter.PageSize, historyServiceResult.TotalRecord);
            ViewBag.Filter = filter;
            return View(historyServiceResult.Result);
        }

        //Lịch sử từng bài
        [Route("/bo-de/lich-su/{historyId}")]
        public IActionResult Detail(int historyId)
        {
            ViewBag.ActivePage = "history";
            return View();
        }
    }
}
