data sweat; 
  input rate sodium potassium;
  datalines;
3.7 48.5 9.3
5.7 65.1 8.0
3.8 47.2 10.9
3.2 53.2 12.0
3.1 55.5 9.7
4.6 36.1 7.9
2.4 24.8 14.0
7.2 33.1 7.6
6.7 47.4 8.5
5.4 54.1 11.3
3.9 36.9 12.7
4.5 58.8 12.3
3.5 27.8 9.8
4.5 40.2 8.4
1.5 13.5 10.1
8.5 56.4 7.1
4.5 71.6 8.2
6.5 52.8 10.9
4.1 44.1 11.2
5.5 40.9 9.4
;
run;

*calculating the Hotelling T-square statistics and p-value;
proc iml;
  use sweat;
  read all var{rate sodium potassium} into X; 
  n=nrow(X); 
  p=ncol(X);
  one=shape(1,n,1); /* column of 1s */
  MeanVec=(one`*X)/n; /* calculate Mean Vector */
  Xbar=repeat(MeanVec,n,1); 
  S=(X-Xbar)`*(X-Xbar)/(n-1); /* calculate Cov Matrix */
  mu0={4 50 10}; /* Test Ho: mu=[4,50,10] Ha: mu not= [4,50,10]; */
  T2=n*(MeanVec-mu0)*inv(S)*(MeanVec-mu0)`; /* Hotelling T-square */
  criticalF=(((n-1)*p)/(n-p))*FINV(0.9, p, n-p);
  F=(n-p)/((n-1)*p)*T2;
  pvalue=1-ProbF(F,p,(n-p)); /* P-value */
  print One MeanVec Xbar S T2 CriticalF pvalue;
run;

*Using PROC GLM******; 
*test H0: MU = 0; 
data sweat; 
set SWEaT; 
Y1=rate-4; 
Y2=sodium-50; 
Y3=potassium-10; 
run; 

proc glm data=sweat; 
model Y1 Y2 Y3 =; 
manova H=intercept; *Multivariate ANOVA; 
run; 
