/*
O propostio desse do file é:
Descrever a matriz de transições de posição na ocupação para cada trimestre

Referência está nas Tabelas 6 e 7 do trabalho:
Sobre o painel da Pesquisa Mensal de Emprego (PME) do IBGE
Ribas, Rafael Perez and Soares, Sergei Suarez Dillon
2008
*/

* collapse at quarter level
collapse (sum) n_*, by(Ano Trimestre)

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
	*/ 	"Transição trimestral de `yy' para `xx' (%)"		
	
}	
}

* label variables
label variable sh_empregadoSC_sh_inativa "Transição trimestral de empregados sem carteira para inativos (%)"	
label variable sh_empregadoSC_sh_desempregado "Transição trimestral de empregados sem carteira para desempregados (%)"
label variable sh_empregadoSC_sh_empregadoSC "Transição trimestral de empregados sem carteira para empregados sem carteira (%)"
label variable sh_empregadoSC_sh_empregadoCC "Transição trimestral de empregados sem carteira para empregados com carteira (%)"
label variable sh_empregadoSC_sh_cpropria "Transição trimestral de empregados sem carteira para conta própria (%)"
label variable sh_empregadoSC_sh_empregador "Transição trimestral de empregados sem carteira para empregadores (%)"
label variable sh_empregadoSC_sh_militar "Transição trimestral de empregados sem carteira para servidores públicos (%)"
 
label variable sh_empregadoCC_sh_inativa "Transição trimestral de empregados com carteira para inativos (%)"
label variable sh_empregadoCC_sh_desempregado "Transição trimestral de empregados com carteira para desempregados (%)"
label variable sh_empregadoCC_sh_empregadoSC "Transição trimestral de empregados com carteira para empregados sem carteira (%)"
label variable sh_empregadoCC_sh_empregadoCC "Transição trimestral de empregados com carteira para empregados com carteira (%)"
label variable sh_empregadoCC_sh_cpropria "Transição trimestral de empregados com carteira para conta própria (%)"
label variable sh_empregadoCC_sh_empregador "Transição trimestral de empregados com carteira para empregadores (%)"
label variable sh_empregadoCC_sh_militar "Transição trimestral de empregados com carteira para servidores públicos (%)"
 
label variable sh_cpropria_sh_inativa "Transição trimestral de conta própria com carteira para inativos (%)"
label variable sh_cpropria_sh_desempregado "Transição trimestral de conta própria com carteira para desempregados (%)"
label variable sh_cpropria_sh_empregadoSC "Transição trimestral de conta própria com carteira para empregados sem carteira (%)"
label variable sh_cpropria_sh_empregadoCC "Transição trimestral de conta própria com carteira para empregados com carteira (%)"
label variable sh_cpropria_sh_cpropria "Transição trimestral de conta própria com carteira para conta própria (%)"
label variable sh_cpropria_sh_empregador "Transição trimestral de conta própria com carteira para empregadores (%)"
label variable sh_cpropria_sh_militar "Transição trimestral de conta própria com carteira para servidores públicos (%)"
 
label variable sh_empregador_sh_inativa "Transição trimestral de empregadores para inativos (%)"
label variable sh_empregador_sh_desempregado "Transição trimestral de empregadores para desempregados (%)"
label variable sh_empregador_sh_empregadoSC "Transição trimestral de empregadores para empregados sem carteira (%)"
label variable sh_empregador_sh_empregadoCC "Transição trimestral de empregadores para empregados com carteira (%)"
label variable sh_empregador_sh_cpropria "Transição trimestral de empregadores para conta própria (%)"
label variable sh_empregador_sh_empregador "Transição trimestral de empregadores para empregadores (%)"
label variable sh_empregador_sh_militar "Transição trimestral de empregadores para servidores públicos (%)"
 
label variable sh_militar_sh_inativa "Transição trimestral de servidores públicos para inativos (%)"
label variable sh_militar_sh_desempregado "Transição trimestral de servidores públicos para desempregados (%)"
label variable sh_militar_sh_empregadoSC "Transição trimestral de servidores públicos para empregados sem carteira (%)"
label variable sh_militar_sh_empregadoCC "Transição trimestral de servidores públicos para empregados com carteira (%)"
label variable sh_militar_sh_cpropria "Transição trimestral de servidores públicos para conta própria (%)"
label variable sh_militar_sh_empregador "Transição trimestral de servidores públicos para empregadores (%)"
label variable sh_militar_sh_militar "Transição trimestral de servidores públicos para servidores públicos (%)"

* keep relevant variables
keep Ano Trimestre sh_*
sort Ano Trimestre 
order Ano Trimestre 

