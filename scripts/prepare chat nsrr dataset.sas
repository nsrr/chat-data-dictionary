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
%let release = 0.1.0.beta2;

*set library to BioLINCC CHAT dataset;
libname chatb "\\rfa01\bwh-sleepepi-chat\nsrr-prep\_datasets\biolincc-master";

*set latest dataset based upon most recent release;
data chat_latest;
  set chatb.redacted_chat_20140501;

  *retain race3 variable to get it in followup dataset;
  retain race3retain;
  if vnum = 3 then race3retain = race3;
  if vnum = 10 then race3 = race3retain;
  drop race3retain;

  *retain male variable to get it in followup dataset;
  retain maleretain;
  if vnum = 3 then maleretain = male;
  if vnum = 10 then male = maleretain;
  drop maleretain;

  *remove variables as needed;
  drop  ran8 /* contains original subject code, which is identifiable */
        ethnicity /* has missing subjects, chi3 variable is more complete */
        cbal /* visit number indicator, seemingly no value */
        pho3a2 /* empty variable, no valid data */
        pho4a2 /* empty variable, no valid data */
        ;
run;


*split dataset into two parts based on 'vnum';
data chatbaseline chatfollowup;
  set chat_latest;

  *visit number is 'vnum';
  if vnum = 3 then output chatbaseline;
  if vnum = 10 then output chatfollowup;
run;

*set library for permanent CHAT NSRR datasets;
libname chatn "\\rfa01\bwh-sleepepi-chat\nsrr-prep\_datasets";

*save dated permanent SAS datasets;
data chatn.chatbaseline_&release_&sasfiledate;
  set chatbaseline;
run;

data chatn.chatfollowup_&release_&sasfiledate;
  set chatend;
run;

*export to csv;
proc export data=chatbaseline
  outfile="\\rfa01\bwh-sleepepi-chat\nsrr-prep\_datasets\nsrr-csvs\chat-baseline-dataset-&release..csv"
  dbms=csv
  replace;
run;

proc export data=chatfollowup
  outfile="\\rfa01\bwh-sleepepi-chat\nsrr-prep\_datasets\nsrr-csvs\chat-followup-dataset-&release..csv"
  dbms=csv
  replace;
run;
