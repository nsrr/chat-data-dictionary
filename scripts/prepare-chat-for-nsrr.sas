*******************************************************************************;
/* prepare-chat-for-nsrr.sas */
*******************************************************************************;

*******************************************************************************;
* establish options and libnames ;
*******************************************************************************;
  options nofmterr;
  data _null_;
    call symput("sasfiledate",put(year("&sysdate"d),4.)||put(month("&sysdate"d),z2.)||put(day("&sysdate"d),z2.));
  run;

  *set data dictionary version;
  %let version = 0.12.0.pre;

  *nsrr id location;
  libname obf "\\rfawin\bwh-sleepepi-chat\nsrr-prep\_ids";

  *project source datasets from biolincc / sleep reading center;
  libname chatb "\\rfawin\bwh-sleepepi-chat\nsrr-prep\_datasets\biolincc-master";

  *cyclic alternating pattern data;
  libname cycl "\\rfawin\bwh-sleepepi-chat\nsrr-prep\cyclic-alternating-pattern";

  *output location for nsrr datasets;
  libname chatn "\\rfawin\bwh-sleepepi-chat\nsrr-prep\_datasets";

  *set nsrr csv release path;
  %let releasepath = \\rfawin\bwh-sleepepi-chat\nsrr-prep\_releases;

