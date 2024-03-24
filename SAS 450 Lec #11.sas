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

*Principal components method; 
proc factor method=principal nfactors=3
rotate=varmix simple corr scree ev preplot plot residuals; 
var climateL10 housingL10 healthL10 crimeL10 transL10 educateL10 
artsL10 recreateL10 econL10; 
run; 
