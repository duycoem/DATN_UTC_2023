using QuizIT.Common.Models;
using QuizIT.Service.Entities;
using QuizIT.Service.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace QuizIT.Service.IServices
{
    public interface IQuestionService
    {
        Task<ServiceResult<string>> ImportExcel(List<Question> questionLst);

        ServiceResult<Question> GetPage(FilterQuestion filter);
    }
}