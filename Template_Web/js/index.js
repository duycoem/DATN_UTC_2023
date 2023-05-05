let maxSubLenght = 0; 
let dict = {}; 
let idx = 0; 
for(let i = 0; i < s.length; i++){ 
    if(s.charAt(i) in dict){ 
        while(dict[s.charAt(i)] > 0){ 
            dict[s.charAt(idx)] -=1;
            idx++; 
        } 
    } 
    dict[s.charAt(i)] = 1; 
    maxSubLenght = Math.max(i-idx+1, maxSubLenght); 
} 
 return maxSubLenght;