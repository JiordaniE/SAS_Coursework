 *************************************************
*Jiordani Etienne
*Homework 4
*11/8/22
*************************************************;

*Question 1;

*Make a permanent library;
Libname jretienn '/home/u62112786/myLib';

*Question 2;

*Import dataset;
Filename jretienn URL 'https://www4.stat.ncsu.edu/~online/ST307/Data/jretienn_garment.csv';
proc import datafile = jretienn
replace
DBMS = csv
Out = jretienn.garment;
Getnames =yes;
Run;

*Question 3;

*Sort by day;
Proc sort data = jretienn.garment;
by day;
run; 

*Find mean and SD of wip;
Proc means data = jretienn.garment mean std;
by day;
var wip;
run;

*Question 4;

*rename observations;
data garm;
set jretienn.garment;
if (Department = 'sweing') then Department = "sewing";
if (wip = .) and (day = 'Sunday') then wip = 1009.9;
else if (wip = .) and (day = 'Monday') then wip = 1917.74;
else if (wip = .) and (day = 'Tuesday') then wip = 994.1428571;
else if (wip = .) and (day = 'Wednesday') then wip = 951.3333333;
else if (wip = .) and (day = 'Thursday') then wip = 364.7211968;
else if (wip = .) and (day = 'Saturday') then wip = 305.3159010;
run;

*Question 5;

*Find correlation;
proc corr data = garm;
var team smv actual_productivity;
run;

*Question 6;
Proc sgplot data = garm;
scatter x = team y = actual_productivity/Group = day;
run;

*Question 7;
 
 *Make a simple linear regression with diagnostic plots;
Proc glm data = garm plots = all;
model actual_productivity = team;
run;
*The fitted line regression is Yi = .7833090604	- .0069325098*Teami;

*The slope term isn't statistically significant, because the p-value is low, which means
that we reject the null hypothesis.;

*The normality assumption has not been met because the histogram is left-skewed and 
the quantiles graph only has a moderately strong positive linear relationship.;

*Question 8;

*Make a multiple linear regression with diagnostic plots;
Proc glm data = garm plots = all;
model actual_productivity = team smv team*smv;
run;