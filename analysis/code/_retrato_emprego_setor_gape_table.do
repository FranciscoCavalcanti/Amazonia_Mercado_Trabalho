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
ds n_de_formal_gape_* 
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
local ttitle "Número de total de formal por setor de Serviços - 2019"
local tnotes "Valores correspondem a média entre os trimestres da PNAD Contínua 2019"

#delim ;    
esttab matrix(A, fmt(%16,0fc)) using "$output_dir\retrato_emprego\_retrato_emprego_setor_gape_table.tex", 
	replace 
	booktabs
	collabels("Amazônia Legal" "Resto do Brasil")
    prehead(
        "\begin{table}[H]"
        "\centering"
		"\label{_retrato_emprego_setor_gstr_table}"
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
		n_de_formal_gape_alimentacao "Alojamento e alimentação" 
		n_de_formal_gape_informacao "Informação, comunicação e atividades financeiras"
		n_de_formal_gape_educacao "Educação, saúde e serviços sociais" 
		n_de_formal_gape_outros "Outros Serviços"
		n_de_formal_gape_domestico "Serviços domésticos"
		n_de_formal_gape_transporte "Transporte, armazenagem e correio"
		n_de_formal_gape_publica "Administração pública"
	)
    ;
#delim cr

