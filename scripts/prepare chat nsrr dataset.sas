*preparing CHAT dataset for NSRR release;

*set options;
options nofmterr;

*create macro date variables;
data _null_;
  call symput("datetoday",put("&sysdate"d,mmddyy8.));
  call symput("date6",put("&sysdate"d,mmddyy6.));
  call symput("date10",put("&sysdate"d,mmddyy10.));
  call symput("filedate",put("&sysdate"d,yymmdd10.));
  call symput("sasfiledate",put(year("&sysdate"d),4.)||put(month("&sysdate"d),z2.)||put(day("&sysdate"d),z2.));
run;

*create macro variable for release number;
%let release = 0.1.0.beta1;

*set library to BioLINCC CHAT dataset;
libname chatb "\\rfa01\bwh-sleepepi-chat\nsrr-prep\_datasets\biolincc-master";

*set latest dataset based upon most recent release;
data chat_latest;
  set chatb.redacted_chat_20140501;
run;

*split dataset into two parts based on 'vnum';
data chatbaseline chatend;
  set chat_latest;

  *visit number is 'vnum';
  if vnum = 3 then output chatbaseline;
  if vnum = 10 then output chatend;
run;

*set library for permanent CHAT NSRR datasets;
libname chatn "\\rfa01\bwh-sleepepi-chat\nsrr-prep\_datasets";

*save dated permanent SAS datasets;
data chatn.chatbaseline_&release_&sasfiledate;
  set chatbaseline;
run;

data chatn.chatend_&release_&sasfiledate;
  set chatend;
run;

*export to csv;
proc export data=chatbaseline
  outfile="\\rfa01\bwh-sleepepi-chat\nsrr-prep\_datasets\nsrr-csvs\chatbaseline_&release..csv"
  dbms=csv
  replace;
run;

proc export data=chatend
  outfile="\\rfa01\bwh-sleepepi-chat\nsrr-prep\_datasets\nsrr-csvs\chatend_&release..csv"
  dbms=csv
  replace;
run;
