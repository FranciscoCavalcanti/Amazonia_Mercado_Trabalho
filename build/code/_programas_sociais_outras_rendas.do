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
*sample 1

**********************
**	 Definitions	**
**********************

global time  `year'

do "$code_dir\_definicoes_pnadcontinua_anual"

* select just a small *sample for training data
cap drop __*
cap drop iten*
cap drop tool*
**sample 2


/////////////////////////////////////////////////////////
//	X) Número da população
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1032 // população total
by Ano Trimestre, sort: egen iten2 = total(iten1)
gen n_populacao = iten2
cap drop iten*

/////////////////////////////////////////////////////////
//	A) Número da população que recebeu Bolsa Família
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if bolsa_familia == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_bolsa_familia = tool2
label variable n_bolsa_familia "Número que recebeu Bolsa Família"
cap drop iten*
cap drop tool*


/////////////////////////////////////////////////////////
//	B) Número da população que recebeu programas sociais
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if ajuda_gov == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_ajuda_gov = tool2
label variable n_ajuda_gov "Número que recebeu programas sociais"
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	C) Número da população que recebeu BPC-LOAS
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if bpc_loas == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_bpc_loas = tool2
label variable n_bpc_loas "Número que recebeu BPC-LOAS"
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	D) Número da população que recebeu seguro-desemprego
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if seguro_desemprego == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_seguro_desemprego = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	E) Número da população que recebeu aposentadoria
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if aposentadoria == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_aposentadoria = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	F) Rendimento domiciliar per capita (R$)
/////////////////////////////////////////////////////////

* Merge na base de dados com o deflator
cap tostring Trimestre, replace
merge m:1 Ano Trimestre UF using "$input_dir\deflatorPNADC_12.1-20.1.dta", update force
drop if _merge==2 
drop _merge
cap destring Trimestre, replace

* Rendimento domiciliar per capita (R$)
gen tool1 = 1 * V1032
gen iten1 = (renda_anual_pc * Habitual) * V1032
by Ano Trimestre, sort: egen total_renda_anual_pc = total(iten1)
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	G) Rendimento recebido em todas as fontes (R$)
/////////////////////////////////////////////////////////

* Rendimento recebido em todas as fontes (R$)
gen tool1 = 1 * V1032
gen iten1 = (renda_anual * Habitual) * V1032
by Ano Trimestre, sort: egen total_renda_anual = total(iten1)
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
// Número indivíduos com rendimento per capita de até R$ 300,00 ($ 1.9 por dia)
/////////////////////////////////////////////////////////
gen iten0 = renda_anual_pc * Habitual
gen tool1 = 1 * V1032 if iten0 <= 300
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_renda_anual_pc_300 = tool2
cap drop iten*
cap drop tool*

**************************************
**	Colapsar ao nível do trimestre 	**
**************************************

	// attach label of variables
	local colvar n_* total_* 

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
*sample 1

**********************
**	 Definitions	**
**********************

do "$code_dir\_definicoes_pnadcontinua_anual"

* select just a small *sample for training data
cap drop __*
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	X) Número da população
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1032 // população total
by Ano Trimestre, sort: egen iten2 = total(iten1)
gen n_populacao = iten2
cap drop iten*

/////////////////////////////////////////////////////////
//	A) Número  com Bolsa Família
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if bolsa_familia == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_bolsa_familia = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	B) Número da população que recebeu programas sociais
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if ajuda_gov == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_ajuda_gov = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	C) Número da população que recebeu BPC-LOAS
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if bpc_loas == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_bpc_loas = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	D) Número da população que recebeu seguro-desemprego
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if seguro_desemprego == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_seguro_desemprego = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	E) Número da população que recebeu aposentadoria
/////////////////////////////////////////////////////////
gen tool1 = 1 * V1032 if aposentadoria == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_aposentadoria = tool2
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	F) Rendimento domiciliar per capita (R$)
/////////////////////////////////////////////////////////

* Merge na base de dados com o deflator
cap tostring Trimestre, replace
merge m:1 Ano Trimestre UF using "$input_dir\deflatorPNADC_12.1-20.1.dta", update force
drop if _merge==2 
drop _merge
cap destring Trimestre, replace

* Rendimento domiciliar per capita (R$)
gen tool1 = 1 * V1032
gen iten1 = (renda_anual_pc * Habitual) * V1032
by Ano Trimestre, sort: egen total_renda_anual_pc = total(iten1)
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	G) Rendimento recebido em todas as fontes (R$)
/////////////////////////////////////////////////////////

* Rendimento recebido em todas as fontes (R$)
gen tool1 = 1 * V1032
gen iten1 = (renda_anual * Habitual) * V1032
by Ano Trimestre, sort: egen total_renda_anual = total(iten1)
cap drop iten*
cap drop tool*

/////////////////////////////////////////////////////////
//	B) Pobreza
/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// Número indivíduos com rendimento per capita de até R$ 300,00 ($ 1.9 por dia)
/////////////////////////////////////////////////////////
gen iten0 = renda_anual_pc * Habitual
gen tool1 = 1 * V1032 if iten0 <= 300
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_renda_anual_pc_300 = tool2
cap drop iten*
cap drop tool*

**************************************
**	Colapsar ao nível do trimestre 	**
**************************************

	// attach label of variables
	local colvar n_* total_* 

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
	// attach label of variables
	local colvar n_* total_*
	foreach v of var `colvar' {
    	local l`v' : variable label `v'
	}
collapse (sum) n_* total_* , by(Ano Trimestre)	
	// copy back the label of variables
	foreach v of var `colvar' {
    	label var `v' "`l`v''"
	}
	
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

* roporção da população que recebeu seguro desemprego em (%)
gen prop_seguro_desemprego = (n_seguro_desemprego/n_populacao)*100
label variable prop_seguro_desemprego "Proporção da população que recebeu seguro desemprego (%)"
cap drop iten* tool* 

* Proporção da população aposentadoria em (%)
gen prop_aposentadoria = (n_aposentadoria/n_populacao)*100
label variable prop_aposentadoria "Proporção da população que recebeu aposentadoria (%)"
cap drop iten* tool* 

* Proporção da população aposentadoria em (%)
gen prop_renda_anual_pc_300 = (n_renda_anual_pc_300/n_populacao)*100
label variable prop_renda_anual_pc_300 "Proporção da população com rendimento per capita de até R$ 300,00 (%)"
cap drop iten* tool* 

* Rendimento domiciliar per capita (R$)
gen renda_anual_pc_total = (total_renda_anual_pc/n_populacao)
label variable	renda_anual_pc_total "Rendimento domiciliar per capita (R$)"
cap drop iten*
cap drop tool*

* Rendimento recebido em todas as fontes (R$)
gen renda_anual_total = (total_renda_anual/n_populacao)
label variable	renda_anual_total "Rendimento recebido em todas as fontes (R$)"
cap drop iten*
cap drop tool*

* keep only relavant variables
keep Ano Trimestre  prop_* renda_*
order Ano Trimestre prop_* renda_*
