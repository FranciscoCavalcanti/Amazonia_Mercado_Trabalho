//////////////////////////////////////////////
//	4) Raça
//////////////////////////////////////////////

* call data 
use "$output_dir_build\_composicao_demografica_amazonia_legal_raca_branca.dta", clear
gen id = "Branca e Amarela"
* append data
append using "$output_dir_build\_composicao_demografica_amazonia_legal_raca_indigena.dta"
replace id = "Indígena" if id==""
append using "$output_dir_build\_composicao_demografica_amazonia_legal_raca_preta.dta"
replace id = "Preto e Parda" if id==""

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
		graph twoway connected `lname' trim 	if raca_branca == 1 || /*
		*/  connected `lname' trim 	if raca_preta == 1  || /*
		*/  connected `lname' trim 	if raca_indigena == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0 20) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3) cols(3) label(1 "Branca/Amarela") label(2 "Preta/Parda") label(3 "Indígena") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
		else if "`lname'" == "taxa_de_ocupacao" 	/*
		*/ 	| "`lname'" == "taxa_de_informalidade" 	/*
		*/ 	| "`lname'" == "taxa_de_participacao" 	{
* 		Grafico 
		graph twoway connected `lname' trim 	if raca_branca == 1 || /*
		*/  connected `lname' trim 	if raca_preta == 1  || /*
		*/  connected `lname' trim 	if raca_indigena == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3) cols(3) label(1 "Branca/Amarela") label(2 "Preta/Parda") label(3 "Indígena") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}		
		** Y-axis between ()
		else {
		graph twoway connected `lname' trim 	if raca_branca == 1 || /*
		*/  connected `lname' trim 	if raca_preta == 1  || /*
		*/  connected `lname' trim 	if raca_indigena == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3) cols(3) label(1 "Branca/Amarela") label(2 "Preta/Parda") label(3 "Indígena") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\composicao_demografica\raca\_composicao_demografica_raca_`lname'.gph", replace
graph use "$output_dir\composicao_demografica\raca\_composicao_demografica_raca_`lname'.gph"
graph export "$output_dir\composicao_demografica\raca\_composicao_demografica_raca_`lname'.png", replace		

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
		graph twoway connected `lname' trim 	if raca_branca == 1 || /*
		*/  connected `lname' trim 	if raca_preta == 1  || /*
		*/  connected `lname' trim 	if raca_indigena == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) format(%12.0fc)  ) 		/*
		*/	yscale( axis(1) range(0) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3) cols(3) label(1 "Branca/Amarela") label(2 "Preta/Parda") label(3 "Indígena") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
		** Y-axis between ()
		else {
		graph twoway connected `lname' trim 	if raca_branca == 1 || /*
		*/  connected `lname' trim 	if raca_preta == 1  || /*
		*/  connected `lname' trim 	if raca_indigena == 1 	/*
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#6, angle(0) format(%12.0fc) ) 		/*
		*/	yscale( axis(1) range(0) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3) cols(3) label(1 "Branca/Amarela") label(2 "Preta/Parda") label(3 "Indígena") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\composicao_demografica\raca\_composicao_demografica_raca_`lname'.gph", replace
graph use "$output_dir\composicao_demografica\raca\_composicao_demografica_raca_`lname'.gph"
graph export "$output_dir\composicao_demografica\raca\_composicao_demografica_raca_`lname'.png", replace		

}
*
clear