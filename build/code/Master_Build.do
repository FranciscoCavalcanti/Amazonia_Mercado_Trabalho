/*
O propostio desse do file é:
limpar os dados brutos da PNAD Contínua Trimestral e Anual
para posteriormente analisar a estrutura do mercado de tabalho 
e comparar a Amazônia Legal com o resto do Brasil.

A análise está dividida da seguinte forma:
1) Descrever a estrutrura do emprego
2) Descrever a estrutura da renda
3) Descrever a relevância de programas sociais
4) Matriz de transições de ocupações
5) Composição demográfica no mercado trabalho
*/

* Stata version
version 16.1 //always set the stata version being used
set more off, perm

// caminhos (check your username by typing "di c(username)" in Stata) ----
if "`c(username)'" == "Francisco"   {
    global ROOT "C:\Users\Francisco\Dropbox"
}
else if "`c(username)'" == "f.cavalcanti"   {
    global ROOT "C:\Users\Francisco\Dropbox"
}	

global input_basiic		"${ROOT}\DataZoom\BasesIBGE\datazoom_rar\PNAD_CONTINUA\pnadcontinua_trimestral_20190729\pnad_painel\basico"  
global input_advanc     "${ROOT}\DataZoom\BasesIBGE\datazoom_rar\PNAD_CONTINUA\pnadcontinua_trimestral_20190729\pnad_painel\avancado"
global input_pnadanual	"${ROOT}\DataZoom\BasesIBGE\datazoom_rar\PNAD_CONTINUA\pnadcontinua_anual_20191016\Stata"      
global tmp_dir			"${ROOT}\Amazonia_Mercado_Trabalho\build\tmp"   
global code_dir			"${ROOT}\Amazonia_Mercado_Trabalho\build\code"   
global output_dir		"${ROOT}\Amazonia_Mercado_Trabalho\build\output"   
global input_dir		"${ROOT}\Amazonia_Mercado_Trabalho\build\input"   

* set more off 
set more off, perm


//////////////////////////////////////////////
//	
//	Retrato do Emprego
//	
//////////////////////////////////////////////
**********************
**	Amazônia Legal	**
**********************

global area_geografica = "Amazônia Legal"

forvalues yr = 2019(1)2019{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	*sample 1
	* run code
	do "$code_dir\_retrato_emprego"
	* save as temporary
	save "$tmp_dir\_temp_retrato_emprego_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2019(1)2019 {
	* call data
	append using "$tmp_dir\_temp_retrato_emprego_PNADC`yr'.dta"
}

* save in the output directory
save "$output_dir\_retrato_emprego_amazonia_legal.dta", replace
export excel using "$output_dir\_retrato_emprego_amazonia_legal.xls", /*
	*/	firstrow(varlabels) replace

**********************
**	Resto do Brasil	**
**********************

global area_geografica = "Resto do Brasil"

forvalues yr = 2019(1)2019 {
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	*sample 1
	* run code
	do "$code_dir\_retrato_emprego"
	* save as temporary
	save "$tmp_dir\_temp_retrato_emprego_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2019(1)2019 {
	* call data
	append using "$tmp_dir\_temp_retrato_emprego_PNADC`yr'.dta"
}

* save in the output directory
save "$output_dir\_retrato_emprego_resto_brasil.dta", replace
export excel using "$output_dir\_retrato_emprego_resto_brasil.xls", /*
	*/	firstrow(varlabels) replace
	
//////////////////////////////////////////////
//	
//	1) Descrever a estrutrura do emprego
//	
//////////////////////////////////////////////

**********************
**	Amazônia Legal	**
**********************

global area_geografica = "Amazônia Legal"

forvalues yr = 2012(1)2020{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	*sample 1
	* run code
	do "$code_dir\_estrutura_emprego"
	* save as temporary
	save "$tmp_dir\_temp_estrutura_emprego_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(1)2020{
	* call data
	append using "$tmp_dir\_temp_estrutura_emprego_PNADC`yr'.dta"
}

* save in the output directory
save "$output_dir\_estrutura_emprego_amazonia_legal.dta", replace
export excel using "$output_dir\_estrutura_emprego_amazonia_legal.xls", /*
	*/	firstrow(varlabels) replace

**********************
**	Resto do Brasil	**
**********************

global area_geografica = "Resto do Brasil"

forvalues yr = 2012(1)2020{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	*sample 1
	* run code
	do "$code_dir\_estrutura_emprego"
	* save as temporary
	save "$tmp_dir\_temp_estrutura_emprego_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(1)2020{
	* call data
	append using "$tmp_dir\_temp_estrutura_emprego_PNADC`yr'.dta"
}

* save in the output directory
save "$output_dir\_estrutura_emprego_resto_brasil.dta", replace
export excel using "$output_dir\_estrutura_emprego_resto_brasil.xls", /*
	*/	firstrow(varlabels) replace

