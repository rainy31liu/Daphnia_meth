#! /bin/bash
#$ -l h_rt=1:00:00
#$ -l h_data=2G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

dir="/u/project/pellegrini/rainyliu/Daphnia"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting bed2fragreg for exons"

${cgmaptools} bed2fragreg -i "${dir}/mfg_exon/bed/exon_1.txt" \
    -F 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5 \
    -T 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5 \
    -n 30 -o "${dir}/mfg_exon/fragreg/exon_1.txt"

${cgmaptools} bed2fragreg -i "${dir}/mfg_exon/bed/exon_2.txt" \
    -F 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5 \
    -T 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5 \
    -n 30 -o "${dir}/mfg_exon/fragreg/exon_2.txt"

${cgmaptools} bed2fragreg -i "${dir}/mfg_exon/bed/exon_3.txt" \
    -F 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5 \
    -T 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5 \
    -n 30 -o "${dir}/mfg_exon/fragreg/exon_3.txt"

${cgmaptools} bed2fragreg -i "${dir}/mfg_exon/bed/exon_4.txt" \
    -F 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5 \
    -T 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5 \
    -n 30 -o "${dir}/mfg_exon/fragreg/exon_4.txt"

echo "Finished bed2fragreg for exons"