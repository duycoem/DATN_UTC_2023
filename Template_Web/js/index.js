const str = ["flower","flow","flight"];
if(strs.length == 1){
  return str[0].charAt(0);
}
let result = "";
for(let i = 0; i < strs[0].length;i++){
  let currentChar = strs[0].charAt(i);
  for(let j = 1 ; j < strs.length;j++){
    if(strs[j].charAt(i) != currentChar){
      return result;
    }
  }
  result+=currentChar;
}
return result;