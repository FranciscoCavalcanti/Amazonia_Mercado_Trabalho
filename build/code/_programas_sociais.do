/*
O propostio desse do file é:
Descrever a relevância da programas sociais

Mais especificamente:
A) Proporção da população que recebe Bolsa Família
*/


/////////////////////////////////////////////////////////
//	A) Proporção da população que recebe Bolsa Família
/////////////////////////////////////////////////////////

// Dificuldade: 
// A pergunta sobre Bolsa Família é feita em diferentes visitas entre os anos, 
// e as vezes possui varíaveis com nomes diferentes
// i) 2012 até 2015 (visita 1)
// ii) 2016 até 2019 (visita 1)
// ii) 2016 até 2019 (visita 5)
// Solução: fazer loops separados,
// e ao final somar números totais por todos os trimestres

// i) 2012 até 2019 (visita 1)
forvalues year = 2012(1)2019 {
	
* call data
use "$input_pnadanual\PNADC_anual_`year'_visita1.dta", clear
cap drop iten*
**********************
**	 Definitions	**
**********************

global time  `year'

do "$code_dir\_definicoes_pnadcontinua_anual"

* select just a small sample for training data
cap drop __*
cap drop iten*
cap drop tool*
*sample 2

/////////////////////////////////////////////////////////
//	A) Proporção da população que recebeu Bolsa Família
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1032 // população total
by Ano Trimestre, sort: egen iten2 = total(iten1)
gen n_populacao = iten2

gen tool1 = 1 * V1032 if bolsa_familia == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_bolsa_familia = tool2
cap drop iten*
cap drop tool*


/////////////////////////////////////////////////////////
//	B) Proporção da população que recebeu programas sociais
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if ajuda_gov == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_ajuda_gov = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	c) Proporção da população que recebeu BPC-LOAS
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if bpc_loas == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_bpc_loas = tool2
cap drop iten*
cap drop tool*

**************************************
**	Colapsar ao nível do trimestre 	**
**************************************

	// attach label of variables
	local colvar n_* 

	foreach v of var `colvar' {
    local l`v' : variable label `v'
	}

	* colapse
	collapse (firstnm) `colvar' , by(Ano Trimestre)

	// copy back the label of variables
	foreach v of var `colvar' {
    label var `v' "`l`v''"
	}

* save as temporary
save "$tmp_dir\_temp_programas_sociais_PNADC_anual_`year'_visita1.dta", replace

 }
 
 
// ii) 2016 até 2019  (visita 5)
forvalues year = 2016(1)2019 {
	
* call data
use "$input_pnadanual\PNADC_anual_`year'_visita5.dta", clear
cap drop iten*
**********************
**	 Definitions	**
**********************

do "$code_dir\_definicoes_pnadcontinua_anual"

* select just a small sample for training data
cap drop __*
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	A) Proporção  com Bolsa Família
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1032 // população total
by Ano Trimestre, sort: egen iten2 = total(iten1)
gen n_populacao = iten2

gen tool1 = 1 * V1032 if bolsa_familia == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_bolsa_familia = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	B) Proporção da população que recebeu programas sociais
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if ajuda_gov == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_ajuda_gov = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	c) Proporção da população que recebeu BPC-LOAS
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if bpc_loas == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_bpc_loas = tool2
cap drop iten*
cap drop tool*

**************************************
**	Colapsar ao nível do trimestre 	**
**************************************

	// attach label of variables
	local colvar n_*

	foreach v of var `colvar' {
    local l`v' : variable label `v'
	}

	* colapse
	collapse (firstnm) `colvar' , by(Ano Trimestre)

	// copy back the label of variables
	foreach v of var `colvar' {
    label var `v' "`l`v''"
	}

* save as temporary
save "$tmp_dir\_temp_programas_sociais_PNADC_anual_`year'_visita5.dta", replace
}
 
 ************************************
 * 	Append temporary data base
 ************************************
clear 
	// i) 2012 até 2015  (visita 1) &
	// ii) 2016 até 2019  (visita 1)
	forvalues year = 2012(1)2019 {
	append using "$tmp_dir\_temp_programas_sociais_PNADC_anual_`year'_visita1.dta"
	}
	// iii) 2016 até 2019  (visita 5)
	forvalues year = 2016(1)2019 {
	append using "$tmp_dir\_temp_programas_sociais_PNADC_anual_`year'_visita5.dta"
	}

* sort	 
sort  Ano Trimestre

* Somar numeros totais por cada trimestre
collapse (sum) n_*, by(Ano Trimestre)
	
* Proporção da população que recebeu Bolsa Família em (%)
gen prop_bolsa_familia = (n_bolsa_familia/n_populacao)*100
label variable prop_bolsa_familia "Proporção da população que recebeu Bolsa Família (%)"
cap drop iten* tool* 

* Proporção da população que recebeu programas sociais em (%)
gen prop_ajuda_gov = (n_ajuda_gov/n_populacao)*100
label variable prop_ajuda_gov "Proporção da população que recebeu programas sociais (%)"
cap drop iten* tool* 

* Proporção da população que recebeu programas sociais em (%)
gen prop_bpc_loas = (n_bpc_loas/n_populacao)*100
label variable prop_bpc_loas "Proporção da população que recebeu BPC-LOAS (%)"
cap drop iten* tool* 

* keep only relavant variables
keep Ano Trimestre prop_*
order Ano Trimestre prop_*
