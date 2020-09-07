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
local tem_var_y inativa desempregado formal informal empregadoSC empregadoCC cpropria cpropriaC cpropriaNc empregador militar desalento nemnem

* Definitions regarding the position of the indiviual in ACTUAL period
* Horizontal axis in the Table 6 (Ribas Soares, 2008)
* tem_var_x
local tem_var_x inativa desempregado formal informal empregadoSC empregadoCC cpropria cpropriaC cpropriaNc empregador militar desalento nemnem

* compute the share of tem_var_y that are tem_var_x in the next quarter
foreach yy in `tem_var_y' {	
foreach xx in `tem_var_x' {	
	gen sh_`yy'_sh_`xx' = ((n_`yy'_n_`xx') / (n_`yy'))*100
	cap label variable sh_`yy'_sh_`xx' /* 	
	*/ 	"Transição anual de `yy' para `xx' (%)"		
	
}	
}

* cap label variables
cap label variable sh_empregadoSC_sh_inativa "Transição anual de empregados sem carteira para inativos (%)"	
cap label variable sh_empregadoSC_sh_formal "Transição anual de empregados sem carteira para formal (%)"	
cap label variable sh_empregadoSC_sh_informal "Transição anual de empregados sem carteira para informal (%)"	
cap label variable sh_empregadoSC_sh_desempregado "Transição anual de empregados sem carteira para desempregados (%)"
cap label variable sh_empregadoSC_sh_empregadoSC "Transição anual de empregados sem carteira para empregados sem carteira (%)"
cap label variable sh_empregadoSC_sh_empregadoCC "Transição anual de empregados sem carteira para empregados com carteira (%)"
cap label variable sh_empregadoSC_sh_cpropria "Transição anual de empregados sem carteira para conta própria (%)"
cap label variable sh_empregadoSC_sh_empregador "Transição anual de empregados sem carteira para empregadores (%)"
cap label variable sh_empregadoSC_sh_militar "Transição anual de empregados sem carteira para servidores públicos (%)"
cap label variable sh_empregadoSC_sh_desalento "Transição anual de empregados sem carteira para desalentados (%)"
cap label variable sh_empregadoSC_sh_nemnem "Transição anual de empregados sem carteira para nem-nem (%)"
 
cap label variable sh_empregadoCC_sh_inativa "Transição anual de empregados com carteira para inativos (%)"
cap label variable sh_empregadoCC_sh_formal "Transição anual de empregados com carteira para formal (%)"	
cap label variable sh_empregadoCC_sh_informal "Transição anual de empregados com carteira para informal (%)"	
cap label variable sh_empregadoCC_sh_desempregado "Transição anual de empregados com carteira para desempregados (%)"
cap label variable sh_empregadoCC_sh_empregadoSC "Transição anual de empregados com carteira para empregados sem carteira (%)"
cap label variable sh_empregadoCC_sh_empregadoCC "Transição anual de empregados com carteira para empregados com carteira (%)"
cap label variable sh_empregadoCC_sh_cpropria "Transição anual de empregados com carteira para conta própria (%)"
cap label variable sh_empregadoCC_sh_empregador "Transição anual de empregados com carteira para empregadores (%)"
cap label variable sh_empregadoCC_sh_militar "Transição anual de empregados com carteira para servidores públicos (%)"
cap label variable sh_empregadoCC_sh_desalento "Transição anual de empregados com carteira para desalentados (%)"
cap label variable sh_empregadoCC_sh_nemnem "Transição anual de empregados com carteira para nem-nem (%)"

cap label variable sh_cpropria_sh_inativa "Transição anual de conta própria para inativos (%)"
cap label variable sh_cpropria_sh_formal "Transição anual de conta própria para formal (%)"	
cap label variable sh_cpropria_sh_informal "Transição anual de conta própria para informal (%)"	
cap label variable sh_cpropria_sh_desempregado "Transição anual de conta própria para desempregados (%)"
cap label variable sh_cpropria_sh_empregadoSC "Transição anual de conta própria para empregados sem carteira (%)"
cap label variable sh_cpropria_sh_empregadoCC "Transição anual de conta própria para empregados com carteira (%)"
cap label variable sh_cpropria_sh_cpropria "Transição anual de conta própria para conta própria (%)"
cap label variable sh_cpropria_sh_empregador "Transição anual de conta própria para empregadores (%)"
cap label variable sh_cpropria_sh_militar "Transição anual de conta própria para servidores públicos (%)"
cap label variable sh_cpropria_sh_desalento "Transição anual de conta própria para desalentados (%)"
cap label variable sh_cpropria_sh_nemnem "Transição anual de conta própria para nem-nem (%)"

