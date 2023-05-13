using QuizIT.Common.Models;
using QuizIT.Service.Entities;
using QuizIT.Service.IServices;
using QuizIT.Service.Models;
using System.Linq;

namespace QuizIT.Service.Services
{
    public class UserService : IUserService
    {
        private readonly QuizITContext dbContext = new QuizITContext();

        public ServiceResult<User> GetPage(FilterUser filter)
        {
            ServiceResult<User> serviceResult = new ServiceResult<User>
            {
                ResponseCode = ResponseCode.SUCCESS
            };
            try
            {
                if (string.IsNullOrEmpty(filter.Name))
                {
                    filter.Name = string.Empty;
                }
                serviceResult.Result = dbContext.User
                    .Where(c =>
                       (
                           c.FullName.ToLower().Contains(filter.Name.ToLower()) ||
                           c.UserName.ToLower().Contains(filter.Name.ToLower())
                       ) &&
                       (filter.Role == -1 || c.RoleId == filter.Role)
                      )
                    .Skip((filter.PageNumber - 1) * filter.PageSize)
                    .Take(filter.PageSize)
                    .ToList();

                serviceResult.TotalRecord = dbContext.User
                    .Where(c =>
                       (
                           c.FullName.ToLower().Contains(filter.Name.ToLower()) ||
                           c.UserName.ToLower().Contains(filter.Name.ToLower())
                       ) &&
                       (filter.Role == -1 || c.RoleId == filter.Role)
                      ).Count();
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