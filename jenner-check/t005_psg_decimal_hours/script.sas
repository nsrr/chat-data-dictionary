*******************************************************************************;
* restore PSG lights/onset timing and convert to decimal hours ;
* (logic from scripts/prepare-chat-for-nsrr.sas, chatrestore* steps) ;
*******************************************************************************;
  data chatrestore2;
    set chatrestore;

    format stloutp2 stonsetp2 stlonp2 time8.;
    stloutp2 = input(stloutp,time8.);
    stonsetp2 = input(stonsetp,time8.);
    stlonp2 = input(stlonp,time8.);

    keep
      pid
      vnum
      stloutp2
      stonsetp2
      stlonp2
      ;
  run;

  data chatrestore2_nsrr;
    set chatrestore2;

    rename
      stloutp2 = stloutp
      stonsetp2 = stonsetp
      stlonp2 = stlonp;

    if stloutp2 = . then delete;
  run;

  data chat_decimal_hours;
    set chatrestore2_nsrr;

    *create decimal hours variables for PSG lights/onset;
    format stloutp_dec stonsetp_dec stlonp_dec 8.2;
    if stloutp < 43200 then stloutp_dec = stloutp/3600 + 24;
    else stloutp_dec = stloutp/3600;
    if stonsetp < 43200 then stonsetp_dec = stonsetp/3600 + 24;
    else stonsetp_dec = stonsetp/3600;
    stlonp_dec = stlonp/3600 + 24;
  run;

proc print data=chat_decimal_hours;
  var pid stloutp stloutp_dec stonsetp stonsetp_dec stlonp stlonp_dec;
run;
