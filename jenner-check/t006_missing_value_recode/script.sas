*******************************************************************************;
* recode sentinel codes to missing ;
* (recode statements from the main DATA step of                                ;
*  scripts/prepare-chat-for-nsrr.sas, one per variable)                        ;
*******************************************************************************;
data chat_clean;
  set chat_raw;

  *recode values to missing;
  if bri10a_tr in (555,666,999) then bri10a_tr = .;
  if wra2a in (666,777) then wra2a = .;
  if vmi6 in (666) then vmi6 = .;
  if med5 in (999) then med5 = .;
  if ldl_mg_dl in (-999) then ldl_mg_dl = .;
  if das6g in (666,999) then das6g = .;
  if cdi9b in (666,999) then cdi9b = .;
  if cbc6c in (555,888,999) then cbc6c = .;
  if bp31 in (0,9) then bp31 = .;
  if chol in (-999) then chol = .;
run;

proc print data=chat_clean;
run;

proc means data=chat_clean n nmiss min max;
  var bri10a_tr wra2a vmi6 med5 ldl_mg_dl das6g cdi9b cbc6c bp31 chol;
run;
