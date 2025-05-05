*******************************************
*Jiordani Etienne
*Homework 2
*******************************************;
*Question 1;
*Create a permanant library;
Libname Jretienn '/home/u62112786/myLib';

*Question 2;
*Read in excel file;
Proc Import Datafile = '/home/u62112786/myLib/jretienn_beans.xlsx'
	Replace
	DBMS = xlsx
	Out = Jretienn.beans;
	Getnames = Yes;
Run;

*Question3;
*Create a temporary dataset, dropping variables, renaming variables, labeling variables, and
including certain variables;
Data Beans1;
	Set Jretienn.beans;
	Drop EquivDiameter Extent;
	Rename MajorAxisLength=LengthMaj 
	MinorAxisLength=LengthMin;
	Label Solidity = 'Ratio Of Pixels In The Convex Shell To Beans' Area = 
	'Area Of Bean Zone And Pixels Within Boundaries' 
	Eccentricity = 'Eccentricity Of The Ellipse';
	Where Class IN ('DERMASON', 'BOMBAY', 'HOROZ', 'SIRA', 'SEEKER');
	Average = Mean(MajorAxisLength, MinorAxisLength);
	Length Round $7;
	If (Roundness >.9086091) Then Round = "Large";
	Else If (Roundness>.8713247 And Roundness<=.9086091) Then Round = "Middle";
	Else Round = "Small";
Run;

*Question 4;
*Sort data;
Proc Sort Data = Beans1 Out = SortedBeans1;
	By DESCENDING Solidity;
Run;

*Print data;
Proc Print Data = SortedBeans1 Label;
	Var Class Round Solidity Area Eccentricity;
Run;

*First Printed observation's value of class is Bombay and solidity is 0.9946774999;
	