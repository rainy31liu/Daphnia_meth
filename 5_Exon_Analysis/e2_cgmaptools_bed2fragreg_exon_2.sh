#! /bin/bash
#$ -l h_rt=1:00:00
#$ -l h_data=2G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

dir="/u/project/pellegrini/rainyliu/Daphnia"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting bed2fragreg for exon 1"

for i in 1 2
do
    for j in {1..10}
    do
        echo "Starting bed2fragreg for TSS S${i} top ${j}0%"
        ${cgmaptools} bed2fragreg -i "${dir}/mfg_exon_2/tss_bed/S${i}.exon2.mtr.${j}.txt" \
            -F 10,10,10,10,10,10,10,10,10,10 \
            -T 10,10,10,10,10,10,10,10,10,10 \
            -n 1 -o "${dir}/mfg_exon_2/tss_fragreg/S${i}.exon2.${j}.fragreg.txt"
    done
done

echo "Finished bed2fragreg"