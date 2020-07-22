//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	C 	
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

* keep 2019
keep if Ano =="2019"

**************************************
**	Colapsar ao nível do Ano 	**
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

*preserve
preserve 
	egen iten1 = mean(prop_ajuda_gov) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_ajuda_gov) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Programas Sociais", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(sienna%65)) 	/*
		*/	bar(2, fcolor(stone%65)) 	/*
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

	egen iten1 = mean(prop_bolsa_familia) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_bolsa_familia) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2
		
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Bolsa Família", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(sienna%65)) 	/*
		*/	bar(2, fcolor(stone%65)) 	/*
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

	egen iten1 = mean(prop_bpc_loas) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_bpc_loas) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2

	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("BPC-LOAS", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(sienna%65)) 	/*
		*/	bar(2, fcolor(stone%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
		*/	xtitle() 	/*	
		*/	yscale( axis(1) range( ) lstyle(none)  )	/* how y axis looks
		*/	ylabel(#9, format(%12.0fc) angle(0) ) 	/*
		*/	ytitle( "")	/*   
		*/  saving("$tmp_dir\iten3", replace)		
		
* restore
restore

*preserve
preserve 	
	egen iten1 = mean(prop_aposentadoria) if id2==1
	egen ok1 = mean(iten1)
	egen iten2 = mean(prop_aposentadoria) if id2==2
	egen ok2 = mean(iten2) 
	collapse ok1 ok2	
	graph bar ok1 ok2  	/*
		*/	,  	 /* 
		*/ 	title("Aposentadoria", size(Medium)) 	 	/*
		*/  /*
		*/	bargap(10) 	/*	
		*/	bar(1, fcolor(sienna%65)) 	/*
		*/	bar(2, fcolor(stone%65)) 	/*
		*/ 	blabel(bar,format(%12.0fc) position(center) color(bg) size(Medium) ) 	/*
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
	*/ 	 	/* subtitle("Amazônia Legal vs. Resto do Brasil")
	*/ 	 	/* note("Fonte: PNAD Contínua 2019")
	*/	
	
				* save graph 
	graph save Graph "$output_dir\retrato_emprego\_retrato_emprego_fotografia_programas_sociais.gph", replace
	graph use "$output_dir\retrato_emprego\_retrato_emprego_fotografia_programas_sociais.gph"
	graph export "$output_dir\retrato_emprego\_retrato_emprego_fotografia_programas_sociais.png", replace
