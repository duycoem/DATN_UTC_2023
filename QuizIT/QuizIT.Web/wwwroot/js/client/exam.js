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


});
