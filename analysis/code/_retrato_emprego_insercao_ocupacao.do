//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	C
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

**************************************
**	Colapsar ao nível do Ano 	**
**************************************

// attach label of variables
local colvar prop_* taxa_* n_*

foreach v of var `colvar' {
    local l`v' : variable label `v'
}

* colapse
collapse (firstnm) `colvar' , by(Ano id)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}


set scheme s1color 
	
	graph pie n_empregadoCC 	/*
		*/ 	n_militar 	/*
		*/ 	n_empregador  	/*
		*/ 	n_cpropriaC  	/*
		*/ 	n_cpropriaNc 	/*
		*/ 	n_empregadoSC 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(on position(6) ring(1) order(1 2 3 4 5 6) cols(2) label(1 "Trabalhador com carteira") label(2 "Servidor público e militares")  label(3 "Empregador") label(4 "Conta própria que contribui") label(5 "Conta própria que não contribui") label(6 "Trabalhador sem carteira") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten1", replace) 	
			
		graph pie n_empregadoCC 	/*
		*/ 	n_militar 	/*
		*/ 	n_empregador  	/*
		*/ 	n_cpropriaC  	/*
		*/ 	n_cpropriaNc 	/*
		*/ 	n_empregadoSC 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	/*
		*/	pie(_all, color(%65) explode) 	/*
		*/	legend(off position(9) ring(0) order(1 2 3 4 5) cols(1) label(1 "Com carteira") label(2 "")  label(3 "Empregador") label(4 "Conta própria que contribui") label(5 "Conta própria que não contribui") label(6 "Sem carteira") size(small) )	/*
		*/	plabel(_all percent, size(Medium) format(%12.1f)  lstyle(p1solid) ) /*  
		*/  saving("$tmp_dir\iten2", replace) 	
	
	
	/*
	 graph combine "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	title("Inserção da Ocupação") 	/*
	*/ 	subtitle("Amazônia Legal vs. Resto do Brasil") 	/*
	*/ 	note("Fonte: PNAD Contínua 2019")		
	*/
	
	* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	legendfrom("$tmp_dir\iten1") 	/*
	*/ 	title("") 	/*
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_insercao_ocupacao.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_insercao_ocupacao.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_insercao_ocupacao.png", replace
	
	
//////// BAR /////////////////////
set scheme s1color 
	
	graph bar n_empregadoCC 	/*
		*/ 	n_militar 	/*
		*/ 	n_empregador  	/*
		*/ 	n_cpropriaC  	/*
		*/ 	n_cpropriaNc 	/*
		*/ 	n_empregadoSC 	/*
		*/ 	if id == "Amazônia Legal" 	/*
		*/	,  title("Amazônia Legal", size(Medium large)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%65)) 	/*
		*/	bar(2, fcolor(%65)) 	/*
		*/	bar(3, fcolor(%65)) 	/*
		*/	bar(4, fcolor(%65)) 	/*
		*/	bar(5, fcolor(%65)) 	/*
		*/	bar(6, fcolor(%65)) 	/*
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,0fc) angle(0) ) 	/*
		*/	legend(on position(11) ring(3) order(1 2 3 4 5 6) cols(2) label(1 "Trabalhador com carteira") label(2 "Servidor público e militares")  label(3 "Empregador") label(4 "Conta própria que contribui") label(5 "Conta própria que não contribui") label(6 "Trabalhador sem carteira") size(small) )	/*
		*/  saving("$tmp_dir\iten3", replace) 	
			
		graph bar n_empregadoCC 	/*
		*/ 	n_militar 	/*
		*/ 	n_empregador  	/*
		*/ 	n_cpropriaC  	/*
		*/ 	n_cpropriaNc 	/*
		*/ 	n_empregadoSC 	/*
		*/ 	if id == "Resto do Brasil" 	/*
		*/	,  title("Resto do Brasil", size(Medium large)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%65)) 	/*
		*/	bar(2, fcolor(%65)) 	/*
		*/	bar(3, fcolor(%65)) 	/*
		*/	bar(4, fcolor(%65)) 	/*
		*/	bar(5, fcolor(%65)) 	/*
		*/	bar(6, fcolor(%65)) 	/*
		*/	yscale( axis(1) range() lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,0fc) angle(0) ) 	/*
		*/	legend(off position(11) ring(3) order(1 2 3 4 5) cols(2) label(1 "Com carteira") label(2 "")  label(3 "Empregador") label(4 "Conta própria que contribui") label(5 "Conta própria que não contribui") label(6 "Sem carteira") size(small) )	/*
		*/  saving("$tmp_dir\iten4", replace) 	
	
	
	/*
	 graph combine "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	title("Inserção da Ocupação") 	/*
	*/ 	subtitle("Amazônia Legal vs. Resto do Brasil") 	/*
	*/ 	note("Fonte: PNAD Contínua 2019")		
	*/
	
	* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten3" "$tmp_dir\iten4",  	/*
	*/ 	legendfrom("$tmp_dir\iten3") 	/*
	*/ 	title("") 	/*
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_insercao_ocupacao_bar.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_insercao_ocupacao_bar.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_insercao_ocupacao_bar.png", replace	