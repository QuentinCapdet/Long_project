### Calculation of the average of the standardized B-factor of each PU

## Run the "calc_MEAN.sh" file

# Input file :
- Pos_PU_PDB.txt : file containing the positions of the PUs corresponding to the PDB.
- ONLY_BFACT : folder wich contains all the standardized B-factor.
- TEST : list of 2 file - files used to test on a small dataset (used only during code creation to verify that it works).

# Output file :
- all_mean.txt : file containing all standardized B-factor averages.

### Continuation of the study on RSTUDIO
- Test.R : file containing the analyzes on R to interpret the results from output file. 
  Also contains information for the results of the ALPHADB and ESMATLAS, same thing for all the results of the UPNC folders.


### Other files & folders :
- CLASS_renumf.txt & only_class.txt : files containing classes acoording to PUs.
- bfact_class.txt : file created from the previous files and all_mean.txt containing the classes for each average B-factor of the corresponding PUs.
