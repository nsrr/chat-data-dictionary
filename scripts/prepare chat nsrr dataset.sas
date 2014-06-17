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
  length obf_pptid 8.;
  set chatb.redacted_chat_20140501;

  *create obfuscated ID for filenaming conventions;
  obf_pptid = new_pid + 300000;

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

  *recode values to missing;
  if bri10a_tr in (555,999) then bri10a_tr = .;
  if bri10b_tr in (555,999) then bri10b_tr = .;
  if bri10c_tr in (555,999) then bri10c_tr = .;
  if bri11a_tr in (555) then bri11a_tr = .;
  if wra3b in (777) then wra3b = .;
  if wra3a in (777) then wra3a = .;
  If wra2b in (777) then wra2b = .;
  if wra2a in (666) then wra2a = .;
  if vmi6 in (666) then vmi6 = .;
  if vmi5 in (666) then vmi5 = .;
  if vmi4 in (666) then vmi4 = .;
  if nep9c_nepsy in (666,777,888) then nep9c_nepsy = .;
  if nep9b_nepsy in (666,888) then nep9b_nepsy = .;
  if nep11c_nepsy in (666,777,888) then nep11c_nepsy = .;
  if nep11b_nepsy in (666,888) then nep11b_nepsy = .;
  if med5 in (999) then med5 = .;
  if ldl_mg_dl in (-999) then ldl_mg_dl = .;
  if insulin_uil_ml in (-999,-888) then insulin_uil_ml = .;
  if fam9_tot_inches in (0) then fam9_tot_inches = .;
  if fam9 in (0) then fam9 = .;
  if fam10_tot_oz in (0) then fam10_tot_oz = .;
  if fam10 in (0) then fam10 = .;
  if das8h in (666,777) then das8h = .;
  if das8f in (666,777) then das8f = .;
  if das8c in (666,777) then das8c = .;
  if das8b in (666,777) then das8b = .;
  if das8a in (666,777) then das8a = .;
  if das7h in (666) then das7h = .;
  if das7g in (666) then das7g = .;
  if das7f in (666) then das7f = .;
  if das7d in (666) then das7d = .;
  if das7b in (666) then das7b = .;
  if das7a in (666) then das7a = .;
  if das6h in (666) then das6h = .;
  if das6g in (999) then das6g = .;
  if das6f in (666) then das6f = .;
  if das6e in (666) then das6e = .;
  if das6b in (666) then das6b = .;
  if das6a in (666) then das6a = .;
  if das5h in (777) then das5h = .;
  if das5f in (777) then das5f = .;
  if das5c in (777) then das5c = .;
  if das5b in (777) then das5b = .;
  if das5a in (777) then das5a = .;
  if das4h in (666) then das4h = .;

  *remove variables as needed;
  drop  ran8 /* contains original subject code, which is identifiable */
        ethnicity /* has missing subjects, chi3 variable is more complete */
        cbal /* visit number indicator, seemingly no value */
        pho3a2 /* empty variable, no valid data */
        pho4a2 /* empty variable, no valid data */
        med3c2 /* empty variable, no valid data */
        med3d2 /* empty variable, no valid data */
        con17b_tr /* empty variable, no valid data */
        con18b_tr /* empty variable, no valid data */
        bp2a /* dubious worth, does not appear to have been cleaned */
        bp1a /* dubious worth, does not appear to have been cleaned */
        bp3a /* dubious worth, does not appear to have been cleaned */
        ant2 /* dubious worth */
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