*******************************************************************************;
* import and process master dataset from source ;
*******************************************************************************;
  data chat_latest;
    length nsrrid 8.;
    set chatb.redacted_chat_20140501;

    *remove subjects from censored site;
    if clusterid = 95 then delete;

    *create obfuscated nsrr subject identifier for filenaming conventions;
    nsrrid = new_pid + 300000;

    *recode race from 1=B, 2=W, 7=O, to 1=W, 2=B, 3=O to match other datasets;
    if race3 = 1 then race3 = 2;
    else if race3 = 2 then race3 = 1;
    else if race3 = 7 then race3 = 3;

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

    *remove values for 'par2r' and 'par4r' at follow-up -- only needed on
      baseline dataset;
    if vnum = 10 then do;
      par2r = .;
      par4r = .;
    end;

    *fix sleep and health questionnaire inconsistencies;
    if vnum = 3 then do;
      slh3_ba = slh3;
      slh5a_ba = slh5a;
      slh5b_ba = slh5b;
      slh5c_ba = slh5c;
      slh5d_ba = slh5d;
      slh5e_ba = slh5e;
      slh5f_ba = slh5f;
      slh5g_ba = slh5g;
      slh5h_ba = slh5h;
      slh5i_ba = slh5i;
      slh5j_ba = slh5j;
    end;

    if vnum = 10 then do;
      slh3_fu = slh3;
      slh5a_fu = slh5a;
      slh5b_fu = slh5b;
      slh5c_fu = slh5c;
      slh5d_fu = slh5d;
      slh5e_fu = slh5e;
      slh5f_fu = slh5f;
      slh5g_fu = slh5g;
      slh5h_fu = slh5h;
      slh5i_fu = slh5i;
    end;

    *create new AHI variables for ICSD3;
    ahi_a0h3 = 60 * (hrembp3 + hrop3 + hnrbp3 + hnrop3 +
                    carbp + carop + canbp + canop +
                    oarbp + oarop + oanbp + oanop +
                    marbp + marop + manrbp + manrop ) / slpprdp;
    ahi_a0h4 = 60 * (hrembp4 + hrop4 + hnrbp4 + hnrop4 +
                    carbp + carop + canbp + canop +
                    oarbp + oarop + oanbp + oanop +
                    marbp + marop + manrbp + manrop ) / slpprdp;
    ahi_a0h3a = 60 * (hremba3 + hroa3 + hnrba3 + hnroa3 +
                      carbp + carop + canbp + canop +
                      oarbp + oarop + oanbp + oanop +
                      marbp + marop + manrbp + manrop ) / slpprdp;
    ahi_a0h4a = 60 * (hremba4 + hroa4 + hnrba4 + hnroa4 +
                      carbp + carop + canbp + canop +
                      oarbp + oarop + oanbp + oanop +
                      marbp + marop + manrbp + manrop ) / slpprdp;

    ahi_o0h3 = 60 * (hrembp3 + hrop3 + hnrbp3 + hnrop3 +
                    oarbp + oarop + oanbp + oanop ) / slpprdp;
    ahi_o0h4 = 60 * (hrembp4 + hrop4 + hnrbp4 + hnrop4 +
                    oarbp + oarop + oanbp + oanop ) / slpprdp;
    ahi_o0h3a = 60 * (hremba3 + hroa3 + hnrba3 + hnroa3 +
                      oarbp + oarop + oanbp + oanop ) / slpprdp;
    ahi_o0h4a = 60 * (hremba4 + hroa4 + hnrba4 + hnroa4 +
                      oarbp + oarop + oanbp + oanop ) / slpprdp;

    ahi_c0h3 = 60 * (hrembp3 + hrop3 + hnrbp3 + hnrop3 +
                    carbp + carop + canbp + canop ) / slpprdp;
    ahi_c0h4 = 60 * (hrembp4 + hrop4 + hnrbp4 + hnrop4 +
                    carbp + carop + canbp + canop ) / slpprdp;
    ahi_c0h3a = 60 * (hremba3 + hroa3 + hnrba3 + hnroa3 +
                    carbp + carop + canbp + canop ) / slpprdp;
    ahi_c0h4a = 60 * (hremba4 + hroa4 + hnrba4 + hnroa4 +
                    carbp + carop + canbp + canop ) / slpprdp;

    cent_obs_ratio = (carbp + carop + canbp + canop) /
                      (oarbp + oarop + oanbp + oanop);
    cent_obs_ratioa = (carba + caroa + canba + canoa) /
                      (oarba + oaroa + oanba + oanoa);


    *create epworth total variables;
    epworthscore_adult = sum(of sls1-sls8);
    epworthscore_modified = sum(of sls1-sls10);

    *recode values to missing;
    if bri10a_tr in (555,666,999) then bri10a_tr = .;
    if bri10b_tr in (555,999) then bri10b_tr = .;
    if bri10c_tr in (555,999) then bri10c_tr = .;
    if bri11a_tr in (555) then bri11a_tr = .;
    if wra3b in (777) then wra3b = .;
    if wra3a in (777) then wra3a = .;
    If wra2b in (777) then wra2b = .;
    if wra2a in (666,777) then wra2a = .;
    if wra4a in (666,777) then wra4a = .;
    if wra4b in (666,777) then wra4b = .;
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
    if das6g in (666,999) then das6g = .;
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
    if cbc10b in (999) then cbc10b = .;
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
    if bri13a_tr in (555,666,999) then bri13a_tr = .;
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
          slh3 /* removed because variables were separated into slh3_ba and slh3_fu */
          slh5a--slh5j /* removed because variables were separated into _ba and _fu versions */
          bmipct_cat /* variable definition not available */
          agec /* variable definition not available */
          chg_ant3 /* duplicate variable of ant3_change */
          chg_ant4 /* duplicate variable of ant4_change */
          chg_bmi /* duplicate variable of bmi_change */
          bmiz_change /* swap with chg_bmiz, which looks inconsistent */
          mat2a /* dubious worth, process variables */
          child_age /* confusing; use ageyear_at_meas instead */
          eli1-eli23 /* eligibility variables are irrelevant because all randomized subjects met inc/exc criteria */
          eli11a eli16a eli3a /* more eligibility variables to drop */
          ahi /* duplicitous -- use 'omahi3' as primary AHI variable */
          income /* unknown why this column was mixed in with PSG data, duplicate of other income variables */
          par5_ats_rc /* recoding of income variable (par5), unneeded duplication */
          siteid /* embedded in PSG dataset but supposed to be removed in favor of clusterid */
          slp_time /* redundant with slpprdp */
          slptime /* redundant with slpprdp */
          slptimem /* redundant with slpprdp */
          slp_lat /* redundant with slplatp */
          slplatm /* redundant with slplatp */
          time_bed /* redundant with timebedp */
          timebedm /* redundant with timebedp */
          totalosa /* redudant with osas18 */
          headcir /* empty variable */
          hcz /* empty variable */
          hcpct /* empty variable */
		  ahi3 /*redundant with ahi_a0h3*/
		  avgdsresp /*redundant with avgdsevent*/
		  avgsaominnr /*unclear metadata, more reliable variable available*/
		  avgsaominr /*unclear metadata, more reliable variable available*/
		  avgsaominrpt /*unclear metadata, more reliable variable available*/
		  avgsaominslp /*unclear metadata, more reliable variable available*/
		  cai /*redundant with cai0p*/
		  oahi3 /*redundant with ahi_o0h3*/
		  oahi4 /*redundant with ahi_o0h4*/
		  oai /*redundant with oai0p*/
		  pctle70 /*redundant with pctsa70*/
		  pctle75 /*redundant with pctsa75*/
		  pctle80 /*redundant with pctsa80*/
		  pctle85 /*redundant with pctsa85*/
		  pctle90 /*redundant with pctsa90*/
		  pctle92 /*redundant with pctsa92*/
		  pctle95 /*redundant with pctsa95*/
		  pctlt75 /*redundant with pctsa75h*/
		  pctlt80 /*redundant with pctsa80h*/
		  pctlt85 /*redundant with pctsa85h*/
		  pctlt90 /*redundant with pctsa90h*/
		  rem_lat1 /*redundant with remlaip*/
		  remlatm /*redundant with remlaip*/
		  slp_eff /*redundant with slpeffp*/
		  tmremp /*redundant with timeremp*/
		  tmstg1p /*redundant with timest1p*/
		  tmstg2p /*redundant with timest2p*/
		  tmstg34p /*redundant with timest34p*/
		  wasom /*redundant with waso*/
          ;
  run;

  *sort dataset by pptid and vnum;
  proc sort data=chat_latest;
    by nsrrid vnum;
  run;

