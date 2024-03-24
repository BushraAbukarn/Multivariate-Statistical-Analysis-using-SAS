title "Nutrient Intake Data";
data nutrition; 
infile "C:\Users\bushr\OneDrive\Desktop\nutrition.txt"; 
input id calcium iron protein vitamin_a vitamin_c; 
run;

ods graphics on / reset=all height=2.5in width=3in; 
*Univariate plots; 
proc univariate data=nutrition; 
histogram calcium iron protein vitamin_a vitamin_c; 
run;
ods graphics off;

*Bivariate plots; 
ods graphics on / reset=all height=4in width=6in;
proc sgscatter data=nutrition; 
    matrix calcium iron protein vitamin_a vitamin_c / diagonal=(histogram kernel); 
run;
ods graphics off; 

*trivariate plots; 
ods graphics on / reset=all height=2.5in width=3in;
proc g3d data=nutrition; 
scatter iron*protein=calcium; 
run; 

