/// CÁLCULO DA TAXA DE INFORMALIDADE

* Regiao Norte
drop if UF>=20

* A amostra utilizada considera apenas a população ocupada de 18 a 64 anos de idade
* V2009 = idade
drop if V2009 < 18
drop if V2009 > 64

gen A = 0 
replace A = 1 if V4013 == 01101 
replace A = 1 if V4013 == 01102 
replace A = 1 if V4013 == 01103 
replace A = 1 if V4013 == 01104 
replace A = 1 if V4013 == 01105 
replace A = 1 if V4013 == 01106 
replace A = 1 if V4013 == 01107 
replace A = 1 if V4013 == 01108 
replace A = 1 if V4013 == 01109 
replace A = 1 if V4013 == 01110 
replace A = 1 if V4013 == 01111 
replace A = 1 if V4013 == 01112 
replace A = 1 if V4013 == 01113 
replace A = 1 if V4013 == 01114 
replace A = 1 if V4013 == 01115 
replace A = 1 if V4013 == 01116 
replace A = 1 if V4013 == 01117 
replace A = 1 if V4013 == 01118 
replace A = 1 if V4013 == 01119 
replace A = 1 if V4013 == 01201 
replace A = 1 if V4013 == 01202 
replace A = 1 if V4013 == 01203 
replace A = 1 if V4013 == 01204 
replace A = 1 if V4013 == 01205 
replace A = 1 if V4013 == 01206 
replace A = 1 if V4013 == 01207 
replace A = 1 if V4013 == 01208 
replace A = 1 if V4013 == 01209 
replace A = 1 if V4013 == 01401 
replace A = 1 if V4013 == 01402 
replace A = 1 if V4013 == 01500 
replace A = 1 if V4013 == 01999 
replace A = 1 if V4013 == 02000 
replace A = 1 if V4013 == 03001 
replace A = 1 if V4013 == 03002 
gen B = 0 
replace B = 1 if V4013 == 05000 
replace B = 1 if V4013 == 06000 
replace B = 1 if V4013 == 07001 
replace B = 1 if V4013 == 07002 
replace B = 1 if V4013 == 08001 
replace B = 1 if V4013 == 08002 
replace B = 1 if V4013 == 08009 
replace B = 1 if V4013 == 09000 
gen C = 0 
replace C = 1 if V4013 == 10010 
replace C = 1 if V4013 == 10021 
replace C = 1 if V4013 == 10022 
replace C = 1 if V4013 == 10030 
replace C = 1 if V4013 == 10091 
replace C = 1 if V4013 == 10092 
replace C = 1 if V4013 == 10093 
replace C = 1 if V4013 == 10099 
replace C = 1 if V4013 == 11000 
replace C = 1 if V4013 == 12000 
replace C = 1 if V4013 == 13001 
replace C = 1 if V4013 == 13002 
replace C = 1 if V4013 == 14001 
replace C = 1 if V4013 == 14002 
replace C = 1 if V4013 == 15011 
replace C = 1 if V4013 == 15012 
replace C = 1 if V4013 == 15020 
replace C = 1 if V4013 == 16001 
replace C = 1 if V4013 == 16002 
replace C = 1 if V4013 == 17001 
replace C = 1 if V4013 == 17002 
replace C = 1 if V4013 == 18000 
replace C = 1 if V4013 == 19010 
replace C = 1 if V4013 == 19020 
replace C = 1 if V4013 == 19030 
replace C = 1 if V4013 == 20010 
replace C = 1 if V4013 == 20020 
replace C = 1 if V4013 == 20090 
replace C = 1 if V4013 == 21000 
replace C = 1 if V4013 == 22010 
replace C = 1 if V4013 == 22020 
replace C = 1 if V4013 == 23010 
replace C = 1 if V4013 == 23091 
replace C = 1 if V4013 == 23099 
replace C = 1 if V4013 == 24001 
replace C = 1 if V4013 == 24002 
replace C = 1 if V4013 == 24003 
replace C = 1 if V4013 == 25001 
replace C = 1 if V4013 == 25002 
replace C = 1 if V4013 == 26010 
replace C = 1 if V4013 == 26020 
replace C = 1 if V4013 == 26030 
replace C = 1 if V4013 == 26041 
replace C = 1 if V4013 == 26042 
replace C = 1 if V4013 == 27010 
replace C = 1 if V4013 == 27090 
replace C = 1 if V4013 == 28000 
replace C = 1 if V4013 == 29001 
replace C = 1 if V4013 == 29002 
replace C = 1 if V4013 == 29003 
replace C = 1 if V4013 == 30010 
replace C = 1 if V4013 == 30020 
replace C = 1 if V4013 == 30030 
replace C = 1 if V4013 == 30090 
replace C = 1 if V4013 == 31000 
replace C = 1 if V4013 == 32001 
replace C = 1 if V4013 == 32002 
replace C = 1 if V4013 == 32003 
replace C = 1 if V4013 == 32009 
replace C = 1 if V4013 == 33001 
replace C = 1 if V4013 == 33002 
gen D = 0 
replace D = 1 if V4013 == 35010 
replace D = 1 if V4013 == 35021 
replace D = 1 if V4013 == 35022 
gen E = 0 
replace E = 1 if V4013 == 36000 
replace E = 1 if V4013 == 37000 
replace E = 1 if V4013 == 38000 
replace E = 1 if V4013 == 39000 
gen F = 0 
replace F = 1 if V4013 == 41000 
replace F = 1 if V4013 == 42000 
replace F = 1 if V4013 == 43000 
gen G = 0 
replace G = 1 if V4013 == 45010 
replace G = 1 if V4013 == 45020 
replace G = 1 if V4013 == 45030 
replace G = 1 if V4013 == 45040 
replace G = 1 if V4013 == 48010 
replace G = 1 if V4013 == 48020 
replace G = 1 if V4013 == 48030 
replace G = 1 if V4013 == 48041 
replace G = 1 if V4013 == 48042 
replace G = 1 if V4013 == 48050 
replace G = 1 if V4013 == 48060 
replace G = 1 if V4013 == 48071 
replace G = 1 if V4013 == 48072 
replace G = 1 if V4013 == 48073 
replace G = 1 if V4013 == 48074 
replace G = 1 if V4013 == 48075 
replace G = 1 if V4013 == 48076 
replace G = 1 if V4013 == 48077 
replace G = 1 if V4013 == 48078 
replace G = 1 if V4013 == 48079 
replace G = 1 if V4013 == 48080 
replace G = 1 if V4013 == 48090 
replace G = 1 if V4013 == 48100 
gen H = 0 
replace H = 1 if V4013 == 49010 
replace H = 1 if V4013 == 49030 
replace H = 1 if V4013 == 49040 
replace H = 1 if V4013 == 49090 
replace H = 1 if V4013 == 50000 
replace H = 1 if V4013 == 51000 
replace H = 1 if V4013 == 52010 
replace H = 1 if V4013 == 52020 
replace H = 1 if V4013 == 53001 
replace H = 1 if V4013 == 53002 
gen I = 0 
replace I = 1 if V4013 == 55000 
replace I = 1 if V4013 == 56011 
replace I = 1 if V4013 == 56012 
replace I = 1 if V4013 == 56020 
gen J = 0 
replace J = 1 if V4013 == 58000 
replace J = 1 if V4013 == 59000 
replace J = 1 if V4013 == 60001 
replace J = 1 if V4013 == 60002 
replace J = 1 if V4013 == 61000 
replace J = 1 if V4013 == 62000 
replace J = 1 if V4013 == 63000 
gen K = 0 
replace K = 1 if V4013 == 64000 
replace K = 1 if V4013 == 65000 
replace K = 1 if V4013 == 66001 
replace K = 1 if V4013 == 66002 
gen L = 0 
replace L = 1 if V4013 == 68000 
gen M = 0 
replace M = 1 if V4013 == 69000 
replace M = 1 if V4013 == 70000 
replace M = 1 if V4013 == 71000 
replace M = 1 if V4013 == 72000 
replace M = 1 if V4013 == 73010 
replace M = 1 if V4013 == 73020 
replace M = 1 if V4013 == 74000 
replace M = 1 if V4013 == 75000 
gen N = 0 
replace N = 1 if V4013 == 77010 
replace N = 1 if V4013 == 77020 
replace N = 1 if V4013 == 78000 
replace N = 1 if V4013 == 79000 
replace N = 1 if V4013 == 80000 
replace N = 1 if V4013 == 81011 
replace N = 1 if V4013 == 81012 
replace N = 1 if V4013 == 81020 
replace N = 1 if V4013 == 82001 
replace N = 1 if V4013 == 82002 
replace N = 1 if V4013 == 82003 
replace N = 1 if V4013 ==82009 
gen O = 0 
replace O = 1 if V4013 == 84011 
replace O = 1 if V4013 == 84012 
replace O = 1 if V4013 == 84013 
replace O = 1 if V4013 == 84014 
replace O = 1 if V4013 == 84015 
replace O = 1 if V4013 == 84016 
replace O = 1 if V4013 == 84017 
replace O = 1 if V4013 == 84020 
gen P = 0 
replace P = 1 if V4013 == 85011 
replace P = 1 if V4013 == 85012 
replace P = 1 if V4013 == 85013 
replace P = 1 if V4013 == 85014 
replace P = 1 if V4013 == 85021 
replace P = 1 if V4013 == 85029 
gen Q = 0 
replace Q = 1 if V4013 == 86001 
replace Q = 1 if V4013 == 86002 
replace Q = 1 if V4013 == 86003 
replace Q = 1 if V4013 == 86004 
replace Q = 1 if V4013 == 86009 
replace Q = 1 if V4013 == 87000 
replace Q = 1 if V4013 == 88000 
gen R = 0 
replace R = 1 if V4013 == 90000 
replace R = 1 if V4013 == 91000 
replace R = 1 if V4013 == 92000 
replace R = 1 if V4013 == 93011 
replace R = 1 if V4013 == 93012 
replace R = 1 if V4013 == 93020 
gen S = 0 
replace S = 1 if V4013 == 94010 
replace S = 1 if V4013 == 94020 
replace S = 1 if V4013 == 94091 
replace S = 1 if V4013 == 94099 
replace S = 1 if V4013 == 95010 
replace S = 1 if V4013 == 95030 
replace S = 1 if V4013 == 96010 
replace S = 1 if V4013 == 96020 
replace S = 1 if V4013 == 96030 
replace S = 1 if V4013 == 96090 
gen T = 0 
replace T = 1 if V4013 == 97000 
gen U = 0 
replace U = 1 if V4013 == 99000 
gen V = 0 
replace V = 1 if V4013 == 00000 

