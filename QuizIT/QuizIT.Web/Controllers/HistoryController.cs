using Microsoft.AspNetCore.Mvc;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using QuizIT.Common.Helpers;
using QuizIT.Common.Models;
using QuizIT.Service.IServices;
using QuizIT.Service.Models;
using System;
using System.Collections.Generic;
using System.IO;
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

         [HttpPost]
         public void EventExportHistory(int historyId, List<ExportHistory> lstExportHistory)
         {
             try
             {
                 var historyServiceResult = examService.GetHistoryById(18);
                 //Văng lỗi ra FE để ajax xử lý
                 if (historyServiceResult.ResponseCode != ResponseCode.SUCCESS)
                 {
                     throw new Exception();
                 }
                 ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
                 ExcelPackage excel = new ExcelPackage();
                 var workSheet = excel.Workbook.Worksheets.Add("Kết quả làm bài");
                 //Css cho sheet
                 workSheet.TabColor = System.Drawing.Color.Black;
                 workSheet.DefaultRowHeight = 12;
                 //Setup tiêu đề
                 workSheet.Row(1).Height = 20;
                 workSheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                 workSheet.Row(1).Style.Font.Bold = true;
                 workSheet.Cells[1, 1].Value = "Câu hỏi";
                 workSheet.Cells[1, 2].Value = "Đáp án đã chọn";
                 workSheet.Cells[1, 3].Value = "Kết quả";

                 string excelName = "studentsRecord";

                 using (var memoryStream = new MemoryStream())
                 {
                     Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                     Response.Headers.Add("content-disposition", "attachment; filename=" + excelName + ".xlsx");
                     excel.SaveAs(memoryStream);
                     memoryStream.WriteTo(Response.Body);
                     Response.Body.Flush();
                 }
             }
             catch (Exception e)
             {
                 string mess = e.Message;
             }
         }

        /*[HttpPost]
        public IActionResult EventExportHistory(int historyId, List<ExportHistory> lstExportHistory)
        {

            var historyServiceResult = examService.GetHistoryById(18);
            //Văng lỗi ra FE để ajax xử lý
            if (historyServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                throw new Exception();
            }
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            ExcelPackage excel = new ExcelPackage();
            var workSheet = excel.Workbook.Worksheets.Add("Kết quả làm bài");
            //Css cho sheet
            workSheet.TabColor = System.Drawing.Color.Black;
            workSheet.DefaultRowHeight = 12;
            //Setup tiêu đề
            workSheet.Row(1).Height = 20;
            workSheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            workSheet.Row(1).Style.Font.Bold = true;
            workSheet.Cells[1, 1].Value = "Câu hỏi";
            workSheet.Cells[1, 2].Value = "Đáp án đã chọn";
            workSheet.Cells[1, 3].Value = "Kết quả";

            string excelName = "studentsRecord";

            var memoryStream = new MemoryStream();
            excel.SaveAs(memoryStream);
            var contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

            return File(memoryStream, contentType, excelName);
        }*/
    }
}