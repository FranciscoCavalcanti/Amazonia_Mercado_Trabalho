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
gen visita = 1

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

/////////////////////////////////////////////////////////
//	H) Composição de rendimentos recebido em todas as fontes (R$)
/////////////////////////////////////////////////////////

// loop over common variables
local faixa renda_anual* renda_ajuda_gov* renda_seguro_desemprego* renda_aposentadoria* renda_doacao* renda_aluguel* renda_outro* renda_setorpublico* renda_privado*

foreach v of var `faixa' {
	* Rendimento recebido as fonte (R$)
	gen iten1 = (`v' * Habitual) * V1032 if `v'~=.
	by Ano Trimestre, sort: egen total_`v' = total(iten1)
	cap drop iten*
	cap drop tool*
	
	/////////////////////////////////////////////////////////
	// Número indivíduos com rendimento esse tipo de recebimento da fonte
	/////////////////////////////////////////////////////////
	gen tool1 = 1 * V1032 if `v' ~= .
	by Ano Trimestre, sort: egen tool2 = total(tool1)
	gen n_`v' = tool2
	cap drop iten*
	cap drop tool*
}

/////////////////////////////////////////////////////////
//	I) Pobreza
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
	local colvar visita n_* total_* 

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
gen visita = 5

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
//	F) Rendimentos (R$)
/////////////////////////////////////////////////////////

* Merge na base de dados com o deflator
cap tostring Trimestre, replace
merge m:1 Ano Trimestre UF using "$input_dir\deflatorPNADC_12.1-20.1.dta", update force
drop if _merge==2 
drop _merge
cap destring Trimestre, replace

/////////////////////////////////////////////////////////
//	H) Composição de rendimentos recebido em todas as fontes (R$)
/////////////////////////////////////////////////////////

// loop over common variables
local faixa renda_anual* renda_ajuda_gov* renda_seguro_desemprego* renda_aposentadoria* renda_doacao* renda_aluguel* renda_outro* renda_setorpublico* renda_privado*

foreach v of var `faixa' {
	* Rendimento recebido as fonte (R$)
	gen iten1 = (`v' * Habitual) * V1032 if `v'~=.
	by Ano Trimestre, sort: egen total_`v' = total(iten1)
	cap drop iten*
	cap drop tool*
	
	/////////////////////////////////////////////////////////
	// Número indivíduos com rendimento esse tipo de recebimento da fonte
	/////////////////////////////////////////////////////////
	gen tool1 = 1 * V1032 if `v' ~= .
	by Ano Trimestre, sort: egen tool2 = total(tool1)
	gen n_`v' = tool2
	cap drop iten*
	cap drop tool*
}

/////////////////////////////////////////////////////////
//	I) Pobreza
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

/////////////////////////////////////////////////////////
//	J) Número de trabalhadores não remunerados e consumo próprio
//	(está análise só é possível através das Visitas 5 PNAD Contínua anual)
/////////////////////////////////////////////////////////

// loop over common variables
local faixa trab_*

foreach v of var `faixa' {
	gen tool1 = 1 * V1032 if `v' ~= .
	by Ano Trimestre, sort: egen tool2 = total(tool1)
	gen n_`v' = tool2
	cap drop iten*
	cap drop tool*
}

/////////////////////////////////////////////////////////
//	L) Número de trabalhadores infantis
//	(está análise só é possível através das Visitas 5 PNAD Contínua anual)
/////////////////////////////////////////////////////////

// Qtd de pessoas de 5 a 13 anos de idade
gen tool1 = 1 * V1032 if infantil == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_infantil = tool2
cap drop iten*
cap drop tool*

// Qtd de pessoas de 5 a 13 anos de idade que trabalham
gen tool1 = 1 * V1032 if infantil_trab == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)
gen n_infantil_trab = tool2
cap drop iten*
cap drop tool*

**************************************
**	Colapsar ao nível do trimestre 	**
**************************************

	// attach label of variables
	local colvar visita n_* total_* 

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
sort  Ano Trimestre visita
** Atenção!!! Temos casos de Trimestres duplicados (representando visita 1 e 5)
*** decidir criar variáveis auxiliares: a média da população para casos onde só há informação na visita 5
gen mean_n_populacao = n_populacao

* Somar numeros totais por cada trimestre
** Atenção!!! Apenas proporções ou valor per capita são válidos apartir daqui
	// attach label of variables
	local colvar n_* total_*
	foreach v of var `colvar' {
    	local l`v' : variable label `v'
	}
collapse (mean) mean_n_populacao (sum) n_* total_* , by(Ano Trimestre)	
	// copy back the label of variables
	foreach v of var `colvar' {
    	label var `v' "`l`v''"
	}

//////////////////////////////////////////////////////
// Proporções onde há variáveis em todas as visitas (Visita 1 e Visita 5)
//////////////////////////////////////////////////////
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

* Proporção da população que recebeu seguro desemprego em (%)
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

