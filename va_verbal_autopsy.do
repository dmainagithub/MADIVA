// Change directory
cd "D:\APHRC\GoogleDrive_ii\data_science\madiva\DMAC\databases\VA"

// Import VA data from raw csv from (D:\APHRC\GoogleDrive_ii\data_science\madiva\DMAC\databases)
import delimited "va_data_raw.csv", bindquote(strict) varnames(1) stripquote(yes) clear 

do "label_va_data.do"
do "va_nulls.do"
do "va_defined_labels.do" 
do "label_values.do"

// Save the dataset
save "D:\APHRC\GoogleDrive_ii\data_science\madiva\DMAC\databases\VA\VA_data.dta", replace
//
//
// cd "D:\Madhiva\Data Documentation\Data\"
// saveold VerbalAutopsy, version(12) replace


