#! /bin/bash
#$ -l h_rt=1:00:00
#$ -l h_data=2G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

dir="/u/project/pellegrini/rainyliu/Daphnia"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting bed2fragreg for transcript"

${cgmaptools} bed2fragreg -i "${dir}/bed/transcript.bed.txt" \
    -F 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100 \
    -T 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100 \
    -n 30 -o "${dir}/bed/transcript.fragreg.txt"

for i in {1..2}
do
    for j in {1..10}
    do
        echo "Starting bed2fragreg for gene S${i} top ${j}0%"
        ${cgmaptools} bed2fragreg -i "${dir}/mtr_new/gene/S${i}.mtr.${j}.txt" \
            -F 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100 \
            -T 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100 \
            -n 30 -o "${dir}/bed/gene/S${i}.${j}.fragreg.txt"

        echo "Starting bed2fragreg for TSS S${i} top ${j}0%"
        ${cgmaptools} bed2fragreg -i "${dir}/mtr_new/tss/S${i}.mtr.${j}.txt" \
            -F 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100 \
            -T 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100 \
            -n 1 -o "${dir}/bed/tss/S${i}.${j}.fragreg.txt"

        echo "Starting bed2fragreg for TES S${i} top ${j}0%"
        ${cgmaptools} bed2fragreg -i "${dir}/mtr_new/tes/S${i}.mtr.${j}.txt" \
            -F 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100 \
            -T 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100 \
            -n 1 -o "${dir}/bed/tes/S${i}.${j}.fragreg.txt"
    done
done