//////////////////////////////////////////////
//	
//	2) Descrever a estrutura da renda
//	
//////////////////////////////////////////////

**********************
**	Amazônia Legal	**
**********************

global area_geografica = "Amazônia Legal"

forvalues yr = 2012(1)2020{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	*sample 1
	* run code
	do "$code_dir\_estrutura_renda"
	* save as temporary
	save "$tmp_dir\_temp_estrutura_renda_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(1)2020{
	* call data
	append using "$tmp_dir\_temp_estrutura_renda_PNADC`yr'.dta"
}

* save in the output directory
save "$output_dir\_estrutura_renda_amazonia_legal.dta", replace
export excel using "$output_dir\_estrutura_renda_amazonia_legal.xls", /*
	*/	firstrow(varlabels) replace

**********************
**	Resto do Brasil	**
**********************

global area_geografica = "Resto do Brasil"

forvalues yr = 2012(1)2020{
	* call data
	use "$input_advanc\PNADC`yr'.dta", clear
	* run code
	do "$code_dir\_estrutura_renda"
	* save as temporary
	save "$tmp_dir\_temp_estrutura_renda_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2012(1)2020{
	* call data
	append using "$tmp_dir\_temp_estrutura_renda_PNADC`yr'.dta"
}

* save in the output directory
save "$output_dir\_estrutura_renda_resto_brasil.dta", replace
export excel using "$output_dir\_estrutura_renda_resto_brasil.xls", /*
	*/	firstrow(varlabels) replace

//////////////////////////////////////////////
//	
//	3) Descrever relevância de programas sociais e outras rendas
//	
//////////////////////////////////////////////

**********************
**	Amazônia Legal	**
**********************

global area_geografica = "Amazônia Legal"

* run code
do "$code_dir\_programas_sociais_outras_rendas"

* save in the output directory
save "$output_dir\_programas_sociais_outras_rendas_amazonia_legal.dta", replace
export excel using "$output_dir\_programas_sociais_outras_rendas_amazonia_legal.xls", /*
	*/	firstrow(varlabels) replace

**********************
**	Resto do Brasil	**
**********************

global area_geografica = "Resto do Brasil"

* run code
do "$code_dir\_programas_sociais_outras_rendas"

* save in the output directory
save "$output_dir\_programas_sociais_outras_rendas_resto_brasil.dta", replace
export excel using "$output_dir\_programas_sociais_outras_rendas_resto_brasil.xls", /*
	*/	firstrow(varlabels) replace

//////////////////////////////////////////////
//	
//	3) Matriz de transições de ocupações
//	
//////////////////////////////////////////////

**********************
**	Amazônia Legal	**
**********************

global area_geografica = "Amazônia Legal"

* loop over all panel data
forvalues yr = 1(1)8{
	* call data
	use "$input_advanc\PNAD_painel_`yr'_rs.dta", clear
	*sample 1
	* run code to clean data
	do "$code_dir\_transicao_ocupacao_1clean_quarter"
	* save as temporary
	save "$tmp_dir\_temp_transicao_ocupacao_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 1(1)8{
	* call data
	append using "$tmp_dir\_temp_transicao_ocupacao_PNADC`yr'.dta"
}

* generate matriz
* preserve
preserve 
	* run code
	do "$code_dir\_transicao_ocupacao_2matriz"
	
* save in the output directory	
save "$output_dir\_transicao_ocupacao_amazonia_legal_matriz.dta", replace	
export excel using "$output_dir\_transicao_ocupacao_amazonia_legal_matriz.xls", /*
	*/	firstrow(varlabels) replace

* restore
restore

* convert to quarter level
* preserve
preserve 
	* run code
	do "$code_dir\_transicao_ocupacao_3quarter_level"
	
* save in the output directory	
save "$output_dir\_transicao_ocupacao_amazonia_legal_trimestral.dta", replace
export excel using "$output_dir\_transicao_ocupacao_amazonia_legal_trimestral.xls", /*
	*/	firstrow(varlabels) replace

* restore
restore
clear

**********************
**	Resto do Brasil	**
**********************

global area_geografica = "Resto do Brasil"

* loop over all panel data
forvalues yr = 1(1)8{
	* call data
	use "$input_advanc\PNAD_painel_`yr'_rs.dta", clear
	*sample 1
	* run code to clean data
	do "$code_dir\_transicao_ocupacao_1clean_quarter"
	* save as temporary
	save "$tmp_dir\_temp_transicao_ocupacao_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 1(1)8{
	* call data
	append using "$tmp_dir\_temp_transicao_ocupacao_PNADC`yr'.dta"
}


* generate matriz
* preserve
preserve 
	* run code
	do "$code_dir\_transicao_ocupacao_2matriz"
	
