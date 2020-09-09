//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////

* Usar dados de 2019 (pré convid)

//////////////////////////////////////////
//	Caracterização do mercado de trabalho	
/////////////////////////////////////////

* run do file
do "$code_dir\_retrato_emprego_caracterizacao.do"

* run do file: table
do "$code_dir\_retrato_emprego_caracterizacao_table.do"

///////////////////////////////////////////
// Composicao setorial da ocupacao (%)
/////////////////////////////////////////

//////////////////////////////////////////
//	Composição setorial	
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_setor_gstr.do"

* run do file: table
do "$code_dir\_retrato_emprego_setor_gstr_table.do"

//////////////////////////////////////////
//	Composição setorial	de Serviços
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_setor_gape.do"
* run do file: table
do "$code_dir\_retrato_emprego_setor_gape_table_n_de_formal.do"
do "$code_dir\_retrato_emprego_setor_gape_table_n_de_informal.do"

//////////////////////////////////////////
//	Composição setorial	de Industria
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_setor_sgap_industria.do"
* run do file: table
do "$code_dir\_retrato_emprego_setor_sgap_industria_table_n_de_formal.do"
do "$code_dir\_retrato_emprego_setor_sgap_industria_table_n_de_informal.do"

//////////////////////////////////////////
//	Composição setorial	de Agricultura
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_setor_sgap_agricultura.do"
* run do file: table
do "$code_dir\_retrato_emprego_setor_sgap_agricultura_table_n_de_formal.do"
do "$code_dir\_retrato_emprego_setor_sgap_agricultura_table_n_de_informal.do"

//////////////////////////////////////////
//	Composição sub-setorial	de Industria de Transfornmação
/////////////////////////////////////////
* run do file: graph
do "$code_dir\_retrato_emprego_setor_sgap_trans.do"
* run do file: table
do "$code_dir\_retrato_emprego_setor_sgap_trans_table_n_de_formal.do"
do "$code_dir\_retrato_emprego_setor_sgap_trans_table_n_de_informal.do"

/////////////////////////////////////////
// Posicao na Ocupacao
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_insercao_ocupacao.do"

///////////////////////////////////////// 
//(Exercicio contractual)
*Sera que é por causa de uma composicao etaria
*Sera que é por causa de uma composicao de escolaridade
*tambem genero
* talvez olhar para genero/junto com faixa etaria
* setorial

*taxa de ocupacao / taxa de informalidade
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_contrafactual.do"

/////////////////////////////////////////
*juntar indigena com preto e pardo
/////////////////////////////////////////

/////////////////////////////////////////
*colocar piramides
*Populacao com um todo
*Apenas ocupados
************
*Em N. De Ocupados
*Estrutura etaria brasil e amazmonia
*linha do X = grupo etarios

*piramide
*pela populacao total
*pelo ocupado
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_fotografia_faixa_etaria.do"

/////////////////////////////////////////
*quebrar escolaridade em dois:
*fundamental em 2 partes:
*1 ciclo de fundamental = ate fundamental 1 completo
*2 ciclo do fundamental = até fundamental 2 completo
/////////////////////////////////////////


/////////////////////////////////////////
*Fotografia!
*taxa do inicio (estrutura do emprego)
*metropolitana vs. n metropolitana
*rural vs rual
*Olhar pro Nivel 
*(2019)
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_fotografia_regiao_metropolitana.do"
* run do file: graph
do "$code_dir\_retrato_emprego_fotografia_regiao_rural.do"

/////////////////////////////////////////
* PNAD Trimestral
*Rendimneto habital (barrinhas Amazonia, e Brasil)
*Ocupados
*Informal
*Formal
*Renda mensal domiciliar per capita
*Fotografia!
*Olhar pro Nivel 
*(2019)
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_fotografia_rendimentos.do"

/////////////////////////////////////////
* PNAD ANUAL
*Rendimento de Todas as fontes (barrinhas Amazonia, e Brasil)
*Ocupados
*Informal
*Formal
*Renda mensal domiciliar per capita
*Fotografia!
*Olhar pro Nivel 
*(2019)
/////////////////////////////////////////

/////////////////////////////////////////
* Programas sociais
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_fotografia_programas_sociais.do"


//////////////////////////////////////////
//	Informalidade vs. Formalidade
/////////////////////////////////////////

* run do file: graph
do "$code_dir\_retrato_emprego_formalidade.do"
