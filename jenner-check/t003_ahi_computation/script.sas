*******************************************************************************;
* apnea-hypopnea index (AHI) computation ;
* (formulas from the main DATA step of scripts/prepare-chat-for-nsrr.sas) ;
*******************************************************************************;
data chat_ahi;
  set chat_src;

  *add sleep maintenance efficiency;
  if timebedp ne 0 then do;
      if slplatp > . then slp_maint_eff = 100*(slpprdp/(timebedp-slplatp));
      else if slplatp = . then slp_maint_eff = 100*(slpprdp/timebedp);
  end;

  *create new AHI variables for ICSD3;
  ahi_a0h3 = 60 * (hrembp3 + hrop3 + hnrbp3 + hnrop3 +
                  carbp + carop + canbp + canop +
                  oarbp + oarop + oanbp + oanop +
                  marbp + marop + manrbp + manrop ) / slpprdp;

  ahi_o0h3 = 60 * (hrembp3 + hrop3 + hnrbp3 + hnrop3 +
                  oarbp + oarop + oanbp + oanop ) / slpprdp;

  ahi_c0h3 = 60 * (hrembp3 + hrop3 + hnrbp3 + hnrop3 +
                  carbp + carop + canbp + canop ) / slpprdp;

  *fix omahi3* variants - correct denominator (eventually update source);
  *first clear existing values, then recompute;
  omahi3r = .;
  omahi3nr = .;
  omahi3b = .;
  omahi3o = .;

  if slpprdp gt 0 then do;
    omahi3r = 60 * (oarbp + oarop + marbp + marop + hremba3 + hroa3) / (minremp);
    omahi3nr = 60 * (oanbp + oanop + manrbp + manrop + hnrba3 + hnroa3) / (slpprdp - minremp);
    omahi3b = 60 * (oarbp + oanbp + marbp +  manrbp + hremba3 + hnrba3) / (remepbp + nremepbp);
    omahi3o = 60 * (oarop + oanop + marop + manrop + hroa3 + hnroa3) / (remepop + nremepop);
  end;
run;

proc print data=chat_ahi;
  var slpprdp slp_maint_eff ahi_a0h3 ahi_o0h3 ahi_c0h3
      omahi3r omahi3nr omahi3b omahi3o;
run;