//////////////////////////////////////////////////////
// Proporções onde há variáveis em apenas na Visita 5
//////////////////////////////////////////////////////

// attach label of variables
local faixa  trab_nremun  /*
 	*/ 	trab_cprop 	/*
 	*/ 	trab_volun 	/*
 	*/ 	trab_domes 	
	
// loop over common variables
foreach v in `faixa' {
	* Proporção da população em (%)
	gen prop_`v' = (n_`v'/mean_n_populacao)*100
	*label variable prop_`v' "Proporção da população (%)"
	cap drop iten* tool* 
}

label variable prop_trab_nremun "Proporção de trabalhador não remunerado sobre a população (%)"
label variable prop_trab_cprop "Proporção de quem produz para próprio consumo sobre a população (%)"
label variable prop_trab_volun "Proporção de trabalhadores voluntários sobre a população (%)"
label variable prop_trab_domes "Proporção de quem faz afazers domésticos sobre a população (%)"

* Proporção trabalhador infantil (pessoas de 5 a 13 anos de idade) em (%)
gen prop_infantil_trab = (n_infantil_trab/n_infantil)*100
label variable prop_infantil_trab "Proporção de crianças que trabalham (%)"
cap drop iten* tool* 

//////////////////////////////////////////////////////
// Rendimentos
//////////////////////////////////////////////////////
* Rendimento domiciliar per capita (R$)
cap gen renda_anual_pc_total = (total_renda_anual_pc/n_populacao)
label variable	renda_anual_pc_total "Rendimento domiciliar per capita (R$)"
cap drop iten*
cap drop tool*

* Rendimento recebido em todas as fontes (R$)
cap gen renda_anual_total = (total_renda_anual/n_populacao)
label variable	renda_anual_total "Rendimento recebido em todas as fontes (R$)"
cap drop iten*
cap drop tool*

// attach label of variables
local faixa  renda_ajuda_gov  /*
 	*/ 	renda_seguro_desemprego 	/*
 	*/ 	renda_aposentadoria 	/*
 	*/ 	renda_doacao 	/*
 	*/ 	renda_aluguel 	/*
 	*/ 	renda_outro 	/*
 	*/ 	renda_setorpublico 	/*
 	*/ 	renda_privadoformal 	/*
 	*/ 	renda_privadoinformal 	/*
 	*/ 	renda_anual_pc
	
// loop over common variables
foreach v in `faixa' {
    gen `v' = (total_`v'/n_populacao)
    // loop sobre faixas de rendimentos
    forvalues num = 1(1)7 {
		gen `v'`num' = (total_`v'`num'/n_renda_anual_pc`num')
		replace `v'`num' = 0 if `v'`num'==.
		cap drop iten*
		cap drop tool*
	}
}

label variable	renda_ajuda_gov "Programas sociais"
label variable	renda_ajuda_gov1 "Programas sociais"
label variable	renda_ajuda_gov2 "Programas sociais"
label variable	renda_ajuda_gov3 "Programas sociais"
label variable	renda_ajuda_gov4 "Programas sociais"
label variable	renda_ajuda_gov5 "Programas sociais"
label variable	renda_ajuda_gov6 "Programas sociais"
label variable	renda_ajuda_gov7 "Programas sociais"

label variable	renda_seguro_desemprego  "Seguro-desemprego e seguro-defeso"
label variable	renda_seguro_desemprego1 "Seguro-desemprego e seguro-defeso"
label variable	renda_seguro_desemprego2 "Seguro-desemprego e seguro-defeso"
label variable	renda_seguro_desemprego3 "Seguro-desemprego e seguro-defeso"
label variable	renda_seguro_desemprego4 "Seguro-desemprego e seguro-defeso"
label variable	renda_seguro_desemprego5 "Seguro-desemprego e seguro-defeso"
label variable	renda_seguro_desemprego6 "Seguro-desemprego e seguro-defeso"
label variable	renda_seguro_desemprego7 "Seguro-desemprego e seguro-defeso"

label variable	renda_aposentadoria "Aposentadoria e pensão"
label variable	renda_aposentadoria1 "Aposentadoria e pensão"
label variable	renda_aposentadoria2 "Aposentadoria e pensão"
label variable	renda_aposentadoria3 "Aposentadoria e pensão"
label variable	renda_aposentadoria4 "Aposentadoria e pensão"
label variable	renda_aposentadoria5 "Aposentadoria e pensão"
label variable	renda_aposentadoria6 "Aposentadoria e pensão"
label variable	renda_aposentadoria7 "Aposentadoria e pensão"

label variable	renda_doacao "Pensão alimentícia, doação e mesada"
label variable	renda_doacao1 "Pensão alimentícia, doação e mesada"
label variable	renda_doacao2 "Pensão alimentícia, doação e mesada"
label variable	renda_doacao3 "Pensão alimentícia, doação e mesada"
label variable	renda_doacao4 "Pensão alimentícia, doação e mesada"
label variable	renda_doacao5 "Pensão alimentícia, doação e mesada"
label variable	renda_doacao6 "Pensão alimentícia, doação e mesada"
label variable	renda_doacao7 "Pensão alimentícia, doação e mesada"

label variable	renda_aluguel "Aluguel e arrendamento"
label variable	renda_aluguel1 "Aluguel e arrendamento"
label variable	renda_aluguel2 "Aluguel e arrendamento"
label variable	renda_aluguel3 "Aluguel e arrendamento"
label variable	renda_aluguel4 "Aluguel e arrendamento"
label variable	renda_aluguel5 "Aluguel e arrendamento"
label variable	renda_aluguel6 "Aluguel e arrendamento"
label variable	renda_aluguel7 "Aluguel e arrendamento"

label variable	renda_outro "Bolsa de estudos, caderneta de poupança e aplicações financeiras"
label variable	renda_outro1 "Bolsa de estudos, caderneta de poupança e aplicações financeiras"
label variable	renda_outro2 "Bolsa de estudos, caderneta de poupança e aplicações financeiras"
label variable	renda_outro3 "Bolsa de estudos, caderneta de poupança e aplicações financeiras"
label variable	renda_outro4 "Bolsa de estudos, caderneta de poupança e aplicações financeiras"
label variable	renda_outro5 "Bolsa de estudos, caderneta de poupança e aplicações financeiras"
label variable	renda_outro6 "Bolsa de estudos, caderneta de poupança e aplicações financeiras"
label variable	renda_outro7 "Bolsa de estudos, caderneta de poupança e aplicações financeiras"

label variable	renda_setorpublico "Setor público"
label variable	renda_setorpublico1 "Setor público"
label variable	renda_setorpublico2 "Setor público"
label variable	renda_setorpublico3 "Setor público"
label variable	renda_setorpublico4 "Setor público"
label variable	renda_setorpublico5 "Setor público"
label variable	renda_setorpublico6 "Setor público"
label variable	renda_setorpublico7 "Setor público"

label variable	renda_privadoformal "Privado formal"
label variable	renda_privadoformal1 "Privado formal"
label variable	renda_privadoformal2 "Privado formal"
label variable	renda_privadoformal3 "Privado formal"
label variable	renda_privadoformal4 "Privado formal"
label variable	renda_privadoformal5 "Privado formal"
label variable	renda_privadoformal6 "Privado formal"
label variable	renda_privadoformal7 "Privado formal"

label variable	renda_privadoinformal "Privado informal"
label variable	renda_privadoinformal1 "Privado informal"
label variable	renda_privadoinformal2 "Privado informal"
label variable	renda_privadoinformal3 "Privado informal"
label variable	renda_privadoinformal4 "Privado informal"
label variable	renda_privadoinformal5 "Privado informal"
label variable	renda_privadoinformal6 "Privado informal"
label variable	renda_privadoinformal7 "Privado informal"

label variable	renda_anual_pc "Rendimento domiciliar per capita (R$)"
label variable	renda_anual_pc1 "Rendimento domiciliar per capita (R$)"
label variable	renda_anual_pc2 "Rendimento domiciliar per capita (R$)"
label variable	renda_anual_pc3 "Rendimento domiciliar per capita (R$)"
label variable	renda_anual_pc4 "Rendimento domiciliar per capita (R$)"
label variable	renda_anual_pc5 "Rendimento domiciliar per capita (R$)"
label variable	renda_anual_pc6 "Rendimento domiciliar per capita (R$)"
label variable	renda_anual_pc7 "Rendimento domiciliar per capita (R$)"

* Rendimentos do trabalho restante
gen renda_privado = renda_anual_pc - (renda_ajuda_gov + renda_seguro_desemprego + renda_aposentadoria + renda_doacao + renda_aluguel + renda_outro + renda_setorpublico + renda_privadoinformal)
  // loop sobre faixas de rendimentos
forvalues num = 1(1)7 {
	gen renda_privado`num' = renda_anual_pc`num' - (renda_ajuda_gov`num' + renda_seguro_desemprego`num' + renda_aposentadoria`num' + renda_doacao`num' + renda_aluguel`num' + renda_outro`num' + renda_setorpublico`num' + renda_privadoinformal`num')
	replace renda_privado`num' = 0 if renda_privado`num'==.
	cap drop iten*
	cap drop tool*
}

label variable	renda_privado "Setor privado formal"
label variable	renda_privado1 "Setor privado formal"
label variable	renda_privado2 "Setor privado formal"
label variable	renda_privado3 "Setor privado formal"
label variable	renda_privado4 "Setor privado formal"
label variable	renda_privado5 "Setor privado formal"
label variable	renda_privado6 "Setor privado formal"
label variable	renda_privado7 "Setor privado formal"

* keep only relavant variables
keep Ano Trimestre  prop_* renda_*
order Ano Trimestre prop_* renda_*
