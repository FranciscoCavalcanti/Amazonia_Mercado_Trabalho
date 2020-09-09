//////////////////////////////////////////////
//	
//	4) Matriz de transições de ocupações
//	
//////////////////////////////////////////////

* call data 
use "$output_dir_build\_transicao_ocupacao_amazonia_legal_matriz_anual.dta", clear
gen id = "Amazônia Legal"

*append data
append using "$output_dir_build\_transicao_ocupacao_resto_brasil_matriz_anual.dta"
replace id = "Resto do Brasil" if id==""
	
* edit format
encode id, generate(id2)

* select variables
ds sh_desempregado_sh_inativa sh_desempregado_sh_formal sh_formal_sh_informal sh_formal_sh_desempregado sh_informal_sh_desempregado sh_informal_sh_formal
	
local type `r(varlist)'
display "`type'"

*collapse (mean) "`type'", by(id2 id) 
* reshape data
*reshape long sh_desempregado@ sh_informal@ sh_formal@, i(id2) j(@sh_desepregado)

xpose, clear varname
