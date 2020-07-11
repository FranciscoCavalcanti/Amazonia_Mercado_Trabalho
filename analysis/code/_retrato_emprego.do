//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////

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
* set design of graph
*set scheme s1mono
*set scheme economist
*set scheme sj
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
		*/	pie(_all, color(%50) explode) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(1) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agricultura") label(5 "Serviços") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.0f))
		
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
		*/	bar(1, color(%50)) 	/*
		*/	bar(2, color(%50)) 	/*
		*/	bar(3, color(%50)) 	/*
		*/	bar(4, color(%50)) 	/*
		*/	bar(5, color(%50)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(1) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agricultura") label(5 "Serviços") size(small) )
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_amazonia_legal.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_amazonia_legal.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_amazonia_legal.png", replace
	
}
		
* informalidade x formalidade		
set scheme s1mono
	graph pie n_de_informalidade n_de_formal 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("", size(Medium large)) 	/*
		*/	pie(_all, color(%100) explode) 	/*
		*/	legend(on position(1) ring(0) order(1 2) cols(1) label(1 "Informal") label(2 "Formal") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.0f))
		
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_amazonia_legal.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_amazonia_legal.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_amazonia_legal.png", replace
		
	graph bar n_de_informalidade n_de_formal 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("", size(Medium large)) 	 	/*
		*/	bar(1, color(%100)) 	/*
		*/	bar(2, color(%100)) 	/*
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
* set design of graph
*set scheme s1mono
*set scheme economist
*set scheme sj
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
		*/	pie(_all, color(%50) explode) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(1) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agricultura") label(5 "Serviços") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.0f))
		
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
		*/	bar(1, color(%50)) 	/*
		*/	bar(2, color(%50)) 	/*
		*/	bar(3, color(%50)) 	/*
		*/	bar(4, color(%50)) 	/*
		*/	bar(5, color(%50)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(0) order(1 2 3 4 5) cols(1) label(1 "Indústria") label(2 "Construção")  label(3 "Comércio") label(4 "Agricultura") label(5 "Serviços") size(small) )
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_resto_brasil.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_resto_brasil.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_gstr_resto_brasil.png", replace
	
}
		
* informalidade x formalidade		
set scheme s1mono
	graph pie n_de_informalidade n_de_formal 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("", size(Medium large)) 	/*
		*/	pie(_all, color(%100) explode) 	/*
		*/	legend(on position(1) ring(0) order(1 2) cols(1) label(1 "Informal") label(2 "Formal") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.0f))
		
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_resto_brasil.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_resto_brasil.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_formalidade_resto_brasil.png", replace
		
	graph bar n_de_informalidade n_de_formal 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("", size(Medium large)) 	 	/*
		*/	bar(1, color(%100)) 	/*
		*/	bar(2, color(%100)) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0gc) angle(0) ) 	/*
		*/	legend(on position(1) ring(0) order(1 2) cols(1) label(1 "Informal") label(2 "Formal") size(small) )
		
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_resto_brasil.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_resto_brasil.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_formalidade_resto_brasil.png", replace