//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	Contrafactual 
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
collapse (firstnm) `colvar' , by(Ano id2 id)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}


* Taxa de informalidade observada na Amazônia legal

	graph bar taxa_de_informalidade if id == "Amazônia Legal"	/*
		*/	,  	/*
		*/ 	title("Taxa Observada", size(Medium)) 	 	/*
		*/ 	stack 	/*
		*/	bar(1, fcolor(green%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range(0 60) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*  
		*/  saving("$tmp_dir\iten0", replace) 
		
		

*******************************************************
**	Passo a passo para construir o contrafactual 	***
*******************************************************

// 1) Calcular para o Resto do Brasil a composicao etaria/educacional/setor/genero dos ocupados
// 2) Calcular para Amazonia Legal a taxa de informalidade por faixa etaria/educacional/genero/setor
// 3) Multiplicar a taxa de informalidade de 2) com a composicao de 1)
// 4) O somatorio de 3) é taxa de informalidade do contrafactual
		
/// composicao etaria
preserve
* 1)
gen it1 = n_de_ocupado_faixa_etaria1/(n_de_ocupado_faixa_etaria1 + n_de_ocupado_faixa_etaria2 + n_de_ocupado_faixa_etaria3 + n_de_ocupado_faixa_etaria4) if id == "Resto do Brasil"
gen it2 = n_de_ocupado_faixa_etaria2/(n_de_ocupado_faixa_etaria1 + n_de_ocupado_faixa_etaria2 + n_de_ocupado_faixa_etaria3 + n_de_ocupado_faixa_etaria4) if id == "Resto do Brasil"
gen it3 = n_de_ocupado_faixa_etaria3/(n_de_ocupado_faixa_etaria1 + n_de_ocupado_faixa_etaria2 + n_de_ocupado_faixa_etaria3 + n_de_ocupado_faixa_etaria4) if id == "Resto do Brasil"
gen it4 = n_de_ocupado_faixa_etaria4/(n_de_ocupado_faixa_etaria1 + n_de_ocupado_faixa_etaria2 + n_de_ocupado_faixa_etaria3 + n_de_ocupado_faixa_etaria4) if id == "Resto do Brasil"

* 2)
gen ik1 = (n_de_informal_faixa_etaria1)/(n_de_ocupado_faixa_etaria1) if id == "Amazônia Legal"
gen ik2 = (n_de_informal_faixa_etaria2)/(n_de_ocupado_faixa_etaria2) if id == "Amazônia Legal"
gen ik3 = (n_de_informal_faixa_etaria3)/(n_de_ocupado_faixa_etaria3) if id == "Amazônia Legal"
gen ik4 = (n_de_informal_faixa_etaria4)/(n_de_ocupado_faixa_etaria4) if id == "Amazônia Legal"
* 3)
collapse it* ik*
gen mult1 = ik1 * it1
gen mult2 = ik2 * it2
gen mult3 = ik3 * it3
gen mult4 = ik4 * it4
* 4)
gen taxa_de_informalidade = (mult1 + mult2 + mult3 + mult4)*100

	graph bar taxa_de_informalidade 	/*
		*/	,  	/* over(id, label(angle(45)) )
		*/ 	title("Estrutura Etária", size(Medium)) 	 	/*
		*/ 	 	/* subtitle("Mesma composição etária dos ocupados do resto do Brasil")
		*/ 	stack 	/*
		*/	bar(1, fcolor(ebblue%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range(0 60) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*  
		*/  saving("$tmp_dir\iten1", replace) 		
restore	

/// composicao de setor
preserve
* 1)
gen it1 = n_de_ocupado_gape_agricultura/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it2 = n_de_ocupado_gape_industria/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it3 = n_de_ocupado_gape_construcao/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it4 = n_de_ocupado_gape_comercio/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it5 = n_de_ocupado_gape_transporte/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it6 = n_de_ocupado_gape_alimentacao/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it7 = n_de_ocupado_gape_informacao/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it8 = n_de_ocupado_gape_publica/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it9 = n_de_ocupado_gape_educacao/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it10 = n_de_ocupado_gape_outros/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)
gen it11 = n_de_ocupado_gape_domestico/(n_de_ocupado_gape_agricultura + n_de_ocupado_gape_industria + n_de_ocupado_gape_construcao + n_de_ocupado_gape_comercio + n_de_ocupado_gape_transporte + n_de_ocupado_gape_alimentacao + n_de_ocupado_gape_informacao + n_de_ocupado_gape_publica + n_de_ocupado_gape_educacao + n_de_ocupado_gape_outros + n_de_ocupado_gape_domestico)

* 2)
gen ik1 = (n_de_informal_gape_agricultura)/(n_de_ocupado_gape_agricultura) if id == "Amazônia Legal"
gen ik2 = (n_de_informal_gape_industria)/(n_de_ocupado_gape_industria) if id == "Amazônia Legal"
gen ik3 = (n_de_informal_gape_construcao)/(n_de_ocupado_gape_construcao) if id == "Amazônia Legal"
gen ik4 = (n_de_informal_gape_comercio)/(n_de_ocupado_gape_comercio) if id == "Amazônia Legal"
gen ik5 = (n_de_informal_gape_transporte)/(n_de_ocupado_gape_transporte) if id == "Amazônia Legal"
gen ik6 = (n_de_informal_gape_alimentacao)/(n_de_ocupado_gape_alimentacao) if id == "Amazônia Legal"
gen ik7 = (n_de_informal_gape_informacao)/(n_de_ocupado_gape_informacao) if id == "Amazônia Legal"
gen ik8 = (n_de_informal_gape_publica)/(n_de_ocupado_gape_publica) if id == "Amazônia Legal"
gen ik9 = (n_de_informal_gape_educacao)/(n_de_ocupado_gape_educacao) if id == "Amazônia Legal"
gen ik10 = (n_de_informal_gape_outros)/(n_de_ocupado_gape_outros) if id == "Amazônia Legal"
gen ik11 = (n_de_informal_gape_domestico)/(n_de_ocupado_gape_domestico) if id == "Amazônia Legal"
* 3)
collapse it* ik*
gen mult1 = ik1 * it1
gen mult2 = ik2 * it2
gen mult3 = ik3 * it3
gen mult4 = ik4 * it4
gen mult5 = ik5 * it5
gen mult6 = ik6 * it6
gen mult7 = ik7 * it7
gen mult8 = ik8 * it8
gen mult9 = ik9 * it9
gen mult10 = ik10 * it10
gen mult11= ik11 * it11

* 4)
gen taxa_de_informalidade = (mult1 + mult2 + mult3 + mult4 + mult5 + mult6 + mult7 + mult8 + mult9 + mult10 + mult11)*100

	graph bar taxa_de_informalidade 	/*
		*/	,  	/* over(id, label(angle(45)) )
		*/ 	title("Composição Setorial", size(Medium)) 	 	/*
		*/ 		/* subtitle("Mesma composição setorial dos ocupados do resto do Brasil") 
		*/ 	stack 	/*
		*/	bar(1, fcolor(ebblue%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range(0 60) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*  
		*/  saving("$tmp_dir\iten2", replace) 		
	
restore

/// composicao educacional
preserve
* 1)
gen it1 = n_de_ocupado_faixa_educ1/(n_de_ocupado_faixa_educ1 + n_de_ocupado_faixa_educ2 + n_de_ocupado_faixa_educ3 + n_de_ocupado_faixa_educ4 + n_de_ocupado_faixa_educ5) if id == "Resto do Brasil"
gen it2 = n_de_ocupado_faixa_educ2/(n_de_ocupado_faixa_educ1 + n_de_ocupado_faixa_educ2 + n_de_ocupado_faixa_educ3 + n_de_ocupado_faixa_educ4 + n_de_ocupado_faixa_educ5) if id == "Resto do Brasil"
gen it3 = n_de_ocupado_faixa_educ3/(n_de_ocupado_faixa_educ1 + n_de_ocupado_faixa_educ2 + n_de_ocupado_faixa_educ3 + n_de_ocupado_faixa_educ4 + n_de_ocupado_faixa_educ5) if id == "Resto do Brasil"
gen it4 = n_de_ocupado_faixa_educ4/(n_de_ocupado_faixa_educ1 + n_de_ocupado_faixa_educ2 + n_de_ocupado_faixa_educ3 + n_de_ocupado_faixa_educ4 + n_de_ocupado_faixa_educ5) if id == "Resto do Brasil"
gen it5 = n_de_ocupado_faixa_educ5/(n_de_ocupado_faixa_educ1 + n_de_ocupado_faixa_educ2 + n_de_ocupado_faixa_educ3 + n_de_ocupado_faixa_educ4 + n_de_ocupado_faixa_educ5) if id == "Resto do Brasil"

* 2)
gen ik1 = (n_de_informal_faixa_educ1)/(n_de_ocupado_faixa_educ1) if id == "Amazônia Legal"
gen ik2 = (n_de_informal_faixa_educ2)/(n_de_ocupado_faixa_educ2) if id == "Amazônia Legal"
gen ik3 = (n_de_informal_faixa_educ3)/(n_de_ocupado_faixa_educ3) if id == "Amazônia Legal"
gen ik4 = (n_de_informal_faixa_educ4)/(n_de_ocupado_faixa_educ4) if id == "Amazônia Legal"
gen ik5 = (n_de_informal_faixa_educ5)/(n_de_ocupado_faixa_educ5) if id == "Amazônia Legal"
* 3)
collapse it* ik*
gen mult1 = ik1 * it1
gen mult2 = ik2 * it2
gen mult3 = ik3 * it3
gen mult4 = ik4 * it4
gen mult5 = ik5 * it5
* 4)
gen taxa_de_informalidade = (mult1 + mult2 + mult3 + mult4 + mult5)*100

	graph bar taxa_de_informalidade 	/*
		*/	,  	/* over(id, label(angle(45)) )
		*/ 	title("Estrutura Educacional", size(Medium)) 	 	/*
		*/ 		/* subtitl("Mesma composição educacional dos ocupados do resto do Brasil") 
		*/ 	stack 	/*
		*/	bar(1, fcolor(ebblue%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	bargap(10) 	/*	
		*/	yscale( axis(1) range(0 60) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*  
		*/  saving("$tmp_dir\iten3", replace) 	
restore		
	
	/*
	 graph combine "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	title("Inserção da Ocupação") 	/*
	*/ 	subtitle("Amazônia Legal vs. Resto do Brasil") 	/*
	*/ 	note("Fonte: PNAD Contínua 2019")		
	*/
	
 graph combine "$tmp_dir\iten0" "$tmp_dir\iten1" "$tmp_dir\iten2" "$tmp_dir\iten3" ,  	/*
	*/ 	title("", size(Medium)) 	/*
	*/ 	cols(4) 	/*
	*/ 	ycommon 	/* ycommon
	*/  /* 	subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 /*	note("Fonte: PNAD Contínua 2019")	
	*/
	
		* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_contrafactual.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_contrafactual.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_contrafactual.png", replace