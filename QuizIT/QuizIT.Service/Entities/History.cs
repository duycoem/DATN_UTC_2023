using System;
using System.Collections.Generic;

namespace QuizIT.Service.Entities
{
    public partial class History
    {
        public History()
        {
            HistoryExam = new HashSet<HistoryExam>();
        }

        public int Id { get; set; }
        public int ExamId { get; set; }
        public int UserId { get; set; }
        public int TimeDoExam { get; set; }
        public int Point { get; set; }
        public DateTime? CreatedAt { get; set; }

        public virtual Exam Exam { get; set; }
        public virtual User User { get; set; }
        public virtual ICollection<HistoryExam> HistoryExam { get; set; }
    }
}
