*******************************************************************************;
* checking harmonized datasets ;
* (QC checks from scripts/prepare-chat-for-nsrr.sas) ;
*******************************************************************************;

/* Checking for extreme values for continuous variables */

proc means data=chat_harmonized;
VAR   nsrr_age
    nsrr_bmi
    nsrr_bp_systolic
    nsrr_bp_diastolic
  nsrr_ahi_hp3u
  nsrr_ahi_hp3r_aasm07
  nsrr_ahi_hp4u
  nsrr_ahi_hp4r
  nsrr_tst_f1
  nsrr_phrnumar_f1
  nsrr_ttleffsp_f1
  nsrr_ttllatsp_f1
  nsrr_ttlprdsp_s1sr
  nsrr_ttldursp_s1sr
  nsrr_waso_f1
  nsrr_pctdursp_s1
  nsrr_pctdursp_s2
  nsrr_pctdursp_s3
  nsrr_pctdursp_sr
  nsrr_tib_f1
  nsrr_begtimbd_f1
  nsrr_begtimsp_f1
  nsrr_endtimbd_f1
  ;
run;

/* Checking categorical variables */

proc freq data=chat_harmonized;
table   nsrr_age_gt89
    nsrr_sex
    nsrr_race
    nsrr_ethnicity
  nsrr_flag_spsw;
run;
