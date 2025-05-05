************************************
Jiordani Etienne
Simple Regression Project
11/29/2022
************************************;

*Make a library;
libname Regpro '/home/u62112786/EC 351';

*Import SimplReg;
Filename Regpro '/home/u62112786/EC 351/SimplReg.xlsx';

Proc Import datafile = '/home/u62112786/EC 351/SimplReg.xlsx'
Replace
DBMS = xlsx
Out = Regpro.SimplReg;
Getnames = yes;
Run;

*Make a histogram of median income;
Proc SGPlot data = RegPro.SimplReg;
Histogram Income/ Binwidth= 10000;
Run;

*Make a regression of education of individuals with a high school diploma or 
higher and poverty;
Proc SGPlot data = Regpro.SimplReg;
Reg x = Education y = Poverty;
Run;

*Make a regression analysis of education of individuals with a high school diploma
or higher and poverty;
Proc GLM data = RegPro.SimplReg plots = all;
Model Poverty = Education;
Run;

*Make a histogram of education;
Proc SGPlot data = RegPro.SimplReg;
Histogram Education;
Run;

*Make a histogram of governor political affliation;
Proc SGPlot data = RegPro.SimplReg;
Histogram Governor/Binwidth = 1;
Run;

*Make a histogram of employment rate;
Proc SGPlot data = RegPro.SimplReg;
Histogram EmpRt;
Run;

*Make a multiple linear regression of median income, education, governor political 
affiliation, employment rate, and poverty;
Proc GLM data = Regpro.SimplReg plots = all;
Model Poverty = Income Education Governor EmpRt /clparm cli;
Run;