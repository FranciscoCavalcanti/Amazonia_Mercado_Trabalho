**********************
**	 Definitions	**
**********************

/*	Useful variables: Income

VD4016: 
Rendimento mensal habitual do trabalho principal para pessoas de 14 anos ou mais de idade 
(apenas para pessoas que receberam em dinheiro, produtos ou mercadorias no trabalho principal)

VD4019
Rendimento mensal habitual de todos os trabalhos para pessoas de 14 anos ou mais de idade 
(apenas para pessoas que receberam em dinheiro, produtos ou mercadorias em qualquer trabalho)

*/

/*	Useful variables: Labor

VD4001
1 // Pessoas na força de trabalho
2 // Pessoas fora da força de trabalho

VD4002
1 // Pessoas ocupadas 
2 // Pessoas desocupadas 

VD4009
1 // Empregado no setor privado com carteira de trabalho assinada
2 // Empregado no setor privado sem carteira de trabalho assinada
3 // Trabalhador doméstico com carteira de trabalho assinada
4 // Trabalhador doméstico sem carteira de trabalho assinada
5 // Empregado no setor público com carteira de trabalho assinada
6 // Empregado no setor público sem carteira de trabalho assinada
7 // Militar e servidor estatutário
8 // Empregador
9 // Conta-própria
10 // Trabalhador familiar auxiliar
. // Não aplicável

*/

**************************************
** Definição de Área Geográfica 	**
**************************************

if "$area_geografica" == "Amazônia Legal"   {
    keep if UF == 11 	/* 	Rondônia
	*/ 	| UF == 12 	/* Acre
	*/ 	| UF == 13 	/* Amazonas
	*/ 	| UF == 14 	/* Roraima
	*/ 	| UF == 15 	/* Pará
	*/ 	| UF == 16 	/* Amapá
	*/ 	| UF == 17 	/* Tocantins
	*/ 	| UF == 51 	/* Mato Grosso
	*/ 	| (UF == 21 & V1023 == 4) 	// Maranhão & Resto da UF (Unidade da Federação, excluindo a região metropolitana e a RIDE)
	
	local area = "amazonia_legal"
}
else if "$area_geografica" == "Resto do Brasil"   {
    drop if UF == 11 	/* 	Rondônia
	*/ 	| UF == 12 	/* Acre
	*/ 	| UF == 13 	/* Amazonas
	*/ 	| UF == 14 	/* Roraima
	*/ 	| UF == 15 	/* Pará
	*/ 	| UF == 16 	/* Amapá
	*/ 	| UF == 17 	/* Tocantins
	*/ 	| UF == 51 	/* Mato Grosso
	*/ 	| (UF == 21 & V1023 == 4) 	// Maranhão & Resto da UF (Unidade da Federação, excluindo a região metropolitana e a RIDE)

	local area = "resto_brasil"
}	

**********************************
**	Definições de variáveis 	**
**********************************

* pessoa ocupado
gen ocupado = 1 if VD4002 == 1 	// Pessoas ocupadas 
replace ocupado = 0 if ocupado ==. 

* pessoa desocupado
gen desocupado = 1 if VD4002 == 2 	// Pessoas desocupadas 
replace desocupado = 0 if desocupado ==. 

** trabalhador formal
gen formal =.
replace formal = 1 if VD4002 == 1 &  VD4009 == 1 	// Empregado no setor privado com carteira de trabalho assinada
replace formal = 1 if VD4002 == 1 &  VD4009 == 3 	// Trabalhador doméstico com carteira de trabalho assinada
replace formal = 1 if VD4002 == 1 &  VD4009 == 5 	// Empregado no setor público com carteira de trabalho assinada
replace formal = 1 if VD4002 == 1 &  VD4009 == 7 	// Militar e servidor estatutário
replace formal = 1 if VD4002 == 1 &  VD4009 == 9 & VD4012 == 1  // Conta-própria & Contribuinte
replace formal = 0 if formal ==.

** trabalhador informal
gen informal =.
replace informal = 1 if VD4002 == 1 &  VD4009 == 2 	// Empregado no setor privado sem carteira de trabalho assinada 
replace informal = 1 if VD4002 == 1 &  VD4009 == 4 	// Trabalhador doméstico sem carteira de trabalho assinada
replace informal = 1 if VD4002 == 1 &  VD4009 == 6 	// Empregado no setor público sem carteira de trabalho assinada
replace informal = 1 if VD4002 == 1 &  VD4009 == 9 & VD4012 == 2 	// Conta-própria & Não contribuinte
replace informal = 1 if VD4002 == 1 &  VD4009 == 10 	// Trabalhador familiar auxiliar
replace informal = 0 if informal ==. 

* pessoa na força de trabalho
gen forcatrabalho = 1 if VD4001 == 1 	// Pessoas na força de trabalho
replace forcatrabalho = 0 if forcatrabalho ==. 