*******************************************************************************;
* merge with unit data processed separately ;
*******************************************************************************;
  data chat_latest_withunit;
    merge chat_latest (in=a) chatb.chat_unittype;
    by nsrrid vnum;

    *only keep if in latest chat dataset;
    if a;
  run;

*******************************************************************************;
* import thoraco-abdominal asynchrony data to merge ;
*******************************************************************************;
  proc import datafile="\\rfawin\bwh-sleepepi-chat\nsrr-prep\asynchrony\Thoraco_abdominal_asynchrony_submission_20161229.xlsx"
    out=chat_asynchrony_baseline
    dbms=xlsx
    replace;
    sheet="baseline";
    getnames=yes;
  run;

  proc import datafile="\\rfawin\bwh-sleepepi-chat\nsrr-prep\asynchrony\Thoraco_abdominal_asynchrony_submission_20161229.xlsx"
    out=chat_asynchrony_followup
    dbms=xlsx
    replace;
    sheet="followup";
    getnames=yes;
  run;

  data chat_async_base;
    length nsrrid vnum 8.;
    set chat_asynchrony_baseline;
    vnum = 3;
  run;

  data chat_async_fu;
    length nsrrid vnum 8.;
    set chat_asynchrony_followup;
    vnum = 10;
  run;


*******************************************************************************;
* import cyclic alternating pattern data to merge ;
*******************************************************************************;
    proc import datafile="\\rfawin\bwh-sleepepi-chat\nsrr-prep\cyclic-alternating-pattern\CHATbaselineEvaluation_03-Jan-2020.xlsx"
    out=chat_cyclic_baseline
    dbms=xlsx
    replace;
    sheet="CAP";
    getnames=yes;
  run;

        proc import datafile="\\rfawin\bwh-sleepepi-chat\nsrr-prep\cyclic-alternating-pattern\CHATfollowupEvaluation_03-Jan-2020.xlsx"
    out=chat_cyclic_followup
    dbms=xlsx
    replace;
    getnames=yes;
  run;

    data chat_cycl_base;
    length vnum 8.;
    set chat_cyclic_baseline;
  nsrrid = input(id, 8.);
  vnum = 3;
  rename capdur = capdurs;
  drop id
     ac
     ad
     ae
       af
     ag
     eeg1hurst
     eeg1var
     eeg2hurst
     eeg2var
     eegcorr
     ;
  run;


    data chat_cycl_fu;
    length vnum 8.;
    set chat_cyclic_followup;
  nsrrid = input(id, 8.);
  vnum = 10;
  rename capdur = capdurs;
  drop id
     ac
     ad
     ae
       af
     ag
     eeg1hurst
     eeg1var
     eeg2hurst
     eeg2var
     eegcorr
     ;
  run;

*******************************************************************************;
* split dataset into two parts based on vnum ;
*******************************************************************************;
  data chatbaseline
    chatfollowup;
    merge chat_latest_withunit chat_async_base chat_async_fu chat_cycl_base chat_cycl_fu;
    by nsrrid vnum;

    *visit number is 'vnum';
    if vnum = 3 then output chatbaseline;
    if vnum = 10 then output chatfollowup;
  run;

