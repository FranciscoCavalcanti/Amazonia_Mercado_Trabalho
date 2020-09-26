//////////////////////////////////////////////
//	
//	3) Composição da renda domiciliar per capita
//	
//////////////////////////////////////////////

* call data 
use "$output_dir_build\_programas_sociais_outras_rendas_amazonia_legal.dta", clear
gen id = "Amazônia Legal"

* append data
append using "$output_dir_build\_programas_sociais_outras_rendas_resto_brasil.dta"
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
keep if Ano == "2019"

* select variables
ds renda_* 
local type `r(varlist)'
display "`type'"

collapse (mean) `type', by(Ano id2 id)

* edit new groups of variables
gen renda_programas = renda_ajuda_gov + renda_seguro_desemp
gen renda_diversos = renda_outro + renda_doacao + renda_aluguel

forvalues num = 1(1)5 {
	gen renda_programasq`num' = renda_ajuda_govq`num' + renda_seguro_desempq`num'
	gen renda_diversosq`num' = renda_outroq`num' + renda_doacaoq`num' + renda_aluguelq`num'
}

