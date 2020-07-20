/*
O propostio desse do file é:
Descrever a composição e estrutura do emprego em uma fotografia

Mais especificamente:
A) Quantos trabalhadores há?
B) Quantos trabalhadores há em cada setor?
C) Quantos trabalhadores formais e informais?
D) Quantos trabalhadores informais há em cada setor?
E) Quantos trabalhadores formais há em cada setor?
E) Quantos trabalhadores estatutarios entre os formais?
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
//	A) População
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 // população total
by Ano Trimestre, sort: egen iten2 = total(iten1)
gen n_populacao = iten2
replace n_populacao = round(n_populacao)
label variable n_populacao "População"
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
replace n_de_ocupacao = round(n_de_ocupacao)
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
//	D) Número total de formalidade
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if formal == 1
by Ano Trimestre, sort: egen n_de_formal = total(iten1)
replace n_de_formal = round(n_de_formal)
label variable n_de_formal "Número de trabalhadores formais"
cap drop iten*
cap drop tool* 

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
//	Proporção de militares e estatuarios entre os formais
/////////////////////////////////////////////////////////
* total de formal
gen tool1 = 1 * V1028 if formal == 1
by Ano Trimestre, sort: egen tool2 = total(tool1)

* proporção de militares
gen iten1 = 1 * V1028 if militar == 1
by Ano Trimestre, sort: egen iten2 = total(iten1)

gen prop_servidor_formal = (iten2/tool2)*100
label variable prop_servidor_formal "Proporção servidores públicos e militares em relação aos formais (%)"
cap drop iten*

/////////////////////////////////////////////////////////
//	Número de ocupados por setor
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if ocupado == 1 & gstr_agricultura==1
by Ano Trimestre, sort: egen n_de_ocupado_gstr_agricultura = total(iten1)
replace n_de_ocupado_gstr_agricultura = round(n_de_ocupado_gstr_agricultura)
label variable n_de_ocupado_gstr_agricultura "Número de ocupados no setor de agricultura"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gstr_industria==1
by Ano Trimestre, sort: egen n_de_ocupado_gstr_industria = total(iten1)
replace n_de_ocupado_gstr_industria = round(n_de_ocupado_gstr_industria)
label variable n_de_ocupado_gstr_industria "Número de ocupados no setor de indústria"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gstr_construcao==1
by Ano Trimestre, sort: egen n_de_ocupado_gstr_construcao = total(iten1)
replace n_de_ocupado_gstr_construcao = round(n_de_ocupado_gstr_construcao)
label variable n_de_ocupado_gstr_construcao "Número de ocupados no setor de construção"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gstr_comercio==1
by Ano Trimestre, sort: egen n_de_ocupado_gstr_comercio = total(iten1)
replace n_de_ocupado_gstr_comercio = round(n_de_ocupado_gstr_comercio)
label variable n_de_ocupado_gstr_comercio "Número de ocupados no setor de comércio"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gstr_servicos==1
by Ano Trimestre, sort: egen n_de_ocupado_gstr_servicos = total(iten1)
replace n_de_ocupado_gstr_servicos = round(n_de_ocupado_gstr_servicos)
label variable n_de_ocupado_gstr_servicos "Número de ocupados no setor de serviços"
cap drop iten*

/////////////////////////////////////////////////////////
//	Número de formal por setor
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if formal == 1 & gstr_agricultura==1
by Ano Trimestre, sort: egen n_de_formal_gstr_agricultura = total(iten1)
replace n_de_formal_gstr_agricultura = round(n_de_formal_gstr_agricultura)
label variable n_de_formal_gstr_agricultura "Número de formal no setor de agricultura"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gstr_industria==1
by Ano Trimestre, sort: egen n_de_formal_gstr_industria = total(iten1)
replace n_de_formal_gstr_industria = round(n_de_formal_gstr_industria)
label variable n_de_formal_gstr_industria "Número de formal no setor de indústria"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gstr_construcao==1
by Ano Trimestre, sort: egen n_de_formal_gstr_construcao = total(iten1)
replace n_de_formal_gstr_construcao = round(n_de_formal_gstr_construcao)
label variable n_de_formal_gstr_construcao "Número de formal no setor de construção"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gstr_comercio==1
by Ano Trimestre, sort: egen n_de_formal_gstr_comercio = total(iten1)
replace n_de_formal_gstr_comercio = round(n_de_formal_gstr_comercio)
label variable n_de_formal_gstr_comercio "Número de formal no setor de comércio"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gstr_servicos==1
by Ano Trimestre, sort: egen n_de_formal_gstr_servicos= total(iten1)
replace n_de_formal_gstr_servicos = round(n_de_formal_gstr_servicos)
label variable n_de_formal_gstr_servicos "Número de formal no setor de serviços"
cap drop iten*

/////////////////////////////////////////////////////////
//	Número de informal por setor
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if informal == 1 & gstr_agricultura==1
by Ano Trimestre, sort: egen n_de_informal_gstr_agricultura = total(iten1)
replace n_de_informal_gstr_agricultura = round(n_de_informal_gstr_agricultura)
label variable n_de_informal_gstr_agricultura "Número de informais no setor de agricultura"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gstr_industria==1
by Ano Trimestre, sort: egen n_de_informal_gstr_industria = total(iten1)
replace n_de_informal_gstr_industria = round(n_de_informal_gstr_industria)
label variable n_de_informal_gstr_industria "Número de informais no setor de indústria"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gstr_construcao==1
by Ano Trimestre, sort: egen n_de_informal_gstr_construcao = total(iten1)
replace n_de_informal_gstr_construcao = round(n_de_informal_gstr_construcao)
label variable n_de_informal_gstr_construcao "Número de informais no setor de construção"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gstr_comercio==1
by Ano Trimestre, sort: egen n_de_informal_gstr_comercio = total(iten1)
replace n_de_informal_gstr_comercio = round(n_de_informal_gstr_comercio)
label variable n_de_informal_gstr_comercio "Número de informais no setor de comércio"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gstr_servicos==1
by Ano Trimestre, sort: egen n_de_informal_gstr_servicos = total(iten1)
replace n_de_informal_gstr_servicos = round(n_de_informal_gstr_servicos)
label variable n_de_informal_gstr_servicos "Número de informais no setor de serviços"
cap drop iten*

/////////////////////////////////////////////////////////
//	Número de ocupados por atividade principal do empreendimento do trabalho
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if ocupado == 1 & gape_agricultura==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_agricultura = total(iten1)
replace n_de_ocupado_gape_agricultura = round(n_de_ocupado_gape_agricultura)
label variable n_de_ocupado_gape_agricultura "Agricultura, pecuária, produção florestal, pesca e aquicultura "
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_industria==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_industria = total(iten1)
replace n_de_ocupado_gape_industria = round(n_de_ocupado_gape_industria)
label variable n_de_ocupado_gape_industria "Indústria geral"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_construcao==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_construcao = total(iten1)
replace n_de_ocupado_gape_construcao = round(n_de_ocupado_gape_construcao)
label variable n_de_ocupado_gape_construcao "Construção"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_comercio==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_comercio = total(iten1)
replace n_de_ocupado_gape_comercio = round(n_de_ocupado_gape_comercio)
label variable n_de_ocupado_gape_comercio "Comércio, reparação de veículos automotores e motocicletas"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_transporte==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_transporte = total(iten1)
replace n_de_ocupado_gape_transporte = round(n_de_ocupado_gape_transporte)
label variable n_de_ocupado_gape_transporte "Transporte, armazenagem e correio"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_alimentacao==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_alimentacao = total(iten1)
replace n_de_ocupado_gape_alimentacao = round(n_de_ocupado_gape_alimentacao)
label variable n_de_ocupado_gape_alimentacao "Alojamento e alimentação"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_informacao==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_informacao = total(iten1)
replace n_de_ocupado_gape_informacao = round(n_de_ocupado_gape_informacao)
label variable n_de_ocupado_gape_informacao "Informação, comunicação e atividades financeiras, imobiliárias, profissionais e administrativas"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_publica==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_publica = total(iten1)
replace n_de_ocupado_gape_publica = round(n_de_ocupado_gape_publica)
label variable n_de_ocupado_gape_publica "Administração pública, defesa e seguridade social"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_educacao==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_educacao = total(iten1)
replace n_de_ocupado_gape_educacao = round(n_de_ocupado_gape_educacao)
label variable n_de_ocupado_gape_educacao "Educação, saúde humana e serviços sociais"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_outros ==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_outros  = total(iten1)
replace n_de_ocupado_gape_outros  = round(n_de_ocupado_gape_outros )
label variable n_de_ocupado_gape_outros  "Outros Serviços"
cap drop iten*

gen iten1 = 1 * V1028 if ocupado == 1 & gape_domestico==1
by Ano Trimestre, sort: egen n_de_ocupado_gape_domestico = total(iten1)
replace n_de_ocupado_gape_domestico = round(n_de_ocupado_gape_domestico)
label variable n_de_ocupado_gape_domestico "Serviços domésticos"
cap drop iten*

/////////////////////////////////////////////////////////
//	Número de formal  por atividade principal do empreendimento do trabalho
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if formal == 1 & gape_agricultura==1
by Ano Trimestre, sort: egen n_de_formal_gape_agricultura = total(iten1)
replace n_de_formal_gape_agricultura = round(n_de_formal_gape_agricultura)
label variable n_de_formal_gape_agricultura "Agricultura, pecuária, produção florestal, pesca e aquicultura "
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_industria==1
by Ano Trimestre, sort: egen n_de_formal_gape_industria = total(iten1)
replace n_de_formal_gape_industria = round(n_de_formal_gape_industria)
label variable n_de_formal_gape_industria "Indústria geral"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_construcao==1
by Ano Trimestre, sort: egen n_de_formal_gape_construcao = total(iten1)
replace n_de_formal_gape_construcao = round(n_de_formal_gape_construcao)
label variable n_de_formal_gape_construcao "Construção"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_comercio==1
by Ano Trimestre, sort: egen n_de_formal_gape_comercio = total(iten1)
replace n_de_formal_gape_comercio = round(n_de_formal_gape_comercio)
label variable n_de_formal_gape_comercio "Comércio, reparação de veículos automotores e motocicletas"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_transporte==1
by Ano Trimestre, sort: egen n_de_formal_gape_transporte = total(iten1)
replace n_de_formal_gape_transporte = round(n_de_formal_gape_transporte)
label variable n_de_formal_gape_transporte "Transporte, armazenagem e correio"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_alimentacao==1
by Ano Trimestre, sort: egen n_de_formal_gape_alimentacao = total(iten1)
replace n_de_formal_gape_alimentacao = round(n_de_formal_gape_alimentacao)
label variable n_de_formal_gape_alimentacao "Alojamento e alimentação"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_informacao==1
by Ano Trimestre, sort: egen n_de_formal_gape_informacao = total(iten1)
replace n_de_formal_gape_informacao = round(n_de_formal_gape_informacao)
label variable n_de_formal_gape_informacao "Informação, comunicação e atividades financeiras, imobiliárias, profissionais e administrativas"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_publica==1
by Ano Trimestre, sort: egen n_de_formal_gape_publica = total(iten1)
replace n_de_formal_gape_publica = round(n_de_formal_gape_publica)
label variable n_de_formal_gape_publica "Administração pública, defesa e seguridade social"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_educacao==1
by Ano Trimestre, sort: egen n_de_formal_gape_educacao = total(iten1)
replace n_de_formal_gape_educacao = round(n_de_formal_gape_educacao)
label variable n_de_formal_gape_educacao "Educação, saúde humana e serviços sociais"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_outros ==1
by Ano Trimestre, sort: egen n_de_formal_gape_outros  = total(iten1)
replace n_de_formal_gape_outros  = round(n_de_formal_gape_outros )
label variable n_de_formal_gape_outros  "Outros Serviços"
cap drop iten*

gen iten1 = 1 * V1028 if formal == 1 & gape_domestico==1
by Ano Trimestre, sort: egen n_de_formal_gape_domestico = total(iten1)
replace n_de_formal_gape_domestico = round(n_de_formal_gape_domestico)
label variable n_de_formal_gape_domestico "Serviços domésticos"
cap drop iten*

/////////////////////////////////////////////////////////
//	Número de informal  por atividade principal do empreendimento do trabalho
/////////////////////////////////////////////////////////
gen iten1 = 1 * V1028 if informal == 1 & gape_agricultura==1
by Ano Trimestre, sort: egen n_de_informal_gape_agricultura = total(iten1)
replace n_de_informal_gape_agricultura = round(n_de_informal_gape_agricultura)
label variable n_de_informal_gape_agricultura "Agricultura, pecuária, produção florestal, pesca e aquicultura "
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_industria==1
by Ano Trimestre, sort: egen n_de_informal_gape_industria = total(iten1)
replace n_de_informal_gape_industria = round(n_de_informal_gape_industria)
label variable n_de_informal_gape_industria "Indústria geral"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_construcao==1
by Ano Trimestre, sort: egen n_de_informal_gape_construcao = total(iten1)
replace n_de_informal_gape_construcao = round(n_de_informal_gape_construcao)
label variable n_de_informal_gape_construcao "Construção"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_comercio==1
by Ano Trimestre, sort: egen n_de_informal_gape_comercio = total(iten1)
replace n_de_informal_gape_comercio = round(n_de_informal_gape_comercio)
label variable n_de_informal_gape_comercio "Comércio, reparação de veículos automotores e motocicletas"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_transporte==1
by Ano Trimestre, sort: egen n_de_informal_gape_transporte = total(iten1)
replace n_de_informal_gape_transporte = round(n_de_informal_gape_transporte)
label variable n_de_informal_gape_transporte "Transporte, armazenagem e correio"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_alimentacao==1
by Ano Trimestre, sort: egen n_de_informal_gape_alimentacao = total(iten1)
replace n_de_informal_gape_alimentacao = round(n_de_informal_gape_alimentacao)
label variable n_de_informal_gape_alimentacao "Alojamento e alimentação"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_informacao==1
by Ano Trimestre, sort: egen n_de_informal_gape_informacao = total(iten1)
replace n_de_informal_gape_informacao = round(n_de_informal_gape_informacao)
label variable n_de_informal_gape_informacao "Informação, comunicação e atividades financeiras, imobiliárias, profissionais e administrativas"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_publica==1
by Ano Trimestre, sort: egen n_de_informal_gape_publica = total(iten1)
replace n_de_informal_gape_publica = round(n_de_informal_gape_publica)
label variable n_de_informal_gape_publica "Administração pública, defesa e seguridade social"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_educacao==1
by Ano Trimestre, sort: egen n_de_informal_gape_educacao = total(iten1)
replace n_de_informal_gape_educacao = round(n_de_informal_gape_educacao)
label variable n_de_informal_gape_educacao "Educação, saúde humana e serviços sociais"
cap drop iten*


gen iten1 = 1 * V1028 if informal == 1 & gape_outros ==1
by Ano Trimestre, sort: egen n_de_informal_gape_outros  = total(iten1)
replace n_de_informal_gape_outros  = round(n_de_informal_gape_outros )
label variable n_de_informal_gape_outros  "Outros Serviços"
cap drop iten*

gen iten1 = 1 * V1028 if informal == 1 & gape_domestico==1
by Ano Trimestre, sort: egen n_de_informal_gape_domestico = total(iten1)
replace n_de_informal_gape_domestico = round(n_de_informal_gape_domestico)
label variable n_de_informal_gape_domestico "Serviços domésticos"
cap drop iten*


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


