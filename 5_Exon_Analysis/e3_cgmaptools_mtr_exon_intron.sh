#! /bin/bash
#$ -l h_rt=1:00:00
#$ -l h_data=2G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

dir="/u/project/pellegrini/rainyliu/Daphnia"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting mtr for exon & intron"

${cgmaptools} mtr -i "${dir}/cgmap_new_CG/S1.filt.sort.CGmap.gz" \
    -r "${dir}/mtr_exon_intron/annotation_exon_intron.bed.txt" -o "${dir}/mtr_exon_intron/annotation_exon_intron.bed.S2.mtr.txt" 

${cgmaptools} mtr -i "${dir}/cgmap_new_CG/S2.filt.sort.CGmap.gz" \
    -r "${dir}/mtr_exon_intron/annotation_exon_intron.bed.txt" -o "${dir}/mtr_exon_intron/annotation_exon_intron.bed.S1.mtr.txt" 

echo "Finished mtr for exon & intron"