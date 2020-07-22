//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	Composição setorial	
/////////////////////////////////////////

* call data 
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

**********************
**	Amazônia Legal	**
**********************

**	GRANDES SETORES	**
set scheme s1color 

* begin of loop over variables
local type n_de_informal n_de_formal n_de_ocupado
foreach lname in `type' {
	
	graph pie `lname'_gstr_industria 	/*
		*/ 	`lname'_gstr_construcao  	/*
		*/ 	`lname'_gstr_comercio  	/*
		*/ 	`lname'_gstr_agricultura  	/*
		*/ 	`lname'_gstr_servicos 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(1) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agropecuária") label(5 "Serviços") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) 
		
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr_amazonia_legal.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr_amazonia_legal.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr_amazonia_legal.png", replace
		
	graph bar `lname'_gstr_industria 	/*
		*/ 	`lname'_gstr_construcao  	/*
		*/ 	`lname'_gstr_comercio  	/*
		*/ 	`lname'_gstr_agricultura  	/*
		*/ 	`lname'_gstr_servicos 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("", size(Medium large)) 	 	/*
		*/	bar(1, color(%65)) 	/*
		*/	bar(2, color(%65)) 	/*
		*/	bar(3, color(%65)) 	/*
		*/	bar(4, color(%65)) 	/*
		*/	bar(5, color(%65)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.1fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(1) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agropecuária") label(5 "Serviços") size(small) )
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_amazonia_legal.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_amazonia_legal.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_amazonia_legal.png", replace
	
}

**********************
**	Resto do Brasil	**
**********************

**	GRANDES SETORES	**
set scheme s1color 

* begin of loop over variables
local type n_de_informal n_de_formal n_de_ocupado
foreach lname in `type' {
	
	graph pie `lname'_gstr_industria 	/*
		*/ 	`lname'_gstr_construcao  	/*
		*/ 	`lname'_gstr_comercio  	/*
		*/ 	`lname'_gstr_agricultura  	/*
		*/ 	`lname'_gstr_servicos 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(1) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agropecuária") label(5 "Serviços") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) 
		
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr_resto_brasil.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr_resto_brasil.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_gstr_resto_brasil.png", replace
		
	graph bar `lname'_gstr_industria 	/*
		*/ 	`lname'_gstr_construcao  	/*
		*/ 	`lname'_gstr_comercio  	/*
		*/ 	`lname'_gstr_agricultura  	/*
		*/ 	`lname'_gstr_servicos 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("", size(Medium large)) 	 	/*
		*/	bar(1, color(%65)) 	/*
		*/	bar(2, color(%65)) 	/*
		*/	bar(3, color(%65)) 	/*
		*/	bar(4, color(%65)) 	/*
		*/	bar(5, color(%65)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.1fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(1) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agropecuária") label(5 "Serviços") size(small) )
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_resto_brasil.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_resto_brasil.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_resto_brasil.png", replace
	
}
