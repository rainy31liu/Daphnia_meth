#! /bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=4G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

i="2"

input_dir="/u/project/pellegrini/rainyliu/Daphnia"
output_dir="/u/project/pellegrini/rainyliu/Daphnia/mfg_exon_1"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting mfg for sample S${i} exon 1"

for j in {1..10}
do
    echo "Starting mfg for TES S${i} top ${j}0%"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${output_dir}/tes_fragreg/S${i}.exon1.${j}.fragreg.txt" \
        -x CG -c 1 > "${output_dir}/tes_mfg/S${i}.exon1.${j}.mfg.txt"
done

echo "Finished mfg for sample S${i}"
