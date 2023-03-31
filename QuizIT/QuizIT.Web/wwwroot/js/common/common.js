
$.fn.serializeObject = function () {
    var o = Object.create(null),
        elementMapper = function (element) {
            element.name = $.camelCase(element.name);
            return element;
        },
        appendToResult = function (i, element) {
            var node = o[element.name];

            if ('undefined' != typeof node && node !== null) {
                o[element.name] = node.push ? node.push(element.value) : [node, element.value];
            } else {
                o[element.name] = element.value;
            }
        };

    $.each($.map(this.serializeArray(), elementMapper), appendToResult);
    return o;
};

//#region HÀM LOAD SHOW LOADING
showLoading = function () {
    $(".my-loading").addClass("d-flex");
}
//#endregion

//#region HÀM LOAD HIDE LOADING
hideLoading = function () {
    $(".my-loading").removeClass("d-flex");
}
//#endregion

//#region HÀM LOAD HTML BẰNG AJAX
loadHtmlByAjax = function (url, selectDivContainer, data = {}, isShowLoading = false, isAppend = false, errorMess = "Có lổi xảy ra khi load html") {
    $.ajax({
        url: url,
        type: "POST",
        data: data,
        dataType: "html",
        beforeSend: function () {
            if (isShowLoading == true) {
                ShowLoading();
            }
        },
        success: function (html) {
            if (isAppend == false) {
                $(selectDivContainer).html(html);
            }
            else {
                $(selectDivContainer).append(html);
            }
        },
        error: function () {
            toastr.error(errorMess, "Thông báo")
        }
    }).always(function () {
        if (isShowLoading == true) {
            HideLoading();
        }
    })
}
//#endregion