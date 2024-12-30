# NetMHCIIPan
This is a basic tutorial on how to set up NetMHCIIPan on the Fred Hutch computing clusters. Please read below for overview of how to run the NetMHCIIPan shell script. Of note, the source program used here is version 4.3 and is derived from "https://services.healthtech.dtu.dk/services/NetMHCIIpan-4.3".

# Accessing FHCC computing cluster
Make sure you can access rhino03 (or equivalent) cluster on the FHCC servers, including ssh (https://sciwiki.fredhutch.org/scicomputing/access_methods), and for ease of transferring larger files, an ftp client such as filezilla.

# Install NetMHCIIPan
Now, make sure to upload NetMHCIIPan (included on the main page - `netMHCIIpan-4.3e.Linux.tar.gz`) into your directory.  Source website is from (https://services.healthtech.dtu.dk/services/NetMHCIIpan-4.3). Once the file is uploaded to your desired folder, unpack using the command line 
```
tar -xzvf netMHCIIpan-4.3e.Linux.tar.gz
```
Installation instructions are available in the directory "~/NetMHCIIpan-4.3/netMHCIIpan-4.3.readme" (including changing the default home directory and temp directory in the script "netMHCIIpan"). Some additional tips are provided below as well. 

# Data preparation
NetMHCIIPan will require a directory containing peptides files.  These files following a simple format. For example, the file "CMV_PEPTIDE_001.txt" contains the following text:
```
>CMV_PEPTIDE_001
CDLPLVSSRLLPETS
```
Note the first line is the label, and the second line is the peptide / sequence of interest. 

For this run, download all the ".txt" files in the "CMV Peptides" folder in the repository into your directory. Folder is also accessible here "https://github.com/acyeh-lab/NetMHCIIPan/tree/main/CMV%20Peptides".

The directory of folder containing all peptide files will be used as input for running NetMHCIIPan. For this example, all the peptide files from "CMV_Peptide_001.txt" to "CMV_Peptide_136.txt" are uploaded to the directory "/fh/fast/hill_g/Albert/Genomes_Proteomes/Viral_Sequences/CMV_Peptides/core-list" (replace with your directory).

# Run shell script
Included in this directory is a working shell script `NetMHCIIPan_Analysis.sh` that can be used to run netMHCIIpan from the command line, or send it to the slurm queue. For example, from the command line where the shell script `NetMHCIIPan_Analysis.sh` is located, run:
```
sbatch -p campus-new -t 1-0 ./NetMHCIIPan_Analysis.sh /fh/fast/hill_g/Albert/Genomes_Proteomes/Viral_Sequences/CMV_Peptides/core-list DRB1_0101
```
This will execute netMHCIIPan on the "campus-new" server setting a maximum of 1 day (-t 1-0) for run time (more than enough), utilizing all sequence files in "/fh/fast/hill_g/Albert/Genomes_Proteomes/Viral_Sequences/CMV_Peptides/core-list" to find binders for the HLA allele "DRB1_0101".

# Expected output
After running the above shell script (can check on status by typing in `squeue -u ayeh` or whatever the login username is), there will be a new folder output named after the HLA allele used that contains the output data.  For example, for the above trial, we will see a new folder named "/fh/fast/hill_g/Albert/Genomes_Proteomes/Viral_Sequences/CMV_Peptides/core-list/DRB1_0101". In the folder, there will be a separate file named after the sequence file input, for example, "CMV_PEPTIDE_001.txt" in the output folder will contain the list of all potential binders.

The prediction output for each molecule consists of the following columns:
**Pos** - Residue number (starting from 0)  
**MHC** - MHC molecule name  
**Peptide** - Amino acid sequence  
**Of** - Starting position offset of the optimal binding core (starting from 0)  
**Core** - Binding core register  
**Core_Rel** - Reliability of the binding core, expressed as the fraction of networks in the ensemble selecting the optimal core  
**Inverted** - Whether the peptide binds inverted to the given MHC molecule (1: inverted, 0: forward)  
**Identity** - Annotation of the input sequence, if specified  
**Score_EL** - Eluted ligand prediction score  
**%Rank_EL** - Percentile rank of eluted ligand prediction score  
**Exp_bind** - If the input was given in PEPTIDE format with an annotated affinity value (mainly for benchmarking purposes)  
**Score_BA** - Predicted binding affinity in log-scale (printed only if binding affinity predictions were selected)  
**Affinity(nM)** - Predicted binding affinity in nanomolar IC50 (printed only if binding affinity predictions were selected)  
**%Rank_BA** - % Rank of predicted affinity compared to a set of 100.000 random natural peptides. This measure is not affected by inherent bias of certain molecules towards higher or lower mean predicted affinities (printed only if binding affinity predictions were selected)  
**BindLevel** - (SB: strong binder, WB: weak binder). The peptide will be identified as a strong binder if the % Rank is below the specified threshold for the strong binders. The peptide will be identified as a weak binder if the % Rank is above the threshold of the strong binders but below the specified threshold for the weak binders  

More information can be found here "https://services.healthtech.dtu.dk/services/NetMHCIIpan-4.3".

# HLA Alleles
The above example only runs the peptides through the allele "DRB1_0101".  Other alleles can be used as well, as seen here: A comprehensive list can be found here: "https://services.healthtech.dtu.dk/services/NetMHCIIpan-4.3/alleles_name.txt".

Note that the formatting of the allele text must be precise.  For most alleles, this follows the format "DRB1_0101", "DRB1_1501", "DRB5_0101", etc...  However, for DP and DQ alleles, the format is different, i.e. "HLA-DPA10103-DPB10201", or "HLA-DQA10102-DQB10501".  Murine alleles include "H-2-IAb", "H-2-IAd", "H-2-IEd"

# Parameters
Can modiful other factors, including length of peptide read (e.g. -length 15 is default; we changed to -length 9 as some of the eluted class II peptides are only 9 AAs in length)
