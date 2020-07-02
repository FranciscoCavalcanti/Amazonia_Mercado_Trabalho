//////////////////////////////////////////////
//	5) Setor
//////////////////////////////////////////////

* call data 
use "$output_dir_build\_composicao_demografica_amazonia_legal_setor_agricultura.dta", clear
gen id = "Agricultura"
* append data
append using "$output_dir_build\_composicao_demografica_amazonia_legal_setor_industria.dta"
replace id = "Indústria" if id==""
append using "$output_dir_build\_composicao_demografica_amazonia_legal_setor_comercio.dta"
replace id = "Comércio" if id==""
append using "$output_dir_build\_composicao_demografica_amazonia_legal_setor_servicos.dta"
replace id = "Serviços" if id==""
append using "$output_dir_build\_composicao_demografica_amazonia_legal_setor_construcao.dta"
replace id = "Construção" if id==""


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
		graph twoway connected `lname' trim 	if setor_agricultura  == 1 || /*
		*/  connected `lname' trim 	if setor_industria  == 1  || /*
		*/  connected `lname' trim 	if setor_comercio   == 1  || /*
		*/  connected `lname' trim 	if setor_servicos   == 1  || /*
		*/  connected `lname' trim 	if setor_construcao  == 1 	/*
		*/ 	,  title("`label_var'", size(small)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0 20) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3 4 5) cols(5) label(1 "Agricultura") label(2 "Indústria") label(3 "Comércio") label(4 "Serviços") label(5 "Construção") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
		** Y-axis between ()
		else {
* 		Grafico 
		graph twoway connected `lname' trim 	if setor_agricultura  == 1 || /*
		*/  connected `lname' trim 	if setor_industria  == 1  || /*
		*/  connected `lname' trim 	if setor_comercio   == 1  || /*
		*/  connected `lname' trim 	if setor_servicos   == 1  || /*
		*/  connected `lname' trim 	if setor_construcao  == 1 	/*
		*/ 	,  title("`label_var'", size(small)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2 3 4 5) cols(5) label(1 "Agricultura") label(2 "Indústria") label(3 "Comércio") label(4 "Serviços") label(5 "Construção") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\composicao_demografica\setor\_composicao_demografica_setor_`lname'.gph", replace
graph use "$output_dir\composicao_demografica\setor\_composicao_demografica_setor_`lname'.gph"
graph export "$output_dir\composicao_demografica\setor\_composicao_demografica_setor_`lname'.png", replace		

}

*
clear