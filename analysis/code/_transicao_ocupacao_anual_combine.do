//////////////////////////////////////////////
//	
//	4) Matriz de transições de ocupações
//	
//////////////////////////////////////////////

* call data 

* set design of graph
set scheme amz2030


* Desempregado

	* Combing graphs with the same legend
	grc1leg "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_desempregado_sh_inativa" 	/*
	*/ 	"$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_desempregado_sh_formal",  	/*
	*/ 	legendfrom("$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_desempregado_sh_inativa") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(2) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_desempregado.gph", replace
	graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_desempregado.gph"
	graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_desempregado.png", replace
	

* Formal

	* Combing graphs with the same legend
	grc1leg "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_formal_sh_informal" 	/*
	*/ 	"$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_formal_sh_desempregado",  	/*
	*/ 	legendfrom("$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_formal_sh_informal") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(2) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_formal.gph", replace
	graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_formal.gph"
	graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_formal.png", replace	
	
* Informal

	* Combing graphs with the same legend
	grc1leg "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_informal_sh_desempregado" 	/*
	*/ 	"$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_informal_sh_formal",  	/*
	*/ 	legendfrom("$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_informal_sh_desempregado") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(2) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_informal.gph", replace
	graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_informal.gph"
	graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_informal.png", replace		
	

* Empregador

	* Combing graphs with the same legend
	grc1leg "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_empregador_sh_informal" 	/*
	*/ 	"$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_empregador_sh_empregador",  	/*
	*/ 	legendfrom("$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_sh_empregador_sh_informal") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(2) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_empregador.gph", replace
	graph use "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_empregador.gph"
	graph export "$output_dir\transicao_ocupacao\_transicao_ocupacao_anual_combine_empregador.png", replace			