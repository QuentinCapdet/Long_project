### Creation of a folder containing the pdb file of the PUs with the pLDDT and their extracted column

## Run the "PUs_to_ESM.sh" file

# Input file :
- Pos_PU_ESM.txt : file containing the positions of the PUs corresponding to the PDB (taking into account the renumbering for possible offsets).
- min_Pos_PU_ESM.txt : file used to test on a small dataset (used only during code creation to verify that it works).
- pdb_seqres.txt : file to retrieve the protein sequence associated with each PDB id.

# Output file :
- pLDDT : folder which contains all the pLDDT of each PUs.
- seqres_id_not_found.txt renamed to err_lt_400.txt : ESM cannot generate a PDB file from a protein sequence greater than 400.
  pLDDT/1hn0/PUs/1hn0

### Creation of a folder which retrieves all the pLDDT files for ANALYS folder

## Run the "retrieve_pLDDT.sh" file

# Input file :
- ID_PDB_uniq.txt : file containing PDB IDs to easily retrieve pLDDT in the pLDDT folder.

# Output file :
- ONLY_pLDDT : folder wich contains all the pLDDT stat analysis "ANALYS/ONLY_pLDDT".

### Other files & folders :
- SAVE : folder with an old version of PUs_to_ESM.save.
- ANALYS : folder wich contains files for carrying out statistical analyzes of our pLDDT on RSTUDIO.
