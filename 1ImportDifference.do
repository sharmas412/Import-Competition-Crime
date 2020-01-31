clear
cd "J:\Second Paper\UNComtrade\USImports"


local year 1992 1996 1997 2001 2002 2006
local country China Canada Germany Japan Mexico Korea

foreach y of local year{
    foreach c of local country{
        use `y'`c'.dta, clear
		destring commoditycode, replace force
		drop if commoditycode==.
		rename commoditycode hs6
		keep if tradeflow=="Import"
		
*Merge the HS6 code with SIC87dd based on the crosswalk provided by Dron
		merge m:m hs6 using "J:\Second Paper\ConcordanceFiles\HS6toSIC87dd", keep(3) nogen
        gen trade`y'`c'=tradevalueus*share
		collapse(sum) trade`y'`c', by(sic87dd year)
		
		save new`y'`c'.dta,replace
    }

}


*===============================================================================================================

*Trade Difference 1992-1996
clear

local country China Canada Germany Japan Mexico Korea

foreach c of local country{
	use new1992`c'.dta,clear
	merge 1:1 sic87dd using new1996`c'.dta, keep(3) nogen
	gen ImportChange`c'19961992=trade1996`c'-trade1992`c'
	save 19961992`c'.dta,replace
}


*Trade Difference 1997-2001
clear

local country China Canada Germany Japan Mexico Korea

foreach c of local country{
	use new1997`c'.dta,clear
	merge 1:1 sic87dd using new2001`c'.dta, keep(3) nogen
	gen ImportChange`c'20011997=trade2001`c'-trade1997`c'
	save 20011997`c'.dta,replace
}

*Trade Difference 2006-2002
clear

local country China Canada Germany Japan Mexico Korea

foreach c of local country{
	use new2002`c'.dta,clear
	merge 1:1 sic87dd using new2006`c'.dta, keep(3) nogen
	gen ImportChange`c'20062002=trade2006`c'-trade2002`c'
	save 20062002`c'.dta,replace
}