* pessoa fora da força de trabalho
gen forcatrabalhofora = 1 if VD4001 == 2	// Pessoas fora da força de trabalho
replace forcatrabalhofora = 0 if forcatrabalhofora ==. 

* pessoa com idade ativa
gen pia = 1 if V2009 >= 14	// PIA = pessoas em idade de trabalhar inclui as pessoas de 14 anos
replace forcatrabalhofora = 0 if forcatrabalhofora ==. 

* pessoa com economicamente ativa
gen pea = 1 if VD4002 ==1 | VD4002 ==2  // PEA = população ocupada + população desocupada
replace pea = 0 if pea ==. 

* pessoa inativa
gen inativa = 1 if VD4001 == 2  // população desocupada
replace inativa = 0 if inativa ==. 

* pessoa desempregado
gen desempregado = 1 if VD4001 == 1 & VD4002 == 2 // pessoa na força de trabalho & população desocupada
replace desempregado = 0 if desempregado ==. 

* pessoa empregado SC
gen empregadoSC = 1 if VD4009 == 2 | VD4009 == 4 | VD4009 == 6 | VD4009 == 10 // trabalhadores informais
replace empregadoSC = 0 if empregadoSC ==. 

* pessoa empregado CC
gen empregadoCC = 1 if VD4009 == 1 | VD4009 == 3 | VD4009 == 5  // trabalhadores formais
replace empregadoCC = 0 if empregadoCC ==. 

* pessoa conta-própria
gen cpropria = 1 if VD4009 == 9  // conta-própria
replace cpropria = 0 if cpropria ==. 

* pessoa conta-própria contribuinte
gen cpropriaC = 1 if VD4009 == 9 & VD4012 == 1  // Conta-própria & Contribuinte
replace cpropriaC = 0 if cpropriaC ==. 

* pessoa conta-própria não-contribuinte
gen cpropriaNc = 1 if VD4009 == 9 & VD4012 == 2  // Conta-própria & Não contribuinte
replace cpropriaNc = 0 if cpropriaNc ==. 

* pessoa empregador
gen empregador = 1 if VD4009 == 8  // empregador
replace empregador = 0 if empregador ==. 

* pessoa militar e servidor estatutário
gen militar = 1 if VD4009 == 7  // militar e servidor estatutário
replace militar = 0 if militar ==. 

**************************************
**	Variáveis problemáticas 		**
**	que alteram ao longo do anos 	**
**************************************

* recebeu bolsa família
gen bolsa_familia=.

if $time == 2012 /*
	*/ 	| 	$time == 2013 /* 
	*/ 	| 	$time == 2014 {
		replace bolsa_familia=1 if V50101==1 //  ... recebeu Bolsa família ou do Programa de Erradicação do Trabalho Infantil - PETI
}

if $time == 2015 {
		* Trimestre 1, 2, 3
		replace bolsa_familia=1 if V50101==1 & Trimestre ~=4 //  recebeu Bolsa família ou do Programa de Erradicação do Trabalho Infantil - PETI
		* Trimestre 4
		replace bolsa_familia=1 if V5002A==1 & Trimestre ==4 //  recebeu rendimentos de Programa Bolsa Família?
}

if $time == 2016 /* 
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
	replace bolsa_familia=1 if V5002A==1
}

* recebeu programa social
gen ajuda_gov=.

if $time == 2012 /*
	*/ 	| 	$time == 2013 /* 
	*/ 	| 	$time == 2014 {
		replace ajuda_gov=1 if V50101==1 //  recebeu Bolsa família ou do Programa de Erradicação do Trabalho Infantil - PETI
		replace ajuda_gov=1 if V50091==1 //  recebeu Benefício Assistencial de Prestação Continuada - BPC - LOAS
 		replace ajuda_gov=1 if V50111==1 //  recebeu rendimentos de algum outro programa social, público ou privado
}

if $time == 2015 {
		* Trimestre 1, 2, 3
		replace ajuda_gov=1 if V50101==1 & Trimestre ~=4 //  recebeu Bolsa família ou do Programa de Erradicação do Trabalho Infantil - PETI
		replace ajuda_gov=1 if V50091==1 & Trimestre ~=4 //  recebeu Benefício Assistencial de Prestação Continuada - BPC - LOAS
 		replace ajuda_gov=1 if V50111==1 & Trimestre ~=4 //  recebeu rendimentos de algum outro programa social, público ou privado
		* Trimestre 4
		replace ajuda_gov=1 if V5002A==1 & Trimestre ==4 //  recebeu rendimentos de Programa Bolsa Família?
		replace ajuda_gov=1 if V5001A==1 & Trimestre ==4 //  recebeu rendimentos de Benefício Assistencial de Prestação Continuada – BPC-LOAS?
 		replace ajuda_gov=1 if V5003A==1 & Trimestre ==4 //  recebeu rendimentos de outros programas sociais do governo?
}

