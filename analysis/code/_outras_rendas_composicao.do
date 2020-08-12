//////////////////////////////////////////////
//	
//	3) Composição da renda domiciliar per capita
//	
//////////////////////////////////////////////

* call data 
use "$output_dir_build\_programas_sociais_outras_rendas_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_programas_sociais_outras_rendas_resto_brasil.dta"
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

* keep 2019
keep if Ano == "2019"

* select variables
ds renda_* 
local type `r(varlist)'
display "`type'"

collapse (mean) `type', by(Ano id2 id)

* set design of graph
set scheme s2gcolor 

	**********************
	**	Gráfico Pizzas	**
	**********************

	graph pie renda_ajuda_gov 	/*
		*/ 	renda_seguro_desemprego 	/*
		*/ 	renda_aposentadoria 	/*
		*/ 	renda_doacao 	/*
		*/ 	renda_aluguel 	/*
		*/ 	renda_outro 	/*
		*/ 	renda_setorpublico 	/*
		*/ 	renda_privado 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(1) order(1 2 3 4 5 6 7 8) cols(2) label(1 "Programas sociais") label(2 "Seguro-desemprego e seguro-defeso") label(3 "Aposentadoria e pensão") label(4 "Pensão alimentícia, doação e mesada") label(5 "Aluguel e arrendamento") label(6 "Bolsa de estudos, caderneta de poupança e aplicações financeiras") label(7 "Setor público") label(8 "Setor privado") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph pie renda_ajuda_gov 	/*
		*/ 	renda_seguro_desemprego 	/*
		*/ 	renda_aposentadoria 	/*
		*/ 	renda_doacao 	/*
		*/ 	renda_aluguel 	/*
		*/ 	renda_outro 	/*
		*/ 	renda_setorpublico 	/*
		*/ 	renda_privado 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(1) order(1 2 3 4 5 6 7 8) cols(2) label(1 "Programas sociais") label(2 "Seguro-desemprego e seguro-defeso") label(3 "Aposentadoria e pensão") label(4 "Pensão alimentícia, doação e mesada") label(5 "Aluguel e arrendamento") label(6 "Bolsa de estudos, caderneta de poupança e aplicações financeiras") label(7 "Setor público") label(8 "Setor privado") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten2", replace) 			
		
	* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	legendfrom("$tmp_dir\iten1") 	/*
	*/ 	title("") 	/*
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
* save graph 
graph save Graph "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao.gph", replace
graph use "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao.gph"
graph export "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao.png", replace		

*
////////////////////////////////////////
// Loop sobre faixas de rendimentos
////////////////////////////////////////

forvalues num = 1(1)7 {
	
	**********************
	**	Gráfico Pizzas	**
	**********************

	graph pie renda_ajuda_gov`num' 	/*
		*/ 	renda_seguro_desemprego`num' 	/*
		*/ 	renda_aposentadoria`num' 	/*
		*/ 	renda_doacao`num' 	/*
		*/ 	renda_aluguel`num' 	/*
		*/ 	renda_outro`num' 	/*
		*/ 	renda_setorpublico`num' 	/*
		*/ 	renda_privado`num' 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(1) order(1 2 3 4 5 6 7 8) cols(2) label(1 "Programas sociais") label(2 "Seguro-desemprego e seguro-defeso") label(3 "Aposentadoria e pensão") label(4 "Pensão alimentícia, doação e mesada") label(5 "Aluguel e arrendamento") label(6 "Bolsa de estudos, caderneta de poupança e aplicações financeiras") label(7 "Setor público") label(8 "Setor privado") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph pie renda_ajuda_gov`num' 	/*
		*/ 	renda_seguro_desemprego`num' 	/*
		*/ 	renda_aposentadoria`num' 	/*
		*/ 	renda_doacao`num' 	/*
		*/ 	renda_aluguel`num' 	/*
		*/ 	renda_outro`num' 	/*
		*/ 	renda_setorpublico`num' 	/*
		*/ 	renda_privado`num' 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(1) order(1 2 3 4 5 6 7 8) cols(2) label(1 "Programas sociais") label(2 "Seguro-desemprego e seguro-defeso") label(3 "Aposentadoria e pensão") label(4 "Pensão alimentícia, doação e mesada") label(5 "Aluguel e arrendamento") label(6 "Bolsa de estudos, caderneta de poupança e aplicações financeiras") label(7 "Setor público") label(8 "Setor privado") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten2", replace) 			
		
	* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	legendfrom("$tmp_dir\iten1") 	/*
	*/ 	title("") 	/*
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
	* save graph 
	graph save Graph "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao`num'.gph", replace
	graph use "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao`num'.gph"
	graph export "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao`num'.png", replace		

}
*
clear