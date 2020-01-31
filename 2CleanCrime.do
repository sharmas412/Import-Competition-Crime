clear
cd "J:\Second Paper\Downloaded Crime Data"


foreach i in 1992 1996 1997 2001 2002 2006{
	use `i'DloadCrime
	
	keep  FIPS_ST FIPS_CTY CPOPCRIM MURDER RAPE ROBBERY AGASSLT BURGLRY LARCENY MVTHEFT ARSON
	rename (FIPS_ST FIPS_CTY CPOPCRIM MURDER RAPE ROBBERY AGASSLT BURGLRY LARCENY MVTHEFT ARSON) (fips_st fips_cty Population Murder Rape Robbery Assault Burglary Larceny MVTheft Arson)
	
	gen fips=fips_st*1000+fips_cty
	gen year=`i'
	
	
	egen Violent=rowtotal(Murder Rape Robbery Assault)
	egen Property= rowtotal (Burglary Larceny MVTheft Arson)
	
*Drop if not full dataset of crime for each county in the commuting zone

	if `i'<=2001{
		merge m:m fips using "J:\Second Paper\ConcordanceFiles\CountyToCZ90.dta",keep(3) nogen 
		rename cz90 cz
	}
	
	if `i'>=2002{	
		merge m:m fips using "J:\Second Paper\ConcordanceFiles\CountyToCZ00.dta", keep(3) nogen 
	}	
	
	bysort cz: egen minP=min(Property)
	bysort cz: egen minV=min(Violent) 
	drop if minP==0 
	drop if minV==0
	drop if Population==0
	drop minP minV
	
*Assign State to CZ with the most represented state in the CZ
	bysort cz fips_st: gen freq=_N
	bysort cz: egen maxFreq=max(freq)
	bysort cz: gen nstate=fips_st if maxFreq==freq
	sort cz nstate
	bysort cz: replace nstate=nstate[_n-1] if missing(nstate)
	bysort cz: egen state=min(nstate)

	
	
* Create Crime rate per Thousand
	bysort cz: egen totalCZpop=total(Population)
	bysort cz: egen totalProperty=total(Property)
	bysort cz: egen totalViolent=total(Violent)
	collapse year state totalCZpop totalProperty totalViolent, by(cz)
	
	gen PropertyCZ=(totalProperty/totalCZpop)*1000
	gen ViolentCZ=(totalViolent/totalCZpop)*1000
	
	gen LnCZProperty`i'=ln(PropertyCZ)
	gen LnCZViolent`i'=ln(ViolentCZ)
	
	keep cz year LnCZProperty`i' LnCZViolent`i' state
	
save `i'Crime.dta,replace 
}		
	
	

*===============================================================================================================================================================
*							Find Crime Difference
*===================================================================================================================================================================
 clear
 
 use 1992Crime.dta
 merge 1:1 cz using 1996Crime.dta, keep(3) nogen
 gen LnChangeProperty=LnCZProperty1996 - LnCZProperty1992
 gen LnChangeViolent=LnCZViolent1996-LnCZViolent1992
 keep cz year LnChangeProperty LnChangeViolent state
 save 19921996Crime.dta,replace
 
 use 1997Crime.dta
 merge 1:1 cz using 2001Crime.dta, keep(3) nogen
 gen LnChangeProperty=LnCZProperty2001 - LnCZProperty1997
 gen LnChangeViolent=LnCZViolent2001-LnCZViolent1997
 keep cz year LnChangeProperty LnChangeViolent state
 save 19972001Crime.dta,replace
 
 use 2002Crime.dta
 merge 1:1 cz using 2006Crime.dta, keep(3) nogen
 gen LnChangeProperty=LnCZProperty2006 - LnCZProperty2002
 gen LnChangeViolent=LnCZViolent2006-LnCZViolent2002
 keep cz year LnChangeProperty LnChangeViolent state
 save 20022006Crime.dta,replace
 
 
 
