using QuizIT.Common.Models;
using QuizIT.Service.Entities;
using QuizIT.Service.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace QuizIT.Service.IServices
{
    public interface IExamService
    {
        ServiceResult<Exam> GetPage(FilterExam filter);
        Task<ServiceResult<string>> Create(Exam exam, List<int> questionIdLst);
    }
}
