options obs=100;
options nofmterr;

/*
  Bundle setup for the PSG lights/onset decimal-hour restore step.

  In prepare-chat-for-nsrr.sas the lights-out / sleep-onset / lights-on PSG
  timing variables (stloutp, stonsetp, stlonp) are restored from the
  chat_mega_data source dataset, parsed from TIME8. text into numeric SAS
  time values, then converted to "decimal hours" with a midnight-crossing
  adjustment (times before noon are pushed past 24h so an overnight study
  reads as a monotonic sequence). That source dataset lives on the BWH Sleep
  EPI fileserver and is not part of this public dictionary repository, so this
  bundle supplies a small mock chatrestore dataset of HH:MM:SS strings. The
  INPUT/RENAME and decimal-hour conversion logic in script.sas is verbatim
  from the repository.
*/

data chatrestore;
  length stloutp stonsetp stlonp $8;
  input pid vnum stloutp $ stonsetp $ stlonp $;
  datalines;
1001 3 22:00:00 22:18:00 06:30:00
1002 3 21:45:00 22:05:00 06:00:00
1003 3 23:10:00 23:30:00 07:15:00
1004 3 20:30:00 20:52:00 05:40:00
1005 3 11:50:00 12:10:00 19:45:00
;
run;
