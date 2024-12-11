#!/bin/bash

dir=$1 #Directory with all the .txt files ONLY
hla=$2

subdir="$1/Results"
files="ls $1/*.txt"
mkdir $dir/$hla

for eachfile in $files
do
  temp=$(basename $eachfile)
  subfile="$dir/$hla/$temp"
  /fh/fast/hill_g/Albert/NetMHCIIPan/netMHCIIpan-4.3/netMHCIIpan "-f" $eachfile "-a" $hla > $subfile #Note change the initial directory to the location of netMHCIIpan install
done

#A=$1 #File to Anlayze without the ".txt"
#B=$2 #HLA subtype
#C="$1.txt"
#D="$1_analysis.txt"

#/fh/fast/hill_g/Albert/NetMHCIIPan/netMHCIIpan-4.3/netMHCIIpan "-f" $C "-a" $B > $D

