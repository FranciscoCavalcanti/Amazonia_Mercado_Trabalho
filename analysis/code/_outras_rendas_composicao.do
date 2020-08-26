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

* edit new groups of variables
gen renda_programas = renda_ajuda_gov + renda_seguro_desemp
gen renda_diversos = renda_outro + renda_doacao + renda_aluguel

* set design of graph
set scheme s2gcolor 

	**********************
	**	Gráfico Pizzas	**
	**********************

	graph pie renda_privadoformal 	/*
		*/ 	renda_privadoinformal 	/*
		*/ 	renda_setorpublico 	/*
		*/ 	renda_aposentadoria 	/*
		*/ 	renda_programas 	/*
		*/ 	renda_diversos 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(1) order(1 2 3 4 5 6) cols(2) label(1 "Setor privado formal") label(2 "Setor privado informal") label(3 "Setor público") label(4 "Aposentadoria e pensão") label(5 "Programas e auxílio estatal") label(6 "Outros tipos renda") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph pie renda_privadoformal 	/*
		*/ 	renda_privadoinformal 	/*
		*/ 	renda_setorpublico 	/*
		*/ 	renda_aposentadoria 	/*
		*/ 	renda_programas 	/*
		*/ 	renda_diversos 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(1) order(1 2 3 4 5 6) cols(2) label(1 "Setor privado formal") label(2 "Setor privado informal") label(3 "Setor público") label(4 "Aposentadoria e pensão") label(5 "Programas e auxílio estatal") label(6 "Outros tipos renda") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
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
graph save Graph "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao_porfaixas.gph", replace
graph use "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao_porfaixas.gph"
graph export "$output_dir\programas_sociais_outras_rendas\_outras_rendas_composicao_porfaixas.png", replace		

clear
