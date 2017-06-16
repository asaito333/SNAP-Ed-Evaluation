/* create macro for probit */
%let pagedummy=age18to24 age25to34 age35to44 age45to54 age55to64;
%let peduca=loweduc somehs hsged somecolleg;
%let pemploy=Employed Selfemploy Unemployed Homemaker Student Unablework;
%let prace=Black Asian AmericanIn Hispanic;
%let pincome=lesss10000 lesss15000 lesss20000 lesss25000 lesss35000 lesss50000 ;

%let pcounty=Apache Cochise Coconino Gila Graham Greenlee LaPaz Mohave Navajo Pima Pinal StCruz Yavapai Yuma;

%let pmarital=male Divorced Widowed Separated Nevermarri Unmarriedc; 
%let pinteraction=mdivorced mwidowed mseparated mnevermarr munmarried mmarried fdivorced fwidowed fseparated fnevermarr funmarried;

%let pdistance=distance logdistance d10 d25 d50;
%let partner=SNAPpartne;

%let pdemo= &pagedummy &peduca &pemploy &prace ;

/*try
(a) personal characteristics from the BRFSS (e.g. education, marital status, income, employment status, etc.)
(b) grocery store density (try both per person or per square mile, separately) 
(c) try different SNAP-Ed variables separately
(d) include SNAP (0/1 variable), but NOT distance of SNAP partner variables
(e) try with and without county dummies */

data snaped3.eligp;
	set snaped3.eligp;
	if loweduc=. then loweduc=0;
	groceryperperson=allestabli/sqmi;
	run;

/*** with county ***/

/* base */
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction &pcounty fs; title "base model";
	run;

/* grocery */	
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction &pcounty fs allestabli; title "base + # of grocery store";
	run;	
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction &pcounty fs groceryden; title "base + grocery per sqmi";
	run;
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction &pcounty fs groceryperperson; title "base + grocery per person";
	run;

/* snap ed */
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction &pcounty fs Dsnaped; title "base + SNAPED dummy";
	run;	
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction &pcounty fs contracte0; title "base + SNAPEd per sqmi";
	run;
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction &pcounty fs contracte1; title "base + SNAPEd per person";
	run;

data snaped3.eligp;
	set snaped3.eligp;
	if (lesss75000=1 or Moree75000=1) then moree50000=1; else moree50000=0;
	contracte11=contracte1*1000000;
	run;
	proc means data=snaped3.eligp; var moree50000 contracte11;run;
	
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction  contracte11 ; title "base + SNAPEd per person";
	run;

proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs contracte1; title "base + SNAPEd per person";
	run;	

	
proc surveyreg data=snaped3.snapdata plots=all;STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pincome;
	run;


	

/*** no county ***/

/* base */
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs; title "base model";
	run;

/* grocery */	
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs allestabli; title "base + # of grocery store";
	run;	
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs groceryden; title "base + grocery per sqmi";
	run;
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs groceryperperson; title "base + grocery per person";
	run;

/* snap ed */
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs Dsnaped; title "base + SNAPED dummy";
	run;	
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs contracte0; title "base + SNAPEd per sqmi";
	run;
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs contracte1; title "base + SNAPEd per person";
	run;	
	

/* with whole sample */	
data snaped3.snapdata;
	set snaped3.snapdata;
	groceryperperson=allestabli/sqmi;run;
data snaped3.snapdata;
	set snaped3.snapdata;
	if (lesss75000=1 or Moree75000=1) then moree50000=1; else moree50000=0;
	if year=2011 then d2011=1; else d2011=0;
	run;
proc means	data=snaped3.snapdata; var moree50000 d2011;run;

proc surveyreg data=snaped3.snapdata; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs contracte1 groceryperperson &pincome d2011; title "base + SNAPEd per person";
	run;
	
data snaped3.snapdata;
	set snaped3.snapdata;
	distancesq=distance*distance;
	run;
proc surveyreg data=snaped3.snapdata; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=&pdemo &pinteraction fs contracte1 groceryperperson &pincome d2011; title "base + SNAPEd per person";
	run;
	
data snaped3.eligp;
	set snaped3.eligp;
	distancesq=distance*distance;
	run;
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pinteraction distance distancesq/ link=probit;
	output out=model44 predicted=p44; run;	
		
	
