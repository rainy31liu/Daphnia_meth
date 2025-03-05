#! /bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=4G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

input_dir="/u/project/pellegrini/rainyliu/Daphnia"
output_dir="/u/project/pellegrini/rainyliu/Daphnia/mfg_exon_2"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting mfg for sample S${i} exon 2"
for i in 1 2
do
    for j in {1..10}
    do
        echo "Starting mfg for TES S${i} top ${j}0%"
        gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
            -r "${output_dir}/tss_fragreg/S${i}.exon2.${j}.fragreg.txt" \
            -x CG -c 1 > "${output_dir}/tss_mfg/S${i}.exon2.${j}.mfg.txt"
    done
done

echo "Finished mfg for sample S${i}"
