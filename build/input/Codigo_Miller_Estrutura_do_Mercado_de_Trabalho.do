///// ESTRUTURA DO MERCADO DE TRABALHO /////

* Taxa de desemprego = desocupados/pessoas na força de trabalho
* Taxa de ocupação = ocupados/pessoas em idade ativa
* Taxa de participação = PEA/PIA
* Pessoas em idade ativa = pessoas fora da força de trabalho + pessoas na força de trabalho
* População Economicamente Ativa = Pessoas na força de trabalho = Ocupados + Desocupados
* Peso da PEA do RJ e da população ocupada do RJ no total brasileiro
* Informalidade para RJ e BR


     ///  DEFININDO FORMALIDADE E INFORMALIDADE  ///

gen formal =.
replace formal = 1 if VD4009 == 1 
replace formal = 1 if VD4009 == 3
replace formal = 1 if VD4009 == 5
replace formal = 1 if VD4009 == 7 
replace formal = 1 if VD4009 == 9 & VD4012 == 1  
replace formal = 0 if formal ==.

gen informal =.
replace informal = 1 if VD4009 == 2 
replace informal = 1 if VD4009 == 4
replace informal = 1 if VD4009 == 6
replace informal = 1 if VD4009 == 9 & VD4012 == 2
replace informal = 1 if VD4009 == 10
replace informal = 0 if informal ==. 


/// DADOS PARA O RJ ///

* Forca Ocupada RJ
gen iten = 1 * V1028 if VD4002 == 1 & Capital == 33
egen forca_ocup_rj = total(iten)
label var forca_ocup_rj "nome dela"
drop iten

* Forca Desocupada RJ
gen iten = 1 * V1028 if VD4002 == 2 & Capital == 33
egen forca_desocup_rj = total(iten)
label var forca_desocup_rj "nome dela"
drop iten

* Pessoas em idade ativa RJ
gen iten = 1 * V1028 if VD4001 == 1 & Capital == 33
egen forca_de_trab_rj = total(iten)
label var forca_de_trab_rj "nome dela"
drop iten

gen iten = 1 * V1028 if VD4001 == 2 & Capital == 33
egen fora_da_forca_de_trab_rj = total(iten)
label var fora_da_forca_de_trab_rj "nome dela"
drop iten

gen iten = 1 * V1028 if V2009 >= 14 if Capital == 33
egen PIA_rj = total (iten)
drop iten

* Forca informal RJ
gen iten = informal * V1028 if Capital == 33
egen forca_informal_rj = total(iten)
drop iten

* PEA RJ
gen PEA_rj = forca_de_trab_rj

* Taxa de desemprego RJ
gen taxa_de_desemprego_rj = (forca_desocup_rj/forca_de_trab_rj)*100

* Taxa de ocupação RJ
gen taxa_de_ocupação_rj = (forca_ocup_rj/PIA_rj)*100

* Taxa de participação RJ
gen taxa_de_participação_rj = (PEA_rj/PIA_rj)*100

* Taxa de Informalidade RJ
gen informalidade_RJ = (forca_informal_rj/forca_ocup_rj)*100



///DADOS PARA O BR ///

* Forca Ocupada BR
gen iten = 1 * V1028 if VD4002 == 1 
egen forca_ocup_br = total(iten)
label var forca_ocup_br "nome dela"
drop iten

* Forca Desocupada BR
gen iten = 1 * V1028 if VD4002 == 2
egen forca_desocup_br = total(iten)
label var forca_desocup_br "nome dela"
drop iten

* Pessoas em idade ativa BR
gen iten = 1 * V1028 if VD4001 == 1
egen forca_de_trab_br = total(iten)
label var forca_de_trab_br "nome dela"
drop iten

gen iten = 1 * V1028 if VD4001 == 2
egen fora_da_forca_de_trab_br = total(iten)
label var fora_da_forca_de_trab_br "nome dela"
drop iten

gen iten = 1 * V1028 if V2009 >= 14
egen PIA_br = total (iten)
drop iten

* Forca informal BR
gen iten = informal * V1028 
egen forca_informal_br = total(iten)
drop iten

* PEA BR
gen PEA_br = forca_de_trab_br

* Taxa de desemprego BR
gen taxa_de_desemprego_br = (forca_desocup_br/forca_de_trab_br)*100

* Taxa de ocupação BR
gen taxa_de_ocupação_br = (forca_ocup_br/PIA_br)*100

