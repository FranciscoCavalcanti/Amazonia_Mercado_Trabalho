/*
O propostio desse do file é:
Descrever a estrutura do emprego

Mais especificamente:
A) Taxa de desemprego
B) Proporção de ocupados
C) Taxa de participação
D) Taxa de informalidade
E) Inserção no mercado de trabalho por tipo ocupação
*/

**********************
**	 Definitions	**
**********************

do "$code_dir\_definicoes_pnadcontinua_trimestral"

* select just a small sample for training data
cap drop __*
cap drop iten*
*sample 2

/////////////////////////////////////////////////////////
//	A) Taxa de desemprego
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if desocupado == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen tool1 = 1 * V1028 if forcatrabalho == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)

gen taxa_de_desemprego = (iten2/tool2)*100
label variable taxa_de_desemprego "Taxa de desemprego em relação à força de trabalho (%)"
cap drop iten*
cap drop tool* 

/////////////////////////////////////////////////////////
//	B) Proporção de ocupados
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if ocupado == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen tool1 = 1 * V1028 if pia == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)

gen taxa_de_ocupacao = (iten2/tool2)*100
label variable taxa_de_ocupacao "Taxa de ocupação em relação à PIA (%)"
cap drop iten* tool* 

/////////////////////////////////////////////////////////
//	C) Taxa de participação
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if pea == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen tool1 = 1 * V1028 if pia == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)

gen taxa_de_participacao = (iten2/tool2)*100
label variable taxa_de_participacao "Taxa de participação em relação à PIA (%)"
cap drop iten*
cap drop tool* 

/////////////////////////////////////////////////////////
//	D) Taxa de informalidade
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if informal == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen tool1 = 1 * V1028 if ocupado == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)

gen taxa_de_informalidade = (iten2/tool2)*100
label variable taxa_de_informalidade "Taxa de informalidade em relação aos ocupados (%)"
cap drop iten*
cap drop tool* 

/////////////////////////////////////////////////////////
//	E) Inserção no mercado de trabalho por tipo ocupação
/////////////////////////////////////////////////////////

* total de ocupados
gen tool1 = 1 * V1028 if ocupado == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)

* proporção de trabalhador com carteira assinada
gen iten1 = 1 * V1028 if empregadoCC == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_empregadoCC = (iten2/tool2)*100
label variable prop_empregadoCC "Proporção de trabalhadores com carteira em relação aos ocupados (%)"
cap drop iten*

* proporção de trabalhador sem carteira assinada
gen iten1 = 1 * V1028 if empregadoSC == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_empregadoSC = (iten2/tool2)*100
label variable prop_empregadoSC "Proporção de trabalhadores sem carteira em relação aos ocupados (%)"
cap drop iten*

* proporção de empregadores
gen iten1 = 1 * V1028 if empregador == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_empregador = (iten2/tool2)*100
label variable prop_empregador "Proporção de empregadores em relação aos ocupados (%)"
cap drop iten*

* proporção de trabalhadores por conta-própria
gen iten1 = 1 * V1028 if cpropria == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_cpropria = (iten2/tool2)*100
label variable prop_cpropria "Proporção de trabalhadores por conta própria em relação aos ocupados (%)"
cap drop iten*

* proporção de trabalhadores por conta-própria que contribui
gen iten1 = 1 * V1028 if cpropriaC == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_cpropriaC = (iten2/tool2)*100
label variable prop_cpropriaC "Proporção de conta própria que contribui em relação aos ocupados (%)"
cap drop iten*

* proporção de trabalhadores por conta-própria que não contribui
gen iten1 = 1 * V1028 if cpropriaNc == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_cpropriaNc = (iten2/tool2)*100
label variable prop_cpropriaNc "Proporção de conta própria que não contribui em relação aos ocupados (%)"
cap drop iten*

* proporção de militares
gen iten1 = 1 * V1028 if militar == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_militar = (iten2/tool2)*100
label variable prop_militar "Proporção servidores públicos e militares em relação aos ocupados (%)"
cap drop iten*

* proporção de trabalhadores em casa
gen iten1 = 1 * V1028 if homeoffice == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_homeoffice = (iten2/tool2)*100
label variable prop_homeoffice "Proporção trabalhadores em casa em relação aos ocupados (%)"
cap drop iten*

/////////////////////////////////////////////////////////
//	A) Número total de desemprego
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if desocupado == 1
by Ano Trimestre, sort: egen n_de_desemprego = total(iten1)
replace n_de_desemprego = round(n_de_desemprego)
label variable n_de_desemprego "Número de desempregados"
cap drop iten*
cap drop tool* 

/////////////////////////////////////////////////////////
//	B) Número de ocupados
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if ocupado == 1
by Ano Trimestre, sort: egen n_de_ocupacao = total(iten1)
label variable n_de_ocupacao "Número de ocupados"
cap drop iten*
cap drop tool* 


/////////////////////////////////////////////////////////
//	D) Número total de informalidade
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if informal == 1
by Ano Trimestre, sort: egen n_de_informalidade = total(iten1)
replace n_de_informalidade = round(n_de_informalidade)
label variable n_de_informalidade "Número de trabalhadores informais"
cap drop iten*
cap drop tool* 

