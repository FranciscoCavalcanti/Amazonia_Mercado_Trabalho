/*
O propostio desse do file é:
Analisar a estrutura do mercado de tabalho da Amazônia

A análise está dividida da seguinte forma:
1) Descrever a estrutrura do emprego
2) Descrever a estrutura da renda
3) Descrever a relevância de programas sociais
4) Matriz de transições de ocupações
5) Composição demográfica no mercado trabalho
*/

// caminhos (check your username by typing "di c(username)" in Stata) ----
if "`c(username)'" == "Francisco"   {
    global ROOT "C:\Users\Francisco\Dropbox"
}
else if "`c(username)'" == "f.cavalcanti"   {
    global ROOT "C:\Users\Francisco\Dropbox"
}	
else if "`c(username)'" == "DELL"   {
    global ROOT "C:/Users/DELL/Documents/GitHub"
}

global output_dir_build	"${ROOT}\Amazonia_Mercado_Trabalho\build\output"      
global tmp_dir			"${ROOT}\Amazonia_Mercado_Trabalho\analysis\tmp"   
global code_dir			"${ROOT}\Amazonia_Mercado_Trabalho\analysis\code"   
global output_dir		"${ROOT}\Amazonia_Mercado_Trabalho\analysis\output"   
global input_dir		"${ROOT}\Amazonia_Mercado_Trabalho\analysis\input"   

* set more off 
set more off, perm

//////////////////////////////////////////////
//	Descrever o retrato do emprego	
//////////////////////////////////////////////

* run do file
do "$code_dir\_retrato_emprego.do"

//////////////////////////////////////////////	
//	1) Descrever a estrutrura do emprego	
//////////////////////////////////////////////

* run do file
do "$code_dir\_estrutura_emprego.do"

* run do file
do "$code_dir\_estrutura_emprego_faixa.do"

* run do file
do "$code_dir\_estrutura_emprego_faixa_desalento.do"

//////////////////////////////////////////////	
//	2) Descrever a estrutura da renda	
//////////////////////////////////////////////

* run do file
do "$code_dir\_estrutura_renda.do"

//////////////////////////////////////////////	
//	3) Descrever a relevância de programas sociais	
//////////////////////////////////////////////

* run do file
do "$code_dir\_programas_sociais_outras_rendas.do"

* run do file
do "$code_dir\_outras_rendas_composicao.do"

* run do file
do "$code_dir\_outras_rendas_composicao_porquintil.do"

* run do file
do "$code_dir\_outras_rendas_composicao_porfaixas.do"

* run do file
do "$code_dir\_outros_emprego_caracterizacao.do"

//////////////////////////////////////////////	
//	4) Matriz de transições de ocupações
//////////////////////////////////////////////

* run do file
do "$code_dir\_transicao_ocupacao.do"

* run do file
do "$code_dir\_transicao_ocupacao_combine.do"

* run do file
do "$code_dir\_transicao_ocupacao_anual.do"

* run do file
do "$code_dir\_transicao_ocupacao_anual_combine.do"

//////////////////////////////////////////////	
//	5) Composição demográfica no mercado trabalho
//////////////////////////////////////////////

* run do file
do "$code_dir\_composicao_demografica.do"


//////////////////////////////////////////////	
//	6) Desigualdade de renda
//////////////////////////////////////////////

* run do file
do "$code_dir\_retrato_emprego_fotografia_desigualdade_renda.do"
	
* delete temporary files

cd  "${tmp_dir}/"
local datafiles: dir "${tmp_dir}/" files "*.dta"
foreach datafile of local datafiles {
        rm `datafile'
}

cd  "${tmp_dir}/"
local datafiles: dir "${tmp_dir}/" files "*.csv"
foreach datafile of local datafiles {
        rm `datafile'
}

cd  "${tmp_dir}/"
local datafiles: dir "${tmp_dir}/" files "*.txt"
foreach datafile of local datafiles {
        rm "`datafile'"
}


cd  "${tmp_dir}/"
local datafiles: dir "${tmp_dir}/" files "*.pdf"
foreach datafile of local datafiles {
        rm `datafile'
}
