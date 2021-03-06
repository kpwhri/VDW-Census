* Gather all state files so they can be concatenated.;
data output.census_demog(compress=no);
  length geocode $15.;
  set temp_seg.acs_all:;
  geocode = cats(state, county, tract, blockgp);
  * Create the calculated variables.;
  rename  B19113001 = medfamincome
          B19013001 = medhousincome
          B25077001 = Homes_medvalue
          geolevel  = &_SITEABBR._geolevel
  ;

  * B01001 - Sex by Age;
  if B01001001 then do;
    Residents_65 = sum(B01001020, B01001021, B01001022, B01001023, B01001024, B01001025, B01001044,
      B01001045, B01001046, B01001047, B01001048, B01001049)/B01001001;

    * Additional population control variables created by David Tabano at KPCO;
    &_SITEABBR._ACS_Total_Pop        = B01001001;
    &_SITEABBR._ACS_maleunder18pop   = sum(B01001003,B01001004,B01001005,B01001006);
    &_SITEABBR._ACS_femaleunder18pop = sum(B01001027, B01001028, B01001029, B01001030);
    &_SITEABBR._ACS_under18pop       = sum(B01001003,B01001004,B01001005,B01001006,B01001027, B01001028, B01001029, B01001030);
    &_SITEABBR._ACS_male18overpop    = sum(B01001007,B01001008,B01001009,B01001010,B01001011,B01001012,B01001013, B01001014,B01001015,B01001016,B01001017,B01001018,B01001019,B01001020,B01001021,B01001022,B01001023,B01001024,B01001025);
    &_SITEABBR._ACS_female18overpop  = sum(B01001031,B01001032,B01001033,B01001034,B01001035,B01001036,B01001037, B01001038,B01001039,B01001040,B01001041,B01001042,B01001043,B01001044,B01001045,B01001046,B01001047,B01001048,B01001049);
    &_SITEABBR._ACS_18overpop        = sum(B01001007,B01001008,B01001009,B01001010,B01001011,B01001012,B01001013,B01001014,B01001015,B01001016,B01001017,B01001018,B01001019, B01001020,B01001021,B01001022,B01001023,B01001024,B01001025,B01001031,B01001032,B01001033,B01001034,B01001035,B01001036,B01001037, B01001038,B01001039,B01001040,B01001041,B01001042,B01001043,B01001044,B01001045,B01001046,B01001047,B01001048,B01001049);
    &_SITEABBR._ACS_male25overpop    = sum(B01001011,B01001012,B01001013,B01001014,B01001015,B01001016,B01001017,B01001018,B01001019, B01001020,B01001021,B01001022,B01001023,B01001024,B01001025);
    &_SITEABBR._ACS_female25overpop  = sum(B01001035,B01001036,B01001037, B01001038,B01001039,B01001040,B01001041,B01001042,B01001043,B01001044,B01001045,B01001046,B01001047,B01001048,B01001049);
    &_SITEABBR._ACS_25overpop        = sum(B01001011,B01001012,B01001013,B01001014,B01001015,B01001016,B01001017,B01001018,B01001019, B01001020,B01001021,B01001022,B01001023,B01001024,B01001025,B01001035,B01001036,B01001037,B01001038,B01001039,B01001040,B01001041,B01001042,B01001043,B01001044,B01001045,B01001046,B01001047,B01001048,B01001049);
    &_SITEABBR._ACS_male65overpop    = sum(B01001020,B01001021,B01001022,B01001023,B01001024,B01001025);
    &_SITEABBR._ACS_female65overpop  = sum(B01001044,B01001045,B01001046,B01001047,B01001048,B01001049);
    &_SITEABBR._ACS_65overpop        = sum(B01001020,B01001021,B01001022,B01001023,B01001024,B01001025,B01001044,B01001045,B01001046,B01001047,B01001048,B01001049);

    * B01001A - Sex by Age (White);
    &_SITEABBR._ACS_Total_Pop_WH = B01001A001;
    &_SITEABBR._ACS_WH = B01001A001/B01001001;

    * B01001B - Sex by Age (Black);
    &_SITEABBR._ACS_Total_Pop_BA = B01001B001;
    &_SITEABBR._ACS_BA = B01001B001/B01001001;

    * B01001C - Sex by Age (American Indian/Alaskan Native);
    &_SITEABBR._ACS_Total_Pop_IN = B01001C001;
    &_SITEABBR._ACS_IN = B01001C001/B01001001;

    * B01001D - Sex by Age (Asian);
    &_SITEABBR._ACS_Total_Pop_AS = B01001D001;
    &_SITEABBR._ACS_AS = B01001D001/B01001001;

    * B01001E - Sex by Age (Native Hawaiian/Pacific Islander);
    &_SITEABBR._ACS_Total_Pop_HP = B01001E001;
    &_SITEABBR._ACS_HP = B01001E001/B01001001;

    * B01001F - Sex by Age (Other);
    &_SITEABBR._ACS_Total_Pop_OT = B01001F001;
    &_SITEABBR._ACS_OT = B01001F001/B01001001;

    * B01001G - Sex by Age (Multiple);
    &_SITEABBR._ACS_Total_Pop_MU = B01001G001;
    &_SITEABBR._ACS_MU = B01001G001/B01001001;

    * B01001H - Sex by Age (Non-Hispanic White);
    &_SITEABBR._ACS_Total_Pop_NHWH = B01001H001;
    &_SITEABBR._ACS_NHWH = B01001H001/B01001001;

    * B01001I - Sex by Age (Hispanic/Latino);
    &_SITEABBR._ACS_Total_Pop_HS = B01001I001;
    &_SITEABBR._ACS_HS = B01001I001/B01001001;
  end;

  * B05001 - Nativity & Citizenship Status in US;
  if B05001001 then BornInUS = (B05001002/B05001001);

  * B07001 - Geographical Mobility in Past Year by Age for Current Residence in US;
  if B07001001 then MovedInLast12Mon = 1 - (B07001017/B07001001);

  * B08201 - Household Size by Vehicles Available;
  if B08201001 then HH_NoCar = B08201002/B08201001;

  * B12001 - Sex by Marital Status for Population 15+;
  if B12001001 then do;
    Married = sum(B12001004, B12001013)/B12001001;
    Divorced = sum(B12001010, B12001019)/B12001001;
  end;

  * B15002 - Sex by Educational Attainment for Population 25+;
  if B15002001 then do;
    education1 = sum(B15002003, B15002004, B15002005, B15002006, B15002020, B15002021, B15002022, B15002023)/B15002001;
    education2 = sum(B15002007, B15002008, B15002009, B15002010, B15002024, B15002025, B15002026, B15002027)/B15002001;
    education3 = sum(B15002011, B15002028)/B15002001;
    education4 = sum(B15002012, B15002013, B15002029, B15002030)/B15002001;
    education5 = sum(B15002014, B15002031)/B15002001;
    education6 = sum(B15002015, B15002032)/B15002001;
    education7 = sum(B15002016, B15002017, B15002033, B15002034)/B15002001;
    education8 = sum(B15002018, B15002035)/B15002001;
  end;

  * B16007 - Age by Language Spoken at Home for Population 5+;
  if B16007001 then do;
    English_Speaker = sum(B16007003, B16007009, B16007015)/B16007001;
    Spanish_Speaker = sum(B16007004, B16007010, B16007016)/B16007001;
  end;

  * B17001 - Poverty Status in Past 12 Months by Sex & Age;
  if B17001001 then fampoverty = B17001002/B17001001;

  * B17026 - Ratio of Income to Poverty Level of Families in Past 12 Months;
  if B17026001 then do;
    houspoverty = sum(B17026002, B17026003, B17026004)/B17026001;
    pov_lt_50 = B17026002/B17026001;
    pov_50_74 = B17026003/B17026001;
    pov_75_99 = B17026004/B17026001;
    pov_100_124 = B17026005/B17026001;
    pov_125_149 = B17026006/B17026001;
    pov_150_174 = B17026007/B17026001;
    pov_175_184 = B17026008/B17026001;
    pov_185_199 = B17026009/B17026001;
    pov_gt_200 = sum(B17026010, B17026011, B17026012, B17026013)/B17026001;
  end;

  * B18101 - Sex by Age by Disability Status;
  if not(missing(sum(B18101009, B18101012, B18101015, B18101018))) then
    Disability = sum(B18101010, B18101013, B18101016, B18101019)/sum(B18101009, B18101012, B18101015, B18101018);

  * B19001 - Household Income in Past 12 Months;
  if B19001001 then do;
    housincome1 = B19001002/B19001001;
    housincome2 = B19001003/B19001001;
    housincome3 = B19001004/B19001001;
    housincome4 = B19001005/B19001001;
    housincome5 = B19001006/B19001001;
    housincome6 = B19001007/B19001001;
    housincome7 = B19001008/B19001001;
    housincome8 = B19001009/B19001001;
    housincome9 = B19001010/B19001001;
    housincome10 = B19001011/B19001001;
    housincome11 = B19001012/B19001001;
    housincome12 = B19001013/B19001001;
    housincome13 = B19001014/B19001001;
    housincome14 = B19001015/B19001001;
    housincome15 = B19001016/B19001001;
    housincome16 = B19001017/B19001001;
  end;

  * B19057 - Household Public Assistance Income in Past 12 Months;
  if B19057001 then HH_Public_Assistance = B19057002/B19057001;

  * B19101 - Family Income in Past 12 Months;
  if B19101001 then do;
    famincome1 = B19101002/B19101001;
    famincome2 = B19101003/B19101001;
    famincome3 = B19101004/B19101001;
    famincome4 = B19101005/B19101001;
    famincome5 = B19101006/B19101001;
    famincome6 = B19101007/B19101001;
    famincome7 = B19101008/B19101001;
    famincome8 = B19101009/B19101001;
    famincome9 = B19101010/B19101001;
    famincome10 = B19101011/B19101001;
    famincome11 = B19101012/B19101001;
    famincome12 = B19101013/B19101001;
    famincome13 = B19101014/B19101001;
    famincome14 = B19101015/B19101001;
    famincome15 = B19101016/B19101001;
    famincome16 = B19101017/B19101001;
  end;

  * B23001 - Sex by Age by Employment Status for Population 16+;
  if B23001001 then do;
    Unemployment = sum(B23001008, B23001015, B23001022, B23001029, B23001036, B23001043, B23001050, B23001057,
      B23001064, B23001071, B23001076, B23001081, B23001086, B23001094, B23001101, B23001108, B23001115,
      B23001122, B23001129, B23001136, B23001143, B23001150, B23001157, B23001162, B23001167, B23001172)/B23001001;
    Unemployment_Male = sum(B23001008, B23001015, B23001022, B23001029, B23001036, B23001043, B23001050, B23001057,
      B23001064, B23001071, B23001076, B23001081, B23001086)/B23001002;
  end;

  * B25014 - Tenure by Occupants per Room;
  if B25014001 then
    Pct_crowding = sum(B25014005, B25014006, B25014007, B25014011, B25014012, B25014013)/B25014001;

  * B25026 - Total Population in Occupied Housing Units by Tenure by Year Householder Moved into Unit;
  if B25026001 then
    Same_residence = sum(B25026004, B25026005, B25026006, B25026007, B25026008, B25026011, B25026012,
      B25026013, B25026014, B25026015)/B25026001;

  * B25091 - Mortgage Status by Selected Monthly Owner Costs as Percentage of HH Income in Past 12 Months;
  if B25091001 then do;
    Hmowner_costs_mort = B25091011/B25091001;
    Hmowner_costs_no_mort = B25091022/B25091001;
  end;

  * B25115 - Tenure by Household Type & Presence & Age of Own Children;
  if B25115001 then
    Female_Head_of_HH = sum(B25115011, B25115024)/B25115001;

  * C24040 - Sex by Industry for Full-time, Year-round Civilian Employed for Population 16+;
  if C24040001 then do;
    MGR_Female = sum(C24040046, C24040045)/C24040001;
    MGR_Male = sum(C24040019, C24040018)/C24040001;
  end;

  * C27006 - Medicare Coverage by Sex & Age;
  if C27006001 then
    Ins_Medicare = sum(C27006004, C27006007, C27006010, C27006014, C27006017, C27006020)/C27006001;

  * C27007 - Medicaid Coverage by Sex & Age;
  if C27007001 then
    Ins_Medicaid = sum(C27007004, C27007007, C27007010, C27007014, C27007017, C27007020)/C27007001;

  * Variables of interest to KPWA;
  * % males age 20-64 not in labor force (Roblin 2013);
  &_SITEABBR._males_out_labor_force = sum(B23001011, B23001018, B23001025, B23001032, B23001039, B23001046, B23001053, B23001060, B23001067)
    / sum (B23001010, B23001017, B23001024, B23001031, B23001038, B23001045, B23001052, B23001059, B23001066);

  * Keep only VDW variables in production.;
  &ETL_KEEP_STMT.;
run;

proc sql;
  create index geocode on output.census_demog;
  create index state on output.census_demog;
quit;