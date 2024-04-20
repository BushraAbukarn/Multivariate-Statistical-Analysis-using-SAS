*Q1;
data antidepressant; 
input TOT AMI GEN AMT PR DIAP QRS; 
cards; 
  3389  3149  1  7500  220  0  140
  1101  653  1  1975  200  0  100
  1131  810  0  3600  205  60  111
  596  448  1  675  160  60  120
  896  844  1  750  185  70  83
  1767  1450  1  2500  180  60  80
  807  493  1  350  154  80  98
  1111  941  0  1500  200  70  93
  645  547  1  375  137  60  105
  628  392  1  1050  167  60  74
  1360  1283  1  3000  180  60  80
  652  458  1  450  160  64  60
  860  722  1  1750  135  90  79
  500  384  0  2000  160  60  80
  781  501  0  4500  180  0  100
  1070  405  0  1500  170  90  120
  1754  1520  1  3000  180  0  129
;
run; 
options ods_graphics;

proc glm data=antidepressant plots=all; 
class GEN; 
model TOT AMI = AMT PR DIAP QRS / solution ss2;
manova h=_ALL_;
run; 

*Q3;
*a;
proc import out=CountryTrack datafile="C:\Users\bushr\OneDrive\Desktop\CountryTrack.csv"
dbms=csv replace; getnames=yes;
data CountryTrack;
set CountryTrack;
t100L10=log10(t100); 
t200L10=log10(t200); 
t400L10=log10(t400); 
t800L10=log10(t800); 
t1500L10=log10(t1500); 
t5000L10=log10(t5000); 
t10000L10=log10(t10000); 
tMaraphonL10=log10(tMaraphon); 
run; 
ods graphics on / reset height=3in width=6in; 
proc princomp data=CountryTrack cov out=ct; 
var t100L10 t200L10 t400L10 t800L10 t1500L10 t5000L10 t10000L10 tMaraphonL10;
run; 
ods graphics off; 
*b;
proc corr data=ct noprob;
var prin1 prin2 prin3 t100L10 t200L10 t400L10 t800L10 t1500L10 t5000L10 t10000L10 tMaraphonL10;
run;
*d; 
ods graphics on/ reset=all height=4in width=4in; 
proc sgplot data=ct;
scatter x=prin1 y=prin2; 
run;
ods graphics off;
*Q5; 
data SalesPeople; 
infile "C:\Users\bushr\OneDrive\Desktop\SalesPeople.dat"; 
input SalesGrowth SalesProfit NewAccountSales CreativityTest MechanicalTest AbstractTest MathTest; 
SalesGrowthL10=log10(SalesGrowth); 
SalesProfitL10=log10(SalesProfit); 
NewAccountSalesL10=log10(NewAccountSales); 
CreativityTestL10=log10(CreativityTest); 
MechanicalTestL10=log10(MechanicalTest); 
AbstractTestL10=log10(AbstractTest); 
MathTestL10=log10(MathTest); 
run; 
*a; 
proc factor method=principal nfactors=2
rotate=varimax  corr residuals; 
var SalesGrowthL10 SalesProfitL10 NewAccountSalesL10 CreativityTestL10 MechanicalTestL10 AbstractTestL10 MathTestL10; 
run; 
*b m=2; 
proc factor method=ml nfactors=2 heywood; 
var SalesGrowthL10 SalesProfitL10 NewAccountSalesL10 CreativityTestL10 MechanicalTestL10 AbstractTestL10 MathTestL10; 
run;
*m=3; 
proc factor method=ml nfactors=3 heywood; 
var SalesGrowthL10 SalesProfitL10 NewAccountSalesL10 CreativityTestL10 MechanicalTestL10 AbstractTestL10 MathTestL10; 
run;
