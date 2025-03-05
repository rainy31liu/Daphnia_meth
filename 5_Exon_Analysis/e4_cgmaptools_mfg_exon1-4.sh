#! /bin/bash
#$ -l h_rt=2:00:00
#$ -l h_data=4G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

input_dir="/u/project/pellegrini/rainyliu/Daphnia"
output_dir="/u/project/pellegrini/rainyliu/Daphnia/mfg_exon"
cgmaptools="/u/home/r/rainyliu/cgmaptools-master/cgmaptools"

for i in 1 2
do
    echo "Starting mfg for exon 1"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${output_dir}/fragreg/exon_1.txt" \
        -x CG -c 1 > "${output_dir}/mfg/S${i}.exon_1.new.txt"

    echo "Starting mfg for exon 2"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${output_dir}/fragreg/exon_2.txt" \
        -x CG -c 1 > "${output_dir}/mfg/S${i}.exon_2.new.txt"

    echo "Starting mfg for exon 3"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${output_dir}/fragreg/exon_3.txt" \
        -x CG -c 1 > "${output_dir}/mfg/S${i}.exon_3.new.txt"

    echo "Starting mfg for exon 4"
    gunzip -c "${input_dir}/cgmap_new/S${i}.filt.CGmap.gz" | ${cgmaptools} mfg \
        -r "${output_dir}/fragreg/exon_4.txt" \
        -x CG -c 1 > "${output_dir}/mfg/S${i}.exon_4.new.txt"
done

echo "Finished mfg"
