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
        private readonly string UPDATE_SUCCESS = "Cập nhật bộ đề thành công";
        private readonly string DELETE_SUCCESS = "Xoá bộ đề thành công";
        private readonly string DELETE_FAILED = "Bộ đề đã thuộc đã nằm trong lịch sử làm đề hoặc bảng xếp hạng, không thể xoá";
        private readonly string NOT_FOUND = "Bộ đề không tồn tại";

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

        public ServiceResult<Exam> GetById(int examdId)
        {
            ServiceResult<Exam> serviceResult = new ServiceResult<Exam>
            {
                ResponseCode = ResponseCode.SUCCESS,
            };
            try
            {
                Exam exam = dbContext.Exam.FirstOrDefault(c => c.Id == examdId);
                if (exam == null)
                {
                    return new ServiceResult<Exam>
                    {
                        ResponseCode = ResponseCode.NOT_FOUND,
                    };
                }
                serviceResult.Result.Add(exam);
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

        public async Task<ServiceResult<string>> Update(Exam examNew, List<int> questionIdNewLst)
        {
            ServiceResult<string> serviceResult = new ServiceResult<string>
            {
                ResponseCode = ResponseCode.SUCCESS,
                ResponseMess = UPDATE_SUCCESS
            };
            try
            {
                //Lấy ra exam cũ trong db
                Exam examOld = dbContext.Exam.FirstOrDefault(c => c.Id == examNew.Id);
                //Sai id
                if (examOld == null)
                {
                    serviceResult.ResponseCode = ResponseCode.NOT_FOUND;
                    serviceResult.ResponseMess = NOT_FOUND;
                }
                else
                {
                    //Cập nhật thông tin exam
                    examOld.ExamName = examNew.ExamName;
                    examOld.CategoryId = examNew.CategoryId;
                    examOld.Time = examNew.Time;
                    examOld.IsActive = examNew.IsActive;
                    //Lưu lại xuống database 
                    dbContext.Exam.Update(examOld);
                    await dbContext.SaveChangesAsync();
                    //Cập nhật question của exam
                    await UpdateQuesitionOfExam(examOld.Id, examOld.ExamDetail.ToList(), questionIdNewLst);
                    //Xoá những bảng xếp có số điểm > số câu hỏi
                    dbContext.Rank.RemoveRange(dbContext.Rank.Where(r => r.Point > questionIdNewLst.Count));
                    //Xoá những bảng xếp có thời gian hoàn thành > thời gian làm của bộ đề
                    dbContext.Rank.RemoveRange(dbContext.Rank.Where(r => r.TimeDoExam > examOld.Time));
                    await dbContext.SaveChangesAsync();
                }
            }
            catch
            {
                serviceResult.ResponseCode = ResponseCode.INTERNAL_SERVER_ERROR;
                serviceResult.ResponseMess = ResponseMessage.INTERNAL_SERVER_ERROR;
            }

            return serviceResult;
        }

        public async Task<ServiceResult<string>> Delete(Exam exam)
        {
            ServiceResult<string> serviceResult = new ServiceResult<string>
            {
                ResponseCode = ResponseCode.SUCCESS,
                ResponseMess = DELETE_SUCCESS
            };
            try
            {
                //Kiểm tra xem đã có bộ đề đã có trong lịch sử/bảng xếp hạng chưa
                if (dbContext.History.FirstOrDefault(e => e.ExamId == exam.Id) != null ||
                    dbContext.Rank.FirstOrDefault(q => q.ExamId == exam.Id) != null)
                {
                    serviceResult.ResponseCode = ResponseCode.BAD_REQUEST;
                    serviceResult.ResponseMess = DELETE_FAILED;
                }
                else
                {
                    //Xoá bảng exam detail
                    dbContext.ExamDetail.RemoveRange(dbContext.ExamDetail.Where(c => c.ExamId == exam.Id));
                    //Xoá bảng exam
                    dbContext.Exam.Remove(dbContext.Exam.FirstOrDefault(c => c.Id == exam.Id));
                    await dbContext.SaveChangesAsync();
                }

            }
            catch
            {
                serviceResult.ResponseCode = ResponseCode.INTERNAL_SERVER_ERROR;
                serviceResult.ResponseMess = ResponseMessage.INTERNAL_SERVER_ERROR;
            }

            return serviceResult;
        }

        private async Task UpdateQuesitionOfExam(int examId, List<ExamDetail> examDetailldLst, List<int> questionIdNewLst)
        {
            List<ExamDetail> examDetailCreateLst = new List<ExamDetail>();
            List<ExamDetail> examDetailUpdateLst = new List<ExamDetail>();
            List<ExamDetail> examDetailDeleteLst = new List<ExamDetail>();
            //Duyệt list exam detail cũ
            foreach (var examDetail in examDetailldLst)
            {
                //Nếu nằm trong list question id mới => cập nhật exam detail
                int indexOf = questionIdNewLst.IndexOf(examDetail.QuestionId);
                if (indexOf != -1)
                {
                    examDetail.Order = indexOf + 1;
                    examDetailUpdateLst.Add(examDetail);
                }
                //Nếu không trong list question id mới cập nhật => xoá exam detail
                else
                {
                    examDetailDeleteLst.Add(examDetail);
                }
            }

            //Duyệt list question id mới 
            for (int i = 0; i < questionIdNewLst.Count; i++)
            {
                //Nếu không nằm trong list exam detail cũ => thêm mới
                if (examDetailldLst.FirstOrDefault(c => c.QuestionId == questionIdNewLst[i]) == null)
                {
                    examDetailCreateLst.Add(new ExamDetail
                    {
                        ExamId = examId,
                        QuestionId = questionIdNewLst[i],
                        Order = (i + 1)
                    });
                }
            }

            //Cập nhật
            dbContext.ExamDetail.RemoveRange(examDetailDeleteLst);
            dbContext.ExamDetail.UpdateRange(examDetailUpdateLst);
            await dbContext.ExamDetail.AddRangeAsync(examDetailCreateLst);
        }

    }
}