*******************************************************************************;
* create separate dataset for nonrandomized subjects ;
*******************************************************************************;
  proc import datafile="\\rfawin\bwh-sleepepi-chat\nsrr-prep\_ids\chat_nonrandomized_ids.csv"
    out=chat_nr_ids
    dbms=csv
    replace;
  run;

  proc sort data=chat_nr_ids;
    by pid;
  run;

  data mega;
    set chatb.chat_mega_data_04242014;

    if vnum = 3;
  run;

  proc sort data=mega;
    by pid;
  run;

  data chatnonrandomized;
    merge chat_nr_ids (in=a) mega;
    by pid;

    if a;

    format age_nr 8.1;
    age_nr = (datepart(ref3) - datepart(ref2)) / 365.25;

    keep nsrrid omahi3 omai0p REF9 REF8 age_nr REF5 REF4;
  run;

  proc sort data=chatnonrandomized;
    by nsrrid;
  run;


proc print data=chatbaseline (obs=10);
  run;

/* quick check of blood pressure calculations
data chatbaseline_temp;
set chatbaseline;
*systolic bp;
format avgsys;
avgsys = round(mean(BP11, BP21, BP31));
*systolic bp;
format avgdia;
avgdia = round(mean(BP12, BP22, BP32));

keep 
nsrrid
avgsys
bp41
avgdia
bp42;
run;

proc print data = chatbaseline_temp (obs=10);
run;
*/

*******************************************************************************;
* create harmonized datasets ;
*******************************************************************************;
data chatbaseline_harmonized;
  set chatbaseline;

*demographics
*age;
*use ageyear_at_meas;
  format nsrr_age 8.2;
  nsrr_age = ageyear_at_meas;

*age_gt89;
*use ageyear_at_meas;
  format nsrr_age_gt89 $100.; 
  if ageyear_at_meas gt 89 then nsrr_age_gt89='yes';
  else if ageyear_at_meas le 89 then nsrr_age_gt89='no';

*sex;
*use male;
  format nsrr_sex $100.;
  if male = '01' then nsrr_sex = 'male';
  else if male = '0' then nsrr_sex = 'female';
  else if male = '.' then nsrr_sex = 'not reported';

*race;
*use ref4;
    format nsrr_race $100.;
    if ref4 = 1 then nsrr_race = 'american indian or alaska native';
    else if ref4 = 2 then nsrr_race = 'asian';
    else if ref4 = 3 then nsrr_race = 'native hawaiian or other pacific islander';
    else if ref4 = 4 then nsrr_race = 'black or african american';
  else if ref4 = 5 then nsrr_race = 'white';
  else if ref4 = 6 then nsrr_race = 'multiple';
  else if ref4 = 7 then nsrr_race = 'other';
  *note: the 'not reported includes 'not sure';
  else  nsrr_race = 'not reported';

*ethnicity;
*use chi3;
  format nsrr_ethnicity $100.;
    if chi3 = '01' then nsrr_ethnicity = 'hispanic or latino';
    else if chi3 = '02' then nsrr_ethnicity = 'not hispanic or latino';
  else if chi3 = '.' then nsrr_ethnicity = 'not reported';

*anthropometry
*bmi;
*use ant5;
  format nsrr_bmi 10.9;
  nsrr_bmi = ant5;

*clinical data/vital signs
*bp_systolic;
*use bp41;
  format nsrr_bp_systolic 8.2;
  nsrr_bp_systolic = bp41;

*bp_diastolic;
*use bp42;
  format nsrr_bp_diastolic 8.2;
  nsrr_bp_diastolic = bp42;

*lifestyle and behavioral health
*current_smoker;
*ever_smoker;
*no data;

*polysomnography;
*nsrr_ahi_hp3u;
*use ahi_a0h3;
  format nsrr_ahi_hp3u 8.2;
  nsrr_ahi_hp3u = ahi_a0h3;

*nsrr_ahi_hp3r_aasm07;
*use ahi_a0h3a;
  format nsrr_ahi_hp3r_aasm07 8.2;
  nsrr_ahi_hp3r_aasm07 = ahi_a0h3a;
 