proc means data=snaped3.snapdata; var &pincome;run;	

%let pincome=lesss10000 lesss15000 lesss20000 lesss25000 lesss35000 lesss50000 ;
data lesss10000;
	set snaped3.snapdata (keep=servings lesss10000 X_STSTR  X_PSU X_LLCPWT);
	where lesss10000=1;
	income=10000;
	drop lesss10000;
	run;
data lesss15000;
	set snaped3.snapdata (keep=servings lesss15000 X_STSTR  X_PSU X_LLCPWT);
	where lesss15000=1;
	income=15000;
	drop lesss15000;
	run;	
data lesss20000;
	set snaped3.snapdata (keep=servings lesss20000 X_STSTR  X_PSU X_LLCPWT);
	where lesss20000=1;
	income=20000;
	drop lesss20000;
	run;	
data lesss25000;
	set snaped3.snapdata (keep=servings lesss25000 X_STSTR  X_PSU X_LLCPWT);
	where lesss25000=1;
	income=25000;
	drop lesss25000;
	run;	
data lesss35000;
	set snaped3.snapdata (keep=servings lesss35000 X_STSTR  X_PSU X_LLCPWT);
	where lesss35000=1;
	income=35000;
	drop lesss35000;
	run;	
data lesss50000;
	set snaped3.snapdata (keep=servings lesss50000 X_STSTR  X_PSU X_LLCPWT);
	where lesss50000=1;
	income=50000;
	drop lesss50000;
	run;	
data lesss75000;
	set snaped3.snapdata (keep=servings lesss75000 X_STSTR  X_PSU X_LLCPWT);
	where lesss75000=1;
	income=75000;
	drop lesss75000;
	run;	
data moree75000;
	set snaped3.snapdata (keep=servings moree75000 X_STSTR  X_PSU X_LLCPWT);
	where moree75000=1;
	income=90000;
	drop moree75000;
	run;	

data new;
	set lesss10000 lesss15000 lesss20000 lesss25000 lesss35000 lesss50000 moree75000;
	run;


proc surveyreg data=new plots=all; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings=income;run;
	
ods graphics on;
proc corr data=new nomiss
          plots(maxpoints=7000)=scatter(nvar=2 alpha=.20 .30);
   var income servings;
run;
ods graphics off;	

 ods listing style=listing;  
   proc sgplot data=snaped3.snapdata;
      scatter x=income2 y=servings / group=income2;
      title "servings by income group";
   run;
  proc sgplot data=snaped3.snapdata;
      scatter x=income2 y=servings / group=income2;
      title "servings<1000 by income group";
      where servings<1000;
   run;
  
  proc surveyreg data=snaped3.snapdata; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	class income2;
	model servings=income2/solution;
	run;

%let pagedummy=age18to24 age25to34 age35to44 age45to54 age55to64;
%let peduca=loweduc somehs hsged somecolleg;
%let pemploy=Employed Selfemploy Unemployed Homemaker Student Unablework;
%let prace=Black Asian AmericanIn Hispanic;
%let pincome=lesss10000 lesss15000 lesss20000 lesss25000 lesss35000 lesss50000 lesss75000;

%let pcounty=Apache Cochise Coconino Gila Graham Greenlee LaPaz Mohave Navajo Pima Pinal StCruz Yavapai Yuma;

%let pmarital=male Divorced Widowed Separated Nevermarri Unmarriedc; 
%let pinteraction=mdivorced mwidowed mseparated mnevermarr munmarried mmarried fdivorced fwidowed fseparated fnevermarr funmarried;

%let pdistance=distance logdistance d10 d25 d50;
%let partner=SNAPpartne;

%let pdemo= &pagedummy &peduca &pemploy &prace;

/* 0424 for presentation */
data snaped3.eligp;
	set snaped3.eligp;
	eliged=eligbroad1*dsnaped;
	eligcon0=eligbroad1*contracte0;
	eligcon1=eligbroad1*contracte1;
	run;
proc means data=snaped3.snapdata; var eliged eligcon0 eligcon1;run;	
	
proc surveyreg data=snaped3.snapdata; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings= &pdemo  &pincome &pinteraction fs eliged;run; 
  
proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings= &pdemo  &pinteraction fs eliged eligcon0 eligcon1 groceryperperson;run; 


proc surveyreg data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model servings= fs;run;    