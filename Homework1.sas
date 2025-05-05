*****************
*Jiordani Etienne
*Homework 1
*****************;

*Question 1
*Creating a library;

Libname JRETIENN '/home/u62112786/myLib';

*Question 2
*Saving data from csv to sas;

Filename Jretienn URL ' https://www4.stat.ncsu.edu/~online/ST307/Data/jretienn_glass.csv';

Proc Import DataFile = Jretienn
	DBMS = csv
	OUT = Jretienn.Glass;
	Getnames = Yes;
GuessingRows = Max;

Run;

Proc Sort Data = Jretienn.Glass OUT = sortedGlass;

By Ba;

Run;

Proc Print Data = sortedGlass;

Run;

*The first value of Ba is 0;

*Question 3;
*Saving data from tsv to sas;

Filename Jretienn URL ' https://www4.stat.ncsu.edu/~online/ST307/Data/jretienn_zoo.tsv';

Proc Import DataFile = Jretienn
	DBMS = tab
	OUT = Jretienn.Zoo;
	GETNAMES = No;
GuessingRows = Max;

Run;

*Naming variables;

Data Jretienn.Zoo;
	Set Jretienn.Zoo;
	Rename Var1 = Venomous
		   Var2 = Eggs
		   Var3 = Domestic
		   Var4 = Legs
		   Var5 = Feathers
		   Var6 = Milk;
		   
Run;

*The first value of Venomous is 0;

*Question 4;
*Saving data from xlsx to sas;

Filename Jretienn  '/home/u62112786/myLib/jretienn_balance-scale.xlsx';

Proc Import Datafile = Jretienn
	DBMS = xlsx
	OUT = Jretienn.Balance;
	Getnames = Yes;
	
Run;


*Copying excel sheet into WORK library;

Libname Jretienn xlsx '/home/u62112786/myLib/jretienn_balance-scale.xlsx';

Proc Import Datafile = Jretienn
	DBMS = xlsx
	OUT = Balance;
	Getnames = Yes;

Run;