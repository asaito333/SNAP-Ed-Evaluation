/* macro for descriptive stat*/
%let other =age	distance male female numhhd;
%let econ=PercentUne MedianHous MeanSocial MeanSupple MeanCashPu PercentSNA PerCapita PercentPov;
%let agedummy=age18to24 age25to34 age35to44 age45to54 age55to64 age65over;
%let county=Apache Cochise Coconino Gila Graham Greenlee LaPaz Maricopa Mohave Navajo Pima Pinal StCruz Yavapai Yuma;
%let marital=Married Divorced Widowed Separated Nevermarri Unmarriedc;
%let educa=noschool elementary somehs hsged somecolleg college;
%let employ=Employed Selfemploy Unemployed Homemaker Student Retired Unablework;
%let race=White Black Asian AmericanIn Hispanic;
%let smoke=Everydaysm Somedaysmo nosmoke;
%let income=lesss10000 lesss15000 lesss20000 lesss25000 lesss35000 lesss50000 lesss75000 Moree75000;
%let grocery=AllEstabli groceryden Population ppldensity;
%let snaped=Dsnaped contracter contracte0 contracte1;
%let partner=SNAPpartne;

data snaped3.snapdata;
	set snaped3.snapdata;
	logdistance=log(distance);
	if distance>10 then d10=1; else d10=0;
	if distance>25 then d25=1; else d25=0;
	if distance>50 then d50=1; else d50=0;
	if (noschool=1 or elementary=1) then loweduc=1; else lowedu=0;
	run;
proc means data=snaped3.snapdata; var loweduc;run;
data snaped3.snapdata;
	set snaped3.snapdata;
	if loweduc=. then loweduc=0;run;
proc surveylogistic data=snaped3.snapdata; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pcounty &pinteraction snappartne eligbroad1/ link=probit;
	output out=model44 predicted=p44; run;	

data snaped3.eligp;
	set snaped3.elig;
	logdistance=log(distance);
	if distance>10 then d10=1; else d10=0;
	if distance>25 then d25=1; else d25=0;
	if distance>50 then d50=1; else d50=0;
	if (noschool=1 or elementary=1) then loweduc=1; else lowedu=0;
	run;
proc means data=snaped3.eligp;
	var logdistance d10 d25 d50 lowedu;
	run;

/* create macro for probit */
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

%let pdemo= &pagedummy &peduca &pemploy &prace &pincome;

/* probit */
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pcounty / link=probit;
	output out=model11 predicted=p11;
	run;
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pcounty d10 d25 d50 / link=probit;
	output out=model12 predicted=p12;
	run;	
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pcounty distance / link=probit;
	output out=model13 predicted=p13;
	run;	
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pcounty snappartne / link=probit;
	output out=model14 predicted=p14;
	run;	

/* no county */	
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo  / link=probit;
	output out=model21 predicted=p21;
	run;
	
	
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo d10 d25 d50 / link=probit;
	output out=model22 predicted=p22;
	run;	
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo distance / link=probit;
	output out=model23 predicted=p23;
	run;	
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo snappartne / link=probit;
	output out=model24 predicted=p24;
	run;	


data model21;
	set model21;
	if p21>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0;
	run;
data model12;
	set model12;
	if p12>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0;
	run;	
data model13;
	set model13;
	if p13>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0;
	run;
data model14;
	set model14;
	if p14>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0;
	run;
proc freq data=model21;
	title "model21";
	tables correct;
	tables correct*fs;
	tables predfs*fs;
	run;	
proc freq data=model22;
	title "model22";
	tables correct;
	tables correct*fs;
	tables predfs*fs;
	run;	
proc freq data=model13;
	title "model13";
	tables correct;
	tables correct*fs;
	tables predfs*fs;
	run;	
proc freq data=model14;
	title "model14";
	tables correct;
	tables correct*fs;
	tables predfs*fs;
	run;	

/* create macro for probit */
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

%let pdemo= &pagedummy &peduca &pemploy &prace &pincome;

/* probit with marital & interaction */
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pmarital/ link=probit; 
	output out=model31 predicted=p31; run;
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pcounty &pmarital / link=probit;
	output out=model32 predicted=p32; run;	
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pinteraction / link=probit;
	output out=model33 predicted=p33; run;		
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pcounty &pinteraction / link=probit;
	output out=model34 predicted=p34; run;	
data model31; set model31;
	if p31>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;	
data model32; set model32; 
	if p32>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;	
data model33; set model33;
	if p33>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;	
data model34; set model34;
	if p34>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;
proc freq data=model31; title "model31";
	tables correct; tables correct*fs; tables predfs*fs; run;	
proc freq data=model32; title "model32";
	tables correct; tables correct*fs; tables predfs*fs; run;	
proc freq data=model33; title "model33";
	tables correct; tables correct*fs; tables predfs*fs; run;	
proc freq data=model34; title "model34";
	tables correct; tables correct*fs; tables predfs*fs; run;	

/* probit with interaction and exogenous variables */
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo  &pincome &pinteraction/ link=probit; 
	output out=model41 predicted=p41; run;
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo  &pincome &pinteraction d10 d25 d50 / link=probit;
	output out=model42 predicted=p42; run;	
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo  &pincome &pinteraction distance/ link=probit;
	output out=model43 predicted=p43; run;		
proc surveylogistic data=snaped3.eligp; STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo  &pincome &pinteraction snappartne/ link=probit;
	output out=model44 predicted=p44; run;	
	
	
	

		
	
data model41; set model41;
	if p41>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;	
data model42; set model42; 
	if p42>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;	
data model43; set model43;
	if p43>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;	
data model44; set model44;
	if p44>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;
proc freq data=model41; title "model41";
	tables correct; tables correct*fs; tables predfs*fs; run;	
proc freq data=model42; title "model42";
	tables correct; tables correct*fs; tables predfs*fs; run;	
proc freq data=model43; title "model43";
	tables correct; tables correct*fs; tables predfs*fs; run;	
proc freq data=model44; title "model44";
	tables correct; tables correct*fs; tables predfs*fs; run;	
	
proc qlim data=snaped3.pelig;
		STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
		

/* likelihood ratio test */		
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo  / link=probit;
	run;		
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pcounty / link=probit;
	run;	
	
/* 0424 for presentation */
/* create macro for probit */
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

%let pdemo= &pagedummy &peduca &pemploy &prace &pincome;
	
proc surveylogistic data=snaped3.eligp;
	STRATA X_STSTR; CLUSTER X_PSU; WEIGHT X_LLCPWT;
	model fs(event="1.000000000000000") = &pdemo &pinteraction distance / link=probit;
	output out=model1 predicted=p1  ; run;	


data model1; set model1;
	if p1>=0.5 then predfs=1; else predfs=0;
	if fs=predfs then correct=1; else correct=0; run;	

proc freq data=model1; title "model1";
	tables correct; tables correct*fs; tables predfs*fs; run;			
	
		