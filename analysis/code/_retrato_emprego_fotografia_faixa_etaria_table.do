//////////////////////////////////////////////
//	
//	Descrever o retrato do emprego	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//		
/////////////////////////////////////////

** call data 
use "$output_dir_build\_estrutura_emprego_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_estrutura_emprego_resto_brasil.dta"
replace id = "Resto do Brasil" if id==""

* generate variable of quartely date
	tostring Ano, replace
	tostring Trimestre, replace
	gen iten1 = Ano + "." + Trimestre
	gen  trim = quarterly(iten1, "YQ")
	drop iten*
	
* edit format
encode id, generate(id2)
tsset id2 trim, quarterly 
format %tqCCYY trim

* keep 2019
keep if Ano =="2019" & Trimestre =="4"

**************************************
**	Colapsar ao nível do Ano 	**
**************************************

// attach label of variables
local colvar prop_* taxa_* n_*

foreach v of var `colvar' {
    local l`v' : variable label `v'
}

* colapse
collapse (firstnm) `colvar' , by(Ano id2)

// copy back the label of variables
foreach v of var `colvar' {
    label var `v' "`l`v''"
}

* select variables
ds n_de_pea_faixa_etaria* n_faixa_etaria* n_de_ocupado_faixa_etaria* n_de_desa_faixa_etaria*
local type `r(varlist)'
display "`type'"

collapse (mean) "`type'", by(id2 id) 

* reshape data
xpose, clear varname

* label varaibles
label variable v1  "Amazônia Legal"
label variable v2  "Resto do Brasil"

* drop
drop if v2 == .
drop if v1 == .
drop if _varname =="id2"

* format
format v1 %16,0fc
format v2 %16,0fc
encode _varname, generate(id2)
order id2 v1 v2
sort _varname
*gsort   -v1 v2

*******************************************************************
* Tabela de numero absoluto ocupados (Por todos grupos etarios)
*******************************************************************

*preserve
preserve

#delim ; 
keep if _varname == "n_de_ocupado_faixa_etaria1" 
	| _varname == "n_de_ocupado_faixa_etaria2"
	| _varname == "n_de_ocupado_faixa_etaria3"
	| _varname == "n_de_ocupado_faixa_etaria4"
	| _varname == "n_de_ocupado_faixa_etaria5"
	| _varname == "n_de_ocupado_faixa_etaria6"
	| _varname == "n_de_ocupado_faixa_etaria7"
    ;
#delim cr

// transforma data em matrix
mkmat v1 v2, matrix(A) rownames(_varname)

* local notes
local ttitle "Número total de \textbf{ocupados} por grupos etários - 2019"
local tnotes "Valores referentes ao último trimestre da PNAD Contínua 2019"

#delim ;    
esttab matrix(A, fmt(%16,0fc)) using "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_table_ocupados.tex", 
	replace 
	booktabs
	collabels("Amazônia Legal" "Resto do Brasil")
    prehead(
        "\begin{table}[H]"
        "\centering"
		"\label{_retrato_emprego_fotografia_faixa_etaria_table_ocupados}"
        "\begin{threeparttable}"
        "\caption{`ttitle'}"
        "\begin{tabular}{l*{@span}{rrr}}"
        "\midrule \midrule"
    )
    postfoot(
        "\bottomrule"
        "\end{tabular}"    
        "\begin{tablenotes}"
        "\scriptsize{Nota: `tnotes'}"
        "\end{tablenotes}"
        "\end{threeparttable}"
        "\end{table}"
    )    
	label
    unstack 
	noobs 
	nonumber 
	nomtitle 
	coeflabels(
		n_de_ocupado_faixa_etaria1 "14 a 17 anos" 
		n_de_ocupado_faixa_etaria2 "18 a 24 anos" 
		n_de_ocupado_faixa_etaria3 "25 a 29 anos" 
		n_de_ocupado_faixa_etaria4 "30 a 39 anos" 
		n_de_ocupado_faixa_etaria5 "40 a 49 anos" 
		n_de_ocupado_faixa_etaria6 "50 a 59 anos" 
		n_de_ocupado_faixa_etaria7 "> de 60 anos" 
	)
    ;
#delim cr

*restore
restore

*******************************************************************
* Tabela de numero absoluto participação (Por todos grupos etarios)
*******************************************************************

*preserve
preserve

#delim ; 
keep if _varname == "n_de_pea_faixa_etaria1" 
	| _varname == "n_de_pea_faixa_etaria2"
	| _varname == "n_de_pea_faixa_etaria3"
	| _varname == "n_de_pea_faixa_etaria4"
	| _varname == "n_de_pea_faixa_etaria5"
	| _varname == "n_de_pea_faixa_etaria6"
	| _varname == "n_de_pea_faixa_etaria7"
    ;
#delim cr

// transforma data em matrix
mkmat v1 v2, matrix(A) rownames(_varname)

* local notes
local ttitle "Número total de \textbf{participação} por grupos etários - 2019"
local tnotes "Valores referentes ao último trimestre da PNAD Contínua 2019"

