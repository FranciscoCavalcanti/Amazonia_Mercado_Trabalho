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
	*/ 	| 	$time == 2014 /* 
	*/ 	| 	$time == 2015 {
		replace bolsa_familia=1 if V50101==1 //  ... recebeu Bolsa família ou do Programa de Erradicação do Trabalho Infantil - PETI
 		replace bolsa_familia=0 if bolsa_familia==.
}

else if $time == 2016 /*
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
	replace bolsa_familia=1 if V5002A==1
	replace bolsa_familia=0 if bolsa_familia==.
}

* recebeu programa social
gen ajuda_gov=.

if $time == 2012 /*
	*/ 	| 	$time == 2013 /* 
	*/ 	| 	$time == 2014 /* 
	*/ 	| 	$time == 2015 {
		replace ajuda_gov=1 if V50101==1 //  recebeu Bolsa família ou do Programa de Erradicação do Trabalho Infantil - PETI
		replace ajuda_gov=1 if V50091==1 //  recebeu Benefício Assistencial de Prestação Continuada - BPC - LOAS
 		replace ajuda_gov=1 if V50111==1 //  recebeu rendimentos de algum outro programa social, público ou privado
}

else if $time == 2016 /*
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
	*/ 	| 	$time == 2014 /* 
	*/ 	| 	$time == 2015 {
		replace bpc_loas=1 if V50091==1 //  recebeu Benefício Assistencial de Prestação Continuada - BPC - LOAS
}

else if $time == 2016 /*
	*/ 	| 	$time == 2017 /* 
	*/ 	| 	$time == 2018 /* 
	*/ 	| 	$time == 2019 {
		replace bpc_loas=1 if V5001A==1 //  recebeu rendimentos de Benefício Assistencial de Prestação Continuada – BPC-LOAS?
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