clear
cd "J:\Second Paper\CountyBusinessPattern\AfterDorn"

*=======================Find commuting zone level total employment, employment by industry and manufacturing share

forvalues i=1987(5)2002{

	use CBP_`i'adj.dta
	
	if `i'<2002{
		rename (code4 countyid) (sic87 fips)
		collapse (sum) imp_emp if level==4, by(sic87 fips year)
		do dorn8787dd //Concordance of SIC87 with SIC87dd
		collapse (sum) imp_emp, by(sic87dd fips year)
		merge m:m fips using "J:\Second Paper\ConcordanceFiles\CountyToCZ90.dta", keep(3) nogen
		rename (imp_emp cz90) (emp cz)
	}
	
	
	if `i'>=2002{
		rename (code5 countyid) (naics97 fips)
		collapse (sum) imp_emp if level==5, by (naics97 fips year)		
		joinby naics97 using "J:\Second Paper\ConcordanceFiles\NAICS97toSIC87.dta" //NAICS97 concords with different sic87, and has respective weights on how it concords
		gen emp=imp_emp*weight
		collapse (sum) emp, by(sic87 fips year)
		do dorn8787dd //Concordance of SIC87 with SIC87dd
		collapse (sum) emp, by(sic87dd fips year)
		merge m:m fips using "J:\Second Paper\ConcordanceFiles\CountyToCZ00.dta", keep(3) nogen
	}
	
	bysort sic87dd: egen tot_ind_emp=total(emp)
	bysort cz: egen tot_cz_emp= total(emp)
	bysort cz sic87dd: egen tot_ind_CZ=total(emp)
	bysort cz: egen tot_cz_man_emp=total(emp) if sic87dd>=2011 & sic87dd<=3999
	bysort cz: egen cz_man_emp=max(tot_cz_man_emp)
	gen cz_man_share=cz_man_emp/tot_cz_emp
	sort cz sic87dd
	collapse tot_cz_emp cz_man_share tot_ind_CZ tot_ind_emp year, by(cz sic87dd)

save CBP`i'.dta,replace
}
