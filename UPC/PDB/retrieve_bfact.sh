#!/bin/bash

start_time=$(date +%s)

# Access path
workdir="/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/PDB"
list_file="ID_PDB_uniq.txt"
Bfact="$workdir/BFACT"

# function
count=0
len=$(wc -l < "$list_file")

for file_name in $(cat "$list_file"); do
    ((count++))
    
    echo -e "\e[91m$count/$len\e[0m"
    
    cd "$Bfact/${file_name}/PUs"
    cp *B_factor* "$workdir/ANALYS/ONLY_BFACT"
    
done

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time secondes"