#delim ;    
esttab matrix(A, fmt(%16,0fc)) using "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_table_participacao.tex", 
	replace 
	booktabs
	collabels("Amazônia Legal" "Resto do Brasil")
    prehead(
        "\begin{table}[H]"
        "\centering"
		"\label{_retrato_emprego_fotografia_faixa_etaria_table_participacao}"
        "\begin{threeparttable}"
        "\caption{`ttitle'}"
        "\begin{tabular}{l*{@span}{rrr}}"
        "\midrule \midrule"
    )
    postfoot(
        "\bottomrule"
        "\end{tabular}"    
        "\begin{tablenotes}"
        "\scriptsize{Nota: `tnotes'}"
        "\end{tablenotes}"
        "\end{threeparttable}"
        "\end{table}"
    )    
	label
    unstack 
	noobs 
	nonumber 
	nomtitle 
	coeflabels(
		n_de_pea_faixa_etaria1 "14 a 17 anos" 
		n_de_pea_faixa_etaria2 "18 a 24 anos" 
		n_de_pea_faixa_etaria3 "25 a 29 anos" 
		n_de_pea_faixa_etaria4 "30 a 39 anos" 
		n_de_pea_faixa_etaria5 "40 a 49 anos" 
		n_de_pea_faixa_etaria6 "50 a 59 anos" 
		n_de_pea_faixa_etaria7 "> de 60 anos" 
	)
    ;
#delim cr

*restore
restore

*******************************************************************
* Tabela de numero absoluto desalentados (Por todos grupos etarios)
*******************************************************************

*preserve
preserve

#delim ; 
keep if _varname == "n_de_desa_faixa_etaria1" 
	| _varname == "n_de_desa_faixa_etaria2"
	| _varname == "n_de_desa_faixa_etaria3"
	| _varname == "n_de_desa_faixa_etaria4"
	| _varname == "n_de_desa_faixa_etaria5"
	| _varname == "n_de_desa_faixa_etaria6"
	| _varname == "n_de_desa_faixa_etaria7"
    ;
#delim cr

// transforma data em matrix
mkmat v1 v2, matrix(A) rownames(_varname)

* local notes
local ttitle "Número total de \textbf{desalentados} por grupos etários - 2019"
local tnotes "Valores referentes ao último trimestre da PNAD Contínua 2019"

#delim ;    
esttab matrix(A, fmt(%16,0fc)) using "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_table_desalentados.tex", 
	replace 
	booktabs
	collabels("Amazônia Legal" "Resto do Brasil")
    prehead(
        "\begin{table}[H]"
        "\centering"
		"\label{_retrato_emprego_fotografia_faixa_etaria_table_desalentados}"
        "\begin{threeparttable}"
        "\caption{`ttitle'}"
        "\begin{tabular}{l*{@span}{rrr}}"
        "\midrule \midrule"
    )
    postfoot(
        "\bottomrule"
        "\end{tabular}"    
        "\begin{tablenotes}"
        "\scriptsize{Nota: `tnotes'}"
        "\end{tablenotes}"
        "\end{threeparttable}"
        "\end{table}"
    )    
	label
    unstack 
	noobs 
	nonumber 
	nomtitle 
	coeflabels(
		n_de_desa_faixa_etaria1 "14 a 17 anos" 
		n_de_desa_faixa_etaria2 "18 a 24 anos" 
		n_de_desa_faixa_etaria3 "25 a 29 anos" 
		n_de_desa_faixa_etaria4 "30 a 39 anos" 
		n_de_desa_faixa_etaria5 "40 a 49 anos" 
		n_de_desa_faixa_etaria6 "50 a 59 anos" 
		n_de_desa_faixa_etaria7 "> de 60 anos" 
	)
    ;
#delim cr

*restore
restore

*******************************************************************
* Tabela de numero absoluto da população (Por todos grupos etarios)
*******************************************************************

*preserve
preserve

#delim ; 
keep if _varname == "n_faixa_etaria1" 
	| _varname == "n_faixa_etaria2"
	| _varname == "n_faixa_etaria3"
	| _varname == "n_faixa_etaria4"
	| _varname == "n_faixa_etaria5"
	| _varname == "n_faixa_etaria6"
	| _varname == "n_faixa_etaria7"
    ;
#delim cr

// transforma data em matrix
mkmat v1 v2, matrix(A) rownames(_varname)

* local notes
local ttitle "Número total da \textbf{população} por grupos etários - 2019"
local tnotes "Valores referentes ao último trimestre da PNAD Contínua 2019"

#delim ;    
esttab matrix(A, fmt(%16,0fc)) using "$output_dir\retrato_emprego\_retrato_emprego_fotografia_faixa_etaria_table_populacao.tex", 
	replace 
	booktabs
	collabels("Amazônia Legal" "Resto do Brasil")
    prehead(
        "\begin{table}[H]"
        "\centering"
		"\label{_retrato_emprego_fotografia_faixa_etaria_table_populacao}"
        "\begin{threeparttable}"
        "\caption{`ttitle'}"
        "\begin{tabular}{l*{@span}{rrr}}"
        "\midrule \midrule"
    )
    postfoot(
        "\bottomrule"
        "\end{tabular}"    
        "\begin{tablenotes}"
        "\scriptsize{Nota: `tnotes'}"
        "\end{tablenotes}"
        "\end{threeparttable}"
        "\end{table}"
    )    
	label
    unstack 
	noobs 
	nonumber 
	nomtitle 
	coeflabels(
		n_faixa_etaria1 "14 a 17 anos" 
		n_faixa_etaria2 "18 a 24 anos" 
		n_faixa_etaria3 "25 a 29 anos" 
		n_faixa_etaria4 "30 a 39 anos" 
		n_faixa_etaria5 "40 a 49 anos" 
		n_faixa_etaria6 "50 a 59 anos" 
		n_faixa_etaria7 "> de 60 anos" 
	)
    ;
#delim cr

*restore
restore