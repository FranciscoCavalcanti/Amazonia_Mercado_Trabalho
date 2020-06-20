forvalues sector = 1(1)19{
use "C:\Users\onurb\Documents\PNADC\pnadcontinua\PNADC_022019"

do "C:\Users\onurb\Documents\Monografia\Setorizacao\Inf\Desmemb_sec"

drop if sector != `sector'

do "C:\Users\onurb\Documents\Monografia\Informalidade\Taxa_de_informalidade_Monografia"

gen legenda = `sector'

save "C:\Users\onurb\Documents\Monografia\Setorizacao\Inf\Inf_`sector'"

clear
}

use "C:\Users\onurb\Documents\PNADC\pnadcontinua\PNADC_022019"

do "C:\Users\onurb\Documents\Monografia\Setorizacao\Inf\Desmemb_sec"

drop if sector != 22

do "C:\Users\onurb\Documents\Monografia\Informalidade\Taxa_de_informalidade_Monografia"

gen legenda = 22

save "C:\Users\onurb\Documents\Monografia\Setorizacao\Inf\Inf_22"

clear

forvalues sector = 1(1)19 {

append using "C:\Users\onurb\Documents\Monografia\Setorizacao\Inf\Inf_`sector'"
 }
 
 append using "C:\Users\onurb\Documents\Monografia\Setorizacao\Inf\Inf_22"
 
 
 save "C:\Users\onurb\Documents\Monografia\Setorizacao\Inf\Inf_setor_colapsado", replace