*nsrr_ahi_hp4u;
*use ahi_a0h4;
  format nsrr_ahi_hp4u 8.2;
  nsrr_ahi_hp4u = ahi_a0h4;
  
*nsrr_ahi_hp4r;
*use ahi_a0h4a;
  format nsrr_ahi_hp4r 8.2;
  nsrr_ahi_hp4r = ahi_a0h4a;
 
*nsrr_ttldursp_f1;
*use slpprdp;
  format nsrr_ttldursp_f1 8.2;
  nsrr_ttldursp_f1 = slpprdp;
  
*nsrr_phrnumar_f1;
*use ai_all;
  format nsrr_phrnumar_f1 8.2;
  nsrr_phrnumar_f1 = ai_all;  

*nsrr_flag_spsw;
*use slewake;
  format nsrr_flag_spsw $100.;
    if slewake = 1 then nsrr_flag_spsw = 'sleep/wake only';
    else if slewake = 0 then nsrr_flag_spsw = 'full scoring';
    else if slewake = 8 then nsrr_flag_spsw = 'unknown';
  else if slewake = . then nsrr_flag_spsw = 'unknown';  
  
  keep 
    nsrrid
    vnum
    nsrr_age
    nsrr_age_gt89
    nsrr_sex
    nsrr_race
    nsrr_ethnicity
    nsrr_bmi
    nsrr_bp_systolic
    nsrr_bp_diastolic
    nsrr_ahi_hp3u
	nsrr_ahi_hp3r_aasm07
	nsrr_ahi_hp4u
	nsrr_ahi_hp4r
	nsrr_ttldursp_f1
	nsrr_phrnumar_f1
	nsrr_flag_spsw
	;
run;

*******************************************************************************;
* checking harmonized datasets ;
*******************************************************************************;

/* Checking for extreme values for continuous variables */

proc means data=chatbaseline_harmonized;
VAR   nsrr_age
    nsrr_bmi
    nsrr_bp_systolic
    nsrr_bp_diastolic
	nsrr_ahi_hp3u
	nsrr_ahi_hp3r_aasm07
	nsrr_ahi_hp4u
	nsrr_ahi_hp4r
	nsrr_ttldursp_f1
	nsrr_phrnumar_f1;
run;

/* Checking categorical variables */

proc freq data=chatbaseline_harmonized;
table   nsrr_age_gt89
    nsrr_sex
    nsrr_race
    nsrr_ethnicity
	nsrr_flag_spsw;
run;

*******************************************************************************;
* make all variable names lowercase ;
*******************************************************************************;
  options mprint;
  %macro lowcase(dsn);
       %let dsid=%sysfunc(open(&dsn));
       %let num=%sysfunc(attrn(&dsid,nvars));
       %put &num;
       data &dsn;
             set &dsn(rename=(
          %do i = 1 %to &num;
          %let var&i=%sysfunc(varname(&dsid,&i));    /*function of varname returns the name of a SAS data set variable*/
          &&var&i=%sysfunc(lowcase(&&var&i))         /*rename all variables*/
          %end;));
          %let close=%sysfunc(close(&dsid));
    run;
  %mend lowcase;

  %lowcase(chatbaseline);
  %lowcase(chatfollowup);
  %lowcase(chatnonrandomized);
  %lowcase(charbaseline_harmonized);

*******************************************************************************;
* create permanent sas datasets ;
*******************************************************************************;
  data chatn.chatbaseline_&sasfiledate;
    set chatbaseline;
  run;

  data chatn.chatfollowup_&sasfiledate;
    set chatfollowup;
  run;

  data chatn.chatnonrandomized_&sasfiledate;
    set chatnonrandomized;
  run;

*******************************************************************************;
* export nsrr csv datasets ;
*******************************************************************************;
  proc export data=chatbaseline
    outfile="&releasepath\&version\chat-baseline-dataset-&version..csv"
    dbms=csv
    replace;
  run;

  proc export data=chatfollowup
    outfile="&releasepath\&version\chat-followup-dataset-&version..csv"
    dbms=csv
    replace;
  run;

  proc export data=chatnonrandomized
    outfile="&releasepath\&version\chat-nonrandomized-dataset-&version..csv"
    dbms=csv
    replace;
  run;

    proc export data=chatbaseline_harmonized
    outfile="&releasepath\&version\chat-baseline-harmonized-dataset-&version..csv"
    dbms=csv
    replace;
  run;
