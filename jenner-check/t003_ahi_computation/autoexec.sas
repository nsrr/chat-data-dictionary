options obs=100;
options nofmterr;

/*
  Bundle setup for the CHAT apnea-hypopnea index (AHI) computation.

  In prepare-chat-for-nsrr.sas the AHI variables and sleep maintenance
  efficiency are derived inside the main DATA step from per-event PSG counts
  read out of the BioLINCC source dataset (chatb.redacted_chat_20140501),
  which lives on the BWH Sleep EPI fileserver and is not part of this public
  dictionary repository. This bundle supplies a small mock source dataset
  whose per-event count columns match the variable names used in the AHI
  formulas (hrembp3, oarbp, carbp, ... — see the Sleep Monitoring /
  Polysomnography variable definitions in this repository). The AHI and
  omahi3* formulas in script.sas are verbatim from the repository.
*/

data chat_src;
  input slpprdp minremp remepbp nremepbp remepop nremepop timebedp slplatp
        hrembp3 hrop3 hnrbp3 hnrop3 carbp carop canbp canop
        oarbp oarop oanbp oanop marbp marop manrbp manrop
        hremba3 hroa3 hnrba3 hnroa3;
  datalines;
512.5 95.0 60.0 380.0 25.0 120.0 600.0 18.5 12 8 40 30 5 4 3 2 10 9 7 6 2 1 1 1 11 9 38 28
488.0 88.0 55.0 360.0 22.0 110.0 580.0 22.0 18 12 55 42 8 6 5 4 14 11 9 7 3 2 2 1 17 13 52 40
533.0 102.0 65.0 400.0 28.0 130.0 615.0 16.0 8 5 28 20 3 2 2 1 6 5 4 3 1 1 0 0 7 6 26 19
470.0 80.0 48.0 340.0 20.0 100.0 560.0 28.0 22 16 68 50 11 8 7 5 18 14 12 9 4 3 3 2 21 16 64 48
;
run;
