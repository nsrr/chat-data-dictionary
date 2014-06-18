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
%let release = 0.1.0.beta3;

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

  *remove values for 'par2r' and 'par4r' at follow-up -- only needed on baseline dataset;
  if vnum = 10 then do;
    par2r = .;
    par4r = .;
  end;

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
  if das4g in (666) then das4g = .;
  if das4f in (666) then das4f = .;
  if das4e in (666) then das4e = .;
  if das4b in (666) then das4b = .;
  if das4a in (666) then das4a = .;
  if das12g in (666) then das12g = .;
  if das12f in (666,777) then das12f = .;
  if das12e in (666) then das12e = .;
  if das12d in (666) then das12d = .;
  if das12c in (666,777) then das12c = .;
  if das11g in (666) then das11g = .;
  if das11f in (666,777) then das11f = .;
  if das11e in (666) then das11e = .;
  if das11d in (666) then das11d = .;
  if das11c in (666,777) then das11c = .;
  if das10g in (666) then das10g = .;
  if das10f in (666,777) then das10f = .;
  if das10e in (666) then das10e = .;
  if das10d in (666) then das10d = .;
  if das10c in (666,777) then das10c = .;
  if crp_ug_ml in (-999,-888) then crp_ug_ml = .;
  if con9b in (555) then con9b = .;
  if con9a in (555) then con9a = .;
  if con8a in (555) then con8a = .;
  if con7a in (555) then con7a = .;
  if con6a in (555) then con6a = .;
  if con5a in (555) then con5a = .;
  if con4a in (555) then con4a = .;
  if con3a in (555) then con3a = .;
  if con2a in (555) then con2a = .;
  if con17a in (555) then con17a = .;
  if con16a in (555) then con16a = .;
  if con15b in (555) then con15b = .;
  if con15a in (555) then con15a = .;
  if con14b in (555) then con14b = .;
  if con14a in (555) then con14a = .;
  if con13b in (555) then con13b = .;
  if con13a in (555) then con13a = .;
  if con12b in (555) then con12b = .;
  if con12a in (555) then con12a = .;
  if con11b in (555) then con11b = .;
  if con11a in (555) then con11a = .;
  if con10b in (555) then con10b = .;
  if con10a in (555) then con10a = .;
  if cdi9b in (666,999) then cdi9b = .;
  if cdi9a in (666,999) then cdi9a = .;
  if cdi8b in (666,999) then cdi8b = .;
  if cdi8a in (666,999) then cdi8a = .;
  if cdi7b in (666,999) then cdi7b = .;
  if cdi7a in (666,999) then cdi7a = .;
  if cdi6b in (666,999) then cdi6b = .;
  if cdi6a in (666,999) then cdi6a = .;
  if cdi5b in (666,999) then cdi5b = .;
  if cdi5a in (666,999) then cdi5a = .;
  if cdi4a in (666,999) then cdi4a = .;
  if cbc9c in (999) then cbc9c = .;
  if cbc9b in (999) then cbc9b = .;
  if cbc9a in (999) then cbc9a = .;
  if cbc8c in (999) then cbc8c = .;
  if cbc8b in (999) then cbc8b = .;
  if cbc8a in (999) then cbc8a = .;
  if cbc7c in (999) then cbc7c = .;
  if cbc7b in (999) then cbc7b = .;
  if cbc7a in (999) then cbc7a = .;
  if cbc6c in (555,888,999) then cbc6c = .;
  if cbc6b in (555,888,999) then cbc6b = .;
  if cbc6a in (555,888,999) then cbc6a = .;
  if cbc5c in (555,888,999) then cbc5c = .;
  if cbc5b in (555,888,999) then cbc5b = .;
  if cbc5a in (555,888,999) then cbc5a = .;
  if cbc4c in (555,999) then cbc4c = .;
  if cbc4b in (555,999) then cbc4b = .;
  if cbc4a in (555,999) then cbc4a = .;
  if cbc3c in (555) then cbc3c = .;
  if cbc3b in (555) then cbc3b = .;
  if cbc3a in (555) then cbc3a = .;
  if cbc23c in (999) then cbc23c = .;
  if cbc23b in (999) then cbc23b = .;
  if cbc23a in (999) then cbc23a = .;
  if cbc22c in (999) then cbc22c = .;
  if cbc22b in (999) then cbc22b = .;
  if cbc21c in (999) then cbc21c = .;
  if cbc21b in (999) then cbc21b = .;
  if cbc21a in (999) then cbc21a = .;
  if cbc20c in (999) then cbc20c = .;
  if cbc20b in (999) then cbc20b = .;
  if cbc20a in (999) then cbc20a = .;
  if cbc19c in (999) then cbc19c = .;
  if cbc19b in (999) then cbc19b = .;
  if cbc18c in (999) then cbc18c = .;
  if cbc18b in (999) then cbc18b = .;
  if cbc17c in (999) then cbc17c = .;
  if cbc17b in (999) then cbc17b = .;
  if cbc16c in (999) then cbc16c = .;
  if cbc15c in (999) then cbc15c = .;
  if cbc14c in (999) then cbc14c = .;
  if cbc14b in (999) then cbc14b = .;
  if cbc13c in (999) then cbc13c = .;
  if cbc13b in (999) then cbc13b = .;
  if cbc13a in (999) then cbc13a = .;
  if cbc12c in (999) then cbc12c = .;
  if cbc12b in (999) then cbc12b = .;
  if cbc11c in (999) then cbc11c = .;
  if cbc11b in (999) then cbc11b = .;
  if cbc10c in (999) then cbc10c = .;
  if bp31 in (0,9) then bp31 = .;
  if bp22 in (0) then bp22 = .;
  if bp21 in (0) then bp21 = .;
  if bri9c in (555) then bri9c = .;
  if bri9b in (555) then bri9b = .;
  if bri9a in (555) then bri9a = .;
  if bri3c in (888) then bri3c = .;
  if bri14c_tr in (555,999) then bri14c_tr = .;
  if bri14a_tr in (555,999) then bri14a_tr = .;
  if bri13c_tr in (555,999) then bri13c_tr = .;
  if bri13c in (555) then bri13c = .;
  if bri13a_tr in (555,999) then bri13a_tr = .;
  if bri13a in (555) then bri13a = .;
  if bp32 in (0) then bp32 = .;
  if bri12c in (555) then bri12c = .;
  if bri12a in (555) then bri12a = .;
  if bri11c_tr in (555) then bri11c_tr = .;
  if bri11b_tr in (555) then bri11b_tr = .;
  if ant62 in (0) then ant62 = .;
  if ant63 in (0) then ant63 = .;
  if ant72 in (0) then ant72 = .;
  if ant73 in (0) then ant73 = .;
  if ant82 in (0) then ant82 = .;
  if ant83 in (0) then ant83 = .;
  if chhdlr in (-999) then chhdlr = .;
  if chol in (-999) then chol = .;
  if hdl_mg_dl in (-999) then hdl_mg_dl = .;
  if roche_insulin in (-999,-888) then roche_insulin = .;
  if sgl_mg_dl in (-999) then sgl_mg_dl = .;
  if trig in (-999) then trig = .;

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
        sesindex /* variable definition not available */
        sae /* variable definition not available */
        randomized /* all participants in dataset were randomized, variable has no value */
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
