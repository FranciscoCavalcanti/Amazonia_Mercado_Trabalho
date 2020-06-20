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
label variable taxa_de_desemprego "Taxa de desemprego em relação a força de trabalho (%)"
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
label variable taxa_de_ocupacao "Taxa de ocupação em relação a PIA (%)"
cap drop iten* tool* 

/////////////////////////////////////////////////////////
//	C) Taxa de participação
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if pea == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen tool1 = 1 * V1028 if pia == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)

gen taxa_de_participacao = (iten2/tool2)*100
label variable taxa_de_participacao "Taxa de participação em relação a PIA (%)"
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
label variable prop_militar "Proporção militares e estatutários em relação aos ocupados (%)"
cap drop iten*

* proporção de trabalhadores em casa
gen iten1 = 1 * V1028 if homeoffice == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_homeoffice = (iten2/tool2)*100
label variable prop_homeoffice "Proporção trabalhadores em casa em relação aos ocupados (%)"
cap drop iten*

**************************************
**	Colapsar ao nível do trimestre 	**
**************************************

// attach label of variables
local colvar prop_* taxa_*

foreach v of var `colvar' {
    local l`v' : variable label `v'
}

* colapse
collapse (firstnm) `colvar' , by(Ano Trimestre)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}









