//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//		
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

* keep 2019
keep if Ano =="2019"

**************************************
**	Colapsar ao nível do Ano 	**
**************************************

// attach label of variables
local colvar prop_* taxa_* n_*

foreach v of var `colvar' {
    local l`v' : variable label `v'
}

* colapse
collapse (firstnm) `colvar' , by(Ano id2)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}

**	Taxa de participacao	**
set scheme s1mono

*preserve
preserve 

	gen iten1 = (n_de_pea_faixa_etaria1/n_faixa_etaria1)*100
	gen iten2 = (n_de_pea_faixa_etaria2/n_faixa_etaria2)*100
	gen iten3 = (n_de_pea_faixa_etaria3/n_faixa_etaria3)*100
	gen iten4 = (n_de_pea_faixa_etaria4/n_faixa_etaria4)*100	
	
	graph bar iten1 iten2 iten3 iten4	/*
		*/	,  over(id2)	 /* 
		*/ 	title("", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(eltgreen%65)) 	/*
		*/	bar(2, fcolor(blue%65)) 	/*
		*/	bar(3, fcolor(%65)) 	/*
		*/	bar(4, fcolor(%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/ 	legend(on cols(4) label(1 "18 à 24 anos") label(2 "25 à 39 anos") label(3 "40 à 59 anos") label(4 "> de 60 anos") size(small) forcesize symysize(3pt) symxsize(3pt) ) 	/*
		*/  saving("$tmp_dir\iten1", replace)
		
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_prop_participacao.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_prop_participacao.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_prop_participacao.png", replace

	
* restore
restore	

**	Taxa de ocupação	**
set scheme s1mono

*preserve
preserve 

	gen iten1 = (n_de_ocupado_faixa_etaria1/n_faixa_etaria1)*100
	gen iten2 = (n_de_ocupado_faixa_etaria2/n_faixa_etaria2)*100
	gen iten3 = (n_de_ocupado_faixa_etaria3/n_faixa_etaria3)*100
	gen iten4 = (n_de_ocupado_faixa_etaria4/n_faixa_etaria4)*100	
	
	graph bar iten1 iten2 iten3 iten4	/*
		*/	,  over(id2)	 /* 
		*/ 	title("", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(eltgreen%65)) 	/*
		*/	bar(2, fcolor(blue%65)) 	/*
		*/	bar(3, fcolor(%65)) 	/*
		*/	bar(4, fcolor(%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/ 	legend(on cols(4) label(1 "18 à 24 anos") label(2 "25 à 39 anos") label(3 "40 à 59 anos") label(4 "> de 60 anos") size(small) forcesize symysize(3pt) symxsize(3pt) ) 	/*
		*/  saving("$tmp_dir\iten1", replace)
		
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_prop_ocupacao.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_prop_ocupacao.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_prop_ocupacao.png", replace

	
* restore
restore	