if $time == 2016 /* 
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
		replace ajuda_gov=1 if V5002A==1 //  recebeu rendimentos de Programa Bolsa Família?
		replace ajuda_gov=1 if V5001A==1 //  recebeu rendimentos de Benefício Assistencial de Prestação Continuada – BPC-LOAS?
 		replace ajuda_gov=1 if V5003A==1 //  recebeu rendimentos de outros programas sociais do governo?
}

* recebeu bpc_loas
gen bpc_loas=.

if $time == 2012 /*
	*/ 	| 	$time == 2013 /* 
	*/ 	| 	$time == 2014 {
		replace bpc_loas=1 if V50091==1 //  recebeu Benefício Assistencial de Prestação Continuada - BPC - LOAS
}

if $time == 2015 {
		* Trimestre 1, 2, 3
		replace bpc_loas=1 if V50091==1 & Trimestre ~=4 //  recebeu Benefício Assistencial de Prestação Continuada - BPC - LOAS
		* Trimestre 4
		replace bpc_loas=1 if V5001A==1 & Trimestre ==4 //  recebeu rendimentos de Benefício Assistencial de Prestação Continuada – BPC-LOAS?
}

if $time == 2016 /* 
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
		replace bpc_loas=1 if V5001A==1 //  recebeu rendimentos de Benefício Assistencial de Prestação Continuada – BPC-LOAS?
}



**************************************
**	Outros rendimentos		 		**
**************************************

* Rendimento domiciliar per capita (habitual de todos os trabalhos e efetivo de outras fontes) 
gen renda_anual_pc = .

if $time == 2012 /*
	*/ 	| 	$time == 2013 /* 
	*/ 	| 	$time == 2014 {
		replace renda_anual_pc = VD5008 //  Rend habitual domiciliar per capita
}

if $time == 2015 {
		* Trimestre 1, 2, 3
		replace renda_anual_pc = VD5008 if Trimestre ~=4 //  Rend habitual domiciliar per capita
		* Trimestre 4
		replace renda_anual_pc = VD5011 if Trimestre ==4  //  Rend habitual domiciliar per capita
}

if $time == 2016 /* 
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
		replace renda_anual_pc = VD5011 //  Rend habitual domiciliar per capita
}

* Rendimento recebido em todas as fontes 
gen renda_anual = .

if $time == 2012 /*
	*/ 	| 	$time == 2013 /* 
	*/ 	| 	$time == 2014 {
		replace renda_anual = VD5008 //  Rend habitual domiciliar per capita
}

if $time == 2015 {
		* Trimestre 1, 2, 3
		replace renda_anual = VD5008 if Trimestre ~=4 //  Rend habitual domiciliar per capita
		* Trimestre 4
		replace renda_anual= VD5011 if Trimestre ==4  //  Rend habitual domiciliar per capita
}

if $time == 2016 /* 
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
		replace renda_anual= VD5011 //  Rend habitual domiciliar per capita
}

* Recebeu rendimentos de seguro-desemprego, seguro-defeso
gen seguro_desemprego = .

if $time == 2012 /*
	*/ 	| 	$time == 2013 /* 
	*/ 	| 	$time == 2014 {
		replace seguro_desemprego = 1 if V50081 ==1  //  Rend habitual domiciliar per capita
}

if $time == 2015 {
		* Trimestre 1, 2, 3
		replace seguro_desemprego = 1 if V50081 ==1 & Trimestre ~=4  //  Rend habitual domiciliar per capita
		* Trimestre 4
		replace seguro_desemprego = 1 if  V5005A ==1 & Trimestre ==4  //  Rend habitual domiciliar per capita
}

if $time == 2016 /* 
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
		replace seguro_desemprego = 1 if  V5005A ==1 //  Rend habitual domiciliar per capita
}

* Recebeu rendimentos de aposentadoria ou pensão de instituto de previdência federal (INSS), estadual, municipal, ou do governo federal, estadual, municipal?
gen aposentadoria = .

if $time == 2012 /*
	*/ 	| 	$time == 2013 /* 
	*/ 	| 	$time == 2014 {
		replace aposentadoria = 1 if V50011 ==1  //  ... recebeu aposentadoria de instituto de previdência
}

if $time == 2015 {
		* Trimestre 1, 2, 3
		replace aposentadoria = 1 if V50011 ==1 & Trimestre ~=4  //  ... recebeu aposentadoria de instituto de previdência
		* Trimestre 4
		replace aposentadoria = 1 if  V5004A ==1 & Trimestre ==4 //  Recebeu aposentadoria e pensão "
}

if $time == 2016 /* 
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
		replace aposentadoria = 1 if  V5004A ==1 //  Recebeu aposentadoria e pensão "
}


**************************************
**	Editar variável trimestre 		**
** 									**
**	É útil ter valores contínuos 	**
**************************************
 
* generate variable of quartely date
	tostring Ano, gen(iten1)
	tostring Trimestre, gen(iten2)
	gen iten3 = iten1 + "." + iten2
	gen  trim = quarterly(iten3, "YQ")
	cap drop iten*
	cap drop tool*