gen iten = (A+B+C+D+E+F+G+H+I+J+K+L+M+N+O+P+Q+R+S+T+U+V) * V1028
egen forca_tot = total(iten)
label var forca_tot "forca tot"
drop iten

gen iten = A * V1028
egen forca_A = total(iten)
label var forca_A "forca A"
drop iten
gen taxa_A = (forca_A/forca_tot)*100
label var taxa_A "Taxa A"

gen iten = B * V1028
egen forca_B = total(iten)
label var forca_B "forca B"
drop iten
gen taxa_B = (forca_B/forca_tot)*100
label var taxa_B "Taxa B"

gen iten = C * V1028
egen forca_C = total(iten)
label var forca_C "forca C"
drop iten
gen taxa_C = (forca_C/forca_tot)*100
label var taxa_C "Taxa C"

gen iten = D * V1028
egen forca_D = total(iten)
label var forca_D "forca D"
drop iten
gen taxa_D = (forca_D/forca_tot)*100
label var taxa_D "Taxa D"

gen iten = E * V1028
egen forca_E = total(iten)
label var forca_E "forca E"
drop iten
gen taxa_E = (forca_E/forca_tot)*100
label var taxa_E "Taxa E"

gen iten = F * V1028
egen forca_F = total(iten)
label var forca_F "forca F"
drop iten
gen taxa_F = (forca_F/forca_tot)*100
label var taxa_F "Taxa F"

