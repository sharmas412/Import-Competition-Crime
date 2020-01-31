clear
cd "J:\Second Paper\CountyDemographics\Unemployment"

foreach i in 1992 1996 1997 2001 2002 2006{
	use `i'Unemployment.dta
	gen fips=fips_st*1000+fips_cty
	keep fips URate
	
	if `i'<=2001{
		merge m:m fips using "J:\Second Paper\ConcordanceFiles\CountyToCZ90.dta", keep(3) nogen
		collapse URate, by(cz90)
		rename (cz90 URate) (cz URate`i')
		save `i'URate.dta,replace
	}

	if `i'>=2002{
		merge m:m fips using "J:\Second Paper\ConcordanceFiles\CountyToCZ00.dta", keep(3) nogen
		collapse URate, by(cz)
		rename URate URate`i'
		save `i'URate.dta,replace
	}
}


*Find first difference of Unemp

clear

use 1996URate.dta
merge 1:1 cz using 1992URate.dta, keep(3) nogen
gen URateChange=URate1996-URate1992
drop URate1996 URate1992
gen year=1992
save 19961992URate.dta,replace


use 2001URate.dta
merge 1:1 cz using 1997URate.dta, keep(3) nogen
gen URateChange=URate2001-URate1997
drop URate2001 URate1997
gen year=1997
save 20011997URate.dta,replace

use 2006URate.dta
merge 1:1 cz using 2002URate.dta, keep(3) nogen
gen URateChange=URate2006-URate2002
drop URate2006 URate2002
gen year=2002
save 20062002URate.dta,replace
