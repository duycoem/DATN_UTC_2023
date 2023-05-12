using QuizIT.Common.Models;
using QuizIT.Service.Entities;
using QuizIT.Service.IServices;
using QuizIT.Service.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace QuizIT.Service.Services
{
    public class QuestionService : IQuestionService
    {
        private readonly QuizITContext dbContext = new QuizITContext();
        private readonly string IMPORT_SUCCESS = "Nhập file Excel thành công";
        private readonly string CREATE_SUCCESS = "Thêm chủ đề thành công";
        private readonly string UPDATE_SUCCESS = "Cập nhật chủ đề thành công";
        private readonly string DELETE_SUCCESS = "Xoá chủ đề thành công";
        private readonly string DELETE_FAILED = "Đã có bộ đề/câu hỏi thuộc chủ đề này, không thể xoá";
        private readonly string EXISTS_CATEGORY_NAME = "Tên chủ đề đã trùng, vui lòng nhập tên khác";
        private readonly string NOT_FOUND = "Chủ đề không tồn tại";

        public ServiceResult<Question> GetPage(FilterQuestion filter)
        {
            ServiceResult<Question> serviceResult = new ServiceResult<Question>
            {
                ResponseCode = ResponseCode.SUCCESS,
            };
            try
            {
                serviceResult.Result = dbContext.Question
                    .Where(q =>
                        q.Content.ToLower().Contains(filter.Name.ToLower()) &&
                        (filter.Category == -1 || q.CategoryId == filter.Category)
                    )
                    .Skip((filter.PageNumber - 1) * filter.PageSize)
                    .Take(filter.PageSize)
                    .ToList();

                serviceResult.TotalRecord = dbContext.Question
                    .Where(q =>
                        q.Content.ToLower().Contains(filter.Name.ToLower()) &&
                        (filter.Category == -1 || q.CategoryId == filter.Category)
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

        public async Task<ServiceResult<string>> ImportExcel(List<Question> questionLst)
        {
            ServiceResult<string> serviceResult = new ServiceResult<string>
            {
                ResponseCode = ResponseCode.SUCCESS,
                ResponseMess = IMPORT_SUCCESS
            };
            try
            {
                await dbContext.Question.AddRangeAsync(questionLst);
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