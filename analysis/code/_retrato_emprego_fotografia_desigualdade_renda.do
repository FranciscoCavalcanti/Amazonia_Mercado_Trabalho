//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
/////////////////////////////////////////

** call data 
use "$output_dir_build\_desigualdade_renda_resto_brasil.dta", clear

* merge data
cap tostring Trimestre, replace
merge 1:1 Ano Trimestre using "$output_dir_build\_estrutura_renda_resto_brasil.dta"
drop _merge
gen id = "Resto do Brasil"
save "$tmp_dir\data1", replace
			
** call data 
use "$output_dir_build\_desigualdade_renda_amazonia_legal.dta", clear

* merge data
cap tostring Trimestre, replace
merge 1:1 Ano Trimestre using "$output_dir_build\_estrutura_renda_amazonia_legal.dta"
drop _merge
gen id = "Amazônia Legal"
tempfile data1
save data1, replace

** Merge all data now
merge 1:1 Ano Trimestre id using  "$tmp_dir\data1"


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

* select variables
ds prop_rendimento_domiciliar_89 prop_rendimento_domiciliar_178 gini_rendimento_domiciliar_pc gini_ocupado
local type `r(varlist)'
display "`type'"

// attach label of variables
foreach v of var `type' {
    local l`v' : variable label `v'
}

collapse (mean) "`type'", by(id2 id) 

// copy back the label of variables
foreach v of var `type' {
    label var `v' "`l`v''"
}


*set scheme s2color 
*set scheme burd5
*set scheme mrc
set scheme s1color 

*preserve
preserve 

	egen iten1 = mean(prop_rendimento_domiciliar_89) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_rendimento_domiciliar_89) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
		
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("(%) < R$ 89,00", size(Medium)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%65)) 	/*
		*/	bar(2, fcolor(%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/ legend(on label(1 "Amazônia Legal") label(2 "Resto do Brasil")) 	/*
		*/  saving("$tmp_dir\iten1", replace)
		
* restore
restore

*preserve
preserve 

	egen iten1 = mean(prop_rendimento_domiciliar_178) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_rendimento_domiciliar_178) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
		
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("(%) < R$ 178,00", size(Medium)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%65)) 	/*
		*/	bar(2, fcolor(%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/ legend(on label(1 "Amazônia Legal") label(2 "Resto do Brasil")) 	/*
		*/  saving("$tmp_dir\iten2", replace)
		
* restore
restore

*preserve
preserve 

	egen iten1 = mean(gini_rendimento_domiciliar_pc) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(gini_rendimento_domiciliar_pc) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2

	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("GINI de RDPC", size(Medium)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%65)) 	/*
		*/	bar(2, fcolor(%65)) 	/*
		*/ 	blabel(bar,format(%12,2fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,2fc) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/  saving("$tmp_dir\iten3", replace)		
		
* restore
restore

*preserve
preserve 
	egen iten1 = mean(gini_ocupado) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(gini_ocupado) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("GINI dos ocupados", size(Medium)) 	 	/*
		*/	graphregion(fcolor(white)) 	/*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%65)) 	/*
		*/	bar(2, fcolor(%65)) 	/*
		*/ 	blabel(bar,format(%12,2fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12,2fc) angle(0) ) 	/*
		*/	ytitle( "")	/*  
		*/  saving("$tmp_dir\iten4", replace) 		
* restore
restore


* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten1" "$tmp_dir\iten2",  	/*
	*/ 	legendfrom("$tmp_dir\iten1") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(4) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/  saving("$tmp_dir\opa1", replace) 		
	
	

* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten3" "$tmp_dir\iten4",  	/*
	*/ 	legendfrom("$tmp_dir\iten3") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(4) 	/*
	*/ 	ycommon 	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/  saving("$tmp_dir\opa2", replace) 			
	
* Combing graphs with the same legend
	grc1leg "$tmp_dir\opa1" "$tmp_dir\opa2",  	/*
	*/ 	legendfrom("$tmp_dir\opa1") 	/*
	*/ 	title("") 	/*
	*/	graphregion(fcolor(white)) 	/*
	*/ 	cols(4) 	/*
	*/ 	  	/* ycommon
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/		
	
	
	* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_fotografia_desigualdade_renda.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_fotografia_desigualdade_renda.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_fotografia_desigualdade_renda.png", replace