* Taxa de participação BR
gen taxa_de_participação_br = (PEA_br/PIA_br)*100

* Taxa de Informalidade RJ
gen informalidade_BR = (forca_informal_br/forca_ocup_br)*100



/// Peso da PEA do RJ e da população ocupada do RJ no total brasileiro ///
gen peso_PEA_rj = (PEA_rj/PEA_br)*100
gen peso_forca_ocup_rj = (forca_ocup_rj/forca_ocup_br)*100

	 
	 
	 
             /////   DESAGREGAÇÕES   /////


*Tentar entender, a partir da evolução de cada indicador, para onde os integrantes de cada desagregação estariam 
*indo - informalidade ou desemprego - e em que desagregação a informalidade é maior/aumentou mais.	

*OBS: a desagregação por categorias ocupacionais (privado, público, doméstico etc) está em outro do-file		 
		
		
*1) POR FAIXA ETÁRIA

gen IDADE =.

*Idade1 = 14 a 17 anos
*Idade2 = 18 a 29 anos
*Idade3 = 30 a 49 anos
*Idade4 = 50 a 64 anos
*Idade5 = 65+ anos 

gen idade1 =.
replace idade1 = 1 if V2009 >= 14 
replace idade1 = 1 if V2009 < 18
replace idade1 = 0 if V2009 >= 18 

gen idade2 =.
replace idade2 = 1 if V2009 >= 18 
replace idade2 = 1 if V2009 < 30
replace idade2 = 0 if V2009 <= 17 | V2009 >= 30 

gen idade3 =.
replace idade3 = 1 if V2009 >= 30 
replace idade3 = 1 if V2009 < 50
replace idade3 = 0 if V2009 <= 29 | V2009 >= 50

gen idade4 =.
replace idade4 = 1 if V2009 >= 50 
replace idade4 = 1 if V2009 < 65
replace idade4 = 0 if V2009 <= 49 | V2009 >= 65


gen idade5 =.
replace idade5 = 1 if V2009 >= 65
replace idade5 = 0 if V2009 < 65


// RJ //

*Ver evolução do total de pessoas ocupadas em cada faixa etária 

forvalues x = 1(1)5 { 

gen iten = 1 * V1028 if idade`x' == 1 & Capital == 33 & VD4002 == 1 
egen forca_ocup_idade`x'_rj = total(iten)
drop iten

}


*Ver evolução do total de pessoas na força de trabalho em cada faixa etária 

forvalues x = 1(1)5 { 

gen iten = 1 * V1028 if idade`x' == 1 & Capital == 33 & VD4001 == 1 
egen forca_de_trab_idade`x'_rj = total(iten)
drop iten

}


*Peso de cada faixa etária no total de ocupados

forvalues x = 1(1)5 { 

gen peso_ocup_idade`x'_rj = (forca_ocup_idade`x'_rj/forca_ocup_rj)*100

}


*Evolução da informalidade por faixa de etária

forvalues x = 1(1)5 {

gen iten = 1 * V1028 if idade`x' == 1 & informal == 1 & Capital == 33
egen total_inform_idade`x'_rj = total (iten)
gen inform_idade`x'_rj = (total_inform_idade`x'_rj /forca_ocup_idade`x'_rj)*100
label var inform_idade`x'_rj "Informalidade dentro da faixa etária idade`x'"
drop iten

}


*Evolução do desemprego por faixa etária

forvalues x = 1(1)5 {

gen iten = 1 * V1028 if idade`x' == 1 & VD4002 == 2 & Capital == 33
egen total_desocup_idade`x'_rj = total (iten)
gen desocup_idade`x'_rj = (total_desocup_idade`x'_rj /forca_de_trab_idade`x'_rj)*100
label var desocup_idade`x'_rj "Desemprego dentro da faixa etária idade`x'"
drop iten

}



// BR //

*Ver evolução do total de pessoas ocupadas em cada faixa etária 

forvalues x = 1(1)5 { 

gen iten = 1 * V1028 if idade`x' == 1 & VD4002 == 1 
egen forca_ocup_idade`x'_br = total(iten)
drop iten

}


*Ver evolução do total de pessoas na força de trabalho em cada faixa etária 

forvalues x = 1(1)5 { 

gen iten = 1 * V1028 if idade`x' == 1 & VD4001 == 1 
egen forca_de_trab_idade`x'_br = total(iten)
drop iten

}


