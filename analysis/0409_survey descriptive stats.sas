/* import data cleaned in R */
/* as of 0409 */

PROC IMPORT DATAFILE="/home/asaito10/SNAP-Ed2/snapdata2.csv"
		    OUT=snaped3.snap
		    DBMS=csv
		    REPLACE;
RUN;

proc contents data=snaped3.snap;run;
proc means data=snaped3.snap n nmiss; run;

/* descriptive statistics was done for the samples regardless of year */

/* 1bii:F&V: what is the range of survey responses? */
PROC SURVEYMEANS DATA=snaped3.snap MEAN STDERR min q1 median q3 max clm;
  STRATA X_STSTR; 
  CLUSTER X_PSU;
  WEIGHT X_LLCPWT;
  class YEAR;
    VAR X_FRUTSUM X_VEGESUM servings;
RUN;

/* 1c:F&V: create 4 histograms of F&V intake for 2011 and 2013 */
/* subrgoups; eligible and ineligible */

/* create subgroups */
data elig;
	set snaped3.snap;
	where eligbroad1=1;
	run;
data inelig;
	set snaped3.snap;
	where eligbroad1=0;
	run;
proc freq data=elig;
	tables eligbroad1;
	run;
proc freq data=inelig;
	tables eligbroad1;
	run;
	
/* create histogram of each variable for each group */

/* figure out the range for x-axis */
/* x_frutsum:1300, x_vegesum:1800, servings:3000 */
proc surveymeans data=snaped3.snap min median q3 quantile=(0.9, 0.95, 0.99, 0.995, 1 );
  STRATA X_STSTR; 
  CLUSTER X_PSU;
  WEIGHT X_LLCPWT;
  class YEAR;
    VAR X_FRUTSUM X_VEGESUM servings;
run;
proc surveymeans data=snaped3.snap;
	STRATA X_STSTR; 
  CLUSTER X_PSU;
  WEIGHT X_LLCPWT;
  var x_vegesum;
  
  run;
proc print data=snaped3.snap;
	var x_vegesum ;
	where x_vegesum>1000;
	run;
	
/* histogram */

/* garbage start */
/* http://support.sas.com/resources/papers/proceedings12/349-2012.pdf */
proc surveymeans data=snaped3.snap;
STRATA X_STSTR; 
  CLUSTER X_PSU;
  WEIGHT X_LLCPWT;
var x_frutsum;
ods output outstat ;
run ;
proc sgplot data=outstat;
band x=x_frutsum lower=lowerclmean upper=upperclmean / legendlabel="95% CLI" ;
run ;

proc surveymeans data=snaped3.snap ;
   STRATA X_STSTR; 
  CLUSTER X_PSU;
  WEIGHT X_LLCPWT;
var x_frutsum;
  ods output Statistics=MyStat;
run;
proc sgplot data=Mystat;
histogram mean;
	run;
/* garbage end*/

/* 2a:covariates: means and se by fs=0 and 1 */
proc sort data=snaped3.snap;
	by fs;
	run;

/* macro for descriptive stats variable groups */
%let educaemploy=	elementary somehs hsged somecollege college employed selfemployed unemployed homemaker student unablework retired;
%let race = black asian americanindian hispanic other white;
%let maritalsex = married divorced widowed separated nevermarried unmarriedcouple male;
%let county = apache cochise coconino gila graham greenlee lapaz mohave navajo pima pinal stcruz yavapai yuma maricopa;
%let income = lesss10000 lesss15000 lesss20000 lesss25000 lesss35000 lesss50000 lesss75000 Moree75000;
%let agedummy = age18to24 age25to34 age35to44 age45to54 age55to64 age65over;
%let interaction = mmarried	mdivorced	mwidowed	mseparated	mnevermarried	munmarried	fdivorced	fwidowed	fseparated	fnevermarried	funmarried;



proc surveymeans data=snaped3.snap ;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	var age &educaemploy &race &maritalsex &county &income;
	by fs;
run;

/* t-test */
/* later */

/* unique zip1 */
proc sort data=new nodupkey out=new1;
	by zip1;run;
	
proc print data=new1;run;
	
data new;
	set snaped3.snap (keep=zip1);
	run;

