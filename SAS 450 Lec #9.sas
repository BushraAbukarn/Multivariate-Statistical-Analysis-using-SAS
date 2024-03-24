title 'Weight lift data'; 
proc import out=wtlift datafile="C:\Users\bushr\OneDrive\Desktop\wt_lift.csv"
dbms=csv replace; getnames=yes; guessingrows=1000; 
run; 
*check for linearity assumption; 
proc sgscatter data=wtlift; 
compare y=(snatch clean total) x=age / group=wt
markerattrs=(symbol="diamondfilled"); 
run; 
proc sgscatter data=wtlift; 
compare y=(snatch clean total) x=wt / group=age
markerattrs=(symbol="diamondfilled"); 
run;
*check for correlation; 
proc corr data=wtlift; 
var snatch clean total wt age; 
run; 
*test1: overall effect; 
proc reg data=wtlift; 
model snatch clean total = wt age; 
mtest; 
run; 
*test 2: identical fitted regression lines for Snatch and Clean outcomes; 
proc reg data=wtlift; 
model snatch clean total = wt age; 
mtest intercept, wt, age, snatch-clean; 
run; 
*test 3: test AGE coefficients equal for Snatch and Clean outcomes; 
proc reg data=wtlift; 
model snatch clean total = wt age; 
mtest snatch-clean, age; 
run; 
*test 4: test if the coefficients are additive for Age variabel; 
proc reg data=wtlift; 
model snatch clean total = wt age; 
mtest intercept,snatch+clean-total; 
run; 
