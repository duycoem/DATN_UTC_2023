//Xủ lý các logic liên quan đến làm bài thi
$(document).ready(function () {

    //#region SỰ KIỆN TÌM KIẾM BỘ ĐỀ
    $(document).on("submit", "#form-filter", function () {
        const name = $("input", this).val();
        const categoryId = $("select", this).val();
        if (categoryId == -1) {
            if (name == "") {
                window.location.href = `/bo-de`;
            }
            else {
                window.location.href = `/bo-de?name=${name}`;
            }
        }
        else {
            if (name == "") {
                window.location.href = `/bo-de?category=${categoryId}`;
            }
            else {
                window.location.href = `/bo-de?category=${categoryId}&name=${name}`;
            }
        }

        return false;
    });
    //#endregion

    //#region SỰ KIỆN NỘP BÀI
    $(document).on("click", "#btn-submit", function () {
        //Kiểm tra người dùng đã chọn đủ đáp án hay chưa
        if ($(".question-item input").length / 4 != $(".question-item input:checked").length) {
            toastr.error("Hãy chọn đủ đáp án", "Thông báo");
        }
        //Đã chọn đủ đáp án
        else {
            const pathLst = window.location.pathname.split("/");
            const examId = parseInt(pathLst[pathLst.length - 1]);
            const questionSelectLst = getQuestionSelectLst();
            $.ajax({
                url: "/exam/eventmarkpoint",
                type: "POST",
                data: {
                    examId: examId,
                    timeDoExam: timeDo / 60,
                    questionSelectLst: questionSelectLst,
                },
                dataType: "json",
                beforeSend: function () {
                    showLoading();
                },
                success: function (response) {
                    if (response.responseCode == "200") {
                        toastr.success(response.responseMess, "Thông báo");
                        console.log(response.result[0]);
                        /* setTimeout(function () {
                             location.reload();
                         }, 800);*/
                    }
                    else {
                        toastr.error(response.responseMess, "Thông báo");
                    }
                },
                error: function () {
                    toastr.error("Máy chủ tạm thời không phản hồi, vui lòng thử lại sau", "Thông báo");

                },
            }).always(function () {
                hideLoading();
            });

        }
    });
    //#endregion
});

getQuestionSelectLst = function () {
    let questionSelectLst = [];
    $(".question-item").each(function () {
        questionSelectLst.push({
            QuestionId: $(this).attr("data-target"),
            AnswerSelect: $(this).find("input:checked").val()
        })
    });
    return questionSelectLst;
}