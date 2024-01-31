#!/bin/bash

start_time=$(date +%s)

# Access Path and other files or directories
workdir='/home/qcapdet/M2BI/Projet_long/Project_PUs/UPC'
list_file="$workdir/UNIQ_SORT.txt"
#list_file="$workdir/Test.txt"
dir_PDBChains="$workdir/PDBChains"

# Creation of a TSV file
echo -e "ID_PDB_PU\tPos_PU_ori\tPos_PU_struc_PDB\tPos_PU_seq_PDB\tPos_PU_UNP\tID_UNP" > $workdir/TABLE_UPC.tsv

count=0
len=$(wc -l < "$list_file")

for file_name in $(cat "$list_file"); do
    ((count++))
    echo -e "\e[91m$count/$len\e[0m"
    
    # Extract PDB_name and Chain ID
    pdb_name="${file_name:0:4}"
    chain_id="${file_name:4:1}"
    
    # Extract the start and end positions of the residu sequence number
    IFS='_' read -r _ _ residue_start residue_end <<< "$file_name"
    
    # Convert PDB_name to lowercase and append Chain ID
    modif_pdb_name="${pdb_name,,}_$chain_id"
    
    # Path to the TSV file
    tsv_file="$dir_PDBChains/$modif_pdb_name/${modif_pdb_name}_resnum_corresp_uniprot.tsv"
    
    # Vérifier si le fichier existe
    if [[ -f "$tsv_file" ]]; then
        echo "Le fichier $tsv_file existe."
        
        # Extract lines matching residue sequence number
        ID_UNP=$(awk 'NR>1 && $12 != "" && $12 != "?"  && $12 != "-" {print $12; exit}' "$tsv_file")
        #echo "$residue_start"
        #echo "$residue_end"
        #echo "$ID_UNP"
        
        Start_PU_seq=$(awk '$5 == '"$residue_start"' {print '"$residue_start"'; exit}' "$tsv_file")
        End_PU_seq=$(awk '$5 == '"$residue_end"' {print '"$residue_end"'; exit}' "$tsv_file")
        #echo "$Start_PU_seq"
        #echo "$End_PU_seq"
        
        Start_PU_UNP=$(awk '$5 == '"$residue_start"' {print $11}' "$tsv_file")
        End_PU_UNP=$(awk '$5 == '"$residue_end"' {print $11}' "$tsv_file")
        #echo "$Start_PU_UNP ."
        #echo "$End_PU_UNP"
        
        Start_PU_struc=$(awk '$5 == '"$residue_start"' {print $3}' "$tsv_file")
        End_PU_struc=$(awk '$5 == '"$residue_end"' {print $3}' "$tsv_file")
        #echo "$Start_PU_struc .."
        #echo "$End_PU_struc .."
        
        if [[ $(awk '$3 >= '"$Start_PU_struc"' && $3 <= '"$End_PU_struc"' && $2 != "-" {print $2}' "$tsv_file") == "" ]]; then
            Start_PU_struc_f="-"
            End_PU_struc_f="-"
        else
            start_line=$(awk '$3 == '"$Start_PU_struc"' {print NR; exit}' "$tsv_file")
            #echo "$start_line 's' "
            if [[ $(awk '$3 == '"$Start_PU_struc"' {print $2}' "$tsv_file") == "-" ]]; then
                Start_PU_struc_f=$(awk 'NR > '"$start_line"' && $2 != "-" {print $3; exit}' "$tsv_file")
                #echo "$Start_PU_struc_f !!!!"
            else
                Start_PU_struc_f="$Start_PU_struc"
                #echo "$Start_PU_struc .."
            fi
            end_line=$(awk '$3 == '"$End_PU_struc"' {print NR; exit}' "$tsv_file")
            #echo "$end_line 'e' "
            if [[ $(awk '$3 == '"$End_PU_struc"' {print $2}' "$tsv_file") == "-" ]]; then
                End_PU_struc_f=$(awk 'NR < '"$end_line"' && $2 != "-" {value = $3} END {print value}' "$tsv_file")
                #echo "$End_PU_struc_f !!-!!"
            else
                End_PU_struc_f="$End_PU_struc"
                #echo "$End_PU_struc_f .."
            fi
        fi
        if [[ -z "$Start_PU_UNP" && -z "$End_PU_UNP" ]]; then
            first_val=$(awk 'NR>1 && $11 != "" && $11 != "?" && $11 != "-" {print $11; exit}' "$tsv_file")
            first_val_NR=$(awk 'NR>1 && $11 != "" && $11 != "?" && $11 != "-" {print NR; exit}' "$tsv_file")
            Start_PU=$(awk '$5 == '"$residue_start"' {print NR; exit}' "$tsv_file")
            End_PU=$(awk '$5 == '"$residue_end"' {print NR; exit}' "$tsv_file")
            Start_PU_UNP_f=$((first_val - (first_val_NR - Start_PU)))
            End_PU_UNP_f=$((first_val - (first_val_NR - End_PU)))
        else
            if [[ -z "$Start_PU_UNP" && "$End_PU_UNP" != "-" ]]; then
                Start_PU_UNP_tmp=$(awk '$5 == '"$residue_start"' {print NR; exit}' "$tsv_file")
                #echo "$Start_PU_UNP_tmp !tmp!startz"
                Pos_line_end_pu=$(awk '$5 == '"$residue_end"' {print NR; exit}' "$tsv_file")
                #echo "$Pos_line_end_pu !line!end"
                Start_PU_UNP_f=$((End_PU_UNP - (Pos_line_end_pu - Start_PU_UNP_tmp)))
                #echo "$Start_PU_UNP_f // .."
            elif [[ "$Start_PU_UNP" == "?" && "$End_PU_UNP" != "-" && "$End_PU_UNP" != "?" ]]; then
                Start_PU_UNP_tmp=$(awk '$5 == '"$residue_start"' {print NR; exit}' "$tsv_file")
                #echo "$Start_PU_UNP_tmp !tmp!start?"
                Pos_line_end_pu=$(awk '$5 == '"$residue_end"' {print NR; exit}' "$tsv_file")
                #echo "$Pos_line_end_pu !line!end"
                Start_PU_UNP_f=$((End_PU_UNP - (Pos_line_end_pu - Start_PU_UNP_tmp)))
                #echo "$Start_PU_UNP_f //"
            else
                Start_PU_UNP_f="$Start_PU_UNP"
                #echo "$Start_PU_UNP_f !f!"
            fi
            if [[ -z "$End_PU_UNP" && "$Start_PU_UNP" != "-" ]]; then
                Start_PU_UNP_tmp=$(awk '$5 == '"$residue_start"' {print NR; exit}' "$tsv_file")
                #echo "$Start_PU_UNP_tmp !tmp!start"
                Pos_line_end_pu=$(awk '$5 == '"$residue_end"' {print NR; exit}' "$tsv_file")
                #echo "$Pos_line_end_pu !line!endz"
                End_PU_UNP_f=$((Start_PU_UNP + (Pos_line_end_pu - Start_PU_UNP_tmp)))
                #echo "$End_PU_UNP_f //"
            elif [[ "$End_PU_UNP" == "?" && "$Start_PU_UNP" != "-" && "$Start_PU_UNP" != "?" ]]; then
                Start_PU_UNP_tmp=$(awk '$5 == '"$residue_start"' {print NR; exit}' "$tsv_file")
                #echo "$Start_PU_UNP_tmp !tmp!start"
                Pos_line_end_pu=$(awk '$5 == '"$residue_end"' {print NR; exit}' "$tsv_file")
                #echo "$Pos_line_end_pu !line!end?"
                End_PU_UNP_f=$((Start_PU_UNP + (Pos_line_end_pu - Start_PU_UNP_tmp)))
                #echo "$End_PU_UNP_f //"
            else
                End_PU_UNP_f="$End_PU_UNP"
                #echo "$End_PU_UNP_f !f!"
            fi
        fi
        if [[ "$Start_PU_UNP_f" -le 0 && "$Start_PU_UNP_f" != "-" && "$Start_PU_UNP_f" != "" && "$Start_PU_UNP_f" != "?" ]]; then
            Start_PU_UNP_f=1
        fi
        echo -e "${file_name}\t${residue_start}_${residue_end}\t${Start_PU_struc_f}_${End_PU_struc_f}\t${Start_PU_seq}_${End_PU_seq}\t${Start_PU_UNP_f}_${End_PU_UNP_f}\t${ID_UNP}" >> $workdir/TABLE_UPC.tsv
    
    else
    echo "The file $tsv_file doesn't exist. Added the file name to the list of files not found."
    echo "$tsv_file" >> files_not_found.txt
    
fi
done

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time secondes"
