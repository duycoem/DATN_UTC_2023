function startTimer(duration, display) {
  var timer = duration;
  let minutes, seconds;
  setInterval(function () {
    console.log(timer);
      if (timer == 0) {
        console.log('hết giờ');
      }
      minutes = parseInt(timer / 60, 10);
      seconds = parseInt(timer % 60, 10);

      minutes = minutes < 10 ? "0" + minutes : minutes;
      seconds = seconds < 10 ? "0" + seconds : seconds;

      display.textContent = minutes + ":" + seconds;
      timer--;
  }, 1000);
}

window.onload = function () {
  var fiveMinutes = 10,
      display = document.querySelector('#time');
  startTimer(fiveMinutes, display);
};