gen iten = G * V1028
egen forca_G = total(iten)
label var forca_G "forca G"
drop iten
gen taxa_G = (forca_G/forca_tot)*100
label var taxa_G "Taxa G"

gen iten = H * V1028
egen forca_H = total(iten)
label var forca_H "forca H"
drop iten
gen taxa_H = (forca_H/forca_tot)*100
label var taxa_H "Taxa H"

gen iten = I * V1028
egen forca_I = total(iten)
label var forca_I "forca I"
drop iten
gen taxa_I = (forca_I/forca_tot)*100
label var taxa_I "Taxa I"

gen iten = J * V1028
egen forca_J = total(iten)
label var forca_J "forca J"
drop iten
gen taxa_J = (forca_J/forca_tot)*100
label var taxa_J "Taxa J"

gen iten = K * V1028
egen forca_K = total(iten)
label var forca_K "forca K"
drop iten
gen taxa_K = (forca_K/forca_tot)*100
label var taxa_K "Taxa K"

gen iten = L * V1028
egen forca_L = total(iten)
label var forca_L "forca L"
drop iten
gen taxa_L = (forca_L/forca_tot)*100
label var taxa_L "Taxa L"

gen iten = M * V1028
egen forca_M = total(iten)
label var forca_M "forca M"
drop iten
gen taxa_M = (forca_M/forca_tot)*100
label var taxa_M "Taxa M"

