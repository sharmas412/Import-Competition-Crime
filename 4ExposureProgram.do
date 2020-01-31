clear
cd "J:\Second Paper\CountyBusinessPattern\AfterDorn"



local country China Canada Germany Japan Korea Mexico

		foreach c of local country{
			forvalues i=1992(5)2002{
				if `i'==1992{
					use CBP`i'.dta
					merge m:m sic87dd using "J:\Second Paper\UNComtrade\USImports\19961992`c'.dta", keep(3) nogen
					gen firstterm=tot_ind_CZ/tot_cz_emp
					gen secondterm=ImportChange`c'19961992/tot_ind_emp
					gen initialexposure`c'=(firstterm*secondterm)/1000 //expressing exposure in per $1000
					sort cz	
					collapse (sum) initialexposure`c' (mean) cz_man_share, by(cz year)
					save "J:\Second Paper\Exposure\1992Exposure`c'.dta",replace
				}	
				
				if `i'==1997{
					use CBP`i'.dta
					merge m:m sic87dd using "J:\Second Paper\UNComtrade\USImports\20011997`c'.dta", keep(3) nogen
					gen firstterm=tot_ind_CZ/tot_cz_emp
					gen secondterm=ImportChange`c'20011997/tot_ind_emp
					gen initialexposure`c'=(firstterm*secondterm)/1000 //expressing exposure in per $1000
					sort cz	
					collapse (sum) initialexposure`c' (mean) cz_man_share, by(cz year)
					save "J:\Second Paper\Exposure\1997Exposure`c'.dta",replace
				}

				if `i'==2002{
					use CBP`i'.dta
					merge m:m sic87dd using "J:\Second Paper\UNComtrade\USImports\20062002`c'.dta", keep(3) nogen
					gen firstterm=tot_ind_CZ/tot_cz_emp
					gen secondterm=ImportChange`c'20062002/tot_ind_emp
					gen initialexposure`c'=(firstterm*secondterm)/1000 //expressing exposure in per $1000
					sort cz	
					collapse (sum) initialexposure`c' (mean) cz_man_share, by(cz year)
					save "J:\Second Paper\Exposure\2002Exposure`c'.dta",replace
				}
			}
		}
		
			

