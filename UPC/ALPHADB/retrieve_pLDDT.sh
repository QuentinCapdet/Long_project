#!/bin/bash

start_time=$(date +%s)

# Access path
workdir="/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/ALPHADB"
list_file="ID_UNP_uniq.txt"
pLDDT="$workdir/pLDDT"

# function
count=0
len=$(wc -l < "$list_file")

for file_name in $(cat "$list_file"); do
    ((count++))

    echo -e "\e[91m$count/$len\e[0m"

    cd "$pLDDT/${file_name}/PUs"
    cp *B_factor* "$workdir/ANALYS/ONLY_pLDDT"

done

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time secondes"
