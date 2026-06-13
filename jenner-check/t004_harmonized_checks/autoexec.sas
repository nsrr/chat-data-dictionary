options obs=100;
options nofmterr;

/*
  Bundle setup for the harmonized-dataset QC checks.

  In prepare-chat-for-nsrr.sas, after the baseline and follow-up harmonized
  datasets are concatenated into chat_harmonized, the program runs PROC MEANS
  over the continuous NSRR-harmonized variables and PROC FREQ over the
  categorical ones to scan for extreme/unexpected values. chat_harmonized is
  built from the BWH Sleep EPI source libraries that are not part of this
  public dictionary repository, so this bundle supplies a small mock
  chat_harmonized whose columns match the harmonized variable names produced
  by the harmonization step (the nsrr_* variables; see variables/Harmonized/).
  The PROC MEANS and PROC FREQ statements in script.sas are verbatim from the
  repository.
*/

data chat_harmonized;
  infile datalines dlm=',' dsd truncover;
  length nsrr_age_gt89 $4 nsrr_sex $12 nsrr_race $40 nsrr_ethnicity $24
         nsrr_flag_spsw $16;
  input nsrr_age nsrr_age_gt89 $ nsrr_sex $ nsrr_race $ nsrr_ethnicity $
        nsrr_flag_spsw $ nsrr_bmi nsrr_bp_systolic nsrr_bp_diastolic
        nsrr_ahi_hp3u nsrr_ahi_hp3r_aasm07 nsrr_ahi_hp4u nsrr_ahi_hp4r
        nsrr_tst_f1 nsrr_phrnumar_f1 nsrr_ttleffsp_f1 nsrr_ttllatsp_f1
        nsrr_ttlprdsp_s1sr nsrr_ttldursp_s1sr nsrr_waso_f1
        nsrr_pctdursp_s1 nsrr_pctdursp_s2 nsrr_pctdursp_s3 nsrr_pctdursp_sr
        nsrr_tib_f1 nsrr_begtimbd_f1 nsrr_begtimsp_f1 nsrr_endtimbd_f1;
datalines;
7.50,no,male,white,not hispanic or latino,full scoring,16.4,108,67,3.21,2.88,1.95,1.74,512.5,12.3,93.1,18.5,42.0,8.1,42.5,18.0,28.5,460.0,142.0,160.5,79200,80100,108000
9.25,no,female,black or african american,hispanic or latino,full scoring,18.9,112,70,7.84,6.55,5.10,4.22,488.0,21.6,90.4,22.0,55.5,11.2,49.0,15.5,24.0,440.0,128.0,150.0,77400,78600,106200
5.75,no,male,asian,not hispanic or latino,sleep/wake only,15.1,101,62,1.05,0.92,0.61,0.55,533.0,5.4,95.8,12.0,38.0,6.5,40.0,21.0,32.5,478.0,150.0,175.0,80100,81000,109800
90.00,yes,female,other,not hispanic or latino,full scoring,22.3,120,78,12.40,10.10,9.20,7.85,455.5,30.1,86.2,30.5,68.0,15.0,52.5,12.0,20.5,415.0,118.0,140.0,75600,77400,104400
6.00,no,male,american indian or alaska native,hispanic or latino,unknown,14.8,99,60,2.10,1.85,1.30,1.12,520.0,7.8,94.0,16.0,40.5,7.0,41.5,19.5,30.0,468.0,145.0,168.0,79800,80700,109200
8.75,no,female,multiple,not hispanic or latino,full scoring,19.5,115,72,5.50,4.60,3.80,3.10,495.5,17.4,91.6,20.0,50.0,10.0,47.0,16.5,25.5,448.0,135.0,158.0,78000,79200,107100
7.25,no,male,white,not hispanic or latino,full scoring,17.0,107,66,4.02,3.55,2.71,2.30,508.0,14.8,92.8,19.0,44.5,8.8,43.5,17.5,27.0,455.0,140.0,162.0,79200,80400,108600
10.00,no,female,not reported,not reported,full scoring,21.0,118,75,9.15,7.90,6.85,5.60,470.0,26.5,88.5,26.0,60.0,13.0,50.0,14.0,22.5,425.0,125.0,148.0,76800,78000,105600
;
run;
