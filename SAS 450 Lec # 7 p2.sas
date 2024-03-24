*Two-WAY MANOVA; 
title "TWO-WAY MANOVA"; 
data fix; 
infile "C:\Users\bushr\OneDrive\Desktop\fix.dat"; 
input severity $ complexity $ experince $ assessment implementaion total_time; 
run; 

proc glm data=fix; 
class severity experince; 
model assessment implementaion = severity experince severity*experince; 
manova H=severity|experince; 
run; 
