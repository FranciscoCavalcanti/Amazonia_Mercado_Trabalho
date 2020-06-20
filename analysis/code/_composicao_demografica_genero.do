//////////////////////////////////////////////
//	3) Gênero
//////////////////////////////////////////////

* call data 
use "$output_dir_build\_composicao_demografica_amazonia_legal_mulher.dta", clear
gen id = "Mulher"
* append data
append using "$output_dir_build\_composicao_demografica_amazonia_legal_homem.dta"
replace id = "Homem" if id==""

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
		graph twoway connected `lname' trim 	if mulher == 1 || /*
		*/  connected `lname' trim 	if homem == 1 	/*
		*/ 	,  title("`label_var'", size(small)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range(0 20) lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Mulher") label(2 "Homem") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
		** Y-axis between ()
		else {
		graph twoway connected `lname' trim 	if mulher == 1 || /*
		*/  connected `lname' trim 	if homem == 1 	/*
		*/ 	,  title("`label_var'", size(small)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Mulher") label(2 "Homem") size(vsmall) )	/*
		*/ 	xlabel(#8, grid angle(45))	
		}
	
* save graph 
graph save Graph "$output_dir\composicao_demografica\genero\_composicao_demografica_genero_`lname'.gph", replace
graph use "$output_dir\composicao_demografica\genero\_composicao_demografica_genero_`lname'.gph"
graph export "$output_dir\composicao_demografica\genero\_composicao_demografica_genero_`lname'.png", replace		

}

*
clear