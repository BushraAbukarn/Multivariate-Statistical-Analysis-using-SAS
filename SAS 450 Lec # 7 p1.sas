data pottery; 
infile "C:\Users\bushr\OneDrive\Desktop\pottery.txt"; 
input site $ al fe mg ca na; 
run; 
proc contents data=pottery; 
run; 

title "Check for normallity"; 
proc glm data=pottery; 
class site; 
model al fe mg ca na = site; 
output out=resids r=ral rfe rmg rca rna; 
run; 
ods graphics on / reset=all height=6in width=8in; 
proc sgscatter data=resids; 
  matrix ral rfe rmg rca rna / 
    group=site ellipse=(type=mean) diagonal=(histogram kernel); 
run; 
ods graphics off; 

ods graphics on / reset=all height=2in width=3in; 
proc sgplot data=resids; 
scatter x=ral y=rfe; 
ellipse x=ral y=rfe / alpha=0.1; 
keylegend / location=inside position=bottomright;
run; 

ods graphics on / reset=all height=2in width=3in; 
proc sgplot data=resids; 
scatter x=ral y=rmg;
ellipse x=ral y=rmg / alpha=0.1; 
keylegend / location=inside position=bottomright;
run; 

ods graphics on / reset=all height=2in width=3in; 
proc sgplot data=resids; 
scatter x=ral y=rca; 
ellipse x=ral y=rca / alpha=0.1; 
keylegend / location=inside position=bottomright;
run; 

ods graphics on / reset=all height=2in width=3in; 
proc sgplot data=resids; 
scatter x=ral y=rna; 
ellipse x=ral y=rna / alpha=0.1; 
keylegend / location=inside position=bottomright;
run; 

title "Check for common covariance - Bartlett's Test"; 
proc discrim data=pottery pool=test; 
class site; 
var al fe mg ca na; 
run; 

*One-way MANOVA; 
title "MANOVA - Pottery Data"; 
proc glm data=pottery; 
class site; 
model al fe mg ca na = site; 
lsmeans site / stderr; 
manova h=site / printe printh; 
run; 
