﻿
//Xủ lý các logic liên quan đến làm bài thi
var timeDo = 0;
$(document).ready(function () {
    startCountDown();



});


startCountDown = function () {
    var timer = $("#count-down-wrapper").attr("data-time");
    let hour, minute, second;
    //Mở 
    var countDown = setInterval(function () {

        hour = parseInt(timer / 3600);
        minute = parseInt(parseInt(timer % 3600) / 60);
        second = parseInt(parseInt(timer % 3600) % 60);
        hour = hour < 10 ? "0" + hour : hour;
        minute = minute < 10 ? "0" + minute : minute;
        second = second < 10 ? "0" + second : second;
        $("#count-down-wrapper").html(`<i class='bx bx-time'></i> ${hour}:${minute}:${second}`);
        //Hiện giao diện
        $("#count-down-wrapper").removeClass("d-none");
        if (timer == 60) {
            toastr.warning("Thời gian làm còn 1 phút nữa", "Thông báo");
        }
        if (timer == 5) {
            toastr.warning("Sau 5 giây hệ thống sẽ tự nộp bài", "Thông báo");
        }
        if (timer == 0) {
            clearInterval(countDown)
            //Todo
            toastr.warning(timeDo, "Thông báo");
            console.log(timeDo);
        }
        else {
            timer--;
            timeDo++;
        }

    }, 1000);
}