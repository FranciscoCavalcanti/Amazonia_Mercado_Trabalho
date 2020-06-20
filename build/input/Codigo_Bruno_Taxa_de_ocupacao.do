drop if UF>=20
drop if V2009 < 14
gen pia=1
gen ocupado =.
replace ocupado = 1 if VD4002 == 1
replace ocupado = 0 if ocupado ==.
gen desocupado =.
replace desocupado = 1 if VD4002 == 2
replace desocupado = 0 if desocupado ==.

gen iten = pia * V1028
egen forca_pia = total(iten)
label var forca_pia "forca PIA"
drop iten

gen iten = ocupado * V1028
egen forca_ocupada = total(iten)
label var forca_ocupada "forca ocupada"
drop iten

gen iten = desocupado * V1028
egen forca_desocupada = total(iten)
label var forca_desocupada "forca desocupada"
drop iten

gen taxa_ocupacao = (forca_ocupada/forca_pia)*100
label var taxa_ocupacao "Taxa de ocupacao"


collapse (mean) forca_pia forca_ocupada forca_desocupada taxa_ocupacao, by(Trimestre)
