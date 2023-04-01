using QuizIT.Common.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;

namespace QuizIT.Common.Models
{
    public class CurrentUser
    {
        public static int Id
        {
            get
            {
                var claims = HttpHelper.HttpContext.Items["CurrentUser"] as IEnumerable<Claim>;
                if (!int.TryParse(claims?.Where(x => x.Type == ClaimTypes.NameIdentifier)?.FirstOrDefault()?.Value, out int uId))
                {
                    uId = -1;   //Giá trị khi chưa đăng nhập là -1
                }
                return uId;
            }
            set { }
        }
    }
}