*Peso de cada faixa etária no total de ocupados

forvalues x = 1(1)5 { 

gen peso_ocup_idade`x'_br = (forca_ocup_idade`x'_br/forca_ocup_br)*100

}


*Evolução da informalidade por faixa de etária

forvalues x = 1(1)5 {

gen iten = 1 * V1028 if idade`x' == 1 & informal == 1 
egen total_inform_idade`x'_br = total (iten)
gen inform_idade`x'_br = (total_inform_idade`x'_br/forca_ocup_idade`x'_br)*100
label var inform_idade`x'_br "Informalidade dentro da faixa etária idade`x'"
drop iten

}


*Evolução do desemprego por faixa etária

forvalues x = 1(1)5 {

gen iten = 1 * V1028 if idade`x' == 1 & VD4002 == 2 
egen total_desocup_idade`x'_br = total (iten)
gen desocup_idade`x'_br = (total_desocup_idade`x'_br /forca_de_trab_idade`x'_br)*100
label var desocup_idade`x'_br "Desemprego dentro da faixa etária idade`x'"
drop iten

}




*2) POR FAIXA DE ESCOLARIDADE

gen ESCOLARIDADE =.

gen escolar1 =.
replace escolar1 = 1 if VD3006 == 1
replace escolar1 = 0 if VD3006 != 1

gen escolar2 =.
replace escolar2 = 1 if VD3006 == 2
replace escolar2 = 0 if VD3006 != 2

gen escolar3 =.
replace escolar3 = 1 if VD3006 == 3
replace escolar3 = 0 if VD3006 != 3

gen escolar4 =.
replace escolar4 = 1 if VD3006 == 4
replace escolar4 = 0 if VD3006 != 4

gen escolar5 =.
replace escolar5 = 1 if VD3006 == 5
replace escolar5 = 0 if VD3006 != 5

gen escolar6 =.
replace escolar6 = 1 if VD3006 == 6
replace escolar6 = 0 if VD3006 != 6


// RJ //

*Ver evolução do total de pessoas ocupadas em cada faixa de escolaridade

forvalues x = 1(1)6 { 

gen iten = 1 * V1028 if escolar`x' == 1 & Capital == 33 & VD4002 == 1 
egen forca_ocup_escolar`x'_rj = total(iten)
drop iten

}


*Ver evolução do total de pessoas na força de trabalho em cada faixa de escolaridade 

forvalues x = 1(1)6 { 

gen iten = 1 * V1028 if escolar`x' == 1 & Capital == 33 & VD4001 == 1 
egen forca_de_trab_escolar`x'_rj = total(iten)
drop iten

}


*Peso de cada faixa de escolaridade no total de ocupados

forvalues x = 1(1)6 { 

gen peso_ocup_escolar`x'_rj = (forca_ocup_escolar`x'_rj/forca_ocup_rj)*100

}


*Evolução da informalidade por faixa de escolaridade
forvalues x = 1(1)6 {

gen iten = 1 * V1028 if escolar`x' == 1 & informal == 1 & Capital == 33
egen total_inform_escolar`x'_rj = total (iten)
gen inform_escolar`x'_rj = (total_inform_escolar`x'_rj /forca_ocup_escolar`x'_rj)*100
label var inform_escolar`x'_rj "Informalidade dentro da faixa de escolaridade escolar`x'"
drop iten

}


*Evolução do desemprego por faixa de escolaridade

forvalues x = 1(1)6 {

gen iten = 1 * V1028 if escolar`x' == 1 & VD4002 == 2 & Capital == 33
egen total_desocup_escolar`x'_rj = total (iten)
gen desocup_escolar`x'_rj = (total_desocup_escolar`x'_rj /forca_de_trab_escolar`x'_rj)*100
label var desocup_escolar`x'_rj "Desemprego dentro da faixa de escolaridade escolar`x'"
drop iten

}



// BR //

*Ver evolução do total de pessoas ocupadas em cada faixa de escolaridade

forvalues x = 1(1)6 { 

gen iten = 1 * V1028 if escolar`x' == 1 & VD4002 == 1 
egen forca_ocup_escolar`x'_br = total(iten)
drop iten

}


*Ver evolução do total de pessoas na força de trabalho em cada faixa de escolaridade

