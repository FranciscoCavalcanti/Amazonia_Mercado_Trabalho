//////////////////////////////////////////////
//	6) Faixa etária
//////////////////////////////////////////////

* call data 
use "$output_dir_build\_composicao_demografica_amazonia_legal_faixa_etaria_17.dta", clear
gen id = "14 a 17 anos"
* append data
append using "$output_dir_build\_composicao_demografica_amazonia_legal_faixa_etaria_24.dta"
replace id = "18 a 24 anos" if id==""
append using "$output_dir_build\_composicao_demografica_amazonia_legal_faixa_etaria_39.dta"
replace id = "25 a 39 anos" if id==""
append using "$output_dir_build\_composicao_demografica_amazonia_legal_faixa_etaria_59.dta"
replace id = "40 a 59 anos" if id==""
append using "$output_dir_build\_composicao_demografica_amazonia_legal_faixa_etaria_60.dta"
replace id = "> 60 anos" if id==""


* generate variable of quartely date
	tostring Ano, replace
	tostring Trimestre, replace
	gen iten1 = Ano + "." + Trimestre
	gen  trim = quarterly(iten1, "YQ")
	drop iten*
	
* edit format
encode id, generate(id2)
tsset id2 trim, quarterly 
format %tqCCYY trim

* select variables
ds prop_* taxa_* 
local type `r(varlist)'
display "`type'"

* set design of graph
set scheme s1mono

* begin of loop over variables
foreach lname in `type' {

local label_var: variable label `lname'

	* Graphs separated by the range of Y-axis
		** Y-axis between (0 20)
		if "`lname'" == "prop_militar" 	/*
		*/ 	| "`lname'" == "taxa_de_desemprego" 	{
* 		Grafico 
		graph twoway connected `lname' trim 	if faixa_etaria_17  == 1 || /*
		*/  connected `lname' trim 	if faixa_etaria_24  == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_39   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_59   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_60  == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0 20) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3 4 5) cols(5) label(1 "14 a 17 anos") label(2 "18 a 24 anos") label(3 "25 a 39 anos") label(4 "40 a 59 anos") label(5 "> 60 anos") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
		else if "`lname'" == "taxa_de_ocupacao" 	/*
		*/ 	| "`lname'" == "taxa_de_informalidade" 	/*
		*/ 	| "`lname'" == "taxa_de_participacao" 	{
* 		Grafico 
		graph twoway connected `lname' trim 	if faixa_etaria_17  == 1 || /*
		*/  connected `lname' trim 	if faixa_etaria_24  == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_39   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_59   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_60  == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3 4 5) cols(5) label(1 "14 a 17 anos") label(2 "18 a 24 anos") label(3 "25 a 39 anos") label(4 "40 a 59 anos") label(5 "> 60 anos") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}	
		** Y-axis between ()
		else {
* 		Grafico 
		graph twoway connected `lname' trim 	if faixa_etaria_17  == 1 || /*
		*/  connected `lname' trim 	if faixa_etaria_24  == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_39   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_59   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_60  == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3 4 5) cols(5) label(1 "14 a 17 anos") label(2 "18 a 24 anos") label(3 "25 a 39 anos") label(4 "40 a 59 anos") label(5 "> 60 anos") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\composicao_demografica\faixa_etaria\_composicao_demografica_faixa_etaria_`lname'.gph", replace
graph use "$output_dir\composicao_demografica\faixa_etaria\_composicao_demografica_faixa_etaria_`lname'.gph"
graph export "$output_dir\composicao_demografica\faixa_etaria\_composicao_demografica_faixa_etaria_`lname'.png", replace		

}


* select variables
ds n_*
local type `r(varlist)'
display "`type'"

* set design of graph
set scheme s1mono

* begin of loop over variables
foreach lname in `type' {

local label_var: variable label `lname'

	* Graphs separated by the range of Y-axis
		** Y-axis between (0 20)
		if "`lname'" == "" {
* 		Grafico 
		graph twoway connected `lname' trim 	if faixa_etaria_17  == 1 || /*
		*/  connected `lname' trim 	if faixa_etaria_24  == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_39   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_59   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_60  == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#6, angle(0) format(%12.0fc)) 		/*
		*/	yscale( axis(1) range(0 20) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3 4 5) cols(5) label(1 "14 a 17 anos") label(2 "18 a 24 anos") label(3 "25 a 39 anos") label(4 "40 a 59 anos") label(5 "> 60 anos") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
		** Y-axis between ()
		else {
* 		Grafico 
		graph twoway connected `lname' trim 	if faixa_etaria_17  == 1 || /*
		*/  connected `lname' trim 	if faixa_etaria_24  == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_39   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_59   == 1  || /*
		*/  connected `lname' trim 	if faixa_etaria_60  == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#6, angle(0) format(%12.0fc) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3 4 5) cols(5) label(1 "14 a 17 anos") label(2 "18 a 24 anos") label(3 "25 a 39 anos") label(4 "40 a 59 anos") label(5 "> 60 anos") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\composicao_demografica\faixa_etaria\_composicao_demografica_faixa_etaria_`lname'.gph", replace
graph use "$output_dir\composicao_demografica\faixa_etaria\_composicao_demografica_faixa_etaria_`lname'.gph"
graph export "$output_dir\composicao_demografica\faixa_etaria\_composicao_demografica_faixa_etaria_`lname'.png", replace		

}
*
clear