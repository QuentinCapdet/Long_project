### Creation of a folder containing the pdb file of the PUs with the standardized B-factor and their extracted column

## Run the "PUs_to_PDB.sh" file

# Input file :
- Pos_PU_PDB.txt : file containing the positions of the PUs corresponding to the PDB (taking into account the renumbering for possible offsets). 
- min_Pos_PU_PDB.txt : file used to test on a small dataset (used only during code creation to verify that it works).

# Output file :
- BFACT : folder which contains all the standardized B-factor of each PUs.

### Creation of a folder which retrieves all the B-factor files standardized for ANALYS folder

## Run the "retrieve_bfact.sh" file

# Input file :
- ID_PDB_uniq.txt : file containing PDB IDs to easily retrieve B-factors in the BFACT folder.

# Output file :
- ONLY_BFACT : folder wich contains all the standardized B-factor stat analysis "ANALYS/ONLY_BFACT".

### Other files & folders :
- CLASS : folder which contains files to link PUs with their corresponding class.
- ANALYS : folder wich contains files for carrying out statistical analyzes of our standardized B-factor on RSTUDIO. 