forvalues x = 1(1)6 { 

gen iten = 1 * V1028 if escolar`x' == 1 & VD4001 == 1 
egen forca_de_trab_escolar`x'_br = total(iten)
drop iten

}


*Peso de cada faixa de escolaridade no total de ocupados

forvalues x = 1(1)6 { 

gen peso_ocup_escolar`x'_br = (forca_ocup_escolar`x'_br/forca_ocup_br)*100

}


*Evolução da informalidade por faixa de escolaridade

forvalues x = 1(1)6 {

gen iten = 1 * V1028 if escolar`x' == 1 & informal == 1 
egen total_inform_escolar`x'_br = total (iten)
gen inform_escolar`x'_br = (total_inform_escolar`x'_br/forca_ocup_escolar`x'_br)*100
label var inform_escolar`x'_br "Informalidade dentro da faixa de escolaridade escolar`x'"
drop iten

}


*Evolução do desemprego por faixa de escolaridade

forvalues x = 1(1)6 {

gen iten = 1 * V1028 if escolar`x' == 1 & VD4002 == 2 
egen total_desocup_escolar`x'_br = total (iten)
gen desocup_escolar`x'_br = (total_desocup_escolar`x'_br /forca_de_trab_escolar`x'_br)*100
label var desocup_escolar`x'_br "Desemprego dentro da faixa de escolaridade escolar`x'"
drop iten

}




*3) POR SETORES DE OCUPAÇÃO

gen SETOR =.

*Definição de setores
*Setor1 = Setor primário
*Setor2 = Setor secundário (menos construção)
*Setor3 = Setor secundário (construção)
*Setor4 = Setor terciário (comércio)
*Setor5 = Setor terciário (serviços)

gen setor1 =.
replace setor1 = 1 if VD4010 == 1
replace setor1 = 0 if VD4010 != 1

gen setor2 =.
replace setor2 = 1 if VD4010 == 2
replace setor2 = 0 if VD4010 != 2

gen setor3 =.
replace setor3 = 1 if VD4010 == 3
replace setor3 = 0 if VD4010 != 3

gen setor4 =.
replace setor4 = 1 if VD4010 == 4
replace setor4 = 0 if VD4010 != 4

gen setor5 =.
replace setor5 = 1 if VD4010 >= 5
replace setor5 = 0 if VD4010 ==.



// RJ //

*Ver evolução do total de pessoas ocupadas em cada setor de atividade

forvalues x = 1(1)5 { 

gen iten = 1 * V1028 if setor`x' == 1 & Capital == 33 & VD4002 == 1 
egen forca_ocup_setor`x'_rj = total(iten)
drop iten

}


*Ver evolução do total de pessoas na força de trabalho em cada setor de atividade

forvalues x = 1(1)5 { 

gen iten = 1 * V1028 if setor`x' == 1 & Capital == 33 & VD4001 == 1 
egen forca_de_trab_setor`x'_rj = total(iten)
drop iten

}


*Peso de cada setor de atividade no total de ocupados

forvalues x = 1(1)5 { 

gen peso_ocup_setor`x'_rj = (forca_ocup_setor`x'_rj/forca_ocup_rj)*100

}


*Evolução da informalidade por setor de atividade
forvalues x = 1(1)5 {

gen iten = 1 * V1028 if setor`x' == 1 & informal == 1 & Capital == 33
egen total_inform_setor`x'_rj = total (iten)
gen inform_setor`x'_rj = (total_inform_setor`x'_rj /forca_ocup_setor`x'_rj)*100
label var inform_setor`x'_rj "Informalidade dentro do setor de atividade setor`x'"
drop iten

}


*Evolução do desemprego por setor de atividade

forvalues x = 1(1)5 {

gen iten = 1 * V1028 if setor`x' == 1 & VD4002 == 2 & Capital == 33
egen total_desocup_setor`x'_rj = total (iten)
gen desocup_setor`x'_rj = (total_desocup_setor`x'_rj /forca_de_trab_setor`x'_rj)*100
label var desocup_setor`x'_rj "Desemprego dentro do setor de atividade setor`x'"
drop iten

}



// BR //

*Ver evolução do total de pessoas ocupadas em cada setor de atividade

forvalues x = 1(1)5 { 

gen iten = 1 * V1028 if setor`x' == 1 & VD4002 == 1 
egen forca_ocup_setor`x'_br = total(iten)
drop iten

}


*Ver evolução do total de pessoas na força de trabalho em cada setor de atividade

