clear
cd "J:\SecondPaper\Exposure"

forvalues i=1992(5)2002{

	if `i'==1992{
		use 1992ExposureChina.dta
		merge 1:1 cz using 1992ExposureCanada, keep(3) nogen
		merge 1:1 cz using 1992ExposureGermany, keep(3) nogen
		merge 1:1 cz using 1992ExposureJapan, keep(3) nogen
		merge 1:1 cz using 1992ExposureKorea, keep(3) nogen
		merge 1:1 cz using 1992ExposureMexico, keep(3) nogen
		merge 1:1 cz using 1992ExposureIV, keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\CountyDemographics\1992CZDemographics.dta", keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\Downloaded Crime Data\19921996Crime.dta", keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\CountyDemographics\Unemployment\19961992URate.dta", keep(3) nogen
		save "J:\SecondPaper\Final Dataset\1992FinalCZ.dta",replace
	}
		
		if `i'==1997{
		use 1997ExposureChina.dta
		merge 1:1 cz using 1997ExposureCanada, keep(3) nogen
		merge 1:1 cz using 1997ExposureGermany, keep(3) nogen
		merge 1:1 cz using 1997ExposureJapan, keep(3) nogen
		merge 1:1 cz using 1997ExposureKorea, keep(3) nogen
		merge 1:1 cz using 1997ExposureMexico, keep(3) nogen
		merge 1:1 cz using 1997ExposureIV, keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\CountyDemographics\1997CZDemographics.dta", keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\Downloaded Crime Data\19972001Crime.dta", keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\CountyDemographics\Unemployment\20011997URate.dta", keep(3) nogen
		save "J:\SecondPaper\Final Dataset\1997FinalCZ.dta",replace
	}
	
		if `i'==2002{
		use 2002ExposureChina.dta
		merge 1:1 cz using 2002ExposureCanada, keep(3) nogen
		merge 1:1 cz using 2002ExposureGermany, keep(3) nogen
		merge 1:1 cz using 2002ExposureJapan, keep(3) nogen
		merge 1:1 cz using 2002ExposureKorea, keep(3) nogen
		merge 1:1 cz using 2002ExposureMexico, keep(3) nogen
		merge 1:1 cz using 2002ExposureIV, keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\CountyDemographics\2002CZDemographics.dta", keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\Downloaded Crime Data\20022006Crime.dta", keep(3) nogen
		merge 1:1 cz using "J:\SecondPaper\CountyDemographics\Unemployment\20062002URate.dta", keep(3) nogen
		save "J:\SecondPaper\Final Dataset\2002FinalCZ.dta",replace
	}
}

clear
cd "J:\SecondPaper\Final Dataset"
use 1992FinalCZ.dta
append using 1997FinalCZ.dta
append using 2002FinalCZ.dta
merge m:m state using "J:\SecondPaper\ConcordanceFiles\stateregion.dta", keep(3) nogen
save FinalData.dta,replace

	
