# NetMHCIIPan
This is a basic tutorial on how to set up NetMHCIIPan on the Fred Hutch computing clusters.
Please read below for overview of how to run NetMHCIIPan shell script. 

# Accessing FHCC computing cluster
Make sure you can access rhino03 (or equivalent) cluster on the FHCC servers, including ssh (https://sciwiki.fredhutch.org/scicomputing/access_methods/), and for ease of transferring larger files, an ftp client such as filezilla.

# Install NetMHCIIPan
Now, make sure to upload NetMHCIIPan (included on the main page - `netMHCIIpan-4.3e.Linux.tar.gz`) into your directory.  Source website is from (https://services.healthtech.dtu.dk/services/NetMHCIIpan-4.3/). Once the file is uploaded to your desired folder, unpack using the command line `tar -xzvf netMHCIIpan-4.3e.Linux.tar.gz`. Installation instructions are available in the directory "~/NetMHCIIpan-4.3/netMHCIIpan-4.3.readme" (including changing the default home directory and temp directory in the script "netMHCIIpan"). Some additional tips are provided below as well. 

# Data preparation
NetMHCIIPan will require a directory containing peptides files.  These files following a simple format. For example, the file "CMV_PEPTIDE_001.txt" contains the following text:
```
>CMV_PEPTIDE_001
CDLPLVSSRLLPETS
```
Note the first line is the label, and the second line is the peptide / sequence of interest. For this example, we have created a list of CMV peptide files in the folder "CMV Peptides".  The directory of folder containin all peptide files will be used as input for running NetMHCIIPan. Let us set for example, all the peptide files in the directory "/fh/fast/hill_g/Albert/Genomes_Proteomes/Viral_Sequences/CMV_Peptides/core-list" (replace with your directory).

For this run, download all the ".txt" files in the "CMV Peptides" folder in the repository into your directory.


# Run shell script
Included in this directory is a working shell script "NetMHCIIPan_Analysis.sh" that can be used to run netMHCIIpan from the command line, or send it to the slurm queue. For example, from the command line where the shell script "NetMHCIIPan_Analysis.sh" is located, run:
```
sbatch -p campus-new -t 1-0 ./NetMHCIIPan_Analysis.sh /fh/fast/hill_g/Albert/Genomes_Proteomes/Viral_Sequences/CMV_Peptides/core-list DRB1_0101
```
This will execute netMHCIIPan on the "campus-new" server setting a maximum of 1 day (-t 1-0) for run time (more than enough), utilizing all sequence files in "/fh/fast/hill_g/Albert/Genomes_Proteomes/Viral_Sequences/CMV_Peptides/core-list" to find binders for the HLA allele "DRB1_0101".