forvalues x = 1(1)5 { 

gen iten = 1 * V1028 if setor`x' == 1 & VD4001 == 1 
egen forca_de_trab_setor`x'_br = total(iten)
drop iten

}


*Peso de cada setor de atividade no total de ocupados

forvalues x = 1(1)5 { 

gen peso_ocup_setor`x'_br = (forca_ocup_setor`x'_br/forca_ocup_br)*100

}


*Evolução da informalidade por setor de atividade
forvalues x = 1(1)5 {

gen iten = 1 * V1028 if setor`x' == 1 & informal == 1 
egen total_inform_setor`x'_br = total (iten)
gen inform_setor`x'_br = (total_inform_setor`x'_br/forca_ocup_setor`x'_br)*100
label var inform_setor`x'_br "Informalidade dentro do setor de atividade setor`x'"
drop iten

}


*Evolução do desemprego por setor de atividade

forvalues x = 1(1)5 {

gen iten = 1 * V1028 if setor`x' == 1 & VD4002 == 2 
egen total_desocup_setor`x'_br = total (iten)
gen desocup_setor`x'_br = (total_desocup_setor`x'_br/forca_de_trab_setor`x'_br)*100
label var desocup_setor`x'_br "Desemprego dentro do setor de atividade setor`x'"
drop iten

}




*4) POR GÊNERO 

gen GÊNERO =.

gen H =.
replace H = 1 if V2007 == 1
replace H = 0 if V2007 == 2

gen F =.
replace F = 1 if V2007 == 2
replace F = 0 if V2007 == 1 


// RJ //

*Ver evolução do total de pessoas ocupadas por gênero

foreach x in H F { 

gen iten = 1 * V1028 if `x' == 1 & Capital == 33 & VD4002 == 1 
egen forca_ocup_`x'_rj = total(iten)
drop iten

}


*Ver evolução do total de pessoas na força de trabalho por gênero
foreach x in H F  { 

gen iten = 1 * V1028 if `x' == 1 & Capital == 33 & VD4001 == 1 
egen forca_de_trab_`x'_rj = total(iten)
drop iten

}


*Peso de cada gênero na população ocupada

foreach x in H F   { 

gen peso_ocup_`x'_rj = (forca_ocup_`x'_rj/forca_ocup_rj)*100

}


*Evolução da informalidade por gênero
foreach x in H F  {

gen iten = 1 * V1028 if `x' == 1 & informal == 1 & Capital == 33
egen total_inform_`x'_rj = total (iten)
gen inform_`x'_rj = (total_inform_`x'_rj /forca_ocup_`x'_rj)*100
label var inform_`x'_rj "Informalidade no gênero `x'"
drop iten

}


*Evolução do desemprego por gênero

foreach x in H F   {

gen iten = 1 * V1028 if `x' == 1 & VD4002 == 2 & Capital == 33
egen total_desocup_`x'_rj = total (iten)
gen desocup_`x'_rj = (total_desocup_`x'_rj /forca_de_trab_`x'_rj)*100
label var desocup_`x'_rj "Desemprego no gênero `x'"
drop iten

}



// BR //

*Ver evolução do total de pessoas ocupadas por gênero

foreach x in H F  { 

gen iten = 1 * V1028 if `x' == 1 & VD4002 == 1 
egen forca_ocup_`x'_br = total(iten)
drop iten

}


*Ver evolução do total de pessoas na força de trabalho por gênero

foreach x in H F   { 

gen iten = 1 * V1028 if `x' == 1 & VD4001 == 1 
egen forca_de_trab_`x'_br = total(iten)
drop iten

}


*Peso por gênero no total de ocupados 

foreach x in H F   { 

gen peso_ocup_`x'_br = (forca_ocup_`x'_br/forca_ocup_br)*100

}


*Evolução da informalidade por gênero

foreach x in H F  {

gen iten = 1 * V1028 if `x' == 1 & informal == 1 
egen total_inform_`x'_br = total (iten)
gen inform_`x'_br = (total_inform_`x'_br/forca_ocup_`x'_br)*100
label var inform_`x'_br "Informalidade no gênero `x'"
drop iten

}


*Evolução do desemprego por gênero

foreach x in H F  {

gen iten = 1 * V1028 if `x' == 1 & VD4002 == 2 
egen total_desocup_`x'_br = total (iten)
gen desocup_`x'_br = (total_desocup_`x'_br /forca_de_trab_`x'_br)*100
label var desocup_`x'_br "Desemprego no gênero `x'"
drop iten

}


