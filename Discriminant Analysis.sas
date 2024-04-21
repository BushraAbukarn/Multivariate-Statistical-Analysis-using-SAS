title 'Admission data'; 
data admission; 
infile "C:\Users\bushr\OneDrive\Desktop\Admission.dat"; 
input GPA GMAT Population; 
run;
data NewApplicants; 
input GPA GMAT; 
datalines; 
3.21 497
4.00 700
3.00 500
2.00 300
2.00 700
; 
run; 
* Linear Discriminant Analysis; 
proc discrim data=Admission method=normal pool=YES testdata=NewApplicants
simple testlist testout=test1 out=lda; 
class Population; 
var GPA GMAT; 
run; 
proc print data=lda(obs=5); 
run; 

ods graphics on / reset=all height=3in width=4in; 
title 'Population classification';
proc sgscatter data=lda datacolors=(blue pink green); 
plot GPA*GMAT / filledoutlinedmarkers group=Population
markerattrs=(symbol=circlefilles size=10); 
run; 
title 'Population classification';
proc sgscatter data=lda datacolors=(blue pink green); 
plot GPA*GMAT / filledoutlinedmarkers group=_INTO_
markerattrs=(symbol=circlefilles size=10); 
run; 

*Quadratic Discriminant Analysis; 
title 'Quadratic Discriminant Analysis'; 
proc discrim data=Admission method=normal pool=test testdata=NewApplicants
simple testlist testout=test2 out=qda; 
class Population; 
var GPA GMAT; 
run;  
