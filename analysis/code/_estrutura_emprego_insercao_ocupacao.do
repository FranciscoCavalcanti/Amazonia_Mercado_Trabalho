//////////////////////////////////////////////
//	
//	1) Descrever a estrutrura do emprego
//	
//////////////////////////////////////////////
//////////////////////////////////////////
/////////////////////////////////////////

use "$output_dir_build\_estrutura_emprego_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_estrutura_emprego_resto_brasil.dta"
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
ds prop_* taxa_* 
local type `r(varlist)'
display "`type'"

* set design of graph
set scheme s1mono
set scheme s2color 
			
	graph twoway line prop_empregadoCC prop_empregadoSC prop_empregador prop_cpropriaC prop_cpropriaNc prop_militar trim if id == "Amazônia Legal" /*
		*/ 	,  title("Amazônia Legal", size(Medium)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/ 	lwidth(thick thick thick thick thick thick) 	/*		
		*/	yscale( axis(1) range(0) lstyle(none) )	/* how y axis looks
		*/ 	legend(on cols(3) label(1 "Com carteira assinada") label(2 "Sem carteira assinada") label(3 "Empregador") label(4 "Conta própria que contribui") label(5 "Conta própria que não contribui") label(6 "Servidor público") size(small) forcesize symysize(3pt) symxsize(3pt) ) 	/*
		*/ 	xlabel(#8, grid angle(45)) 	/*
		*/  saving("$tmp_dir\iten1", replace) 	
			
	graph twoway line prop_empregadoCC prop_empregadoSC prop_empregador prop_cpropriaC prop_cpropriaNc prop_militar trim if id == "Resto do Brasil" /*	
		*/ 	,  title("Resto do Brasil", size(Medium)) 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/ 	lwidth(thick thick thick thick thick thick) 	/*		
		*/	yscale( axis(1) range(0) lstyle(none) )	/* how y axis looks
		*/ 	legend(on cols(3) label(1 "Com carteira assinada") label(2 "Sem carteira assinada") label(3 "Empregador") label(4 "Conta própria que contribui") label(5 "Conta própria que não contribui") label(6 "Servidor público") size(small) forcesize symysize(3pt) symxsize(3pt) ) 	/*
		*/ 	xlabel(#8, grid angle(45)) 	/*
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
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(4) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/
	
		* save graph 
	graph save Graph "$output_dir\estrutura_emprego\_estrutura_emprego_insercao_ocupacao.gph", replace
	graph use "$output_dir\estrutura_emprego\_estrutura_emprego_insercao_ocupacao.gph"
	graph export "$output_dir\estrutura_emprego\_estrutura_emprego_insercao_ocupacao.png", replace