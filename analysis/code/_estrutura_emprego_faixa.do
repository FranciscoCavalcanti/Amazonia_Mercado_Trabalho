//////////////////////////////////////////////
//	
//	1) Descrever a estrutrura do emprego
//	
//////////////////////////////////////////////

* call data 
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
local type faixa_educ1 faixa_educ2 faixa_educ3 faixa_educ4 faixa_educ5 faixa_etaria1 faixa_etaria2 faixa_etaria3 faixa_etaria4 faixa_etaria5 faixa_etaria6 faixa_etaria7 faixa_genero1 faixa_genero2 faixa_metro faixa_nmetro faixa_rural faixa_urbana

* label variable
label variable n_de_ocupado_faixa_educ1 "Taxa de ocupação com menos 1 ano de estudo (%)"
label variable n_de_ocupado_faixa_educ2 "Taxa de ocupação com fundamental incompleto (%)"
label variable n_de_ocupado_faixa_educ3 "Taxa de ocupação com fundamental completo (%)"
label variable n_de_ocupado_faixa_educ4 "Taxa de ocupação com ensino médio completo (%)"
label variable n_de_ocupado_faixa_educ5 "Taxa de ocupação com ensino superior (%)"

label variable n_de_ocupado_faixa_etaria1 "Taxa de ocupação entre 14 e 17 anos (%) "
label variable n_de_ocupado_faixa_etaria2 "Taxa de ocupação entre 18 e 24 anos (%) "
label variable n_de_ocupado_faixa_etaria3 "Taxa de ocupação entre 25 e 29 anos (%)"
label variable n_de_ocupado_faixa_etaria4 "Taxa de ocupação entre 30 e 39 anos (%)"
label variable n_de_ocupado_faixa_etaria5 "Taxa de ocupação entre 40 e 49 anos (%)"
label variable n_de_ocupado_faixa_etaria6 "Taxa de ocupação entre 50 e 59 anos (%)"
label variable n_de_ocupado_faixa_etaria7 "Taxa de ocupação acima de 60 anos (%)"

label variable n_de_ocupado_faixa_genero1 "Taxa de ocupação entre homens (%) "
label variable n_de_ocupado_faixa_genero2 "Taxa de ocupação entre mullheres (%)"

label variable n_de_ocupado_faixa_metro "Taxa de ocupação na região metropolitana (%) "
label variable n_de_ocupado_faixa_nmetro "Taxa de ocupação fora da região metropolitana (%) "
label variable n_de_ocupado_faixa_rural "Taxa de ocupação na área rural (%)"
label variable n_de_ocupado_faixa_urbana "Taxa de ocupação na área urbana (%)  "

* label variable
label variable n_de_pea_faixa_educ1 "Taxa de participação com menos 1 ano de estudo (%)"
label variable n_de_pea_faixa_educ2 "Taxa de participação com fundamental incompleto (%)"
label variable n_de_pea_faixa_educ3 "Taxa de participação com fundamental completo (%)"
label variable n_de_pea_faixa_educ4 "Taxa de participação com ensino médio completo (%)"
label variable n_de_pea_faixa_educ5 "Taxa de participação com ensino superior (%)"

label variable n_de_pea_faixa_etaria1 "Taxa de participação entre 18 e 24 anos (%) "
label variable n_de_pea_faixa_etaria2 "Taxa de participação entre 25 e 39 anos (%)"
label variable n_de_pea_faixa_etaria3 "Taxa de participação entre 40 e 59 anos (%)"
label variable n_de_pea_faixa_etaria4 "Taxa de participação acima de 60 anos (%)"

label variable n_de_pea_faixa_etaria1 "Taxa de participação entre 14 e 17 anos (%) "
label variable n_de_pea_faixa_etaria2 "Taxa de participação entre 18 e 24 anos (%) "
label variable n_de_pea_faixa_etaria3 "Taxa de participação entre 25 e 29 anos (%)"
label variable n_de_pea_faixa_etaria4 "Taxa de participação entre 30 e 39 anos (%)"
label variable n_de_pea_faixa_etaria5 "Taxa de participação entre 40 e 49 anos (%)"
label variable n_de_pea_faixa_etaria6 "Taxa de participação entre 50 e 59 anos (%)"
label variable n_de_pea_faixa_etaria7 "Taxa de participação acima de 60 anos (%)"

