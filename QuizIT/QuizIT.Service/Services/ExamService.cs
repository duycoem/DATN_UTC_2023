using QuizIT.Common.Models;
using QuizIT.Service.Entities;
using QuizIT.Service.IServices;
using QuizIT.Service.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace QuizIT.Service.Services
{
    public class ExamService : IExamService
    {
        private readonly QuizITContext dbContext = new QuizITContext();
        private readonly string CREATE_SUCCESS = "Thêm bộ đề thành công";
        private readonly string UPDATE_SUCCESS = "Cập nhật câu hỏi thành công";
        private readonly string DELETE_SUCCESS = "Xoá câu hỏi thành công";
        private readonly string DELETE_FAILED = "Câu hỏi đã thuộc 1 bộ đề hoặc nằm trong lịch sử làm đề, không thể xoá";
        private readonly string NOT_FOUND = "Câu hỏi không tồn tại";

        public ServiceResult<Exam> GetPage(FilterExam filter)
        {
            ServiceResult<Exam> serviceResult = new ServiceResult<Exam>
            {
                ResponseCode = ResponseCode.SUCCESS
            };
            try
            {
                if (string.IsNullOrEmpty(filter.Name))
                {
                    filter.Name = string.Empty;
                }
                serviceResult.Result = dbContext.Exam
                     .Where(q =>
                         q.ExamName.ToLower().Contains(filter.Name.ToLower()) &&
                         (filter.Category == -1 || q.CategoryId == filter.Category) &&
                         (filter.IsActive == -1 || q.IsActive == Convert.ToBoolean(filter.IsActive))
                     )
                     .Skip((filter.PageNumber - 1) * filter.PageSize)
                     .Take(filter.PageSize)
                     .ToList();

                serviceResult.TotalRecord = dbContext.Exam
                    .Where(q =>
                         q.ExamName.ToLower().Contains(filter.Name.ToLower()) &&
                         (filter.Category == -1 || q.CategoryId == filter.Category) &&
                         (filter.IsActive == -1 || q.IsActive == Convert.ToBoolean(filter.IsActive))
                     )
                    .Count();
            }
            catch
            {
                serviceResult.ResponseCode = ResponseCode.INTERNAL_SERVER_ERROR;
                serviceResult.ResponseMess = ResponseMessage.INTERNAL_SERVER_ERROR;
            }

            return serviceResult;
        }

        public async Task<ServiceResult<string>> Create(Exam exam, List<int> questionIdLst)
        {
            ServiceResult<string> serviceResult = new ServiceResult<string>
            {
                ResponseCode = ResponseCode.SUCCESS,
                ResponseMess = CREATE_SUCCESS
            };
            try
            {
                //Thêm bảng exam trước
                exam.CreateBy = CurrentUser.Id;
                await dbContext.Exam.AddAsync(exam);
                await dbContext.SaveChangesAsync();

                //Thêm bảng exam detail
                List<ExamDetail> examDetailLst = new List<ExamDetail>();
                for (int i = 0; i < questionIdLst.Count; i++)
                {
                    examDetailLst.Add(new ExamDetail
                    {
                        ExamId = exam.Id,
                        QuestionId = questionIdLst[i],
                        Order = (i + 1)
                    });
                }

                await dbContext.ExamDetail.AddRangeAsync(examDetailLst);
                await dbContext.SaveChangesAsync();

            }
            catch
            {
                serviceResult.ResponseCode = ResponseCode.INTERNAL_SERVER_ERROR;
                serviceResult.ResponseMess = ResponseMessage.INTERNAL_SERVER_ERROR;
            }

            return serviceResult;
        }
    }
}
