proc contents data=snaped.econ_char_2011;run;
proc contents data=snaped.econ_char_2013;run;
proc means data=snaped2.original2011 n nmiss; var zip1;run;
proc means data=snaped2.original2013 mean min max n nmiss; var zip1;run;
proc means data=snaped2.orig_econ_2013 mean min max n nimss; var zip1;run;

1. BRFSS
BRFSS 2011:
raw: snaped.original2011
cleaned for zip1:snaped2.original2011

BRFSS 2013:
raw: snaped.original2013
cleaned for zip1:snaped2.original2013

2. Economic Characteristics
Economic Characteristics 2011:
raw: snaped.econchara2011_raw
cleaned: snaped.econ_char_2011  (zip=numeric)(n=408, var=10)


Economic Characteristics 2013:
raw: snaped.econchara2013
cleaned: snaped.econ_char_2013 (zip=numeric) (n=408, var=12)


3. Econ+orig
snaped2.orig_econ_2011 -> orig.econ.2011.csv
snaped2.orig_econ_2013 -> orig.econ.2013.csv

5.6.7.
snaped3.grocery2011
snaped3.g