*Principal Component Analysis (PCA);
title 'PCA-Covariance Matrix of Places Rated data'; 
data places; 
infile "C:\Users\bushr\OneDrive\Desktop\places.txt"; 
input climate housing health crime trans educate arts recreate econ id; 
*Normalizing the data; 
climateL10=log10(climate); 
housingL10=log10(housing); 
healthL10=log10(health); 
crimeL10=log10(crime); 
transL10=log10(trans); 
educateL10=log10(educate); 
artsL10=log10(arts); 
recreateL10=log10(recreate); 
econL10=log10(econ); 
run;
*Obtain analysis based on the Cov matrix; 
ods graphics on / reset=all height=3in width=6in; 
proc princomp data=places cov out=pc; 
var climateL10 housingL10 healthL10 crimeL10
transL10 educateL10 artsL10 recreateL10 econL10;
run; 

*Correlation; 
proc corr data=pc noprob; 
var prin1 prin2 prin3 climateL10 housingL10 healthL10 crimeL10
transL10 educateL10 artsL10 recreateL10 econL10;
run; 
