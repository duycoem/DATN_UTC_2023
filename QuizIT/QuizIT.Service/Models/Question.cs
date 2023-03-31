﻿using System;
using System.Collections.Generic;

namespace QuizIT.Service.Models
{
    public partial class Question
    {
        public Question()
        {
            ExamDetail = new HashSet<ExamDetail>();
            HistoryExam = new HashSet<HistoryExam>();
        }

        public int Id { get; set; }
        public int CategoryId { get; set; }
        public string Content { get; set; }
        public string AnswerA { get; set; }
        public string AnswerB { get; set; }
        public string AnswerC { get; set; }
        public string AnswerD { get; set; }
        public string AnswerCorrect { get; set; }
        public DateTime? CreatedAt { get; set; }
        public int CreatedBy { get; set; }

        public virtual Category Category { get; set; }
        public virtual User CreatedByNavigation { get; set; }
        public virtual ICollection<ExamDetail> ExamDetail { get; set; }
        public virtual ICollection<HistoryExam> HistoryExam { get; set; }
    }
}