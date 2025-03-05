#!/bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=5G
#$ -l highp
#$ -pe shared 4
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

dir="/u/project/pellegrini/rainyliu/Daphnia"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting bed2fragreg for exon & intron"

${cgmaptools} mtr -i "${dir}/cgmap_new_CG/S1.filt.sort.CGmap.gz" \
    -r "${dir}/mfg_exon_2/exon_2.bed.txt" -o "${dir}/mfg_exon_2/exon_2.S1.mtr.txt" 

${cgmaptools} mtr -i "${dir}/cgmap_new_CG/S2.filt.sort.CGmap.gz" \
    -r "${dir}/mfg_exon_2/exon_2.bed.txt" -o "${dir}/mfg_exon_2/exon_2.S2.mtr.txt" 