/////////////////////////////////////////////////////////
//	E) Inserção no mercado de trabalho por tipo ocupação
/////////////////////////////////////////////////////////

* Número de trabalhador com carteira assinada
gen iten1 = 1 * V1028 if empregadoCC == 1
by Ano Trimestre, sort: egen n_empregadoCC = total(iten1)
replace n_empregadoCC = round(n_empregadoCC)
label variable n_empregadoCC "Número de trabalhadores com carteira"
cap drop iten*

* Número de trabalhador sem carteira assinada
gen iten1 = 1 * V1028 if empregadoSC == 1
by Ano Trimestre, sort: egen n_empregadoSC = total(iten1)
replace n_empregadoSC = round(n_empregadoSC)
label variable n_empregadoSC "Número de trabalhadores sem carteira"
cap drop iten*

* Número de empregadores
gen iten1 = 1 * V1028 if empregador == 1
by Ano Trimestre, sort: egen n_empregador = total(iten1)
replace n_empregador = round(n_empregador)
label variable n_empregador "Número de empregadores"
cap drop iten*

* Número de trabalhadores por conta-própria
gen iten1 = 1 * V1028 if cpropria == 1
by Ano Trimestre, sort: egen n_cpropria = total(iten1)
replace n_cpropria = round(n_cpropria)
label variable n_cpropria "Número de trabalhadores por conta própria"
cap drop iten*

* Número de trabalhadores por conta-própria que contribui
gen iten1 = 1 * V1028 if cpropriaC == 1
by Ano Trimestre, sort: egen n_cpropriaC = total(iten1)
replace n_cpropriaC = round(n_cpropriaC)
label variable n_cpropriaC "Número de conta própria que contribui"
cap drop iten*

* Número de trabalhadores por conta-própria que não contribui
gen iten1 = 1 * V1028 if cpropriaNc == 1
by Ano Trimestre, sort: egen n_cpropriaNc = total(iten1)
replace n_cpropriaNc = round(n_cpropriaNc)
label variable n_cpropriaNc "Número de conta própria que não contribui"
cap drop iten*

* Número de militares
gen iten1 = 1 * V1028 if militar == 1
by Ano Trimestre, sort: egen n_militar = total(iten1)
replace n_militar = round(n_militar)
label variable n_militar "Número servidores públicos e militares"
cap drop iten*

* Número de trabalhadores em casa
gen iten1 = 1 * V1028 if homeoffice == 1
by Ano Trimestre, sort: egen n_homeoffice = total(iten1)
replace n_homeoffice = round(n_homeoffice)
label variable n_homeoffice "Número trabalhadores em casa"
cap drop iten*


/////////////////////////////////////////////////////////
//	Caracterização por faixas de etarias, educacional, genero
/////////////////////////////////////////////////////////

// attach label of variables
local faixa faixa_*

foreach v of var `faixa' {

    local l`v' : variable label `v'
    /////////////////////////////////////////////////////////
	//	Número total
	/////////////////////////////////////////////////////////
	gen iten1 = 1 * V1028 if `v'==1
	by Ano Trimestre, sort: egen n_`v' = total(iten1)
	replace n_`v' = round(n_`v')
	label variable n_`v' "Número total"
	cap drop iten*

	/////////////////////////////////////////////////////////
	//	Número de ocupados 
	/////////////////////////////////////////////////////////
	gen iten1 = 1 * V1028 if ocupado == 1 & `v'==1
	by Ano Trimestre, sort: egen n_de_ocupado_`v' = total(iten1)
	replace n_de_ocupado_`v' = round(n_de_ocupado_`v')
	label variable n_de_ocupado_`v' "Número de ocupados"
	cap drop iten*
	
	/////////////////////////////////////////////////////////
	//	Número de formal 
	/////////////////////////////////////////////////////////
	gen iten1 = 1 * V1028 if formal == 1 & `v'==1
	by Ano Trimestre, sort: egen n_de_formal_`v' = total(iten1)
	replace n_de_formal_`v' = round(n_de_formal_`v')
	label variable n_de_formal_`v' "Número de formal"
	cap drop iten*
	
	/////////////////////////////////////////////////////////
	//	Número de informal  
	/////////////////////////////////////////////////////////
	gen iten1 = 1 * V1028 if informal == 1 & `v'==1
	by Ano Trimestre, sort: egen n_de_informal_`v' = total(iten1)
	replace n_de_informal_`v' = round(n_de_informal_`v')
	label variable n_de_informal_`v' "Número de informais"
	cap drop iten*

	/////////////////////////////////////////////////////////
	//	Número de economicamente ativo (PEA)  
	/////////////////////////////////////////////////////////
	gen iten1 = 1 * V1028 if pea == 1 & `v'==1
	by Ano Trimestre, sort: egen n_de_pea_`v' = total(iten1)
	replace n_de_pea_`v' = round(n_de_pea_`v')
	label variable n_de_pea_`v' "Número de PEA"
	cap drop iten*

}

**************************************
**	Colapsar ao nível do trimestre 	**
**************************************

// attach label of variables
local colvar prop_* taxa_* n_*

foreach v of var `colvar' {
    local l`v' : variable label `v'
}

* colapse
collapse (firstnm) `colvar' , by(Ano Trimestre)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}









