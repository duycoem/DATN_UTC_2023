using System;
using System.Collections.Generic;
using System.Text;

namespace QuizIT.Service.Models
{
    public class FilterHistory
    {
        public int ExamId { get; set; } = -1;
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 10;

        public string GetQueryString(int pageNumber, int examId)
        {

            if (pageNumber == 1)
            {
                if (examId == -1)
                {
                    return "";
                }
                else
                {
                    return $"?examId={examId}";
                }
            }
            else
            {
                if (examId == -1)
                {
                    return $"?pagenumber={pageNumber}";
                }
                else
                {
                    return $"?pagenumber={pageNumber}&examId={examId}";
                }
            }
        }
    }
}