label variable n_de_pea_faixa_genero1 "Taxa de participação entre homens (%) "
label variable n_de_pea_faixa_genero2 "Taxa de participação entre mullheres (%)"

label variable n_de_pea_faixa_metro "Taxa de participação na região metropolitana (%) "
label variable n_de_pea_faixa_nmetro "Taxa de participação fora da região metropolitana (%) "
label variable n_de_pea_faixa_rural "Taxa de participação na área rural (%)"
label variable n_de_pea_faixa_urbana "Taxa de participação na área urbana (%)  "


* set design of graph
* set scheme s1mono
set scheme amz2030  

* begin of loop over variables
foreach lname in `type' {

	* Taxa de ocupação
	gen iten1 = (n_de_ocupado_`lname'/n_`lname')*100

	* generate title from label variable
	local label_var: variable label n_de_ocupado_`lname'

	* Graphs separated by the range of Y-axis
* 		Grafico 
	graph twoway connected iten1 trim 	if id == "Amazônia Legal" || /*
		*/  connected iten1 trim 	if id == "Resto do Brasil"  	/*  
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Amazônia Legal") label(2 "Resto do Brasil") size(Medium) )	/*
		*/ 	xlabel(#8, grid angle(45))	

	cap drop iten*
	
	* save graph 
	graph save Graph "$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_ocupacao_`lname'.gph", replace
	graph use "$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_ocupacao_`lname'.gph"
	graph export "$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_ocupacao_`lname'.png", replace
	
	* Taxa de participação
	gen iten1 = (n_de_pea_`lname'/n_`lname')*100

	* generate title from label variable
	local label_var: variable label n_de_pea_`lname'

	* Graphs separated by the range of Y-axis
	* 		Grafico 
	graph twoway connected iten1 trim 	if id == "Amazônia Legal" || /*
		*/  connected iten1 trim 	if id == "Resto do Brasil"  	/*  
		*/ 	,  title("`label_var'", size(Medium)) 	/*
		*/ 	ytitle("") 	/*
		*/ 	xtitle("")	/*	
		*/	ylabel(#9, angle(0) ) 		/*
		*/	yscale( axis(1) range() lstyle(none) )	/* how y axis looks
		*/	legend( order(1 2) cols(2) label(1 "Amazônia Legal") label(2 "Resto do Brasil") size(Medium) )	/*
		*/ 	xlabel(#8, grid angle(45))	

	cap drop iten*
	
	* save graph 
	graph save Graph "$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_participacao_`lname'.gph", replace
	graph use "$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_participacao_`lname'.gph"
	graph export "$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_participacao_`lname'.png", replace			
}

* Combing graphs with the same legend
	grc1leg "$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_ocupacao_faixa_etaria2.gph" 	/* 
	*/ 	"$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_participacao_faixa_etaria2.gph",  	/*
	*/ 	legendfrom("$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_ocupacao_faixa_etaria2.gph") 	/*
	*/ 	title("") 	/*
	*/ 	cols(2) 	/*
	*/	graphregion(fcolor(white)) 	/*	
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/	
	
	graph save Graph "$output_dir\estrutura_emprego\_estrutura_emprego_faixa_etaria2.gph", replace
	graph use "$output_dir\estrutura_emprego\_estrutura_emprego_faixa_etaria2.gph"
	graph export "$output_dir\estrutura_emprego\_estrutura_emprego_faixa_etaria2.png", replace
	
	
* Combing graphs with the same legend
	grc1leg "$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_ocupacao_faixa_etaria3.gph" 	/* 
	*/ 	"$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_participacao_faixa_etaria3.gph",  	/*
	*/ 	legendfrom("$output_dir\estrutura_emprego\_estrutura_emprego_taxa_de_ocupacao_faixa_etaria3.gph") 	/*
	*/ 	title("") 	/*
	*/ 	cols(2) 	/*
	*/	graphregion(fcolor(white)) 	/*	
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/	
				* save graph 
	graph save Graph "$output_dir\estrutura_emprego\_estrutura_emprego_faixa_etaria3.gph", replace
	graph use "$output_dir\estrutura_emprego\_estrutura_emprego_faixa_etaria3.gph"
	graph export "$output_dir\estrutura_emprego\_estrutura_emprego_faixa_etaria3.png", replace
