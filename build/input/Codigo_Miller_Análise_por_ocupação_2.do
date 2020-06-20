     //////     ANÁLISE POR OCUPAÇÃO (VD4009)    //////


	///   RJ   ///
	 
	 
//// PESO DE CADA OCUPAÇÃO NA FORÇA OCUPADA TOTAL E RESPECTIVA INFORMALIDADE ////

gen RJ =.

* Forca ocupada
gen iten = 1 * V1028 if VD4002 == 1 & Capital == 33
egen forca_ocup_rj = total(iten)
label var forca_ocup_rj "nome dela"
drop iten



///// PESO PRIVADO (VD4009 == 1 OU 2) /////

*Trabalhadores no setor privado com carteira assinada
gen priv_com =.
replace priv_com = 1 if VD4009 == 1 
replace priv_com = 0 if priv_com ==.
gen iten = priv_com * V1028 if Capital == 33
egen privado_com_carteira_rj = total(iten)
drop iten

**Trabalhadores no setor privado sem carteira assinada
gen priv_sem =.
replace priv_sem = 1 if VD4009 == 2
replace priv_sem = 0 if priv_sem ==.
gen iten = priv_sem * V1028 if Capital == 33
egen privado_sem_carteira_rj = total(iten)
drop iten

***Total de Trabalhadores privados
gen privado_total_rj = privado_com_carteira_rj + privado_sem_carteira_rj

* Peso do Setor Privado na Força de Trabalho 
gen Peso_privado_rj = (privado_total_rj/forca_ocup_rj)*100

* Informalidade no setor privado
gen privado_informalidade_rj = (privado_sem_carteira_rj/privado_total_rj)*100



///// PESO DOMÉSTICO (VD4009 == 3 OU 4) /////

*Trabalhadores domésticos com carteira assinada
gen domest_com =.
replace domest_com = 1 if VD4009 == 3
replace domest_com = 0 if domest_com ==.
gen iten = domest_com * V1028 if Capital == 33
egen domest_com_carteira_rj = total(iten)
drop iten

**Trabalhadores domésticos sem carteira assinada
gen domest_sem =.
replace domest_sem = 1 if VD4009 == 4
replace domest_sem = 0 if domest_sem ==.
gen iten = domest_sem * V1028 if Capital == 33
egen domest_sem_carteira_rj = total(iten)
drop iten

***Total de Trabalhadores domésticos
gen domest_total_rj = domest_com_carteira_rj + domest_sem_carteira_rj

* Peso doméstico na Força de Trabalho 
gen Peso_domest_rj = (domest_total_rj/forca_ocup_rj)*100

* Informalidade no setor doméstico
gen domest_informalidade_rj = (domest_sem_carteira_rj/domest_total_rj)*100


///// PESO PÚBLICO (VD4009 == 5 OU 6) /////

*Trabalhadores no setor público com carteira assinada
gen publ_com =.
replace publ_com = 1 if VD4009 == 5
replace publ_com = 0 if publ_com ==.
gen iten = publ_com * V1028 if Capital == 33
egen publico_com_carteira_rj = total(iten)
drop iten

**Trabalhadores no setor público sem carteira assinada
gen publ_sem =.
replace publ_sem = 1 if VD4009 == 6
replace publ_sem = 0 if publ_sem ==.
gen iten = publ_sem * V1028 if Capital == 33
egen publico_sem_carteira_rj = total(iten)
drop iten

***Total de Trabalhadores públicos
gen publico_total_rj = publico_com_carteira_rj + publico_sem_carteira_rj

* Peso do Setor Público na Força de Trabalho 
gen Peso_público_rj = (publico_total_rj/forca_ocup_rj)*100

* Informalidade no setor público
gen publico_informalidade_rj = (publico_sem_carteira_rj/publico_total_rj)*100



///// PESO MILITARES E ESTATUÁRIOS (VD4009 == 7) /////

gen milit_estat =.
replace milit_estat = 1 if VD4009 == 7
replace milit_estat = 0 if milit_estat ==.
gen iten = milit_estat * V1028 if Capital == 33
egen militar_estatutário_rj = total(iten)
drop iten

* Peso do Setor Privado na Força de Trabalho 
gen Peso_milit_estat_rj = (militar_estatutário_rj/forca_ocup_rj)*100


///// PESO CONTA-PRÓPRIA (VD4009 == 9) /////

gen contap =.
replace contap = 1 if VD4009 == 9 & VD4012 == 1
replace contap = 0 if contap ==.
gen iten = contap * V1028 if Capital == 33
egen conta_própria_formal_rj = total(iten)
drop iten

gen contap_sem =.
replace contap_sem = 1 if VD4009 == 9 & VD4012 == 2
replace contap_sem = 0 if contap_sem ==.
gen iten = contap_sem * V1028 if Capital == 33
egen conta_própria_informal_rj = total(iten)
drop iten

***Total de Trabalhadores autonômos
gen conta_própria_total_rj = conta_própria_formal_rj + conta_própria_informal_rj

