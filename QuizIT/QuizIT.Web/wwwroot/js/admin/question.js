
$(document).ready(function () {

    //#region SỰ KIỆN CLICK INPUT EXCEL
    $(document).on("click", "#input-excel", function () {
        $(this).val(null);
    });
    //#endregion

    //#region SỰ KIỆN IMPORT FILE EXCEL
    $(document).on("click", "#btn-import", function () {
        const formData = new FormData();
        const fileExcel = $("#input-excel").get(0).files[0];
        if (fileExcel == undefined) {
            toastr.error("Vui lòng chọn file", "Thông báo");
        }
        else {
            const fileType = fileExcel.name.split('.')[1];
            const categoryId = $("#select-category").val();
            if (fileType != 'xlsx' && fileType != 'XLSX') {
                toastr.error("Vui lòng chọn file excel đuôi .xlsx", "Thông báo");
            }
            else {
                formData.append("categoryId", categoryId);
                formData.append("fileExcel", fileExcel);
                $.ajax({
                    url: "/admin/questionadmin/eventimportexcel",
                    type: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
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
        }

    });
    //#endregion

    //#region SỰ KIỆN TÌM KIẾM CÂU HỎI
    $(document).on("submit", "#form-filter", function () {
        const name = $("input", this).val();
        const categoryId = $("select", this).val();
        if (categoryId == -1) {
            if (name == "") {
                window.location.href = `/admin/cau-hoi`;
            }
            else {
                window.location.href = `/admin/cau-hoi?name=${name}`;
            }
        }
        else {
            if (name == "") {
                window.location.href = `/admin/cau-hoi?category=${categoryId}`;
            }
            else {
                window.location.href = `/admin/cau-hoi?category=${categoryId}&name=${name}`;
            }
        }

        return false;
    });
    //#endregion

    //#region SỰ KIỆN THÊM CÂU HỎI
    $(document).on("click", "#btn-create", function () {
        const question = $("#form-quesion").serializeObject();
        console.log(question);
        /*if (category.CategoryName == "") {
            toastr.error("Chưa nhập đủ thông tin", "Thông báo");
        }
        else {
            $.ajax({
                url: "/admin/categoryadmin/eventupdate",
                type: "POST",
                data: {
                    category: category,
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
            })
        }*/
    });
    //#endregion

    //#region SỰ KIỆN XOÁ CHỦ ĐỀ
    $(document).on("click", "#btn-delete", function () {
        const category = $("#form-category").serializeObject();
        $.ajax({
            url: "/admin/categoryadmin/eventdelete",
            type: "POST",
            data: {
                category: category,
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
        })

    });
    //#endregion

});


