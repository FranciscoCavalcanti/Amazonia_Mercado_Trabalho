//////////////////////////////////////////////
//	
//	1) Descrever a estrutrura do emprego
//	
//////////////////////////////////////////////

* call data 
use "$output_dir_build\_estrutura_emprego_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_estrutura_emprego_resto_brasil.dta"
replace id = "Resto do Brasil" if id==""

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
		graph twoway connected `lname' trim 	if id == "Amazônia Legal" || /*
		*/  connected `lname' trim 	if id == "Resto do Brasil"  	/*  
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0 20) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Amazônia Legal") label(2 "Resto do Brasil") size(Medium) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
		else if "`lname'" == "taxa_de_ocupacao" 	/*
		*/ 	| "`lname'" == "taxa_de_informalidade" 	/*
		*/ 	| "`lname'" == "taxa_de_participacao" 	{
* 		Grafico 
		graph twoway connected `lname' trim 	if id == "Amazônia Legal" || /*
		*/  connected `lname' trim 	if id == "Resto do Brasil"  	/*  
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Amazônia Legal") label(2 "Resto do Brasil") size(Medium) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
		** Y-axis between ()
		else {
		graph twoway connected `lname' trim 	if id == "Amazônia Legal" || /*
		*/  connected `lname' trim 	if id == "Resto do Brasil"  	/*  
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Amazônia Legal") label(2 "Resto do Brasil") size(Medium) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\estrutura_emprego\_estrutura_emprego_`lname'.gph", replace
graph use "$output_dir\estrutura_emprego\_estrutura_emprego_`lname'.gph"
graph export "$output_dir\estrutura_emprego\_estrutura_emprego_`lname'.png", replace		

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
		graph twoway connected `lname' trim 	if id == "Amazônia Legal" || /*
		*/  connected `lname' trim 	if id == "Resto do Brasil"  	/*  
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#7, angle(0) format(%12.0fc) ) 		/*
		*/	yscale( axis(1) range(0) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Amazônia Legal") label(2 "Resto do Brasil") size(Medium) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
		** Y-axis between ()
		else {
		graph twoway connected `lname' trim 	if id == "Amazônia Legal" || /*
		*/  connected `lname' trim 	if id == "Resto do Brasil"  	/*  
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#7, angle(0) format(%12.0fc) ) 		/*
		*/	yscale( axis(1) range(0) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Amazônia Legal") label(2 "Resto do Brasil") size(Medium) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\estrutura_emprego\_estrutura_emprego_`lname'.gph", replace
graph use "$output_dir\estrutura_emprego\_estrutura_emprego_`lname'.gph"
graph export "$output_dir\estrutura_emprego\_estrutura_emprego_`lname'.png", replace		

}
*
clear