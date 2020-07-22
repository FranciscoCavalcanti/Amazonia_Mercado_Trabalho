//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	Informalidade vs. Formalidade
/////////////////////////////////////////

** call data 
use "$output_dir_build\_retrato_emprego_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_retrato_emprego_resto_brasil.dta"
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

**********************
**	Amazônia Legal	**
**********************

**	GRUPAMENTOS DA ATIVIDADE PRINCIPAL NO SETOR DE SERVIÇO	**
set scheme s1color 

**********************
**	Amazônia Legal	**
**********************

**	INFORMALIDADE x FORMALIDADE	**
set scheme s1mono

	graph pie n_de_informalidade n_de_formal 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(1) ring(0) order(1 2) cols(1) label(1 "Informal") label(2 "Formal") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.0f)  lstyle(p1solid) ) 
		
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_amazonia_legal.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_amazonia_legal.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_amazonia_legal.png", replace
		
	graph bar n_de_informalidade n_de_formal 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("", size(Medium large)) 	 	/*
		*/	bar(1, color(%65)) 	/*
		*/	bar(2, color(%65)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	legend(on position(1) ring(0) order(1 2) cols(1) label(1 "Informal") label(2 "Formal") size(small) )
		
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_amazonia_legal.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_amazonia_legal.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_amazonia_legal.png", replace

**********************
**	Resto do Brasil	**
**********************
	
**	INFORMALIDADE x FORMALIDADE	**
set scheme s1mono

	graph pie n_de_informalidade n_de_formal 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(1) ring(0) order(1 2) cols(1) label(1 "Informal") label(2 "Formal") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.0f)  lstyle(p1solid) ) 
		
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_resto_brasil.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_resto_brasil.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_resto_brasil.png", replace
		
	graph bar n_de_informalidade n_de_formal 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("", size(Medium large)) 	 	/*
		*/	bar(1, color(%65)) 	/*
		*/	bar(2, color(%65)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0gc) angle(0) ) 	/*
		*/	legend(on position(1) ring(0) order(1 2) cols(1) label(1 "Informal") label(2 "Formal") size(small) )
		
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_resto_brasil.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_resto_brasil.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_resto_brasil.png", replace