* Peso conta própria na Força de Trabalho
gen Peso_contap_rj = (conta_própria_total_rj/forca_ocup_rj)*100

* Informalidade no setor privado
gen contap_informalidade_rj = (conta_própria_informal_rj/conta_própria_total_rj)*100



///// PESO TRABALHADOR FAMILIAR AUXILIAR (VD4009 == 10) /////

gen fam_aux =.
replace fam_aux = 1 if VD4009 == 10
replace fam_aux = 0 if contap ==.
gen iten = fam_aux * V1028 if Capital == 33
egen familiar_auxiliar_rj = total(iten)
drop iten

* Peso conta própria na Força de Trabalho
gen Peso_fam_aux_rj = (familiar_auxiliar_rj/forca_ocup_rj)*100

*
*
*

/// AGREGAREMOS OS EMPREGADOS PRIVADOS, DOMÉSTICOS E PÚBLICOS COM CARTEIRA EM EMPREGADOS COM CARTEIRA
/// E OS EMPREGADOS PRIVADOS, DOMÉSTICOS E PÚBLICOS SEM CARTEIRA EM EMPREGADOS SEM CARTEIRA
/// ALÉM DISSO, EXCLUIREMOS OS EMPREGADORES DA POP OCUPADA TOTAL

*força ocupada sem empregadores
gen iten = 1 * V1028 if VD4002 == 1 & VD4009 != 8 & Capital == 33
egen forca_empregada_rj = total(iten)
label var forca_empregada_rj "ocupados menos empregadores"
drop iten

gen empregados_com_carteira_rj = privado_com_carteira_rj + domest_com_carteira_rj + publico_com_carteira_rj
gen peso_empregados_cc_rj = (empregados_com_carteira_rj/forca_empregada_rj)*100

gen empregados_sem_carteira_rj = privado_sem_carteira_rj + domest_sem_carteira_rj + publico_sem_carteira_rj + familiar_auxiliar_rj
gen peso_empregados_sc_rj = (empregados_sem_carteira_rj/forca_empregada_rj)*100

gen peso_contapf_rj =(conta_própria_formal_rj/forca_empregada_rj)*100
gen peso_contapi_rj =(conta_própria_informal_rj/forca_empregada_rj)*100

gen peso_militestat_rj = (militar_estatutário_rj/forca_empregada_rj)*100

gen peso_famaux_rj = (familiar_auxiliar_rj/forca_empregada_rj)*100

gen informalidade_empregados_rj = (empregados_sem_carteira_rj/(empregados_sem_carteira_rj + empregados_com_carteira_rj))*100




	///   BR   ///
	 
	 
//// PESO DE CADA OCUPAÇÃO NA FORÇA OCUPADA TOTAL E RESPECTIVA INFORMALIDADE ////

gen BR =.

* Forca ocupada
gen iten = 1 * V1028 if VD4002 == 1 
egen forca_ocup_br = total(iten)
label var forca_ocup_br "nome dela"
drop iten



///// PESO PRIVADO (VD4009 == 1 OU 2) /////

*Trabalhadores no setor privado com carteira assinada
gen iten = priv_com * V1028 
egen privado_com_carteira_br = total(iten)
drop iten

**Trabalhadores no setor privado sem carteira assinada
gen iten = priv_sem * V1028
egen privado_sem_carteira_br = total(iten)
drop iten

***Total de Trabalhadores privados
gen privado_total_br = privado_com_carteira_br + privado_sem_carteira_br

* Peso do Setor Privado na Força de Trabalho 
gen Peso_privado_br = (privado_total_br/forca_ocup_br)*100

* Informalidade no setor privado
gen privado_informalidade_br = (privado_sem_carteira_br/privado_total_br)*100



///// PESO DOMÉSTICO (VD4009 == 3 OU 4) /////

*Trabalhadores domésticos com carteira assinada
gen iten = domest_com * V1028
egen domest_com_carteira_br = total(iten)
drop iten

**Trabalhadores domésticos sem carteira assinada
gen iten = domest_sem * V1028
egen domest_sem_carteira_br = total(iten)
drop iten

***Total de Trabalhadores domésticos
gen domest_total_br = domest_com_carteira_br + domest_sem_carteira_br

* Peso doméstico na Força de Trabalho 
gen Peso_domest_br = (domest_total_br/forca_ocup_br)*100

* Informalidade no setor doméstico
gen domest_informalidade_br = (domest_sem_carteira_br/domest_total_br)*100


///// PESO PÚBLICO (VD4009 == 5 OU 6) /////

*Trabalhadores no setor público com carteira assinada
gen iten = publ_com * V1028
egen publico_com_carteira_br = total(iten)
drop iten

**Trabalhadores no setor público sem carteira assinada
gen iten = publ_sem * V1028 
egen publico_sem_carteira_br = total(iten)
drop iten

***Total de Trabalhadores públicos
gen publico_total_br = publico_com_carteira_br + publico_sem_carteira_br

