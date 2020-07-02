//////////////////////////////////////////////
//	2) Área geográfica
//////////////////////////////////////////////

************************
** 2.1) Rural vs. Urbano
************************

* call data 
use "$output_dir_build\_composicao_demografica_amazonia_legal_domicilio_rural.dta", clear
gen id = "Rural"
* append data
append using "$output_dir_build\_composicao_demografica_amazonia_legal_domicilio_urbano.dta"
replace id = "Urbano" if id==""

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
ds prop_* taxa_* n_*
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
		graph twoway connected `lname' trim 	if domicilio_rural == 1 || /*
		*/  connected `lname' trim 	if domicilio_urbano == 1 	/*
		*/ 	,  title("`label_var'", size(small)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0 20) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Domicílios rural") label(2 "Domicílios urbano") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
		** Y-axis between ()
		else {
		graph twoway connected `lname' trim 	if domicilio_rural == 1 || /*
		*/  connected `lname' trim 	if domicilio_urbano == 1 	/*
		*/ 	,  title("`label_var'", size(small)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Domicílios rural") label(2 "Domicílios urbano") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\composicao_demografica\area_geografica\_composicao_demografica_rural_urbano_`lname'.gph", replace
graph use "$output_dir\composicao_demografica\area_geografica\_composicao_demografica_rural_urbano_`lname'.gph"
graph export "$output_dir\composicao_demografica\area_geografica\_composicao_demografica_rural_urbano_`lname'.png", replace		

}

*
clear

************************
** 2.2) Região Metropolitana vs. Urbano
************************

* call data 
use "$output_dir_build\_composicao_demografica_amazonia_legal_area_regiao_metropolitana.dta", clear
gen id = "Região Metropolitana"
* append data
append using "$output_dir_build\_composicao_demografica_amazonia_legal_area_nregiao_metropolitana.dta"
replace id = "Fora de Região Metropolitana" if id==""

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
		graph twoway connected `lname' trim 	if area_regiao_metropolitana == 1 || /*
		*/  connected `lname' trim 	if area_nregiao_metropolitana == 1 	/*
		*/ 	,  title("`label_var'", size(small)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0 20) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Região Metropolitana") label(2 "Fora de Região Metropolitana") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
		** Y-axis between ()
		else {
* 		Grafico 
		graph twoway connected `lname' trim 	if area_regiao_metropolitana == 1 || /*
		*/  connected `lname' trim 	if area_nregiao_metropolitana == 1 	/*
		*/ 	,  title("`label_var'", size(small)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Região Metropolitana") label(2 "Fora de Região Metropolitana") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\composicao_demografica\area_geografica\_composicao_demografica_regiao_metro_`lname'.gph", replace
graph use "$output_dir\composicao_demografica\area_geografica\_composicao_demografica_regiao_metro_`lname'.gph"
graph export "$output_dir\composicao_demografica\area_geografica\_composicao_demografica_regiao_metro_`lname'.png", replace		

}

*
clear