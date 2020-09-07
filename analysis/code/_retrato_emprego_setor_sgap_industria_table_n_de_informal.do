//////////////////////////////////////////////
//	
//	Descrever a composição setorial	
//	
//////////////////////////////////////////////
//////////////////////////////////////////
//	Composição setorial	
/////////////////////////////////////////

** call data 
use "$output_dir_build\_retrato_emprego_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_retrato_emprego_resto_brasil.dta"
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


* select variables
ds n_de_informal_sgap_extrativa 	/*
	*/ 	n_de_informal_sgap_trans 	/*
	*/ 	n_de_informal_sgap_energia 	/*
	*/ 	n_de_informal_sgap_agua 
	
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
gsort   -v1 v2

// transforma data em matrix
mkmat v1 v2, matrix(A) rownames(_varname)


* local notes
local ttitle "Número total de \textbf{informal} por setor de Indústria - 2019"
local tnotes "Valores correspondem a média entre os trimestres da PNAD Contínua 2019"

#delim ;    
esttab matrix(A, fmt(%16,0fc)) using "$output_dir\retrato_emprego\_retrato_emprego_setor_spap_industria_table_n_de_informal.tex", 
	replace 
	booktabs
	collabels("Amazônia Legal" "Resto do Brasil")
    prehead(
        "\begin{table}[H]"
        "\centering"
		"\label{_retrato_emprego_setor_spap_industria_table_n_de_informal}"
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
		n_de_informal_sgap_extrativa "Indústrias extrativas" 
		n_de_informal_sgap_trans "Indústrias de transformação"
		n_de_informal_sgap_energia "Eletricidade, gás e outras utilidades" 
		n_de_informal_sgap_agua "Água, esgoto e gestão de resíduos"
	)
    ;
#delim cr

