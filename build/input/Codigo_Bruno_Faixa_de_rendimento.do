drop if V2009 < 18
drop if V2009 > 64

gen aa =.
replace aa = 1 if V403311 == 1
replace aa = 0 if aa ==.
gen bb =.
replace bb = 1 if V403311 == 2
replace bb = 0 if bb ==.
gen ccc =.
replace ccc = 1 if V403311 == 3
replace ccc = 0 if ccc ==.
gen dd =.
replace dd = 1 if V403311 == 4
replace dd = 0 if dd ==.
gen ee =.
replace ee = 1 if V403311 == 5
replace ee = 0 if ee ==.
gen ff =.
replace ff = 1 if V403311 == 6
replace ff = 0 if ff ==.
gen gg =.
replace gg = 1 if V403311 == 7
replace gg = 0 if gg ==.
gen hh =.
replace hh = 1 if V403311 == 8
replace hh = 0 if hh ==.

gen iten = aa * V1028
egen forca_a = total(iten)
label var forca_a "ate meio SM"
drop iten

gen iten = bb * V1028
egen forca_b = total(iten)
label var forca_b "de meio a 1 SM"
drop iten

gen iten = ccc * V1028
egen forca_c = total(iten)
label var forca_c "de 1 a 2 SM"
drop iten

gen iten = dd * V1028
egen forca_d = total(iten)
label var forca_d "de 2 a 3 SM"
drop iten

gen iten = ee * V1028
egen forca_e = total(iten)
label var forca_e "de 3 a 5 SM"
drop iten

gen iten = ff * V1028
egen forca_f = total(iten)
label var forca_f "de 5 a 10 SM"
drop iten

gen iten = gg * V1028
egen forca_g = total(iten)
label var forca_g "de 10 a 20 SM"
drop iten

gen iten = hh * V1028
egen forca_h = total(iten)
label var forca_h "mais de 20 SM"
drop iten

gen iten = (aa+bb+ccc+dd+ee+ff+gg+hh) * V1028
egen forca_tot = total(iten)
label var forca_tot "forca tot"
drop iten

gen taxa_a = (forca_a/forca_tot)*100
label var taxa_a "ate meio SM"

gen taxa_b = (forca_b/forca_tot)*100
label var taxa_b "Taxa de meio a 1 SM"

gen taxa_c = (forca_c/forca_tot)*100
label var taxa_c "Taxa de 1 a 2 SM"

gen taxa_d = (forca_d/forca_tot)*100
label var taxa_d "Taxa de 2 a 3 SM"

gen taxa_e = (forca_e/forca_tot)*100
label var taxa_e "Taxa de 3 a 5 SM"

gen taxa_f = (forca_f/forca_tot)*100
label var taxa_f "Taxa de 5 a 10 SM"

gen taxa_g = (forca_g/forca_tot)*100
label var taxa_g "Taxa de 10 a 20 SM"

gen taxa_h = (forca_h/forca_tot)*100
label var taxa_h "Taxa mais de 20 SM"

collapse (mean) taxa_a taxa_b taxa_c taxa_d taxa_e taxa_f taxa_g taxa_h, by(Trimestre)
