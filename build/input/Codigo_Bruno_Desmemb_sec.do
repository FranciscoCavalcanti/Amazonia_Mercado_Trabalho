/// CÁLCULO DA TAXA DE INFORMALIDADE



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

gen sector=0
replace sector = 1 if A == 1
replace sector = 2 if B == 1
replace sector = 3 if C == 1
replace sector = 4 if D == 1
replace sector = 5 if E == 1
replace sector = 6 if F == 1
replace sector = 7 if G == 1
replace sector = 8 if H == 1
replace sector = 9 if I == 1
replace sector = 10 if J == 1
replace sector = 11 if K == 1
replace sector = 12 if L == 1
replace sector = 13 if M == 1
replace sector = 14 if N == 1
replace sector = 15 if O == 1
replace sector = 16 if P == 1
replace sector = 17 if Q == 1
replace sector = 18 if R == 1
replace sector = 19 if S == 1
replace sector = 20 if T == 1
replace sector = 21 if U == 1
replace sector = 22 if V == 1