gen iten = N * V1028
egen forca_N = total(iten)
label var forca_N "forca N"
drop iten
gen taxa_N = (forca_N/forca_tot)*100
label var taxa_N "Taxa N"

gen iten = O * V1028
egen forca_O = total(iten)
label var forca_O "forca O"
drop iten
gen taxa_O = (forca_O/forca_tot)*100
label var taxa_O "Taxa O"

gen iten = P * V1028
egen forca_P = total(iten)
label var forca_P "forca P"
drop iten
gen taxa_P = (forca_P/forca_tot)*100
label var taxa_P "Taxa P"

gen iten = Q * V1028
egen forca_Q = total(iten)
label var forca_Q "forca Q"
drop iten
gen taxa_Q = (forca_Q/forca_tot)*100
label var taxa_Q "Taxa Q"

gen iten = R * V1028
egen forca_R = total(iten)
label var forca_R "forca R"
drop iten
gen taxa_R = (forca_R/forca_tot)*100
label var taxa_R "Taxa R"

gen iten = S * V1028
egen forca_S = total(iten)
label var forca_S "forca S"
drop iten
gen taxa_S = (forca_S/forca_tot)*100
label var taxa_S "Taxa S"

gen iten = T * V1028
egen forca_T = total(iten)
label var forca_T "forca T"
drop iten
gen taxa_T = (forca_T/forca_tot)*100
label var taxa_T "Taxa T"

gen iten = U * V1028
egen forca_U = total(iten)
label var forca_U "forca U"
drop iten
gen taxa_U = (forca_U/forca_tot)*100
label var taxa_U "Taxa U"

gen iten = V * V1028
egen forca_V = total(iten)
label var forca_V "forca V"
drop iten
gen taxa_V = (forca_V/forca_tot)*100
label var taxa_V "Taxa V"


collapse (mean) forca_A forca_B forca_C forca_D forca_E forca_F forca_G forca_H forca_I forca_J forca_K forca_L forca_M forca_N forca_O forca_P forca_Q forca_R forca_S forca_T forca_U forca_V taxa_A taxa_B taxa_C taxa_D taxa_E taxa_F taxa_G taxa_H taxa_I taxa_J taxa_K taxa_L taxa_M taxa_N taxa_O taxa_P taxa_Q taxa_R taxa_S taxa_T taxa_U taxa_V, by(Trimestre)
