options obs=100;
options nofmterr;

/*
  Bundle setup for the special-value-to-missing recode block.

  In prepare-chat-for-nsrr.sas, a large block of `if <var> in (...) then
  <var> = .;` statements scrubs survey/lab sentinel codes (555, 666, 777,
  888, 999, 0, -999, -888) down to SAS missing so they do not contaminate
  downstream summaries. Each variable has its own sentinel list. Those
  variables come from the BioLINCC source dataset on the BWH Sleep EPI
  fileserver, which is not part of this public dictionary repository, so this
  bundle supplies a small mock chat_raw carrying representative sentinel and
  in-range values for a sample of those variables. The recode statements in
  script.sas are verbatim from the repository (one per variable, with that
  variable's exact sentinel list).
*/

data chat_raw;
  input bri10a_tr wra2a vmi6 med5 ldl_mg_dl das6g cdi9b cbc6c bp31 chol;
  datalines;
555 666 666 999 -999 666 666 555 0 -999
12 45 8 230 110 4 3 2 5 180
666 777 666 555 95 999 999 888 9 150
999 14 6 200 -999 7 6 1 3 -999
18 30 7 245 120 5 2 1 4 165
;
run;
