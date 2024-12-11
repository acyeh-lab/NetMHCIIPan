# NetMHCIIPan
This is a basic tutorial on how to set up NetMHCIIPan on the Fred Hutch computing clusters.
Please read below for overview of how to run NetMHCIIPan shell script. 

# Accessing FHCC computing cluster
Make sure you can access rhino03 (or equivalent) cluster on the FHCC servers, including ssh (https://sciwiki.fredhutch.org/scicomputing/access_methods/), and for ease of transferring larger files, an ftp client such as filezilla.

# Install NetMHCIIPan
Now, make sure to upload NetMHCIIPan (included on the main page - `netMHCIIpan-4.3e.Linux.tar.gz`) into your directory.  Source website is from (https://services.healthtech.dtu.dk/services/NetMHCIIpan-4.3/). Once the file is uploaded to your desired folder, unpack using the command line `tar -xzvf netMHCIIpan-4.3e.Linux.tar.gz`. Installation instructions are available in the directory "~/NetMHCIIpan-4.3/netMHCIIpan-4.3.readme" (including changing the default home directory and temp directory in the script "netMHCIIpan"). Some additional tips are provided below as well. 

# Data preparation
NetMHCIIPan will require a directory containing peptides files.  These files following a simple format:
```
>CMV_PEPTIDE_001
CDLPLVSSRLLPETS
```
Note the first line is the label, and the second line is the peptide / sequence of interest. For this example, we have created a list of CMV peptide files in the folder "CMV Peptides".  The directory of folder containin all peptide files will be used as input for running NetMHCIIPan.
