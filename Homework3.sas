**********************************
*Jiordani Etienne
*Homework 3
*10/25/2022
***********************************;
*Conceptual Questions:

*Question 1: The difference between a Proc Univariate and Proc Means is that 
Proc Univariate throws all of the summary statistics at you, while Proc Means 
Lets you choose what summary statistics you want to be displayed.;

*Question 2: Proc SGPlot makes only one graph, while Proc SGPanel makes multiple graphs.

*Programming Questions:;

*Question 1;

*Create a permanent library;
Libname jretienn '/home/u62112786/myLib';

*Question 2;

*Return Question 3 Homework 2;
Data Beans1;
	Set Jretienn.beans;
	Drop EquivDiameter Extent;
	Rename MajorAxisLength=LengthMaj 
	MinorAxisLength=LengthMin;
	Label Solidity = 'Ratio Of Pixels In The Convex Shell To Beans' Area = 
	'Area Of Bean Zone And Pixels Within Boundaries' 
	Eccentricity = 'Eccentricity Of The Ellipse';
	Where Class IN ('DERMASON', 'BOMBAY', 'HOROZ', 'SIRA', 'SEKER');
	Average = Mean(MajorAxisLength, MinorAxisLength);
	Length Round $7;
	If (Roundness >.9086091) Then Round = "Large";
	Else If (Roundness>.8713247 And Roundness<=.9086091) Then Round = "Middle";
	Else Round = "Small";
Run;

*Question 3;

*Create a two-way contingency table;
Proc freq Data = Beans1;
Where  LengthMaj < 390.7171;
Table Class*Round / Expected NoCol NoRow;
Run;

*The top number 1428 represents the frequency of which the computer found that the
dry beans are both in the class Dermason and the roundness was calculated to be
considered large, given that the longest length that can be drawn on the beans were
less than 390.7171. The roundness must have been at least .9086091.

*The middle number 784.1 represents the expected counts of which the class is 
Dermason and the roundness was calculated to be considered large are predicted to be, all
given that the longest length that can be drawn on the beans were less than 390.7171.

*The bottom number 26.95 is the percentage of which the class of beans Dermason and
roundness was calculated the be large appears in the contingency table, all given
that the longest length that can be drawn on the beans were less than 390.7171.;

*Question 4;

*Make summary statistics for Area and Perimeter Variables for all classes of beans;
Proc Means Data = beans1 StdDev P5 Var Median;
Class Class;
Var Area Perimeter;
Run;

*Question 5;

*Make a spearman correlation;
Proc Corr Data = Beans1 Spearman;
Var Area Perimeter AspectRatio Eccentricity ConvexArea;
Run;

*Question 6;

*Create a bar plot;
Proc SGPlot Data = beans1;
VBar Class/Group = Round GroupDisplay = Cluster;
Run;

*Question 7;

*Create a histogram about solidity;
Proc SGPlot Data = Beans1;
Histogram Solidity/ Datalabel = Count;
Density Solidity /Type = Kernel;
Run;

*Question 8;

*Create a histogram about class;
Proc SGPanel Data = Beans1;
PanelBy Class;
Histogram Solidity/ Group = Class Datalabel = Count Transparency = .6;
Density Solidity /Type = Kernel;
Run;
