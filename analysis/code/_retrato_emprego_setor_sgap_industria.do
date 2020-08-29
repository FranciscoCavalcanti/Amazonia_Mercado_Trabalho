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

**	GRUPAMENTOS DA ATIVIDADE PRINCIPAL NO SETOR DE INDUSTRIA	**
set scheme s1color
*set scheme burd

* 
*Qualitative (view)
*Accent       8 accented colors for qualitative data
*Dark28 dark colors for qualitative data
*Paired       12 paired colors for qualitative data
*Pastel1      9 pastel colors for qualitative data
*Pastel2      8 pastel colors for qualitative data
*Set1 9 colors for qualitative data
*Set2 8 colors for qualitative data
*Set3         12 colors for qualitative data
colorpalette sfso languages, globals

* begin of loop over variables
local type n_de_informal n_de_formal n_de_ocupado

foreach lname in `type' {
	
	**********************
	**	Gráfico Pizzas	**
	**********************

	graph pie `lname'_sgap_extrativa 	/*
		*/ 	`lname'_sgap_trans 	/*
		*/ 	`lname'_sgap_energia 	/*
		*/ 	`lname'_sgap_agua 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	pie(1, color($German%75) explode) 	/*
		*/	pie(2, color($French%75) explode) 	/*
		*/	pie(3, color($Italian%75) explode) 	/*	
		*/	pie(4, color($Rhaeto_Romanic%75) explode) 	/*
		*/	legend(on position(11) ring(1) order(1 2 3 4) cols(2) label(1 "Indústrias extrativas") label(2 "Indústrias de transformação") label(3 "Eletricidade, gás e outras utilidades") label(4 "Água, esgoto e gestão de resíduos")  size(small) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, gap(8) size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph pie `lname'_sgap_extrativa 	/*
		*/ 	`lname'_sgap_trans 	/*
		*/ 	`lname'_sgap_energia 	/*
		*/ 	`lname'_sgap_agua 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	pie(1, color($German%75) explode) 	/*
		*/	pie(2, color($French%75) explode) 	/*
		*/	pie(3, color($Italian%75) explode) 	/*	
		*/	pie(4, color($Rhaeto_Romanic%75) explode) 	/*
		*/	legend(on position(11) ring(1) order(1 2 3 4) cols(2) label(1 "Indústrias extrativas") label(2 "Indústrias de transformação") label(3 "Eletricidade, gás e outras utilidades") label(4 "Água, esgoto e gestão de resíduos")  size(small) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, gap(8) size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
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
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_sgap_industria.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_sgap_industria.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_`lname'_sgap_industria.png", replace

	**********************
	**	Gráfico Barras	**
	**********************	
		
	graph bar `lname'_sgap_extrativa 	/*
		*/ 	`lname'_sgap_trans 	/*
		*/ 	`lname'_sgap_energia 	/*
		*/ 	`lname'_sgap_agua 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bar(1, color($German%75) ) 	/*
		*/	bar(2, color($French%75) ) 	/*
		*/	bar(3, color($Italian%75) ) 	/*	
		*/	bar(4, color($Rhaeto_Romanic%75) ) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(3) order(1 2 3 4) cols(2) label(1 "Indústrias extrativas") label(2 "Indústrias de transformação") label(3 "Eletricidade, gás e outras utilidades") label(4 "Água, esgoto e gestão de resíduos")  size(small) forcesize symysize(3pt) symxsize(3pt) ) /*  
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph bar `lname'_sgap_extrativa 	/*
		*/ 	`lname'_sgap_trans 	/*
		*/ 	`lname'_sgap_energia 	/*
		*/ 	`lname'_sgap_agua 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bar(1, color($German%75) ) 	/*
		*/	bar(2, color($French%75) ) 	/*
		*/	bar(3, color($Italian%75) ) 	/*	
		*/	bar(4, color($Rhaeto_Romanic%75) ) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(3) order(1 2 3 4) cols(2) label(1 "Indústrias extrativas") label(2 "Indústrias de transformação") label(3 "Eletricidade, gás e outras utilidades") label(4 "Água, esgoto e gestão de resíduos")  size(small) forcesize symysize(3pt) symxsize(3pt) ) /*  
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
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_sgap_industria.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_sgap_industria.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_`lname'_sgap_industria.png", replace
}