/*
O propostio desse do file é:
Descrever a matriz de transições de posição na ocupação para cada trimestre

Referência está nas Tabelas 6 e 7 do trabalho:
Sobre o painel da Pesquisa Mensal de Emprego (PME) do IBGE
Ribas, Rafael Perez and Soares, Sergei Suarez Dillon
2008
*/

* collapse everything
collapse (sum) n_*

* Definitions regarding the position of the indiviual in PREVIOUS period
* Vertical axis in the Table 6 (Ribas Soares, 2008)
* tem_var_y
local tem_var_y inativa desempregado formal informal empregadoSC empregadoCC cpropria cpropriaC cpropriaNc empregador militar

* Definitions regarding the position of the indiviual in ACTUAL period
* Horizontal axis in the Table 6 (Ribas Soares, 2008)
* tem_var_x
local tem_var_x inativa desempregado formal informal empregadoSC empregadoCC cpropria cpropriaC cpropriaNc empregador militar

* compute the share of tem_var_y that are tem_var_x in the next quarter
foreach yy in `tem_var_y' {	
foreach xx in `tem_var_x' {	
	gen sh_`yy'_sh_`xx' = ((n_`yy'_n_`xx') / (n_`yy'))*100
	label variable sh_`yy'_sh_`xx' /* 	
	*/ 	"Risco de transição entre `yy' para `xx' (%)"	
	
}	
}

* label variables
* label variables
label variable sh_empregadoSC_sh_inativa "Risco de transição entre empregados sem carteira para inativos (%)"	
label variable sh_empregadoSC_sh_desempregado "Risco de transição entre empregados sem carteira para desempregados (%)"
label variable sh_empregadoSC_sh_empregadoSC "Risco de transição entre empregados sem carteira para empregados sem carteira (%)"
label variable sh_empregadoSC_sh_empregadoCC "Risco de transição entre empregados sem carteira para empregados com carteira (%)"
label variable sh_empregadoSC_sh_cpropria "Risco de transição entre empregados sem carteira para conta própria (%)"
label variable sh_empregadoSC_sh_empregador "Risco de transição entre empregados sem carteira para empregadores (%)"
label variable sh_empregadoSC_sh_militar "Risco de transição entre empregados sem carteira para militares/servidor estatutários (%)"
 
label variable sh_empregadoCC_sh_inativa "Risco de transição entre empregados com carteira para inativos (%)"
label variable sh_empregadoCC_sh_desempregado "Risco de transição entre empregados com carteira para desempregados (%)"
label variable sh_empregadoCC_sh_empregadoSC "Risco de transição entre empregados com carteira para empregados sem carteira (%)"
label variable sh_empregadoCC_sh_empregadoCC "Risco de transição entre empregados com carteira para empregados com carteira (%)"
label variable sh_empregadoCC_sh_cpropria "Risco de transição entre empregados com carteira para conta própria (%)"
label variable sh_empregadoCC_sh_empregador "Risco de transição entre empregados com carteira para empregadores (%)"
label variable sh_empregadoCC_sh_militar "Risco de transição entre empregados com carteira para militares/servidor estatutários (%)"
 
label variable sh_cpropria_sh_inativa "Risco de transição entre conta própria para inativos (%)"
label variable sh_cpropria_sh_desempregado "Risco de transição entre conta própria para desempregados (%)"
label variable sh_cpropria_sh_empregadoSC "Risco de transição entre conta própria para empregados sem carteira (%)"
label variable sh_cpropria_sh_empregadoCC "Risco de transição entre conta própria para empregados com carteira (%)"
label variable sh_cpropria_sh_cpropria "Risco de transição entre conta própria para conta própria (%)"
label variable sh_cpropria_sh_empregador "Risco de transição entre conta própria para empregadores (%)"
label variable sh_cpropria_sh_militar "Risco de transição entre conta própria para militares/servidor estatutários (%)"
 
label variable sh_empregador_sh_inativa "Risco de transição entre empregadores para inativos (%)"
label variable sh_empregador_sh_desempregado "Risco de transição entre empregadores para desempregados (%)"
label variable sh_empregador_sh_empregadoSC "Risco de transição entre empregadores para empregados sem carteira (%)"
label variable sh_empregador_sh_empregadoCC "Risco de transição entre empregadores para empregados com carteira (%)"
label variable sh_empregador_sh_cpropria "Risco de transição entre empregadores para conta própria (%)"
label variable sh_empregador_sh_empregador "Risco de transição entre empregadores para empregadores (%)"
label variable sh_empregador_sh_militar "Risco de transição entre empregadores para militares/servidor estatutários (%)"
 
label variable sh_militar_sh_inativa "Risco de transição entre militares/servidor estatutários para inativos (%)"
label variable sh_militar_sh_desempregado "Risco de transição entre militares/servidor estatutários para desempregados (%)"
label variable sh_militar_sh_empregadoSC "Risco de transição entre militares/servidor estatutários para empregados sem carteira (%)"
label variable sh_militar_sh_empregadoCC "Risco de transição entre militares/servidor estatutários para empregados com carteira (%)"
label variable sh_militar_sh_cpropria "Risco de transição entre militares/servidor estatutários para conta própria (%)"
label variable sh_militar_sh_empregador "Risco de transição entre militares/servidor estatutários para empregadores (%)"
label variable sh_militar_sh_militar "Risco de transição entre militares/servidor estatutários para militares/servidor estatutários (%)"

* keep relevant variables
keep sh_*


