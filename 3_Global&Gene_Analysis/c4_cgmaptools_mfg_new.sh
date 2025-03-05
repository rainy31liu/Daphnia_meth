#! /bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=4G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

i=$1

input_dir="/u/project/pellegrini/rainyliu/Daphnia"
output_dir="/u/project/pellegrini/rainyliu/Daphnia/mfg_new"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

echo "Starting mfg for sample S${i} transcript"

for j in "CA" "CC" "CG" "CT"
do
    echo "Starting mfg for sample S${i} ${j} transcript"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${input_dir}/bed/transcript.fragreg.txt" \
        -x ${j} -c 1 > "${output_dir}/S${i}.transcript.${j}.mfg.txt"
done

for j in {1..10}
do
    echo "Starting mfg for gene S${i} top ${j}0%"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${input_dir}/bed/gene/S${i}.${j}.fragreg.txt" \
        -x CG -c 1 > "${output_dir}/gene/S${i}.${j}.mfg.txt"
    
    echo "Starting mfg for TSS S${i} top ${j}0%"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${input_dir}/bed/tss/S${i}.${j}.fragreg.txt" \
        -x CG -c 1 > "${output_dir}/tss/S${i}.${j}.mfg.txt"

    echo "Starting mfg for TSS S${i} top ${j}0%"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${input_dir}/bed/tes/S${i}.${j}.fragreg.txt" \
        -x CG -c 1 > "${output_dir}/tes/S${i}.${j}.mfg.txt"
done

echo "Finished mfg for sample S${i}"
