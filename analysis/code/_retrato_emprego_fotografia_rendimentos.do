//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	C 	
/////////////////////////////////////////

** call data 
use "$output_dir_build\_estrutura_renda_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_estrutura_renda_resto_brasil.dta"
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
local colvar rendimento_*

foreach v of var `colvar' {
    local l`v' : variable label `v'
}

* colapse
collapse (firstnm) `colvar' , by(Ano id2)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}

* set scheme
set scheme amz2030   

*preserve
preserve 

	egen iten1 = mean(rendimento_medio_total) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(rendimento_medio_total) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
		
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Ocupados", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%75)) 	/*
		*/	bar(2, fcolor(%75)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(small) ) 	/*
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

	egen iten1 = mean(rendimento_medio_formal) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(rendimento_medio_formal) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2

	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Setor formal", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%75)) 	/*
		*/	bar(2, fcolor(%75)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(small) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/  saving("$tmp_dir\iten2", replace)		
		
* restore
restore

*preserve
preserve 
	egen iten1 = mean(rendimento_medio_informal) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(rendimento_medio_informal) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Setor informal", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%75)) 	/*
		*/	bar(2, fcolor(%75)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(small) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*  
		*/  saving("$tmp_dir\iten3", replace) 		
* restore
restore

*preserve
preserve 	
	egen iten1 = mean(rendimento_domiciliar_pc) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(rendimento_domiciliar_pc) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2	
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Domiciliar per capita", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(%75)) 	/*
		*/	bar(2, fcolor(%75)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(small) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/  saving("$tmp_dir\iten4", replace) 			
* restore
restore


* Combing graphs with the same legend
	grc1leg "$tmp_dir\iten1" "$tmp_dir\iten2" "$tmp_dir\iten3" "$tmp_dir\iten4",  	/*
	*/ 	legendfrom("$tmp_dir\iten1") 	/*
	*/ 	title("") 	/*
	*/ 	cols(4) 	/*
	*/ 	ycommon 	/* ycommon
	*/	graphregion(fcolor(white)) 	/*
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/	
	
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_fotografia_rendimentos.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_fotografia_rendimentos.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_fotografia_rendimentos.png", replace
