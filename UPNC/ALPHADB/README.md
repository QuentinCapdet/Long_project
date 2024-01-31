### Creation of a folder containing the pdb file of the PUs with the pLDDT and their extracted column

## Run the "PUs_to_UNP.sh" file

# Input file :
- Pos_PU_UNP.txt : file containing the positions of the PUs corresponding to the PDB (taking into account the renumbering for possible offsets).
- min_Pos_PU_UNP.txt : file used to test on a small dataset (used only during code creation to verify that it works).

# Output file :
- pLDDT : folder which contains all the pLDDT of each PUs.
- url_id_not_found.txt : url not found in AlphaFold database
  https://alphafold.ebi.ac.uk/files/AF-P06492-F1-model_v4.pdb  

### Creation of a folder which retrieves all the pLDDT files for ANALYS folder
## Run the "retrieve_pLDDT.sh" file

# Input file :
- ID_UNP_uniq.txt : file containing PDB IDs to easily retrieve pLDDT in the pLDDT folder.

# Output file :
- ONLY_pLDDT : folder wich contains all the pLDDT stat analysis "ANALYS/ONLY_pLDDT".

### Other files & folders :
- SAVE : folder with an old version of PUs_to_UNP.save.
- ANALYS : folder wich contains files for carrying out statistical analyzes of our pLDDT on RSTUDIO.
- PDB_chain.txt : file containing PUs which has strings other than "A" (for informational purposes).
