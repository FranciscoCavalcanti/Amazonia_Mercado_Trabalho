//////////////////////////////////////////////
//	
//	4) Matriz de transições de ocupações
//	
//////////////////////////////////////////////

/*
* call data 
use "$output_dir_build\_transicao_ocupacao_amazonia_legal_matriz.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_transicao_ocupacao_resto_brasil_matriz.dta"
replace id = "Resto do Brasil" if id==""
*/



* call data 
use "$output_dir_build\_transicao_ocupacao_amazonia_legal_trimestral.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_transicao_ocupacao_resto_brasil_trimestral.dta"
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
ds sh_* 
local type `r(varlist)'
display "`type'"

* set design of graph
set scheme s1mono

* begin of loop over variables
foreach lname in `type' {

local label_var: variable label `lname'

	* Graphs separated by the range of Y-axis
		** Y-axis between (0 20)
		if "`lname'" == "prop_bolsa_familia" 	{
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
	
		** Y-axis between (0 100)
		else {
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
	
* save graph 
graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_`lname'.gph", replace
graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_`lname'.gph"
graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_`lname'.png", replace		

}

*
clear