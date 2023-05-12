﻿using Microsoft.AspNetCore.Mvc;
using QuizIT.Common.Models;
using QuizIT.Service.IServices;
using QuizIT.Service.Entities;
using System;
using System.Linq;
using System.Threading.Tasks;
using QuizIT.Service.Models;
using QuizIT.Common.Helpers;
using Microsoft.AspNetCore.Http;
using System.IO;
using System.Collections.Generic;

namespace QuizIT.Web.Areas.Admin.Controllers
{
    public class QuestionAdminController : BaseAdminController
    {
        private const int MODAL_ACTION_CREATE = 1;
        private const int MODAL_ACTION_UPDATE = 2;
        private readonly IQuestionService questionService;
        private readonly ICategoryService categoryService;

        public QuestionAdminController(IQuestionService questionService, ICategoryService categoryService)
        {
            this.questionService = questionService;
            this.categoryService = categoryService;
        }

        [Route("/admin/cau-hoi")]
        public IActionResult Index(FilterQuestion filter)
        {
            ViewBag.ActivePage = "question";
            //Lấy ra tất cả thể loại để filter
            var categoryServiceResult = categoryService.GetPage(new FilterCategory
            {
                PageSize = int.MaxValue
            });
            //Lấy danh sách câu hỏi
            var questionServiceResult = questionService.GetPage(filter);
            //Gọi service bị lỗi
            if (categoryServiceResult.ResponseCode != ResponseCode.SUCCESS ||
                questionServiceResult.ResponseCode != ResponseCode.SUCCESS)
            {
                return Redirect("~/internal-server-error");
            }
            ViewBag.PaginationModel = PaginationHelper.GetPaginationModel(filter.PageNumber, filter.PageSize, questionServiceResult.TotalRecord);
            ViewBag.Filter = filter;
            ViewBag.CategoryLst = categoryServiceResult.Result;
            return View(questionServiceResult.Result);
        }

        [Route("/admin/cau-hoi/tao")]
        public IActionResult Create()
        {
            ViewBag.ActivePage = "question";
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

        [HttpPost]
        public async Task<ActionResult> EventImportExcel(int categoryId, IFormFile fileExcel)
        {
            List<Question> questionLst = new List<Question>();
            //Load data từ excel
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
            using (var stream = new MemoryStream())
            {
                fileExcel.CopyTo(stream);
                stream.Position = 0;
                using (var reader = ExcelDataReader.ExcelReaderFactory.CreateReader(stream))
                {
                    int row = 1;
                    while (reader.Read())
                    {
                        //Dữ liệu bắt đầu từ dòng 2 vì dòng 1 là của tiêu đề 
                        if (row >= 2)
                        {
                            questionLst.Add(new Question
                            {
                                CategoryId = categoryId,
                                Content = reader.GetValue(0).ToString(),
                                AnswerA = reader.GetValue(1).ToString(),
                                AnswerB = reader.GetValue(2).ToString(),
                                AnswerC = reader.GetValue(3).ToString(),
                                AnswerD = reader.GetValue(4).ToString(),
                                AnswerCorrect = reader.GetValue(5).ToString(),
                                CreatedBy = CurrentUser.Id
                            });
                        }
                        row++;
                    }
                }
            }
            return Json(await questionService.ImportExcel(questionLst));
        }

        /*[HttpPost]
        public IActionResult ModalCategory(int action, int categoryId)
        {
            //Gọi service để lấy thông tin
            Category category = new Category();
            if (action == MODAL_ACTION_UPDATE)
            {
                var serviceResult = categoryService.GetById(categoryId);
                //Lỗi thì văng exception để ajax xử lý
                if (serviceResult.ResponseCode != ResponseCode.SUCCESS)
                {
                    throw new Exception();
                }
                category = serviceResult.Result.FirstOrDefault();
            }
            ViewBag.Action = action;
            ViewBag.CategoryId = categoryId;
            return PartialView(category);
        }

        [HttpPost]
        public async Task<IActionResult> EventCreate(Category category)
        {
            var serviceResult = await categoryService.Create(category);
            return Json(serviceResult);
        }

        [HttpPost]
        public async Task<IActionResult> EventUpdate(Category category)
        {
            var serviceResult = await categoryService.Update(category);
            return Json(serviceResult);
        }

        [HttpPost]
        public async Task<IActionResult> EventDelete(Category category)
        {
            var serviceResult = await categoryService.Delete(category);
            return Json(serviceResult);
        }*/
    }
}