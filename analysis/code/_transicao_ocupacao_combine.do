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
set scheme amz2030


* Desempregado

	* Combing graphs with the same legend
	grc1leg "$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_desempregado_sh_inativa" 	/*
	*/ 	"$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_desempregado_sh_formal",  	/*
	*/ 	legendfrom("$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_desempregado_sh_inativa") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(2) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_desempregado.gph", replace
	graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_desempregado.gph"
	graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_desempregado.png", replace
	

* Formal

	* Combing graphs with the same legend
	grc1leg "$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_formal_sh_informal" 	/*
	*/ 	"$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_formal_sh_desempregado",  	/*
	*/ 	legendfrom("$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_formal_sh_informal") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(2) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_formal.gph", replace
	graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_formal.gph"
	graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_formal.png", replace	
	
* Informal

	* Combing graphs with the same legend
	grc1leg "$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_informal_sh_desempregado" 	/*
	*/ 	"$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_informal_sh_formal",  	/*
	*/ 	legendfrom("$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_informal_sh_desempregado") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(2) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_informal.gph", replace
	graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_informal.gph"
	graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_informal.png", replace		
	

* Empregador

	* Combing graphs with the same legend
	grc1leg "$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_empregador_sh_informal" 	/*
	*/ 	"$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_empregador_sh_empregador",  	/*
	*/ 	legendfrom("$output_dir\transicao_ocupacao\_transicao_ocupacao_sh_empregador_sh_informal") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(2) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_empregador.gph", replace
	graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_empregador.gph"
	graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_combine_empregador.png", replace				