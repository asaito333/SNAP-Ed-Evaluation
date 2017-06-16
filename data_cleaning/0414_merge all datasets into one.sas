/** 2011  **/
/* # of var; */
/* pop(7), gro(17), ori(107), merged(127) */
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/grocery2011.dbf"
		    OUT=snaped3.grocery2011
		    DBMS=dbf
		    REPLACE;
RUN;
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/origecon2011.dbf"
		    OUT=snaped3.origecon2011
		    DBMS=dbf
		    REPLACE;
RUN;
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/population2011.dbf"
		    OUT=snaped3.population2011
		    DBMS=dbf
		    REPLACE;
RUN;

proc contents data=snaped3.population2011;run;
proc contents data=snaped3.grocery2011;run;
proc contents data=snaped3.origecon2011;run;

proc sql;
	create table data1 as
	select *
	from snaped3.origecon2011 as a
	left join snaped3.grocery2011 as b
	on a.zip1=b.zip;
	quit;

proc sql;
	create table data2 as
	select *
	from data1
	left join snaped3.population2011 as c
	on data1.zip1=c.zip;
	quit;
	
proc contents data=data2;run;


/** 2013 **/
/* # of var; */
/* pop(7), gro(17), ori(107), merged(127) */
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/grocery2013.dbf"
		    OUT=snaped3.grocery2013
		    DBMS=dbf
		    REPLACE;
RUN;
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/origecon2013.dbf"
		    OUT=snaped3.origecon2013
		    DBMS=dbf
		    REPLACE;
RUN;
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/population2013.dbf"
		    OUT=snaped3.population2013
		    DBMS=dbf
		    REPLACE;
RUN;

proc contents data=snaped3.population2013;run;
proc contents data=snaped3.grocery2013;run;
proc contents data=snaped3.origecon2013;run;


proc sql;
	create table data3 as
	select *
	from snaped3.origecon2013 as d
	left join snaped3.grocery2013  as e
	on d.zip1=e.zip;
	quit;

proc sql;
	create table data4 as
	select *
	from data3
	left join snaped3.population2013 as f
	on data3.zip1=f.zip;
	quit;
	
proc contents data=data4;run;

data snaped3.data2011;
	set data2;
	year=2011;
	run;
data snaped3.data2013;
	set data4;
	year=2013;
	run;
	
/* 0414 add SNAPEd and SNAP partner variables */
/* SNAP Ed */
proc freq data=snaped3.data2011;
	tables ctycode1;
	run;
proc freq data=snaped3.data2013;
	tables ctycode1;
	run;
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/snaped2011.xlsx"
		    OUT=snaped2011
		    DBMS=xlsx
		    REPLACE;
RUN;
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/snaped2013.xlsx"
		    OUT=snaped2013
		    DBMS=xlsx
		    REPLACE;
RUN;

proc contents data=snaped3.snaped2011;run;
proc contents data=snaped3.snaped2013;run;


proc sql;
	create table data5 as
	select *
	from data2 
	left join snaped2011 
	on data2.ctycode1=snaped2011.countycode;
	quit;
proc contents data=data5;run;	
proc means data=data5 mean min max n nmiss;
	var Dsnaped contracters contracterperppl contracterpersqmi ctycode1;
	run;
data snaped3.data2011;
	set data5;
	run;

proc sql;
	create table data6 as
	select *
	from data4 
	left join snaped2013 
	on data4.ctycode1=snaped2013.countycode;
	quit;
proc contents data=data6;run;
proc means data=data6 mean min max n nmiss;
	var Dsnaped contracters contracterperppl contracterpersqmi ctycode1;
	run;
data snaped3.data2013;
	set data6;
	run;

/* snap partner */
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/SNAPPartners11.xlsx"
		    OUT=partners11
		    DBMS=xlsx
		    REPLACE;
RUN;
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/SNAPpartners13.xlsx"
		    OUT=partners13
		    DBMS=xlsx
		    REPLACE;
RUN;
proc contents data=partners11;run;
proc contents data=partners13;run;

proc sql;
	create table data11 as
	select *
	from data5 
	left join partners11
	on data5.zip1=partners11.zip;
	quit;
proc means data=data11 mean min max n nmiss; var zip1 SNAPpartner;run;
data snaped3.data2011;
	set data11;
	if SNAPpartner=. thenn SNAPpartner=0;
	run;
proc means data=snaped3.data2011 mean min max n nmiss; var zip1 SNAPpartner;run;


proc sql;
	create table data13 as
	select *
	from data6 
	left join partners13
	on data6.zip1=partners13.zip;
	quit;
proc means data=data13 mean min max n nmiss; var zip1 SNAPpartner;run;
data snaped3.data2013;
	set data13;
	if SNAPpartner=. then SNAPpartner=0;
	run;
proc means data=snaped3.data2013 mean min max n nmiss; var ctycode1 zip1 SNAPpartner;run;


proc freq data=snaped3.data2011;
	tables snappartner;
	run;
proc freq data=snaped3.data2013;
	tables snappartner;
	run;

data test;
	set snaped3.data2013;
	GEO_id2 =input(GEO_id, 8.);
	drop GEO_id;
	rename GEO_id2=GEO_id;
	GEO_displa2=input(GEO_displa,8.);
	drop GEO_displa;
	rename GEO_displa2=GEO_displa;
	NAICS_disp2=input(NAICS_disp, 8.);
	drop NAICS_disp;
	rename NAICS_disp2=NAICS_disp;
	NAICS_disp2=input(NAICS_disp, 8.);
	drop NAICS_disp;
	rename NAICS_disp2=NAICS_disp;
	EMPSZES_di2=input(EMPSZES_di, 8.);
	drop EMPSZES_di;
	rename EMPSZES_di2=EMPSZES_di;
	Id2=input(Id, 8.);
	drop Id;
	rename Id2=Id;
	Geography2=input(Geography, 8.);
	drop Geography;
	rename Geography2=Geography;
	run;
	
	
proc contents data=test;run;

proc contents data=snaped3.data2011;run;
proc contents data=snaped3.data2013;run;
	
proc freq data=snaped3.data2013;
	tables marital;run;	


proc freq data=snaped3.data2013;
	tables income2;run;
	
/* import merged data (2011&2013) */
PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed3/snapdata.dbf"
		    OUT=snapdata
		    DBMS=dbf
		    REPLACE;
RUN;


data new;
	set snapdata;
	if fsother=1 then delete;
	if noage=1 then delete;
	if maritaloth=1 then delete;
	if income2oth=1 then delete;
	if educaother=1 then delete;
	if employothe=1 then delete;
	if cityother=1 then delete;
	run;

proc freq data=new;
	tables eligbroad1*year;run;

proc means data=new1 n nmiss;run;

data new1;
	set new;
	if allestabli=. then allestabli=0;
	if groceryden=. then groceryden=0;
	if x_frutsum>1600 then delete;
	if x_vegesum>2300 then delete;
	run;
proc means data=new1;
	var x_frutsum x_vegesum;run;
	
data snaped3.snapdata;
	set new1;
	run;
	
proc contents data=snaped3.snapdata;run;