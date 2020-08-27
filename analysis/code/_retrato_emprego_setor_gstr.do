//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	Composição setorial	
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

* select variables
ds prop_* taxa_* n_*
local type `r(varlist)'
display "`type'"

**	GRUPAMENTOS DA ATIVIDADE PRINCIPAL NO SETOR DE SERVIÇO	**
set scheme s2color 

* begin of loop over variables
local type n_de_informal n_de_formal n_de_ocupado
foreach lname in `type' {
	
	**********************
	**	Gráfico Pizzas	**
	**********************

	graph pie `lname'_gstr_industria 	/*
		*/ 	`lname'_gstr_construcao  	/*
		*/ 	`lname'_gstr_comercio  	/*
		*/ 	`lname'_gstr_agricultura  	/*
		*/ 	`lname'_gstr_servicos 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(5) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agropecuária") label(5 "Serviços") size(small) forcesize symysize(3pt) symxsize(3pt))	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph pie `lname'_gstr_industria 	/*
		*/ 	`lname'_gstr_construcao  	/*
		*/ 	`lname'_gstr_comercio  	/*
		*/ 	`lname'_gstr_agricultura  	/*
		*/ 	`lname'_gstr_servicos 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(5) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agropecuária") label(5 "Serviços") size(small) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten2", replace) 			
		
	* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	legendfrom("$tmp_dir\iten1") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr.png", replace

	**********************
	**	Gráfico Barras	**
	**********************	
		
	graph bar `lname'_gstr_industria 	/*
		*/ 	`lname'_gstr_construcao  	/*
		*/ 	`lname'_gstr_comercio  	/*
		*/ 	`lname'_gstr_agricultura  	/*
		*/ 	`lname'_gstr_servicos 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bar(1, color(%65)) 	/*
		*/	bar(2, color(%65)) 	/*
		*/	bar(3, color(%65)) 	/*
		*/	bar(4, color(%65)) 	/*
		*/	bar(5, color(%65)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(5) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agropecuária") label(5 "Serviços") size(small) forcesize symysize(3pt) symxsize(3pt) )	/* 
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph bar `lname'_gstr_industria 	/*
		*/ 	`lname'_gstr_construcao  	/*
		*/ 	`lname'_gstr_comercio  	/*
		*/ 	`lname'_gstr_agricultura  	/*
		*/ 	`lname'_gstr_servicos 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bar(1, color(%65)) 	/*
		*/	bar(2, color(%65)) 	/*
		*/	bar(3, color(%65)) 	/*
		*/	bar(4, color(%65)) 	/*
		*/	bar(5, color(%65)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(5) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agropecuária") label(5 "Serviços") size(small) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/  saving("$tmp_dir\iten2", replace) 	
		
		
		* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	legendfrom("$tmp_dir\iten1") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/		
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr.png", replace
}