drop if V2009 < 18
drop if V2009 > 64

gen aa =.
replace aa = 1 if VD3006 == 1
replace aa = 0 if aa ==.
gen bb =.
replace bb = 1 if VD3006 == 2
replace bb = 0 if bb ==.
gen ccc =.
replace ccc = 1 if VD3006 == 3
replace ccc = 0 if ccc ==.
gen dd =.
replace dd = 1 if VD3006 == 4
replace dd = 0 if dd ==.
gen ee =.
replace ee = 1 if VD3006 == 5
replace ee = 0 if ee ==.
gen ff =.
replace ff = 1 if VD3006 == 6
replace ff = 0 if ff ==.

gen iten = aa * V1028
egen forca_men1 = total(iten)
label var forca_men1 "menos de 1 ano"
drop iten

gen iten = bb * V1028
egen forca_d1a4 = total(iten)
label var forca_d1a4 "de 1 a 4"
drop iten

gen iten = ccc * V1028
egen forca_d5a8 = total(iten)
label var forca_d5a8 "de 5 a 8"
drop iten

gen iten = dd * V1028
egen forca_d9a11 = total(iten)
label var forca_d9a11 "de 9 a 11"
drop iten

gen iten = ee * V1028
egen forca_d12a15 = total(iten)
label var forca_d12a15 "de 12 a 15"
drop iten

gen iten = ff * V1028
egen forca_ma16 = total(iten)
label var forca_ma16 "mais de 16"
drop iten

gen iten = (aa+bb+ccc+dd+ee+ff) * V1028
egen forca_tot = total(iten)
label var forca_tot "forca tot"
drop iten

gen taxa_men1 = (forca_men1/forca_tot)*100
label var taxa_men1 "Taxa menos de 1 ano"

gen taxa_d1a4 = (forca_d1a4/forca_tot)*100
label var taxa_d1a4 "Taxa de 1 a 4"

gen taxa_d5a8 = (forca_d5a8/forca_tot)*100
label var taxa_d5a8 "Taxa de 5 a 8"

gen taxa_d9a11 = (forca_d9a11/forca_tot)*100
label var taxa_d9a11 "Taxa de 9 a 11"

gen taxa_d12a15 = (forca_d12a15/forca_tot)*100
label var taxa_d12a15 "Taxa de 12 a 15"

gen taxa_ma16 = (forca_ma16/forca_tot)*100
label var taxa_ma16 "Taxa mais de 16"

collapse (mean) taxa_men1 taxa_d1a4 taxa_d5a8 taxa_d9a11 taxa_d12a15 taxa_ma16, by(Trimestre)
