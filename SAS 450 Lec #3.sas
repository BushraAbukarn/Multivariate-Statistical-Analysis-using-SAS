title "Nutrient Intake Data"; 
data nutrition; 
infile "C:\Users\bushr\OneDrive\Desktop\nutrition.txt"; 
input id calcium iron protein vitamin_a vitamin_c; 
run; 
proc contents data=nutrition; 
run; 

*Getting a covariance matrix, correlation matrix, and mean vector; 
proc corr data=nutrition cov noprob; 
var calcium iron protein vitamin_a vitamin_c; 
run; 

*Getting just the correlation matrix; 
proc corr data=nutrition nosimple noprob; 
var calcium iron protein vitamin_a vitamin_c; 
run; 

*Getting just the mean vector; 
proc means data=nutrition; 
var calcium iron protein vitamin_a vitamin_c; 
run; 

*Getting normal Q-Q plots(quantile?quantile plot) for each variable; 
ods graphics on / reset=all height=3in width=4in; 
proc univariate data=nutrition; 
var calcium iron protein vitamin_a vitamin_c;
qqplot; 
run; 
