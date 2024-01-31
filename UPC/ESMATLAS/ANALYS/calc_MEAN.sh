#!/bin/bash

start_time=$(date +%s)

# Access path
workdir="/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC/ESMATLAS"
list_file="$workdir/Pos_PU_ESM.txt"

# function
count=0
len=$(wc -l < "$list_file")

for file_name in $(cat "$list_file"); do
    ((count++))

    # Ignore first line
    if [ "$count" -eq 1 ]; then
        continue
    fi

    echo -e "\e[91m$count/$len\e[0m"

    cd "$workdir/ANALYS/ONLY_pLDDT"
    awk '{sum += $0; count++} END {printf "%.3f\n", sum/count}' "${file_name}_B_factor.txt" >> "$workdir/ANALYS/all_mean.txt"

done

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time secondes"