* Peso do Setor Público na Força de Trabalho 
gen Peso_público_br = (publico_total_br/forca_ocup_br)*100

* Informalidade no setor público
gen publico_informalidade_br = (publico_sem_carteira_br/publico_total_br)*100



///// PESO MILITARES E ESTATUÁRIOS (VD4009 == 7) /////
gen iten = milit_estat * V1028
egen militar_estatutário_br = total(iten)
drop iten

* Peso do Setor Privado na Força de Trabalho 
gen Peso_milit_estat_br = (militar_estatutário_br/forca_ocup_br)*100



///// PESO CONTA-PRÓPRIA (VD4009 == 9) /////

gen iten = contap * V1028
egen conta_própria_formal_br = total(iten)
drop iten

gen iten = contap_sem * V1028
egen conta_própria_informal_br = total(iten)
drop iten

***Total de Trabalhadores autonômos
gen conta_própria_total_br = conta_própria_formal_br + conta_própria_informal_br

* Peso conta própria na Força de Trabalho
gen Peso_contap_br = (conta_própria_total_br/forca_ocup_br)*100

* Informalidade no setor privado
gen contap_informalidade_br = (conta_própria_informal_br/conta_própria_total_br)*100



///// PESO TRABALHADOR FAMILIAR AUXILIAR (VD4009 == 10) /////

gen iten = fam_aux * V1028
egen familiar_auxiliar_br = total(iten)
drop iten

* Peso conta própria na Força de Trabalho
gen Peso_fam_aux_br = (familiar_auxiliar_br/forca_ocup_br)*100

*
*
*

/// AGREGAREMOS OS EMPREGADOS PRIVADOS, DOMÉSTICOS E PÚBLICOS COM CARTEIRA EM EMPREGADOS COM CARTEIRA
/// E OS EMPREGADOS PRIVADOS, DOMÉSTICOS E PÚBLICOS SEM CARTEIRA EM EMPREGADOS SEM CARTEIRA
/// ALÉM DISSO, EXCLUIREMOS OS EMPREGADORES DA POP OCUPADA TOTAL

*força ocupada sem empregadores
gen iten = 1 * V1028 if VD4002 == 1 & VD4009 != 8
egen forca_empregada_br = total(iten)
label var forca_empregada_br "ocupados menos empregadores - BR"
drop iten

gen empregados_com_carteira_br = privado_com_carteira_br + domest_com_carteira_br + publico_com_carteira_br
gen peso_empregados_cc_br = (empregados_com_carteira_br/forca_empregada_br)*100

gen empregados_sem_carteira_br = privado_sem_carteira_br + domest_sem_carteira_br + publico_sem_carteira_br + familiar_auxiliar_br
gen peso_empregados_sc_br = (empregados_sem_carteira_br/forca_empregada_br)*100

gen peso_contapf_br =(conta_própria_formal_br/forca_empregada_br)*100
gen peso_contapi_br =(conta_própria_informal_br/forca_empregada_br)*100

gen peso_militestat_br = (militar_estatutário_br/forca_empregada_br)*100

gen peso_famaux_br = (familiar_auxiliar_br/forca_empregada_br)*100

gen informalidade_empregados_br = (empregados_sem_carteira_br/(empregados_sem_carteira_br + empregados_com_carteira_br))*100


* Colapsar

collapse (mean) RJ forca_ocup_rj privado_com_carteira_rj privado_sem_carteira_rj privado_total_rj privado_informalidade_rj /*
*/ domest_com_carteira_rj domest_sem_carteira_rj domest_total_rj domest_informalidade_rj publico_com_carteira_rj publico_sem_carteira_rj /*
*/ publico_total_rj publico_informalidade_rj militar_estatutário_rj /*
*/ conta_própria_formal_rj conta_própria_informal_rj conta_própria_total_rj contap_informalidade_rj familiar_auxiliar_rj /*
*/ Peso_privado_rj Peso_domest_rj Peso_público_rj Peso_milit_estat_rj Peso_contap_rj Peso_fam_aux_rj peso_empregados_cc_rj /*
*/ peso_empregados_sc_rj peso_contapf_rj peso_contapi_rj peso_militestat_rj peso_famaux_rj informalidade_empregados_rj BR forca_ocup_br privado_com_carteira_br privado_sem_carteira_br /*
*/ privado_total_br privado_informalidade_br domest_com_carteira_br domest_sem_carteira_br domest_total_br domest_informalidade_br publico_com_carteira_br /*
*/ publico_sem_carteira_br publico_total_br publico_informalidade_br militar_estatutário_br /*
*/ conta_própria_formal_br conta_própria_informal_br conta_própria_total_br contap_informalidade_br familiar_auxiliar_br /*
*/ Peso_privado_br Peso_domest_br Peso_público_br Peso_milit_estat_br Peso_contap_br Peso_fam_aux_br peso_empregados_cc_br /*
*/ peso_empregados_sc_br peso_contapf_br peso_contapi_br peso_militestat_br peso_famaux_br informalidade_empregados_br, by(Trimestre)
