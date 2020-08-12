//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	Caracterização do mercado de trabalho	
/////////////////////////////////////////

** call data 
use "$output_dir_build\_programas_sociais_outras_rendas_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_programas_sociais_outras_rendas_resto_brasil.dta"
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
sort trim

** Mas trabalho infantil só existe para 2016
** Necessário collapsar para 2019 para todas variavies, exceto trabalho infantil
*** Anteção gambiarra! Transfomar 2019 = 2016 para trabalho infantil
by Trimestre id2, sort: egen iten = mean(prop_infantil_trab)
replace prop_infantil_trab = iten if Ano =="2019"

**************************************
**	Colapsar ao nível do Ano 		**
**************************************

// attach label of variables
local colvar prop_* 

foreach v of var `colvar' {
    local l`v' : variable label `v'
}

* colapse
collapse (firstnm) `colvar' , by(Ano id2)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}

* keep ano 2019
keep if Ano =="2019" 

*preserve
preserve 

	egen iten1 = mean(prop_trab_nremun) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_trab_nremun) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
		
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Trabalho não remunerado (%)", size(small)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(green%65)) 	/*
		*/	bar(2, fcolor(blue%65)) 	/*
		*/ 	blabel(bar,format(%9.1fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0f) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/ legend(on label(1 "Amazônia Legal") label(2 "Resto do Brasil")) 	/*
		*/  saving("$tmp_dir\iten1", replace)
		
* restore
restore

*preserve
preserve 

	egen iten1 = mean(prop_trab_cprop) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_trab_cprop) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2

	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Para consumo próprio (%)", size(small)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(green%65)) 	/*
		*/	bar(2, fcolor(blue%65)) 	/*
		*/ 	blabel(bar,format(%9.1fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0f) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/  saving("$tmp_dir\iten2", replace)		
		
* restore
restore

*preserve
preserve 
	egen iten1 = mean(prop_trab_volun) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_trab_volun) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Trabalho voluntário (%)", size(small)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(green%65)) 	/*
		*/	bar(2, fcolor(blue%65)) 	/*
		*/ 	blabel(bar,format(%9.1fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0f) angle(0) ) 	/*
		*/	ytitle( "")	/*  
		*/  saving("$tmp_dir\iten3", replace) 		
* restore
restore

*preserve
preserve 	
	egen iten1 = mean(prop_trab_domes) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_trab_domes) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2	
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Afazeres doméstico (%)", size(small)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(green%65)) 	/*
		*/	bar(2, fcolor(blue%65)) 	/*
		*/ 	blabel(bar,format(%9.1fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0f) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/  saving("$tmp_dir\iten4", replace) 			
* restore
restore

*preserve
preserve 	
	egen iten1 = mean(prop_infantil_trab) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_infantil_trab) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2	
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Trabalho infantil (%)", size(small)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(green%65)) 	/*
		*/	bar(2, fcolor(blue%65)) 	/*
		*/ 	blabel(bar,format(%9.1fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0f) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/  saving("$tmp_dir\iten5", replace) 			
* restore
restore

* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten1" "$tmp_dir\iten2" "$tmp_dir\iten3" "$tmp_dir\iten5",  	/*
	*/ 	legendfrom("$tmp_dir\iten1") 	/*
	*/ 	title("") 	/*
	*/ 	cols(4) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/	
	
				* save graph 
	graph save Graph "$output_dir\programas_sociais_outras_rendas\_outros_emprego_caracterizacao.gph", replace
	graph use "$output_dir\programas_sociais_outras_rendas\_outros_emprego_caracterizacao.gph"
	graph export "$output_dir\programas_sociais_outras_rendas\_outros_emprego_caracterizacao.png", replace
