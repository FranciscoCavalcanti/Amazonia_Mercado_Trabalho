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

* rendimento de todos os trabalhos
gen rendatotal =  VD4019 	// Rendimento mensal habitual de todos os trabalhos
replace rendatotal = 0 if rendatotal ==. 

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

* trabalhadores em casa
gen homeoffice = 1 if   V4022 == 4  // No domicílio de residência, em local exclusivo para o desempenho da atividade
replace homeoffice = 1 if   V4022 == 5 // No domicílio de residência, sem local exclusivo para o desempenho da atividade 
replace homeoffice = 0 if homeoffice ==. 

* grandes setores da economia
gen gstr_agricultura = 1 if VD4010 == 1 	// Agricultura
gen gstr_industria = 1 if VD4010 == 2 	// Indústria geral
gen gstr_construcao = 1 if VD4010 == 3 	// Construção
gen gstr_comercio = 1 if VD4010 == 4 	// Comércio, reparação de veículos automotores e motocicletas
gen gstr_servicos = 1 if VD4010 >= 5 	// 

**************************************
**	Editar variável trimestre 		**
** 									**
**	É útil ter valores contínuos 	**
**************************************
 
* generate variable of quartely date
	tostring Ano, gen(iten1)
	gen iten3 = iten1 + "." + Trimestre
	gen  trim = quarterly(iten3, "YQ")
	cap drop iten*
	cap drop tool*