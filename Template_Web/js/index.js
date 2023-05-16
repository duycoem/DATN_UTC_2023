var inputArray = [1, 0, 1];
var max = inputArray[0];
var moves = 0;
for (var i = 1; i < inputArray.length; i++) {
  if (inputArray[i] <= max) {
    max+=1;
    moves += max - inputArray[i];
  }
  else{
    max = inputArray[i];
  }
}
alert(moves);