cap label variable sh_empregador_sh_inativa "Transição anual de empregadores para inativos (%)"
cap label variable sh_empregador_sh_formal "Transição anual de empregadores para formal (%)"	
cap label variable sh_empregador_sh_informal "Transição anual de empregadores para informal (%)"	
cap label variable sh_empregador_sh_desempregado "Transição anual de empregadores para desempregados (%)"
cap label variable sh_empregador_sh_empregadoSC "Transição anual de empregadores para empregados sem carteira (%)"
cap label variable sh_empregador_sh_empregadoCC "Transição anual de empregadores para empregados com carteira (%)"
cap label variable sh_empregador_sh_cpropria "Transição anual de empregadores para conta própria (%)"
cap label variable sh_empregador_sh_empregador "Transição anual de empregadores para empregadores (%)"
cap label variable sh_empregador_sh_militar "Transição anual de empregadores para servidores públicos (%)"
cap label variable sh_empregador_sh_desalento "Transição anual de empregadores para desalentados (%)"
cap label variable sh_empregador_sh_nemnem "Transição anual de empregadores para nem-nem (%)"
 
cap label variable sh_militar_sh_inativa "Transição anual de servidores públicos para inativos (%)"
cap label variable sh_militar_sh_formal "Transição anual de servidores públicos para formal (%)"	
cap label variable sh_militar_sh_informal "Transição anual de servidores públicos para informal (%)"	
cap label variable sh_militar_sh_desempregado "Transição anual de servidores públicos para desempregados (%)"
cap label variable sh_militar_sh_empregadoSC "Transição anual de servidores públicos para empregados sem carteira (%)"
cap label variable sh_militar_sh_empregadoCC "Transição anual de servidores públicos para empregados com carteira (%)"
cap label variable sh_militar_sh_cpropria "Transição anual de servidores públicos para conta própria (%)"
cap label variable sh_militar_sh_empregador "Transição anual de servidores públicos para empregadores (%)"
cap label variable sh_militar_sh_militar "Transição anual de servidores públicos para servidores públicos (%)"
cap label variable sh_militar_sh_desalento "Transição anual servidores públicos para desalentados (%)"
cap label variable sh_militar_sh_nemnem "Transição anual de servidores públicos para nem-nem (%)"

cap label variable sh_desalento_sh_inativa "Transição anual de desalentados para inativos (%)"
cap label variable sh_desalento_sh_formal "Transição anual de desalentados para formal (%)"	
cap label variable sh_desalento_sh_informal "Transição anual de desalentados para informal (%)"	
cap label variable sh_desalento_sh_desempregado "Transição anual de desalentados para desempregados (%)"
cap label variable sh_desalento_sh_empregadoSC "Transição anual de desalentados para empregados sem carteira (%)"
cap label variable sh_desalento_sh_empregadoCC "Transição anual de desalentados para empregados com carteira (%)"
cap label variable sh_desalento_sh_cpropria "Transição anual de desalentados para conta própria (%)"
cap label variable sh_desalento_sh_empregador "Transição anual de desalentados para empregadores (%)"
cap label variable sh_desalento_sh_militar "Transição anual de desalentados para servidores públicos (%)"
cap label variable sh_desalento_sh_desalento "Transição anual de desalentados para desalentados (%)"
cap label variable sh_desalento_sh_nemnem "Transição anual de desalentados para nem-nem (%)"
 

cap label variable sh_nemnem_sh_inativa "Transição anual de nem-nem para inativos (%)"
cap label variable sh_nemnem_sh_formal "Transição anual de nem-nem para formal (%)"	
cap label variable sh_nemnem_sh_informal "Transição anual de nem-nem para informal (%)"	
cap label variable sh_nemnem_sh_desempregado "Transição anual de nem-nem para desempregados (%)"
cap label variable sh_nemnem_sh_empregadoSC "Transição anual de nem-nem para empregados sem carteira (%)"
cap label variable sh_nemnem_sh_empregadoCC "Transição anual de nem-nem para empregados com carteira (%)"
cap label variable sh_nemnem_sh_cpropria "Transição anual de nem-nem para conta própria (%)"
cap label variable sh_nemnem_sh_empregador "Transição anual de nem-nem para empregadores (%)"
cap label variable sh_nemnem_sh_militar "Transição anual de nem-nem para servidores públicos (%)"
cap label variable sh_nemnem_sh_desalento "Transição anual de nem-nem para desalentados (%)"
cap label variable sh_nemnem_sh_nemnem "Transição anual de nem-nem para nem-nem (%)"
 
* keep relevant variables
keep Ano Trimestre sh_*
sort Ano Trimestre 
order Ano Trimestre 

