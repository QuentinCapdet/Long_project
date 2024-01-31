#!/bin/bash

start_time=$(date +%s)

# Access Path and other files or directories
workdir='/home/qcapdet/M2BI/Projet_long/Project_PUs/UPNC/PDB'
#list_file="$workdir/Pos_PU_PDB.txt"
list_file="$workdir/min_Pos_PU_PDB.txt"

# Destination folder
destination_folder="$workdir/ERREUR"

# Check if the destination folder exists, otherwise create it
mkdir -p "$destination_folder"

count=0
len=$(wc -l < "$list_file")

for file_name in $(cat "$list_file"); do
    ((count++))
    
    # Ignore first line
    if [ "$count" -eq 1 ]; then
        continue
    fi
    
    echo -e "\e[91m$count/$len\e[0m"
    
    # Extract PDB_ID (First 4 characters)
    pdb_id="${file_name:0:4}"
    pdb_name="${file_name:0:5}"
    
    # Create a PDB folder
    pdb_folder="$destination_folder/${pdb_name}"
    mkdir "$pdb_folder" 2>/dev/null

    # Extract the start and end positions of the residu sequence number
    IFS='_' read -r _ residue_start residue_end <<< "$file_name"
    #echo "$residue_start"
    #echo "$residue_end"
    
    # Extract characters which represent the chain (A, B, etc.)
    chain_id="${file_name:4:1}"
    #echo "$chain_id"
    
    # URL to download PDB file
    pdb_url="https://files.rcsb.org/download/${pdb_id}.pdb"
    
    # Check if URL exist
    if curl --output /dev/null --silent --head --fail "$pdb_url"; then
        echo "URL exist"
     
        # Download PDB file
        curl -o "$pdb_folder/${pdb_name}.pdb" "$pdb_url"
        
        # Z-score standardization
        
        # Calculate mean and standard deviation of B factor values
        mean=$(awk '$1 == "ATOM" {sum += substr($0, 62, 6); count++} END {print sum/count}' "$pdb_folder/${pdb_name}.pdb")
        stddev=$(awk -v mean="$mean" '$1 == "ATOM" {sum += (substr($0, 62, 6) - mean)^2; count++} END {print sqrt(sum/count)}' "$pdb_folder/${pdb_name}.pdb")
        
        # Standardize B factor values and create a new PDB normalized
        awk -v mean="$mean" -v stddev="$stddev" '
            $1 == "ATOM" {
                b_factor = substr($0, 62, 6);
                normalized = (b_factor - mean) / stddev;
                new_b_factor = sprintf("%6.2f", normalized);
                printf "%s%6s%s\n", substr($0, 1, 61), new_b_factor, substr($0, 68);
            }
            $1 != "ATOM" {
                print $0;
            }
        ' "$pdb_folder/${pdb_name}.pdb" > "$pdb_folder/${pdb_name}_normalized.pdb"
        
        # Create a PUs folder
        pu_folder="$pdb_folder/PUs"
        mkdir "$pu_folder" 2>/dev/null
        
        # Extract lines matching residue sequence number
        awk -v chain="$chain_id" -v start="$residue_start" -v end="$residue_end" '$1 == "ATOM" && substr($0, 22, 1) == chain && int(substr($0, 23, 4)) >= start && int(substr($0, 23, 4)) <= end { print }' "$pdb_folder/${pdb_name}_normalized.pdb" > "$pu_folder/${file_name}.pdb"
        
        # Extract B factor columns
        awk '{ print substr($0, 63, 5)}' "$pu_folder/${file_name}.pdb" | sed 's/ //g' > "$pu_folder/${file_name}_B_factor.txt"
    
    else
        echo "URL doesn't exist"
        echo "$pdb_url" >> url_id_not_found.txt
    fi
    
done

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time secondes"