* save in the output directory	
save "$output_dir\_transicao_ocupacao_resto_brasil_matriz.dta", replace
export excel using "$output_dir\_transicao_ocupacao_resto_brasil_matriz.xls", /*
	*/	firstrow(varlabels) replace

* restore
restore

* convert to quarter level
* preserve
preserve 
	* run code
	do "$code_dir\_transicao_ocupacao_3quarter_level"
	
* save in the output directory	
save "$output_dir\_transicao_ocupacao_resto_brasil_trimestral.dta", replace
export excel using "$output_dir\_transicao_ocupacao_resto_brasil_trimestral.xls", /*
	*/	firstrow(varlabels) replace
		
* restore
restore
clear
	
//////////////////////////////////////////////
//	
//	3.1) Matriz de transições de ocupações (Anualizadas)
//	
//////////////////////////////////////////////

**********************
**	Amazônia Legal	**
**********************

global area_geografica = "Amazônia Legal"

* loop over all panel data
forvalues yr = 2(1)7{
	* call data
	use "$input_advanc\PNAD_painel_`yr'_rs.dta", clear
	*sample 1
	* run code to clean data
	do "$code_dir\_transicao_ocupacao_1clean_annual"
	* save as temporary
	save "$tmp_dir\_temp_transicao_ocupacao_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2(1)7{
	* call data
	append using "$tmp_dir\_temp_transicao_ocupacao_PNADC`yr'.dta"
}

* generate matriz
* preserve
preserve 
	* run code
	do "$code_dir\_transicao_ocupacao_2matriz"
	
* save in the output directory	
save "$output_dir\_transicao_ocupacao_amazonia_legal_matriz_anual.dta", replace	
export excel using "$output_dir\_transicao_ocupacao_amazonia_legal_matriz_anual.xls", /*
	*/	firstrow(varlabels) replace

* restore
restore

* convert to quarter level
* preserve
preserve 
	* run code
	do "$code_dir\_transicao_ocupacao_3annual_level"
	
* save in the output directory	
save "$output_dir\_transicao_ocupacao_amazonia_legal_anual.dta", replace
export excel using "$output_dir\_transicao_ocupacao_amazonia_legal_anual.xls", /*
	*/	firstrow(varlabels) replace

* restore
restore
clear

**********************
**	Resto do Brasil	**
**********************

global area_geografica = "Resto do Brasil"

* loop over all panel data
forvalues yr = 2(1)7{
	* call data
	use "$input_advanc\PNAD_painel_`yr'_rs.dta", clear
	*sample 1
	* run code to clean data
	do "$code_dir\_transicao_ocupacao_1clean_annual"
	* save as temporary
	save "$tmp_dir\_temp_transicao_ocupacao_PNADC`yr'.dta", replace
}

* append temporary data base
clear
forvalues yr = 2(1)7{
	* call data
	append using "$tmp_dir\_temp_transicao_ocupacao_PNADC`yr'.dta"
}


* generate matriz
* preserve
preserve 
	* run code
	do "$code_dir\_transicao_ocupacao_2matriz"
	
* save in the output directory	
save "$output_dir\_transicao_ocupacao_resto_brasil_matriz_anual.dta", replace
export excel using "$output_dir\_transicao_ocupacao_resto_brasil_matriz_anual.xls", /*
	*/	firstrow(varlabels) replace

* restore
restore

* convert to quarter level
* preserve
preserve 
	* run code
	do "$code_dir\_transicao_ocupacao_3annual_level"
	
* save in the output directory	
save "$output_dir\_transicao_ocupacao_resto_brasil_anual.dta", replace
export excel using "$output_dir\_transicao_ocupacao_resto_brasil_anual.xls", /*
	*/	firstrow(varlabels) replace
		
* restore
restore
clear	
//////////////////////////////////////////////
//	
//	4) Composição demográfica no mercado trabalho
//	
//////////////////////////////////////////////

	* run code
	do "$code_dir\_composicao_demografica"
	
//////////////////////////////////////////////
//	
//	5) Desigualdade de renda
//	
//////////////////////////////////////////////

**********************
**	Amazônia Legal	**
**********************

global area_geografica = "Amazônia Legal"

* run code
do "$code_dir\_desigualdade_renda"

* save in the output directory
save "$output_dir\_desigualdade_renda_amazonia_legal.dta", replace
export excel using "$output_dir\_desigualdade_renda_amazonia_legal.xls", /*
	*/	firstrow(varlabels) replace

**********************
**	Resto do Brasil	**
**********************

global area_geografica = "Resto do Brasil"

* run code
do "$code_dir\_desigualdade_renda"

* save in the output directory
save "$output_dir\_desigualdade_renda_resto_brasil.dta", replace
export excel using "$output_dir\_desigualdade_renda_rendas_resto_brasil.xls", /*
	*/	firstrow(varlabels) replace

******************************************
** delete temporary files
******************************************

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
