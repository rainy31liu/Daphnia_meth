
cd /u/home/r/rainyliu/samtools-1.17/bin/

for i in {1..2}
do
    qsub -pe shared 10 /u/project/pellegrini/rainyliu/Daphnia/script/f3_bsbolt_align_mito_new.sh ${i}
done