collapse (mean) forca_ocup_rj forca_desocup_rj forca_de_trab_rj fora_da_forca_de_trab_rj PIA_rj /*
	*/ PEA_rj taxa_de_desemprego_rj taxa_de_ocupação_rj taxa_de_participação_rj forca_ocup_br forca_desocup_br forca_de_trab_br fora_da_forca_de_trab_br /*
	*/ PIA_br PEA_br taxa_de_desemprego_br taxa_de_ocupação_br taxa_de_participação_br peso_PEA_rj peso_forca_ocup_rj forca_informal_rj forca_informal_br informalidade_RJ  informalidade_BR/*
	*/ IDADE forca_ocup_idade1_rj forca_ocup_idade2_rj forca_ocup_idade3_rj forca_ocup_idade4_rj forca_ocup_idade5_rj forca_de_trab_idade1_rj /*
	*/ forca_de_trab_idade2_rj forca_de_trab_idade3_rj forca_de_trab_idade4_rj forca_de_trab_idade5_rj peso_ocup_idade1_rj peso_ocup_idade2_rj /*
	*/ peso_ocup_idade3_rj peso_ocup_idade4_rj peso_ocup_idade5_rj total_inform_idade1_rj total_inform_idade2_rj total_inform_idade3_rj total_inform_idade4_rj total_inform_idade5_rj inform_idade1_rj inform_idade2_rj  inform_idade3_rj inform_idade4_rj/*
	*/ inform_idade5_rj total_desocup_idade1_rj total_desocup_idade2_rj  total_desocup_idade3_rj total_desocup_idade4_rj total_desocup_idade5_rj  /*
	*/ desocup_idade1_rj desocup_idade2_rj desocup_idade3_rj desocup_idade4_rj desocup_idade5_rj  /*
	*/ forca_ocup_idade1_br forca_ocup_idade2_br forca_ocup_idade3_br forca_ocup_idade4_br forca_ocup_idade5_br  /*
	*/ forca_de_trab_idade1_br forca_de_trab_idade2_br forca_de_trab_idade3_br forca_de_trab_idade4_br forca_de_trab_idade5_br /*
	*/ peso_ocup_idade1_br peso_ocup_idade2_br peso_ocup_idade3_br peso_ocup_idade4_br peso_ocup_idade5_br /*
	*/ total_inform_idade1_br total_inform_idade2_br total_inform_idade3_br total_inform_idade4_br total_inform_idade5_br inform_idade1_br inform_idade2_br inform_idade3_br inform_idade4_br inform_idade5_br/*
	*/ total_desocup_idade1_br total_desocup_idade2_br total_desocup_idade3_br total_desocup_idade4_br total_desocup_idade5_br /*
	*/ desocup_idade1_br desocup_idade2_br desocup_idade3_br desocup_idade4_br desocup_idade5_br ESCOLARIDADE /*
	*/ forca_ocup_escolar1_rj forca_ocup_escolar2_rj forca_ocup_escolar3_rj forca_ocup_escolar4_rj forca_ocup_escolar5_rj forca_ocup_escolar6_rj /*
	*/ forca_de_trab_escolar1_rj forca_de_trab_escolar2_rj forca_de_trab_escolar3_rj forca_de_trab_escolar4_rj forca_de_trab_escolar5_rj /*
	*/ forca_de_trab_escolar6_rj peso_ocup_escolar1_rj peso_ocup_escolar2_rj peso_ocup_escolar3_rj peso_ocup_escolar4_rj peso_ocup_escolar5_rj /*
	*/ peso_ocup_escolar6_rj total_inform_escolar1_rj total_inform_escolar2_rj total_inform_escolar3_rj total_inform_escolar4_rj total_inform_escolar5_rj total_inform_escolar6_rj inform_escolar1_rj inform_escolar2_rj inform_escolar3_rj inform_escolar4_rj inform_escolar5_rj inform_escolar6_rj /*
	*/ total_desocup_escolar1_rj total_desocup_escolar2_rj total_desocup_escolar3_rj total_desocup_escolar4_rj total_desocup_escolar5_rj total_desocup_escolar6_rj /*
	*/ desocup_escolar1_rj desocup_escolar2_rj desocup_escolar3_rj desocup_escolar4_rj desocup_escolar5_rj desocup_escolar6_rj /*
	*/ forca_ocup_escolar1_br forca_ocup_escolar2_br forca_ocup_escolar3_br forca_ocup_escolar4_br forca_ocup_escolar5_br forca_ocup_escolar6_br /*
	*/ forca_de_trab_escolar1_br forca_de_trab_escolar2_br forca_de_trab_escolar3_br forca_de_trab_escolar4_br forca_de_trab_escolar5_br /*
	*/ forca_de_trab_escolar6_br peso_ocup_escolar1_br peso_ocup_escolar2_br peso_ocup_escolar3_br peso_ocup_escolar4_br peso_ocup_escolar5_br /*
	*/ peso_ocup_escolar6_br total_inform_escolar1_br total_inform_escolar2_br total_inform_escolar3_br total_inform_escolar4_br total_inform_escolar5_br total_inform_escolar6_br inform_escolar1_br inform_escolar2_br inform_escolar3_br inform_escolar4_br inform_escolar5_br inform_escolar6_br /*
	*/ total_desocup_escolar1_br total_desocup_escolar2_br total_desocup_escolar3_br total_desocup_escolar4_br total_desocup_escolar5_br total_desocup_escolar6_br /*
	*/ desocup_escolar1_br desocup_escolar2_br desocup_escolar3_br desocup_escolar4_br desocup_escolar5_br desocup_escolar6_br SETOR /*
	*/ forca_ocup_setor1_rj forca_ocup_setor2_rj forca_ocup_setor3_rj forca_ocup_setor4_rj forca_ocup_setor5_rj /*
	*/ forca_de_trab_setor1_rj forca_de_trab_setor2_rj forca_de_trab_setor3_rj forca_de_trab_setor4_rj forca_de_trab_setor5_rj /*
	*/ peso_ocup_setor1_rj peso_ocup_setor2_rj peso_ocup_setor3_rj peso_ocup_setor4_rj peso_ocup_setor5_rj /*
	*/ total_inform_setor1_rj total_inform_setor2_rj total_inform_setor3_rj total_inform_setor4_rj total_inform_setor5_rj  inform_setor1_rj inform_setor2_rj inform_setor3_rj inform_setor4_rj inform_setor5_rj  /*
	*/ total_desocup_setor1_rj total_desocup_setor2_rj total_desocup_setor3_rj total_desocup_setor4_rj total_desocup_setor5_rj /*
	*/ desocup_setor1_rj desocup_setor2_rj desocup_setor3_rj desocup_setor4_rj desocup_setor5_rj /*
	*/ forca_ocup_setor1_br forca_ocup_setor2_br forca_ocup_setor3_br forca_ocup_setor4_br forca_ocup_setor5_br /*
	*/ forca_de_trab_setor1_br forca_de_trab_setor2_br forca_de_trab_setor3_br forca_de_trab_setor4_br forca_de_trab_setor5_br /*
	*/ peso_ocup_setor1_br peso_ocup_setor2_br peso_ocup_setor3_br peso_ocup_setor4_br peso_ocup_setor5_br /*
	*/ total_inform_setor1_br total_inform_setor2_br total_inform_setor3_br total_inform_setor4_br total_inform_setor5_br inform_setor1_br inform_setor2_br inform_setor3_br inform_setor4_br inform_setor5_br  /*
	*/ total_desocup_setor1_br total_desocup_setor2_br total_desocup_setor3_br total_desocup_setor4_br total_desocup_setor5_br /*
	*/ desocup_setor1_br desocup_setor2_br desocup_setor3_br desocup_setor4_br desocup_setor5_br GÊNERO /*
	*/ forca_ocup_H_rj forca_ocup_F_rj forca_de_trab_H_rj forca_de_trab_F_rj peso_ocup_H_rj peso_ocup_F_rj total_inform_H_rj total_inform_F_rj inform_H_rj inform_F_rj total_desocup_H_rj/*
	*/ total_desocup_F_rj desocup_H_rj desocup_F_rj forca_ocup_H_br forca_ocup_F_br forca_de_trab_H_br forca_de_trab_F_br peso_ocup_H_br peso_ocup_F_br /*
	*/ total_inform_H_br total_inform_F_br inform_H_br inform_F_br total_desocup_H_br total_desocup_F_br desocup_H_br desocup_F_br, by(Trimestre)
