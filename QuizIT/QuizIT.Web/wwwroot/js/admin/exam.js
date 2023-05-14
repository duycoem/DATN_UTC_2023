var selectedQuestionIdLst = [];
var isOpenModalFirst = true;
$(document).ready(function () {

    //Lưu lại id của những câu hỏi đã được chọn
    updateSelectedQuestionIdLst();

    //#region SỰ KIỆN CLICK MỞ MODAL CHỌN CÂU HỎI
    $(document).on("click", "#btn-modal-question", function () {
        //Chỉ gọi ajax vào lần đầu tiên
        if (isOpenModalFirst == true) {
            loadTableQuestion({}, true);
            isOpenModalFirst = false;
        }
    });
    //#endregion

    //#region SỰ KIỆN CLICK VÀO CÁC CÂU HỎI ĐỂ CHỌN
    $(document).on("click", "#table-question tbody tr", function () {
        //Lấy ra id
        const questionId = parseInt($(this).attr("data-target"));
        //Kiểm tra xem đã chọn câu hỏi này chưa
        //Câu hỏi đã được chọn
        if (selectedQuestionIdLst.includes(questionId)) {
            toastr.error("Câu hỏi đã được chọn", "Thông báo");
        }
        //Câu hỏi chưa được chọn
        else {
            //Chưa có câu hỏi nào
            if (selectedQuestionIdLst.length == 0) {
                //Setup table html
                $("#table-question-selected").html(
                    "<table class='table table-hover'>" +
                    "   <thead>" +
                    "       <tr>" +
                    "           <th>Câu hỏi</th>" +
                    "           <th>Chủ đề</th>" +
                    "           <th>Đáp án A</th>" +
                    "           <th>Đáp án B</th>" +
                    "           <th>Đáp án C</th>" +
                    "           <th>Đáp án D</th>" +
                    "           <th>Đáp án đúng</th>" +
                    "           <th>Thao tác</th>" +
                    "       </tr>" +
                    "   </thead>" +
                    "   <tbody>" +
                    "   </tbody>" +
                    "</table>");
            }
            //Clone ra tr mới
            const newTr = $(this).clone();
            //Đánh dấu câu hỏi đã được chọn
            $(this).addClass("selected");
            //Thêm html icon xoá
            newTr.append("<td><i class='bx bx-trash text-danger btn-delete-question'></i></td>");
            $("#table-question-selected tbody").append(newTr.prop('outerHTML'));
            //Thêm id câu hỏi vào selectedQuestionIdLst
            selectedQuestionIdLst.push(questionId);
        }

    });
    //#endregion

    //#region SỰ KIỆN CLICK BỎ CHỌN CÁC CÂU HỎI ĐÃ CHỌN
    $(document).on("click", ".btn-delete-question", function () {
        //Lấy ra phần tử tr
        const trElement = $(this).parent().parent("tr");
        const questionId = parseInt(trElement.attr("data-target"));
        //Xoá html trong table question đã chọn
        trElement.remove();
        //Trường hợp xoá hết các câu hỏi đã chọn
        if (selectedQuestionIdLst.length == 1) {
            $("#table-question-selected").html("<p class='text-center'>Không có dữ liệu</p>");
        }
        //Bỏ đánh dấu question trong table danh sách question
        $(`#table-question tbody tr[data-target=${questionId}]`).removeClass("selected");
        //Xoá id câu hỏi ở selectedQuestionIdLst
        selectedQuestionIdLst.splice(selectedQuestionIdLst.indexOf(questionId), 1);
    });
    //#endregion

    //#region SỰ KIỆN TÌM KIẾM QUESTION Ở MODAL
    $(document).on("submit", "#form-filter-question", function () {
        const name = $("input", this).val();
        const category = $("select", this).val();
        //load lại dữ liệu
        loadTableQuestion({ name: name, category: category }, true);
        return false;
    });
    //#endregion

    //#region SỰ KIỆN ẤN XÁC NHẬN CHỌN CÁC CÂU HỎI
    $(document).on("click", "#btn-save-detail", function () {
        //Test
        console.log(selectedQuestionIdLst);
        $("#table-question-selected tbody tr").each(function () {
            console.log($(this).attr("data-target"));
        })
        //Nếu không có question nào được chọn
        if (selectedQuestionIdLst.length == 0) {
            $("#table-question-exam").html("<p class='text-center'>Không có dữ liệu</p>");
        }
        else {
            //Duyệt html các question đã được chọn
            //Setup table html
            $("#table-question-exam").html(
                "<table class='table'>" +
                "   <thead>" +
                "       <tr>" +
                "           <th>STT</th>" +
                "           <th>Câu hỏi</th>" +
                "           <th>Chủ đề</th>" +
                "           <th>Đáp án A</th>" +
                "           <th>Đáp án B</th>" +
                "           <th>Đáp án C</th>" +
                "           <th>Đáp án D</th>" +
                "           <th>Đáp án đúng</th>" +
                "       </tr>" +
                "   </thead>" +
                "   <tbody>" +
                "   </tbody>" +
                "</table>");
            let html = ""
            $("#table-question-selected tbody tr").each(function (index) {
                var newTrElement = $(this).clone();
                //Loại bỏ cột icon xoá
                newTrElement.find("td:last-child").remove();
                newTrElement.html(`<td>${index + 1}</td>` + newTrElement.html());
                html += newTrElement.prop('outerHTML');
            });
            $("#table-question-exam tbody").html(html);
        }
        //Đóng modal
        $(".close").trigger("click");

    });
    //#endregion

    //#region SỰ KIỆN THÊM BỘ ĐỀ
    $(document).on("click", "#btn-create", function () {
        const exam = $("#form-question").serializeObject();
        console.log(exam);
    });
    //#endregion

    //#region SỰ KIỆN SỬA CÂU HỎI
    $(document).on("click", "#btn-update", function () {
        const question = $("#form-question").serializeObject();
        //Loại bỏ dấu cách thừa
        question.Content = question.Content.trim()
        question.AnswerA = question.AnswerA.trim()
        question.AnswerB = question.AnswerB.trim()
        question.AnswerC = question.AnswerC.trim()
        question.AnswerD = question.AnswerD.trim()
        if (!isValidQuestion(question)) {
            toastr.error("Chưa nhập đủ thông tin", "Thông báo");
        }
        else {

            $.ajax({
                url: "/admin/questionadmin/eventupdate",
                type: "POST",
                data: {
                    question: question,
                },
                dataType: "json",
                beforeSend: function () {
                    showLoading();
                },
                success: function (response) {
                    if (response.responseCode == "200") {
                        toastr.success(response.responseMess, "Thông báo");
                        setTimeout(function () {
                            location.reload();
                        }, 800);
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

    //#region SỰ KIỆN XOÁ CÂU HỎI
    $(document).on("click", "#btn-delete", function () {
        const question = $("#form-question").serializeObject();
        $.ajax({
            url: "/admin/questionadmin/eventdelete",
            type: "POST",
            data: {
                question: question,
            },
            dataType: "json",
            beforeSend: function () {
                showLoading();
            },
            success: function (response) {
                if (response.responseCode == "200") {
                    toastr.success(response.responseMess, "Thông báo");
                    setTimeout(function () {
                        window.location.href = "/admin/cau-hoi";
                    }, 800);
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
    });
    //#endregion

});


isValidExam = function (exam) {
    if (question.Content == "" || question.AnswerA == "" || question.AnswerB == "" || question.AnswerC == ""
        || question.AnswerD == "") {
        return false;
    }
    return true;
}

//Hàm lấy các question đã được chọn và gán vào biến global selectedQuestionIdLst
updateSelectedQuestionIdLst = function () {
    $("#table-question-selected tbody tr").each(function () {
        const questionId = parseInt($(this).attr("data-target"));
        selectedQuestionIdLst.push(questionId);
    })
}

//#region load table question 
loadTableQuestion = function (data = {}, isShowLoading = false) {
    //Gọi ajax để load dữ liệu
    $.ajax({
        url: "/admin/examadmin/tablequestion",
        type: "POST",
        data: data,
        dataType: "html",
        beforeSend: function () {
            if (isShowLoading == true) {
                showLoading();
            }
        },
        success: function (html) {
            //Có dữ liệu trả về
            if (html.includes("</td>")) {
                $("#table-question").html(html);
                //Đánh dấu lại các question trong danh sách question mà đã được chọn
                markQuestionSelected();
            }
            //Không có dữ liệu trả về
            else {
                $("#table-question").html("<p class='text-center'>Không có dữ liệu</p>");
            }
        },
        error: function () {
            toastr.error("Máy chủ tạm thời không phản hồi, vui lòng thử lại sau", "Thông báo")
        }
    }).always(function () {
        if (isShowLoading == true) {
            hideLoading();
        }

    });
}
//#endregion

//Đánh dấu lại các question trong danh sách question mà đã được chọn
markQuestionSelected = function () {
    //Đánh dấu lại các question trong danh sách question mà đã được chọn
    $("#table-question tbody tr").each(function () {
        const questionId = parseInt($(this).attr("data-target"));
        //Đánh dấu lại các hỏi đã được chọn bằng class
        if (selectedQuestionIdLst.includes(questionId)) {
            $(this).addClass("selected");
        }
    });
}