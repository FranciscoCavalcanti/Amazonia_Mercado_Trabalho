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
ds n_de_ocupado_sgap* 
local type `r(varlist)'
display "`type'"

**	GRUPAMENTOS DA ATIVIDADE PRINCIPAL NO SETOR DE INDUSTRIA DE TRANSFORMAÇÃO	**
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
colorpalette w3 food , globals

* begin of loop over variables
local type n_de_informal n_de_formal n_de_ocupado
foreach lname in `type' {
	
	**********************
	**	Gráfico Pizzas	**
	**********************

	graph pie `lname'_sgap_trans01 	/*
		*/ 	`lname'_sgap_trans02 	/*
		*/ 	`lname'_sgap_trans03 	/*
		*/ 	`lname'_sgap_trans04 	/*
		*/ 	`lname'_sgap_trans05 	/*
		*/ 	`lname'_sgap_trans06 	/*
		*/ 	`lname'_sgap_trans07 	/*
		*/ 	`lname'_sgap_trans08 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	pie(1, color($w3_food_apple%75) explode) 	/*
		*/	pie(2, color($w3_food_orange%75) explode) 	/*
		*/	pie(3, color($w3_food_plum%75) explode) 	/*	
		*/	pie(4, color($w3_food_carrot%75) explode) 	/*
		*/	pie(5, color($w3_food_cranberry%75) explode) 	/*
		*/	pie(6, color($w3_food_spearmint%75) explode) 	/*
		*/	pie(7, color($w3_food_tomato%75) explode) 	/*	
		*/	pie(8, color($w3_food_mustard%75) explode) 	/*		
		*/	legend(on position(11) ring(1) order(1 2 3 4 5 6 7 8) cols(2) label(1 "Alimentos, bebidas e fumo") label(2 "Acessórios, vestuário e produtos têxteis") label(3 "Madeira, celulose e papel") label(4 "Químicos, biocombustíveis e derivados de petróleo") label(5 "Minerais e metalurgia") label(6 "Informática, máquinas e equipamentos") label(7 "Veículos automotores e equipamentos de transporte") label(8 "Outros produtos") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph pie `lname'_sgap_trans01 	/*
		*/ 	`lname'_sgap_trans02 	/*
		*/ 	`lname'_sgap_trans03 	/*
		*/ 	`lname'_sgap_trans04 	/*
		*/ 	`lname'_sgap_trans05 	/*
		*/ 	`lname'_sgap_trans06 	/*
		*/ 	`lname'_sgap_trans07 	/*
		*/ 	`lname'_sgap_trans08 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	pie(1, color($w3_food_apple%75) explode) 	/*
		*/	pie(2, color($w3_food_orange%75) explode) 	/*
		*/	pie(3, color($w3_food_plum%75) explode) 	/*	
		*/	pie(4, color($w3_food_carrot%75) explode) 	/*
		*/	pie(5, color($w3_food_cranberry%75) explode) 	/*
		*/	pie(6, color($w3_food_spearmint%75) explode) 	/*
		*/	pie(7, color($w3_food_tomato%75) explode) 	/*	
		*/	pie(8, color($w3_food_mustard%75) explode) 	/*	
		*/	legend(on position(11) ring(1) order(1 2 3 4 5 6 7 8) cols(2) label(1 "Alimentos, bebidas e fumo") label(2 "Acessórios, vestuário e produtos têxteis") label(3 "Madeira, celulose e papel") label(4 "Químicos, biocombustíveis e derivados de petróleo") label(5 "Minerais e metalurgia") label(6 "Informática, máquinas e equipamentos") label(7 "Veículos automotores e equipamentos de transporte") label(8 "Outros produtos") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
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
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_pie_setor_sgap_trans_`lname'.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_pie_setor_sgap_trans_`lname'.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_pie_setor_sgap_trans_`lname'.png", replace

	**********************
	**	Gráfico Barras	**
	**********************	
		
	graph bar `lname'_sgap_trans01 	/*
		*/ 	`lname'_sgap_trans02 	/*
		*/ 	`lname'_sgap_trans03 	/*
		*/ 	`lname'_sgap_trans04 	/*
		*/ 	`lname'_sgap_trans05 	/*
		*/ 	`lname'_sgap_trans06 	/*
		*/ 	`lname'_sgap_trans07 	/*
		*/ 	`lname'_sgap_trans08 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bar(1, color($w3_food_apple%75) ) 	/*
		*/	bar(2, color($w3_food_orange%75) ) 	/*
		*/	bar(3, color($w3_food_plum%75) ) 	/*	
		*/	bar(4, color($w3_food_carrot%75) ) 	/*
		*/	bar(5, color($w3_food_cranberry%75) ) 	/*
		*/	bar(6, color($w3_food_spearmint%75) ) 	/*
		*/	bar(7, color($w3_food_tomato%75) ) 	/*	
		*/	bar(8, color($w3_food_mustard%75) ) 	/*	
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(3) order(1 2 3 4 5 6 7 8) cols(2) label(1 "Alimentos, bebidas e fumo") label(2 "Acessórios, vestuário e produtos têxteis") label(3 "Madeira, celulose e papel") label(4 "Químicos, biocombustíveis e derivados de petróleo") label(5 "Minerais e metalurgia") label(6 "Informática, máquinas e equipamentos") label(7 "Veículos automotores e equipamentos de transporte") label(8 "Outros produtos") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
		*/  saving("$tmp_dir\iten1", replace) 			
		
	graph bar `lname'_sgap_trans01 	/*
		*/ 	`lname'_sgap_trans02 	/*
		*/ 	`lname'_sgap_trans03 	/*
		*/ 	`lname'_sgap_trans04 	/*
		*/ 	`lname'_sgap_trans05 	/*
		*/ 	`lname'_sgap_trans06 	/*
		*/ 	`lname'_sgap_trans07 	/*
		*/ 	`lname'_sgap_trans08 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bar(1, color($w3_food_apple%75) ) 	/*
		*/	bar(2, color($w3_food_orange%75) ) 	/*
		*/	bar(3, color($w3_food_plum%75) ) 	/*	
		*/	bar(4, color($w3_food_carrot%75) ) 	/*
		*/	bar(5, color($w3_food_cranberry%75) ) 	/*
		*/	bar(6, color($w3_food_spearmint%75) ) 	/*
		*/	bar(7, color($w3_food_tomato%75) ) 	/*	
		*/	bar(8, color($w3_food_mustard%75) ) 	/*	
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(3) order(1 2 3 4 5 6 7 8) cols(2) label(1 "Alimentos, bebidas e fumo") label(2 "Acessórios, vestuário e produtos têxteis") label(3 "Madeira, celulose e papel") label(4 "Químicos, biocombustíveis e derivados de petróleo") label(5 "Minerais e metalurgia") label(6 "Informática, máquinas e equipamentos") label(7 "Veículos automotores e equipamentos de transporte") label(8 "Outros produtos") size(vsmall) forcesize symysize(3pt) symxsize(3pt) )	/*
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
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_bar_setor_sgap_trans_`lname'.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_bar_setor_sgap_trans_`lname'.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_bar_setor_sgap_trans_`lname'.png", replace
}